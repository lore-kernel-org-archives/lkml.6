Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F31ECDFBB
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 22:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D16272086D
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 22:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="Pz+BmLqs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D16272086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbeGUXTE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 19:19:04 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40431 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727974AbeGUXTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 19:19:04 -0400
Received: by mail-lj1-f193.google.com with SMTP id j19-v6so13878458ljc.7
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 15:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0eM98ZREW8zwGXk6HGpHvPeLfLF+NJNyTNP7DRXMQM0=;
        b=Pz+BmLqsT79aRUKdAeZ4f5tT8IL+HTzrr3O6qJO44JmZk9b2H+HM5dHefaOuwERhnQ
         e+KSOBYn0v2zxsfiCF8vk1Ra1pmfmHPNllLGnUq7ysQVkZ8dK3A3tMrimEe37XHe09M+
         Md3Tr00eIS7DihMzJDy3JsLTw0NL+IYPdc+ebpAmf8DB0QrTky/lFRnHEBOAZX4eAO1H
         DQ83yf6P7EqPzU+z3eh8M8MNyRaqFeGz3RD1cukZPOICuCSFCA+FKXzA4qCA1fowtBnz
         pNxzqR8pxCq1dCvarbl1x2+GlGm1jdddZu7gTJwYljY8DPeSzRJoqSh5pltPpo+P4T9O
         fxVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0eM98ZREW8zwGXk6HGpHvPeLfLF+NJNyTNP7DRXMQM0=;
        b=paBRcQW1/dKGgeOX33rCOD6BMu3cXtH4s+fIjpNwE3qnbf/EpqpkGWpjgyD3VFt8LZ
         7rVjqmJ7vcv5y1Q19aw/Xby1K0ooNGUSk4ubftLVMhV7XcoTAD5l0tU64KThCfGbDM9D
         kW9xGW+36Tb7NjvxiXgHcXk8GoliNSxmL9ZH3oNkI6ojTlZWYZGe9Eq4Earuuu6Vzzgp
         N7aGKjr5SpJhzaK+J27r/oy81GalGB8FXCfLXBnio+cdX4F29SRbgOCNmB+b3l8auIWl
         Ss8KJye0EUAudr/3dLzuzESLZx8JmdXwV59ir3dB0X1rLp104iW7KgzMVSd5u+WCFG7r
         zQxg==
X-Gm-Message-State: AOUpUlFyD/ngNa2SgMTXWg3jhsm/v9pZZj6oxkBN2DBSkIkeLNmkHn8D
        KC+PU1tNKFA2O3aYNRSv3Aqayw==
X-Google-Smtp-Source: AAOMgpcUSgW3peAgMtHthnP/yOFb2GUmNopKbsEnbpJuEmodBI9d4Mp3KPm4PNeReUOCWBv3CQyHqA==
X-Received: by 2002:a2e:10ca:: with SMTP id 71-v6mr5137247ljq.59.1532211884317;
        Sat, 21 Jul 2018 15:24:44 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.se.alltele.net. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id r23-v6sm1058161ljc.15.2018.07.21.15.24.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 15:24:43 -0700 (PDT)
Date:   Sat, 21 Jul 2018 14:26:26 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     arm-soc <arm@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL 1/3] ARM: dts: uniphier: UniPhier DT updates for v4.19
Message-ID: <20180721212626.p3vth4xry46tlsfg@localhost>
References: <CAK7LNASA08wMtQaEfZy66u-EubV7X-u+z6KcTrtq_yXzWyzPvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNASA08wMtQaEfZy66u-EubV7X-u+z6KcTrtq_yXzWyzPvw@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 08:01:06AM +0900, Masahiro Yamada wrote:
> Hi Arnd, Olof,
> 
> Please pull UniPhier DT (32bit) updates for the v4.19 MW.
> 
> Thanks!
> 
> 
> 
> The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:
> 
>   Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier.git
> tags/uniphier-dt-v4.19
> 
> for you to fetch changes up to 38dc27c85e642cd6229f3a4b2c85128501852158:
> 
>   ARM: dts: uniphier: Add missing cooling device properties for CPUs
> (2018-07-19 06:42:16 +0900)

Merged, thanks.


-Olof
