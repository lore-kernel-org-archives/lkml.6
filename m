Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7582BC282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 20:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49A2D218D2
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 20:34:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbfBIUeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 15:34:24 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36023 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbfBIUeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 15:34:24 -0500
Received: by mail-qk1-f195.google.com with SMTP id o125so4242346qkf.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Feb 2019 12:34:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w+Bzstf7Nu1gX2cAvQeXqr2LtMo2D/XVu84B6YMcGbQ=;
        b=CX+en3hZ0B4C38jnZFwybSzoghs5+DMLTkIBOzUHwYvdjJ+Qcgj7kmadti20F74/iP
         n449xDD3NS6jOlNl7qliv3cejiwO7ETr/Ry1F8R+sBUPy2/IoGS0r/hplsNAw89JAWpk
         Ag+qYFZb6PnKZbbPnWWZl2z0kRCPmuVifSjU2JpnuAl+72PuFzQPCrEZ2Sl8+JhEZldT
         rpOIe1/oNcukrsI9QjjoBSlxpPx5A79YE5XXUTT7k9l4ePt8jC1JelnnIqsLZqS7Byy0
         i8qLD88Aez0uF6p1ThQINk15AGc9uK1iZ+I37Zyv/w11LO2H8ed4uQZRayhn+PH8fVgR
         Mdcg==
X-Gm-Message-State: AHQUAuZggxB2x2F5AdlB/+twCcPnShY24ducgMl6l2sSNfU8Wp3PdU7s
        GAMWuBve3kl/FC6W8avwGK6VWKKPQTs=
X-Google-Smtp-Source: AHgI3IYLBTvKszyWtL/vdisQm3vGnRnTRD+c6P+GdkRC86TgMGry79f9CtH/5JKsp7NXDKrEIg0GkA==
X-Received: by 2002:a37:9205:: with SMTP id u5mr20472017qkd.227.1549744463041;
        Sat, 09 Feb 2019 12:34:23 -0800 (PST)
Received: from ?IPv6:2601:602:9800:dae6::112f? ([2601:602:9800:dae6::112f])
        by smtp.gmail.com with ESMTPSA id z17sm6811327qth.79.2019.02.09.12.34.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Feb 2019 12:34:22 -0800 (PST)
Subject: Re: [PATCH] s390/jump_label: Correct asm contraint
To:     Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     Andreas Krebbel <krebbel@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190123125513.20210-1-labbott@redhat.com>
 <20190123132401.GG3424@osiris>
 <898d52cc-fa76-0888-429f-27446190653b@redhat.com>
 <20190205124349.GA10167@osiris>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <541cdc96-7ce0-de6a-0f8b-778ee826a378@redhat.com>
Date:   Sat, 9 Feb 2019 12:34:20 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190205124349.GA10167@osiris>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/5/19 12:43 PM, Heiko Carstens wrote:
> On Tue, Jan 29, 2019 at 08:25:58AM +0100, Laura Abbott wrote:
>> On 1/23/19 5:24 AM, Heiko Carstens wrote:
>>> On Wed, Jan 23, 2019 at 01:55:13PM +0100, Laura Abbott wrote:
>>>> There's a build failure with gcc9:
>>>>
>>>>   ./arch/s390/include/asm/jump_label.h: Assembler messages:
>>>>   ./arch/s390/include/asm/jump_label.h:23: Error: bad expression
>>>>   ./arch/s390/include/asm/jump_label.h:23: Error: junk at end of line, first unrecognized character is `r'
>>>>   make[1]: *** [scripts/Makefile.build:277: init/main.o] Error 1
> ...
>> I've had to turn off s390 in Fedora until this gets fixed :(
> 
> Laura, the patch below should fix this (temporarily). If possible,
> could you give it a try? It seems to work for me.
> 
> rom 4067027c2ccc8d3f1dc3bb19fe2d00da0c65bcd8 Mon Sep 17 00:00:00 2001
> From: Heiko Carstens <heiko.carstens@de.ibm.com>
> Date: Tue, 5 Feb 2019 13:21:56 +0100
> Subject: [PATCH] s390: disable section anchors
> 
> Disable section anchors to allow to compile with the current gcc 9
> experimental version. The section anchors is a new feature for s390
> with gcc 9, however it breaks our current usage of the 'X' constraint
> within the asm goto construct within our jump label implementation.
> 
> Fixing this seems to be non-trivial, therefore (hopefully) temporarily
> disable section anchors. We will hopefully have a better solution
> before gcc 9 is released, so that this can be removed again.
> 
> Reported-by: Laura Abbott <labbott@redhat.com>
> Suggested-by: Ilya Leoshkevich <iii@linux.ibm.com>
> Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
> ---
>   arch/s390/Makefile | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/arch/s390/Makefile b/arch/s390/Makefile
> index e21053e5e0da..1eac75bc3a29 100644
> --- a/arch/s390/Makefile
> +++ b/arch/s390/Makefile
> @@ -62,6 +62,14 @@ cflags-y += -Wa,-I$(srctree)/arch/$(ARCH)/include
>   #
>   cflags-$(CONFIG_FRAME_POINTER) += -fno-optimize-sibling-calls
>   
> +#
> +# Disable section anchors. This gcc 9 feature currently breaks the 'X'
> +# constraint like it is used in the asm goto construct.
> +#
> +ifeq ($(call cc-option-yn,-fno-section-anchors),y)
> +cflags-y += -fno-section-anchors
> +endif
> +
>   ifeq ($(call cc-option-yn,-mpacked-stack),y)
>   cflags-$(CONFIG_PACK_STACK)  += -mpacked-stack -D__PACK_STACK
>   aflags-$(CONFIG_PACK_STACK)  += -D__PACK_STACK
> 

Tested-by: Laura Abbott <labbott@redhat.com><
