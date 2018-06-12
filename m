Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 77F45C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 17:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28C8C208B4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 17:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=roeck-us.net header.i=@roeck-us.net header.b="tku3ZLBB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28C8C208B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934035AbeFLRTg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 13:19:36 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:51233 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933584AbeFLRTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 13:19:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=eHkwHAZ1nEmkXvV9xIBRlqoAqE1dDoJW749YgxWXtts=; b=tku3ZLBBdnhzg5rtLbWVhsge1x
        oxAqzakkNS5MpNxoempgc7cDWSzDmNCeN6LbOKTJbpuMt7kmOSvwICr1sWQcFa9xMHmdcsbIieL6O
        RRZGpsTAEUZM/zQsb+HRpHPV+hfqhScW/wNsogvadCB4gepYCAe9pqejzjvvQCIIn9zgomgrJyz8R
        XU7PUx89L0IShXFtT5UeUsuEUjPOb+uLhK+mjw0PBHSH3m0XkGnYnHmGb88hVHw0SLPoJqmPrvQly
        ag0XdaiChgUwf5ZJ/KoFcYB3rFB5oZ+yrpVRiAB7rI26VLpJ03yTP1PCbKhOPSSlrA8vvRGp0UF7T
        3ggcwRug==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:46846 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.89)
        (envelope-from <linux@roeck-us.net>)
        id 1fSmx8-00Emxj-Hy; Tue, 12 Jun 2018 17:19:31 +0000
Date:   Tue, 12 Jun 2018 10:19:29 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Stefan Agner <stefan@agner.ch>
Cc:     linux@armlinux.org.uk, ard.biesheuvel@linaro.org, arnd@arndb.de,
        nicolas.pitre@linaro.org, keescook@chromium.org,
        marc.zyngier@arm.com, linux-kernel@vger.kernel.org,
        mka@chromium.org, robin.murphy@arm.com,
        linux-arm-kernel@lists.infradead.org,
        Bernhard.Rosenkranzer@linaro.org
Subject: Re: [v2,4/6] ARM: drop no-thumb-interwork in EABI mode
Message-ID: <20180612171929.GA7829@roeck-us.net>
References: <20180325180959.28008-5-stefan@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180325180959.28008-5-stefan@agner.ch>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 25, 2018 at 08:09:57PM +0200, Stefan Agner wrote:
> According to GCC documentation -m(no-)thumb-interwork is
> meaningless in AAPCS configurations. Also clang does not

It appears that this is only correct for recent versions of gcc.

With gcc 4.9.2, this patch causes the qemu collie emulation
to fail with collie_defconfig+CONFIG_AEABI.

qemu-system-arm: Trying to execute code outside RAM or ROM at 0x02000000
This usually means one of the following happened:
...

With gcc 7.3.0, the emulation works as expected. Reverting the patch
fixes the problem with gcc 4.9.2. Not that it matters much to me - I can
and will switch to gcc 7.3.0 for my testing - but effectively this means
that older versions of gcc are no longer supported for all configurations.

Maybe $(call cc-option,-mno-thumb-interwork,) would have been safer ?

Guenter

> support the flag:
>   clang-5.0: error: unknown argument: '-mno-thumb-interwork'
> 
> Just drop -mno-thumb-interwork in AEABI configuration.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  arch/arm/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index e83f5161fdd8..e9e3fde3c657 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -106,7 +106,7 @@ tune-$(CONFIG_CPU_V6K)		=$(call cc-option,-mtune=arm1136j-s,-mtune=strongarm)
>  tune-y := $(tune-y)
>  
>  ifeq ($(CONFIG_AEABI),y)
> -CFLAGS_ABI	:=-mabi=aapcs-linux -mno-thumb-interwork -mfpu=vfp
> +CFLAGS_ABI	:=-mabi=aapcs-linux -mfpu=vfp
>  else
>  CFLAGS_ABI	:=$(call cc-option,-mapcs-32,-mabi=apcs-gnu) $(call cc-option,-mno-thumb-interwork,)
>  endif
