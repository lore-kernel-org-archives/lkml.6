Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B11FC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 21:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1970D2083F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 21:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="HHYmPZzV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1970D2083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbeIAB6l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 21:58:41 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:47100 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbeIAB6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 21:58:40 -0400
Received: by mail-lj1-f195.google.com with SMTP id 203-v6so11134271ljj.13
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 14:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aDPzYl/zAckhW7P5zdoYeVDnF3hCthJzwyQo2YtEgZo=;
        b=HHYmPZzVcGFAo4EuF64/1wkoF24ylykwrOP+3MHV6BrsdBEvjgBxi+IgbNuAqtfmJs
         fWVgdj/WYXtQvP12qcEMR+/WX0YOPUA0NuItROPvyqBc6ehXpWTAb/1dryIgsZisJufd
         p/hPwRuCXjzbS9lr9hYNlp91BVh3+7wxm2BmM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aDPzYl/zAckhW7P5zdoYeVDnF3hCthJzwyQo2YtEgZo=;
        b=tro6hupVm/cn+OorHmc/Da/3tQ+L2C9mCd7009RpMMOC+oC2Lbnj6ekkyYNLuWGPMT
         nO19ZyofmhDUX1y4DXouHmXU/kGwSP9TSesblEeSorEXoFR2EB7c2ZtDp2e7sjrHltFp
         fYUtOo16VvBjRKkgi4da9BY4Zlod5fSTzUaz5tF2bfzQA0SPMwPKcRQ0IOvsYLMf8TTB
         jujGNO2onPa4Qg+Z0z5GT9yY7W5aCIse3E7lBkmGlOVtLmBQUq+G5MuEgVe23Q4sZ8Ya
         rsZ+tNO4An0butIxpiXvhIbzrThqgJoRvJLZG9VuUZ8TFJhMB+JDlDr6LLP6nO6/uets
         3qxQ==
X-Gm-Message-State: APzg51BtDDO4UVF+7/qezYN7MmUYKC2p17TxgwCDwTMZB+f6J7FBRMIz
        DNGSRYvug9VngeA8HQ3xBQ30CQ==
X-Google-Smtp-Source: ANB0Vdb/oI2QkJdB+s9vvXZDNOPkWi5zUAoX4dghxosQcjxW+J5nXTeDLTwiIVrqxj/D+tRAdsCGDw==
X-Received: by 2002:a2e:9095:: with SMTP id l21-v6mr12094773ljg.15.1535752154463;
        Fri, 31 Aug 2018 14:49:14 -0700 (PDT)
Received: from [192.168.0.189] (dhcp-5-186-114-212.cgn.ip.fibianet.dk. [5.186.114.212])
        by smtp.gmail.com with ESMTPSA id p28-v6sm1988124ljp.90.2018.08.31.14.49.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 14:49:13 -0700 (PDT)
Subject: Re: [PATCH 2/7] Compiler Attributes: use the no-underscores syntax
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Eli Friedman <efriedma@codeaurora.org>,
        Christopher Li <sparse@chrisli.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Joe Perches <joe@perches.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Nick Desaulniers <ndesaulniers@google.com>
References: <20180831170514.24665-1-miguel.ojeda.sandonis@gmail.com>
 <20180831170514.24665-2-miguel.ojeda.sandonis@gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <0a8588f3-929a-608f-1fdc-e24b90e6b59b@rasmusvillemoes.dk>
Date:   Fri, 31 Aug 2018 23:49:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180831170514.24665-2-miguel.ojeda.sandonis@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-31 19:05, Miguel Ojeda wrote:
> The attribute syntax optionally allows to surround attribute names
> with "__" in order to avoid collisions with macros of the same name
> (see https://gcc.gnu.org/onlinedocs/gcc/Attribute-Syntax.html).
> 
> This homogenizes all attributes to use the syntax without underscores.

At the risk of bikeshedding, why not the other way around, exactly
because of what you write above? We have convenience macros anyway, so
those verbose leading/trailing underscores would only be in compiler*.h,
and some of the attribute names are common words that can appear as
#defines. E.g. error is defined
drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c ; if that used a
BUILD_BUG_ON somewhere, the

#define __compiletime_error(message) __attribute__((error(message)))

would break.

Rasmus
