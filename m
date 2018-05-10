Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935281AbeEJLUF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 07:20:05 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36199 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934002AbeEJLUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 07:20:03 -0400
X-Google-Smtp-Source: AB8JxZp60B4/63UgfN4yZxItuEMtnbbbL67VRJwX7bSUHSbt8eFJpgd83b99FLiB/3l1Cr5N+yVRNR0bR2khqHcVxcY=
MIME-Version: 1.0
In-Reply-To: <20180510131725.111079af@wiggum>
References: <20180510111401.1161-1-zajec5@gmail.com> <20180510111401.1161-2-zajec5@gmail.com>
 <20180510131725.111079af@wiggum>
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Date: Thu, 10 May 2018 13:20:01 +0200
Message-ID: <CACna6ryWUCnrw9w4yhfiNXFHy1hFjVV-BqH07i7DQqxq8FtjMw@mail.gmail.com>
Subject: Re: [PATCH 4.17 2/2] ssb: make SSB_PCICORE_HOSTMODE depend on SSB = y
To: =?UTF-8?Q?Michael_B=C3=BCsch?= <m@bues.ch>
Cc: Kalle Valo <kvalo@codeaurora.org>,
        Larry Finger <larry.finger@lwfinger.net>,
        Matt Redfearn <matt.redfearn@mips.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Hauke Mehrtens <hauke@hauke-m.de>, LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4ABKBK3024722

On 10 May 2018 at 13:17, Michael Büsch <m@bues.ch> wrote:
> On Thu, 10 May 2018 13:14:01 +0200
> Rafał Miłecki <zajec5@gmail.com> wrote:
>
>> From: Rafał Miłecki <rafal@milecki.pl>
>>
>> SSB_PCICORE_HOSTMODE protects MIPS specific code that calls not exported
>> symbols pcibios_enable_device and register_pci_controller. This code is
>> supposed to be compiled only with ssb builtin.
>>
>> This fixes:
>> ERROR: "pcibios_enable_device" [drivers/ssb/ssb.ko] undefined!
>> ERROR: "register_pci_controller" [drivers/ssb/ssb.ko] undefined!
>> make[1]: *** [scripts/Makefile.modpost:92: __modpost] Error 1
>>
>> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
>> ---
>>  drivers/ssb/Kconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/ssb/Kconfig b/drivers/ssb/Kconfig
>> index b3f5cae98ea6..c574dd210500 100644
>> --- a/drivers/ssb/Kconfig
>> +++ b/drivers/ssb/Kconfig
>> @@ -131,7 +131,7 @@ config SSB_DRIVER_PCICORE
>>
>>  config SSB_PCICORE_HOSTMODE
>>       bool "Hostmode support for SSB PCI core"
>> -     depends on SSB_DRIVER_PCICORE && SSB_DRIVER_MIPS
>> +     depends on SSB_DRIVER_PCICORE && SSB_DRIVER_MIPS && SSB = y
>>       help
>>         PCIcore hostmode operation (external PCI bus).
>>
>
>
> I think we also need to depend on PCI_DRIVERS_LEGACY.
> See the other patch that floats around.

I believe it's already handled by SSB_PCIHOST_POSSIBLE's dependency on
PCI_DRIVERS_LEGACY.

-- 
Rafał
