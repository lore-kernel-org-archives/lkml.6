Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EFD1C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 05:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36FC1205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 05:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fYmoyOQR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36FC1205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbeH3JzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 05:55:21 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:53373 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbeH3JzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 05:55:21 -0400
Received: by mail-it0-f68.google.com with SMTP id p79-v6so1050923itp.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 22:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=oUDvcb9Exnk+DwTggIYkNboKl4VpBN2wI96GH9WdNGs=;
        b=fYmoyOQRVztHwlDZQ0w5IDSTjRgsPaIgikg0Y9zFCwbsYmPL/WlmW29ZEBxOqk+R3L
         7gJuc8P/9C/QY0HHO6o5Q4pjy2ax6tyDypv8z99FP+r0a8HZZoiS4Rg+IDe3rE6FRgh/
         El5MWjfK1Exws/LxF77hD4CAzSLiduPu7HvCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=oUDvcb9Exnk+DwTggIYkNboKl4VpBN2wI96GH9WdNGs=;
        b=P12lPkYllVK0SL6evpqMgSNgOPSKVUJUOnL/QHNVhtXuVEkx1HJE9APXy7NTqy54Hz
         uj+Dp53MD7hcQx28F3r2N/eMBzU2A13e7sudNSyJxGQUEVEzirAe2VXYBYOEQB8Pd8uU
         X+VOSzP6JVEyYQhn14OANyRGIeP6gNl8BQ1e3Uj9+EDnjGlJJiKSwZ2y+NNAXoVpoWBX
         py4T9S/iLVQxgAUKtY0eqrTJNnNCNK9R+mGtxTlV9Yq+hBLv3kFELBF9GN5ckSIjnaVS
         HVUgKT2sNGmze6SFFJ4bfpx9EQ5Npjv+4ql6bE/1/eUEk7veuivlQRZjO5DbpMcUKuYG
         +IJw==
X-Gm-Message-State: APzg51BE6V2HeAprf1bHSdaW94808oLQXRn7XUh5rSRIFfCQF5iphsfq
        o1/8MqT8ejXWdDBIevU05zkcURRIzayoo6gDM0zZJQ==
X-Google-Smtp-Source: ANB0VdbKR0UveXCRi1ZI9UbcXnFWr02Ck6uud0PkRxpjdxVQQD/bjpKEPOBge0aIqXUhJFarpbZvBsTuV5ADzVOK16U=
X-Received: by 2002:a24:57cb:: with SMTP id u194-v6mr939033ita.148.1535608492784;
 Wed, 29 Aug 2018 22:54:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:ac05:0:0:0:0:0 with HTTP; Wed, 29 Aug 2018 22:54:52
 -0700 (PDT)
In-Reply-To: <fb07b89d-d427-5e59-9f17-b12df26284ec@broadcom.com>
References: <1535563287-24803-1-git-send-email-scott.branden@broadcom.com>
 <CAOesGMhjcJ1p3QcEYb9fsx3fMXAOsgR2njOq=VKgEbWGwJi36g@mail.gmail.com> <fb07b89d-d427-5e59-9f17-b12df26284ec@broadcom.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 30 Aug 2018 07:54:52 +0200
Message-ID: <CAKv+Gu-R7eX=aj=O2-gpzmp0K4t0T4s536UiqJZs0WuxRjkYwQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: defconfig: enable EFI_ARMSTUB_DTB_LOADER
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Olof Johansson <olof@lixom.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 August 2018 at 20:59, Scott Branden <scott.branden@broadcom.com> wrote:
> Hi Olof,
>
>
> On 18-08-29 11:44 AM, Olof Johansson wrote:
>>
>> Hi,
>>
>> On Wed, Aug 29, 2018 at 10:21 AM, Scott Branden
>> <scott.branden@broadcom.com> wrote:
>>>
>>> Enable EFI_ARMSTUB_DTB_LOADER to add support for the dtb= command line
>>> parameter to function with efi loader.
>>>
>>> Required to boot on existing bootloaders that do not support devicetree
>>> provided by the platform or by the bootloader.
>>>
>>> Fixes: 3d7ee348aa41 ("efi/libstub/arm: Add opt-in Kconfig option for the
>>> DTB loader")
>>> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
>>
>> Why did Ard create an option for this if it's just going be turned on
>> in default configs? Doesn't make sense to me.
>>
>> It would help to know what firmware still is crippled and how common
>> it is, since it's been a few years that this has been a requirement by
>> now.
>
> Broadcom NS2 and Stingray in current development and production need this
> option in the kernel enabled in order to boot.

And these production systems run mainline kernels in a defconfig configuration?

The simply reality is that the DTB loader has been deprecated for a
good reason: it was only ever intended as a development hack anyway,
and if we need to treat the EFI stub provided DTB as a first class
citizen, there are things we need to fix to make things works as
expected. For instance, GRUB will put a property in the /chosen node
for the initramfs which will get dropped if you boot with dtb=.

Don't be surprised if some future enhancements of the EFI stub code
depend on !EFI_ARMSTUB_DTB_LOADER. On UEFI systems, DTBs [or ACPI
tables] are used by the firmware to describe itself and the underlying
platform to the OS, and the practice of booting with DTB file images
(taken from the kernel build as well) conflicts with that view. Note
that GRUB still permits you to load DTBs from files (and supports more
sources than just the file system the kernel Image was loaded from).
