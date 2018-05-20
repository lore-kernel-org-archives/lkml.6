Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752579AbeETDpI (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 23:45:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42752 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752459AbeETDpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 23:45:06 -0400
Subject: Re: [ANNOUNCE] Kconfiglib menuconfig implementation
To: Ulf Magnusson <ulfalizer@gmail.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAFkk2KRTnRpi5thUGTM2+LZMyitggdJtiOBO7E0pTn93fz6-SQ@mail.gmail.com>
 <d4c3b2ab-385d-fe7a-bdb1-2d497d620de5@infradead.org>
 <CAFkk2KRozscmd4kQSJKwKmY3WpTody7S5XZZObf8SKLF62k6+w@mail.gmail.com>
 <CAFkk2KRkEt3+786QvyjzPPAm+3HDe2+ydzZJpshfdKyUDQVfuw@mail.gmail.com>
 <CAFkk2KRvSxu+x-nb045=3L63KEk5h9URr5QYLPoYp6rqqTR4qA@mail.gmail.com>
 <3d9be2f2-3fbe-411b-8529-0e0847f01346@infradead.org>
 <CAFkk2KRWon_S--dxYw82cDyGXKTFA6jxrrQwstzLvHPs=6-dqQ@mail.gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c4ec710f-b2bd-b9f0-c33a-159aa53ca73c@infradead.org>
Date: Sat, 19 May 2018 20:45:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAFkk2KRWon_S--dxYw82cDyGXKTFA6jxrrQwstzLvHPs=6-dqQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/08/2018 09:59 AM, Ulf Magnusson wrote:
> Hello,
> 
> I've added incremental search for jumping directly to a symbol now.
> Regular expressions are supported as well.
> 
> Some screenshots below:
> 
> https://raw.githubusercontent.com/ulfalizer/Kconfiglib/screenshots/screenshots/ss10.png
> https://raw.githubusercontent.com/ulfalizer/Kconfiglib/screenshots/screenshots/ss11.png
> https://raw.githubusercontent.com/ulfalizer/Kconfiglib/screenshots/screenshots/ss13.png
> 
> The last screenshot shows how things might look after you jump to a
> symbol. The jumped-to symbol wasn't visible in this case, so show-all
> mode was turned on automatically.

Hi Ulf,

Do I need to save kconfiglib.py in a special location?

With (new) kconfiglib.py and menuconfig.py, I am getting this:

$ make ARCH=x86_64 O=xx64 iscriptconfig
make[1]: Entering directory '/home/rdunlap/lnx/lnx-417-rc3/xx64'
  GEN     ./Makefile
Traceback (most recent call last):
  File "<string>", line 1, in <module>
ImportError: No module named 'kconfiglib'
>>> 

and then if I (being a Python novice) copy kconfiglib.py to
/usr/lib/python3.4/site-packages/ and try again, I get 16 warning messages (below)
and then this:

A Kconfig instance 'kconf' for the architecture x86_64 has been created.
>>> 

What am I supposed to do now?

Hm, OK, I used the trick that you supplied a few weeks ago and I have the UI now.

    ARCH=x86 SRCARCH=x86 KERNELVERSION=`make kernelversion` \
        Kconfiglib/menuconfig.py

so yes, a real Makefile target would be nice. :)


thanks,
-- 
~Randy

the 16 warning messages:

warning: SCSI_DPT_I2O (defined at drivers/scsi/Kconfig:482) has leading or trailing whitespace in its prompt
warning: ATM_FIRESTREAM (defined at drivers/atm/Kconfig:149) has leading or trailing whitespace in its prompt
warning: IWLWIFI (defined at drivers/net/wireless/intel/iwlwifi/Kconfig:1) has leading or trailing whitespace in its prompt
warning: REGULATOR_MAX8973 (defined at drivers/regulator/Kconfig:479) has leading or trailing whitespace in its prompt
warning: MEMSTICK_TIFM_MS (defined at drivers/memstick/host/Kconfig:7) has leading or trailing whitespace in its prompt
warning: MV_XOR_V2 (defined at drivers/dma/Kconfig:374) has leading or trailing whitespace in its prompt
warning: PANEL_LCD_PIN_E (defined at drivers/auxdisplay/Kconfig:335) has leading or trailing whitespace in its prompt
warning: PANEL_LCD_PIN_RS (defined at drivers/auxdisplay/Kconfig:350) has leading or trailing whitespace in its prompt
warning: PANEL_LCD_PIN_RW (defined at drivers/auxdisplay/Kconfig:365) has leading or trailing whitespace in its prompt
warning: PANEL_LCD_PIN_SCL (defined at drivers/auxdisplay/Kconfig:380) has leading or trailing whitespace in its prompt
warning: PANEL_LCD_PIN_SDA (defined at drivers/auxdisplay/Kconfig:395) has leading or trailing whitespace in its prompt
warning: PANEL_LCD_PIN_BL (defined at drivers/auxdisplay/Kconfig:410) has leading or trailing whitespace in its prompt
warning: INTEGRITY_AUDIT (defined at security/integrity/Kconfig:54) has leading or trailing whitespace in its prompt
warning: the choice symbol VIRT_CPU_ACCOUNTING_GEN (defined at init/Kconfig:359) is selected by the following symbols, which has no effect: 
 - NO_HZ_FULL (defined at kernel/time/Kconfig:85)
warning: the choice symbol M486 (defined at arch/x86/Kconfig.cpu:53) is selected by the following symbols, which has no effect: 
 - X86_RDC321X (defined at arch/x86/Kconfig:653)
warning: the choice symbol FB_LITTLE_ENDIAN (defined at drivers/video/fbdev/Kconfig:168) is selected by the following symbols, which has no effect: 
 - FB_MB862XX_LIME (defined at drivers/video/fbdev/Kconfig:2190)
