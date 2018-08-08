Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B70C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 17:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88AEB216F2
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 17:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=landley-net.20150623.gappssmtp.com header.i=@landley-net.20150623.gappssmtp.com header.b="guICrf1L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88AEB216F2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729036AbeHHTko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 15:40:44 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:34301 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727723AbeHHTko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 15:40:44 -0400
Received: by mail-io0-f195.google.com with SMTP id l7-v6so2484417ioj.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 10:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Lla3gIIplMXLwofZXx2roSBkh0znGATqerEuEHgpNqA=;
        b=guICrf1LeIZ3lrdDfqmoih8Hgpd07DbcuV1/JsFcf+I9QVDXKpxFy1yTiT69cGtsBp
         Z1IvU4xACEFLuIDHZH73pni8rLlAF53hNr3M6GFGMtrSiOeeoP5Rxr4nJ+wAqbjcjk1q
         DlVUuwWVfGlHkCWuk11fM/RFgbAuRjYQHc3lWM5kpYu/Fw6Ln733quUVHkhXdM1OGd5i
         KCsMcwLYQwBks3I+mhgy/Xa/rwKlNfS4/vXan5Kifd1yIMZ495i9R+scZOkfdi8fn4j2
         CBSvNUfiyhktPoa8aTxJMhzPRelpPDoy/KHjolA4VFJs/x+4xYIYjYc47hNKvNVEvbfw
         tqfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Lla3gIIplMXLwofZXx2roSBkh0znGATqerEuEHgpNqA=;
        b=TzdBYYXP6wf3Xn46cP8DamPx4RpmD6P561EUbJicEe9WprQiCaY7wgdeaP+fIHP/In
         M+J4ytBQ9N7aSp4tW9FqLMZPN4RFQTk5MRIx9lK29kZUbsX0Ey81YX+3qXVNZtI+lacJ
         tLhGCvsB9npIFmE/J2Z5zfSw0mTRvELcPkp6K5Tl8H6EPBBOL0b0wtXV+chhMUxWAFIu
         fz+1M1/BaqqsSSgCbSUQloWwQKmPfxyrMOdjGa8girpqLmhNH+/fTIBWwwvsPvA+5gyk
         azJ0WZ3LkGUA2UYixO+xikSQiCsfNH+CSF6MzwP1qELobxLPoyC1tIJPH6xhWm2/1frQ
         kjtQ==
X-Gm-Message-State: AOUpUlEnNQrU9fnBqbPeMmnnVqxcFiWJxHzBVbTZ1k9sThbe6qF0h14f
        qRlYfvY/v5ToOM2PqfjIAQ68bA==
X-Google-Smtp-Source: AA+uWPzpddWAtA+QHlYrrkJg0ka7VkE/tkJcBD1nOX0QWqNNp1dyYxqIdF4mE3AVfrSgnaReK8zbIg==
X-Received: by 2002:a6b:8fd4:: with SMTP id r203-v6mr3270615iod.24.1533748806049;
        Wed, 08 Aug 2018 10:20:06 -0700 (PDT)
Received: from [192.168.42.110] ([172.58.139.144])
        by smtp.googlemail.com with ESMTPSA id n142-v6sm17466itb.3.2018.08.08.10.19.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 10:20:05 -0700 (PDT)
Subject: Re: [RESEND PATCH] init/Kconfig: Use short unix-style option instead
 of --longname
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild@vger.kernel.org
Cc:     Ulf Magnusson <ulfalizer@gmail.com>,
        Jiri Kosina <trivial@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
References: <1533701203-31019-1-git-send-email-yamada.masahiro@socionext.com>
From:   Rob Landley <rob@landley.net>
Message-ID: <7c415401-8732-9cdd-44f7-1878e711b440@landley.net>
Date:   Wed, 8 Aug 2018 12:19:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1533701203-31019-1-git-send-email-yamada.masahiro@socionext.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/07/2018 11:06 PM, Masahiro Yamada wrote:
> From: Rob Landley <rob@landley.net>
> 
> Avoids warning messages with the latest release of toybox, which never
> bothered to implement the --longopts nothing was using.
> 
> Signed-off-by: Rob Landley <rob@landley.net>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
> This was sent to the trivial ML some time ago,
> but not applied yet.
> 
> I will apply this to kbuild tree for v4.19

Thank you.

(I have a pile of small kernel fixes but haven't had time+energy to follow up on
them recently.)

Rob
