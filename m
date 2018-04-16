Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754514AbeDPJH1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 05:07:27 -0400
Received: from mail-ua0-f169.google.com ([209.85.217.169]:37737 "EHLO
        mail-ua0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754176AbeDPJHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 05:07:25 -0400
X-Google-Smtp-Source: AIpwx48p87rXL9SY6hnl7RY/Q35tvhoNTTMMWJBNlL/rbPLX+IZsc3FibhaFlvTCf7KqffWwrAqkEs0KiDKwyfD6coU=
MIME-Version: 1.0
In-Reply-To: <4ccb747b-fb3b-18c8-8737-2cc02d7b1c34@roeck-us.net>
References: <4ccb747b-fb3b-18c8-8737-2cc02d7b1c34@roeck-us.net>
From: Greentime Hu <green.hu@gmail.com>
Date: Mon, 16 Apr 2018 17:06:44 +0800
Message-ID: <CAEbi=3cr5i3HKLKOacFih9pz00c7UBKrd=o4ER8HAUT1j_oqGg@mail.gmail.com>
Subject: Re: nds32 build failures
To: Guenter Roeck <private@roeck-us.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vincent Chen <vincentc@andestech.com>,
        Greentime Hu <greentime@andestech.com>, Arnd Bergmann <arnd@arndb.de>,
        kito.cheng@gmail.com, wuiw@andestech.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-04-16 11:58 GMT+08:00 Guenter Roeck <private@roeck-us.net>:
> I thought I should give the brand new architecture a try. Unfortunately,
> that was not very successful.
>
> Build reference: v4.17-rc1
> gcc version: nds32le-elf-gcc (GCC) 7.3.0
>
> Building nds32:defconfig ... failed
>
> arch/nds32/include/asm/nds32.h: In function 'GIE_ENABLE':
> arch/nds32/include/asm/nds32.h:25:2: error: implicit declaration of function
> '__nds32__gie_en'; did you mean '__nds32__'?
>
> arch/nds32/include/asm/nds32.h: In function 'CACHE_SET':
> arch/nds32/include/asm/nds32.h:38:18: error: implicit declaration of
> function '__nds32__mfsr'; did you mean '__nds32__'?
>
> arch/nds32/include/asm/nds32.h:38:32: error: 'NDS32_SR_ICM_CFG' undeclared
>
> arch/nds32/include/asm/nds32.h:41:32: error: 'NDS32_SR_DCM_CFG'
>
> Am I missing something ?
>

Hi, Guenter:

This built failure is because the toolchain version you used is not
supported the latest intrinsic function/macro.
We are sending the latest patchset now and we expect the whole new
features will be supported in gcc8.0.0 and binutil2.31+.

If you'd like to get these new features of toolchain, you may use the
github version.
This is the built-script repo. https://github.com/andestech/build_script.git
