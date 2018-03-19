Return-Path: <dan.rue@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1521503396; cv=none;
        d=google.com; s=arc-20160816;
        b=XBq8wHCSE+ZI5Jf99UEDq/lqjLoOXARgCHPSkO302WNmsEZevWfOQCIdVPhWKTTlr0
         df0aQmV4YM9nDkc9tJlSxNT2+oHUttcUygHdpbUIiQQxrrvfEk/rzHjR+IqCPaLMoynK
         Il+Aj4GlrP3jbrZWaINj+EgnDcdwhhs2faEvd4a0644CsYInpgHbbysgjjo4xNqzJ98w
         8vpi8HArwNeCAvhyXMeZSTg0bMZ65uxrabXboWmXR71kPaB8AhN3xC+BrZCHXi9ud2uU
         DYSQAX6D0P3UO2PluImhva4BS+abXdi8lj7BcSrH2MyLe0kihZ9rShv2+jkgBzZ4+xax
         C6TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=2d2z87c/XXOHj23kiYJWQhmMscIKCyd9Ov9PYGX0E+o=;
        b=z6WMtSfhnG8BDLZ0Jbfo5c6vBcUG02wBZ0vGATgJFNMUdGZSjRFgtZsDTSHD8Zz+VS
         inF89OdaVhUAeNUv6gevu3XVqa3ofwNUvWOT2EvvzPnUlET8lo1M81CVuwxpEkULfOie
         HL/9kJnYmDWwWlHTDyXR0GWbiwTwJQee3KbV03MvTStpkiy9a1yIRmYq6IlUpgSV3vHt
         TLB83/eLYcCBvH8zVf7KKva4JxVQ2wNibdbNnaOILO/TB5QHpm4KrjB18ObHXzBrcDZC
         z9vhVQzMhY5jOHJFr38X7FF1/wSYtcK4uhNa8tVg9Vbml3wErl1z04G9hCnJGgadJ+6n
         Y3pg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=Ao+aNXoE;
       spf=pass (google.com: domain of dan.rue@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=dan.rue@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=Ao+aNXoE;
       spf=pass (google.com: domain of dan.rue@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=dan.rue@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELvQY90LXRloulHwCo/s3ZckwVCw8BQcQjlIeXyByaqMXKXrQTVuCo35VFF/gWXZLvJrLRJedw==
Date: Tue, 20 Mar 2018 07:49:53 +0800
From: Dan Rue <dan.rue@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, ben.hutchings@codethink.co.uk,
	shuahkh@osg.samsung.com, lkft-triage@lists.linaro.org,
	patches@kernelci.org, stable@vger.kernel.org,
	akpm@linux-foundation.org, torvalds@linux-foundation.org,
	linux@roeck-us.net
Subject: Re: [PATCH 4.4 000/134] 4.4.123-stable review
Message-ID: <20180319234953.ox3v57p77t33ipd2@xps>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, ben.hutchings@codethink.co.uk,
	shuahkh@osg.samsung.com, lkft-triage@lists.linaro.org,
	patches@kernelci.org, stable@vger.kernel.org,
	akpm@linux-foundation.org, torvalds@linux-foundation.org,
	linux@roeck-us.net
References: <20180319171849.024066323@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
User-Agent: NeoMutt/20180223
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595390786580465385?=
X-GMAIL-MSGID: =?utf-8?q?1595411945451693633?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 19, 2018 at 07:04:43PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.123 release.
> There are 134 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Mar 21 17:18:04 UTC 2018.
> Anything received after that time might be too late.

4.4 fails to build on arm32 with default config due to
b4df31e348a4 ("ARM: DRA7: hwmod_data: Prevent wait_target_disable error for usb_otg_ss")

#
# make -j10 -k -s ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- O=build-arm multi_v7_defconfig
#
#
# make -j10 -k -s ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- O=build-arm 
#
../arch/arm/mach-omap2/omap_hwmod_7xx_data.c:2243:12: error: 'HWMOD_CLKDM_NOAUTO' undeclared here (not in a function)
  .flags  = HWMOD_CLKDM_NOAUTO,
            ^
../scripts/Makefile.build:269: recipe for target 'arch/arm/mach-omap2/omap_hwmod_7xx_data.o' failed
make[2]: *** [arch/arm/mach-omap2/omap_hwmod_7xx_data.o] Error 1
make[2]: Target '__build' not remade because of errors.
/home/buildslave/workspace/kernel-single-defconfig-builder/defconfig/multi_v7_defconfig/label/builder/Makefile:969: recipe for target 'arch/arm/mach-omap2' failed
make[1]: *** [arch/arm/mach-omap2] Error 2
make[1]: Target '_all' not remade because of errors.
Makefile:152: recipe for target 'sub-make' failed
make: *** [sub-make] Error 2
make: Target '_all' not remade because of errors.

Dan
