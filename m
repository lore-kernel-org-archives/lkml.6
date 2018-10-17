Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3162AC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 04:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4D8E214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 04:32:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4D8E214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=koikeco.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbeJQM0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 08:26:03 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37239 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbeJQM0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 08:26:02 -0400
Received: by mail-qt1-f196.google.com with SMTP id d14-v6so28550375qto.4;
        Tue, 16 Oct 2018 21:32:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PWxm3SD45Eg6owF26keSIF9eU1wqJcLR5YhM2ajYDoE=;
        b=NWrRGCWyMouYQrHVlSSMKtoZAigTAr2lVxTEjFTDZpnuPJOygq5JP09OuxoYH9hB+h
         /xGRBrhTZu5Lj+DsmzmKr4ppVbzi5yzvRkAuarU5bYcHFEdhkCWgTG9ShDafQGDJtl9G
         Fzs4RWoke/y7RzY1OzL73aqyO6ezTr0Wb5q4ojhBS1Eofo4YSjKVE/RfNwJv71aPwxqT
         cBcPYWQoRIR6G9cy+zcPNBqiPqg2W4GIeOkBl1PuC26D1yqhYnCM8J9wqnNDKhjUHYjA
         0qUToGQgBg1vnm9CeDmfiLScJH4qFcaCanJac+5DvvXhGqZLYQkILzoieabFIEFCsf6F
         kE4A==
X-Gm-Message-State: ABuFfohUY5BVoHLBEwCRdmPlgi5Zv0JiMsRB9UWN6qVB0+/TjLN1wn/u
        iLrqQRh0R2FzWNkG+64FElY=
X-Google-Smtp-Source: ACcGV628YH9HqfWVtTTSOkmxm8H98S1DjhyxhMLcrNuENgf7T19cOewBiz4pZvWmW6rk++FSpibbWg==
X-Received: by 2002:a0c:b66d:: with SMTP id q45-v6mr24896645qvf.43.1539750738208;
        Tue, 16 Oct 2018 21:32:18 -0700 (PDT)
Received: from ?IPv6:2804:431:9718:6346:661:e081:23ef:66b? ([2804:431:9718:6346:661:e081:23ef:66b])
        by smtp.gmail.com with ESMTPSA id n67-v6sm15142117qkh.66.2018.10.16.21.32.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 21:32:17 -0700 (PDT)
Subject: Re: [Lkcamp] [PATCH 1/4] Adds -Wshadow=local on KBUILD_HOSTCFLAGS
To:     =?UTF-8?Q?Leonardo_Br=c3=a1s?= <leobras.c@gmail.com>,
        lkcamp@lists.libreplanetbr.org
Cc:     x86@kernel.org, linux-kbuild@vger.kernel.org,
        Matthew Wilcox <willy6545@gmail.com>,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20181017000809.GA21292@WindFlash>
From:   Helen Koike <helen@koikeco.de>
Message-ID: <716d591a-a0da-e048-a00d-0fe7dabdc4f1@koikeco.de>
Date:   Wed, 17 Oct 2018 01:32:12 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181017000809.GA21292@WindFlash>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leonardo,

Thanks for the patch.

On 10/16/18 9:08 PM, Leonardo Brás wrote:
> Adds -Wshadow=local on KBUILD_HOSTCFLAGS to show shadow warnings
> on tools built for HOST.
> 
> Signed-off-by: Leonardo Brás <leobras.c@gmail.com>
> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index e8b599b4dcde..fb0a9ac195e7 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -360,7 +360,7 @@ HOST_LFS_LIBS := $(shell getconf LFS_LIBS 2>/dev/null)
>  
>  HOSTCC       = gcc
>  HOSTCXX      = g++
> -KBUILD_HOSTCFLAGS   := -Wall -Wmissing-prototypes -Wstrict-prototypes -O2 \
> +KBUILD_HOSTCFLAGS   := -Wall -Wshadow=local -Wmissing-prototypes -Wstrict-prototypes -O2 \
>  		-fomit-frame-pointer -std=gnu89 $(HOST_LFS_CFLAGS) \
>  		$(HOSTCFLAGS)
>  KBUILD_HOSTCXXFLAGS := -O2 $(HOST_LFS_CFLAGS) $(HOSTCXXFLAGS)
> 

I believe this should be the last patch on this series and not the first
one to avoid commits in between where we have those warnings.

Regards
Helen
