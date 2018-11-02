Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F05C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 22:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB66F2082D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 22:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mzA2Rp9d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB66F2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbeKCHSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 03:18:51 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33419 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbeKCHSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 03:18:50 -0400
Received: by mail-qk1-f194.google.com with SMTP id o89so5542462qko.0;
        Fri, 02 Nov 2018 15:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=VBdkJFAhkpRJeeLuhXI+zUMh5vjDzPrabtG/iD3N8Jk=;
        b=mzA2Rp9djT36IgoRJnhN2XAiuksBzMHJ/Y+PfCocNGTDl+vGQ8GiF4f36aLjJazjYV
         93CMxT1iXTKYZHFczXx78A5RKlGdYIHowmOv6Z15j7EUeChACpH/RqKogw/rbBemoB9v
         luP3aBbGgmSajsVHAaWz9x2vGfrwblD7LfNnHG+pVW30IeIGZNkaKXPpUGbCguS0dOYf
         Lsete9naTeNQkruR5U/DUTRd1uzAZLGxrnXGakIfG/lcbMPptKvbbqvZUa+K4C8bM3tF
         nMgqLaJw+iIpN6ORriUvGa4Ujy0tl0jKXZIbFLjB8MH68qtnvlJ6OgGhxKum3o/2WcRC
         MttA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=VBdkJFAhkpRJeeLuhXI+zUMh5vjDzPrabtG/iD3N8Jk=;
        b=HbMD3yW04VrYwW+/ZV/lotuwEeDrEfX5onYoolbWIlD7PNdY0eEWSGHrCekPdxQ3hg
         YMiLwLy1Yu3swy73KHHrcCZyIwfWJbTF3/lYbJgKu2vOgQyeNO01M7EcCAJPQrJxhvN4
         dxonSn5GMewoRR4JUpDB9581bc4vq4CgbzgyrRjHvFACsKKH+1Vx6gLk2VVi1eCn2HWx
         hDo1S7WI23n4EAj3SObkX1WhRlbS+v06iNyYIp8xZ9FniPl7gjoZ+DQLwmvhjxa2opo9
         82XAnDwFM/rDNLzHkJDjkNs5YnIiu+wm3MbZwFdqTJ9bmvf8yngtWpjVVML178fFWnmb
         JR5w==
X-Gm-Message-State: AGRZ1gJw4ut/VKLdO+/ObjjiijzjR/Fjy7fnmIWs3me0pupoTjT4YMk3
        8HETkMSuHsoAXmku+HC6cCLNpakLLoGnufKIkWo=
X-Google-Smtp-Source: AJdET5eFdRhOB1iVbwiSR+6BIfTg77YJWtYQ4KF3gzpwTdFev3NP4MnolboGQmQZ8HJ04lK4ChpVzqxvhF8s38KpzJ0=
X-Received: by 2002:ae9:d801:: with SMTP id u1-v6mr12367581qkf.291.1541196594875;
 Fri, 02 Nov 2018 15:09:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:9881:0:0:0:0:0 with HTTP; Fri, 2 Nov 2018 15:09:54 -0700 (PDT)
In-Reply-To: <CAK8P3a2ESTVLG3q0LgDmjqa_LbYhLCeqYW3Jod6WUCh2fwFOZg@mail.gmail.com>
References: <20181102110653.118257-1-arnd@arndb.de> <20181102151644.GB10650@smile.fi.intel.com>
 <CAK8P3a2ESTVLG3q0LgDmjqa_LbYhLCeqYW3Jod6WUCh2fwFOZg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 2 Nov 2018 23:09:54 +0100
X-Google-Sender-Auth: CTc1owDKB7bQsj7sJOSXR_2t3OI
Message-ID: <CAK8P3a2k0XTtKhL=A6yg80ZcJsMF46m_c6hZv2bDr3_+kpyBtg@mail.gmail.com>
Subject: Re: [PATCH] ACPI / PMIC: xpower: fix IOSF_MBI dependency
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/2/18, Arnd Bergmann <arnd@arndb.de> wrote:
> On 11/2/18, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>> On Fri, Nov 02, 2018 at 12:06:43PM +0100, Arnd Bergmann wrote:
>>> We still get a link failure with IOSF_MBI=m when the xpower driver
>>> is built-in:
>>>
>>> drivers/acpi/pmic/intel_pmic_xpower.o: In function
>>> `intel_xpower_pmic_update_power':
>>> intel_pmic_xpower.c:(.text+0x4f2): undefined reference to
>>> `iosf_mbi_block_punit_i2c_access'
>>> intel_pmic_xpower.c:(.text+0x5e2): undefined reference to
>>> `iosf_mbi_unblock_punit_i2c_access'
>>>
>>> This makes the dependency stronger, so we can only build when IOSF_MBI
>>> is built-in.
>>>
>>> Fixes: 6a9b593d4b6f ("ACPI / PMIC: xpower: Add depends on IOSF_MBI to
>>> Kconfig entry")
>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>> ---
>>>  drivers/acpi/Kconfig | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
>>> index 18851e7eedd5..31a3c4a03f61 100644
>>> --- a/drivers/acpi/Kconfig
>>> +++ b/drivers/acpi/Kconfig
>>> @@ -514,7 +514,7 @@ config CRC_PMIC_OPREGION
>>>
>>>  config XPOWER_PMIC_OPREGION
>>>  	bool "ACPI operation region support for XPower AXP288 PMIC"
>>> -	depends on MFD_AXP20X_I2C && IOSF_MBI
>>> +	depends on MFD_AXP20X_I2C && IOSF_MBI=y
>>
>> To me sounds like
>>
>> select IOSF_MBI would be more appropriate here.
>
> It looks like we have a mix of the two two, with most drivers
> using 'select' and only a few ones using 'depends on'. Mixing
> the two often leads to trouble, especially for user-visible
> symbols.
>
> Making it a hidden symbol that is always selected is probably
> fine, but then every driver selecting it must also use 'depends
> on X86 && PCI'.

Oh, and that also requires removing the #else section in
arch/x86/include/asm/iosf_mbi.h, otherwise you might have
a driver that can build with or without CONFIG_IOSF_MBI,
but fails to be built-in when some other tristate symbol
uses 'select IOSF_MBI'. Making it a 'bool' seems easier
there.

        Arnd
