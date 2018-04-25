Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752079AbeDYJD3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 05:03:29 -0400
Received: from mail-lf0-f49.google.com ([209.85.215.49]:37161 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751278AbeDYJCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 05:02:25 -0400
X-Google-Smtp-Source: AIpwx48SK0B6DFu8A6fafP9FNgaPUB0OLX5EF2li3F9s5LGhCFOlMGgGB0L8mImXXhwHwlPG1igzoA==
Subject: Re: [PATCH] ARM: BCM5301X: Fix NAND ECC parameters for Linksys
 Panamera
To: Vivek Unune <npcomplete13@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, Jon Mason <jonmason@broadcom.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180310171244.70299-1-npcomplete13@gmail.com>
 <CACna6rz1TeRbPq-60HkHz9A0TDn+iXtmXniE6FCiANpUmV-qrw@mail.gmail.com>
 <20180311100313.znonhesgh462rz65@osboxes>
 <2ef6e4fc-cce7-372e-e35f-578fd6ada9ca@gmail.com>
 <20180313010210.ws4dugy3rrpqwzmk@osboxes>
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Message-ID: <00df9ee9-2bd2-ad2b-fdf8-682efdb9a4d1@gmail.com>
Date: Wed, 25 Apr 2018 11:02:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <20180313010210.ws4dugy3rrpqwzmk@osboxes>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.03.2018 02:02, Vivek Unune wrote:
> On Mon, Mar 12, 2018 at 03:52:27PM -0700, Florian Fainelli wrote:
>> On 03/11/2018 03:03 AM, Vivek Unune wrote:
>>> Hi Rafał,
>>>
>>> On Sat, Mar 10, 2018 at 10:41:04PM +0100, Rafał Miłecki wrote:
>>>> On 10 March 2018 at 18:12, Vivek Unune <npcomplete13@gmail.com> wrote:
>>>>> Using BCH8 gives ecc errors and makes the router unsuable.
>>>>> Switching to BCH1 fixes these errors.
>>>>
>>>> Can you provide CFE's log messages starting with
>>>> "Decompressing...done" and up to the "Press Ctrl+C to stop in CFE"
>>>> please? I'd like to see what NAND info CFE prints there.
>>>
>>> See below. It does say BCH-8, however I can't get it to work.
>>>
>>> CFE log:
>>>
>>> Decompressing...done
>>> Found a Toshiba NAND flash:
>>> Total size:  128MB
>>> Block size:  128KB
>>> Page Size:   2048B
>>> OOB Size:    64B
>>> Sector size: 512B
>>> Spare size:  16B
>>> ECC level:   8 (8-bit)
>>> Device ID: 0x98 0xf1 0x80 0x15 0xf2 0x16
>>> find_devinfo: devinfo block found at 0x00180000!
>>>
>>> Press Ctrl+C to stop in CFE
>>
>> What kind of error are you getting in Linux with BCH-8?
> 
> See below:
> 
> [   12.941850] Generic PHY dsa-1.0:03: attached PHY driver [Generic PHY] (mii_bus:phy_addr=dsa-1.0:03, irq=POLL)
> [   12.991851] Generic PHY dsa-1.0:04: attached PHY driver [Generic PHY] (mii_bus:phy_addr=dsa-1.0:04, irq=POLL)
> [   13.032404] UBI: auto-attach mtd5
> [   13.035731] ubi0: attaching mtd5
> [   13.115701] ubi0 warning: 0xc037c9e4: error -74 (ECC error) while reading 64 bytes from PEB 113:0, read only 64 bytes, retry
> [   13.127630] ubi0 warning: 0xc037c9e4: error -74 (ECC error) while reading 64 bytes from PEB 113:0, read only 64 bytes, retry
> [   13.139524] ubi0 warning: 0xc037c9e4: error -74 (ECC error) while reading 64 bytes from PEB 113:0, read only 64 bytes, retry
> [   13.151419] ubi0 error: 0xc037ca08: error -74 (ECC error) while reading 64 bytes from PEB 113:0, read 64 bytes
> [   13.161448] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.14.25 #0
> [   13.167460] Hardware name: BCM5301X
> [   13.170951] Backtrace:
> [   13.173398] Function entered at [<c0105ccc>] from [<c0105fb4>]
> [   13.179240]  r7:00000000 r6:60000013 r5:00000000 r4:c081d988
> [   13.184903] Function entered at [<c0105f9c>] from [<c04f29a8>]
> [   13.190744] Function entered at [<c04f2918>] from [<c037ca0c>]
> [   13.196586]  r7:00000000 r6:00000040 r5:c7954000 r4:ffffffb6
> [   13.202251] Function entered at [<c037c7dc>] from [<c037cd1c>]
> [   13.208095]  r10:00000000 r9:00000040 r8:00000071 r7:c7954000 r6:c7979000 r5:c7036180
> [   13.215941]  r4:c7b72900
> [   13.218475] Function entered at [<c037cca4>] from [<c0381c5c>]
> [   13.224318]  r10:00000000 r9:c7979800 r8:c7954000 r7:c7979000 r6:00000071 r5:c7036180
> [   13.232157]  r4:c7b72900
> [   13.234690] Function entered at [<c0381a84>] from [<c0376d74>]
> [   13.240534]  r10:c7954040 r9:00000840 r8:c702e400 r7:00000000 r6:c702e400 r5:c7954000
> [   13.248381]  r4:fffff800
> [   13.250914] Function entered at [<c0376720>] from [<c0717b9c>]
> [   13.256759]  r10:c0813a88 r9:c0651c18 r8:c0651bec r7:c084ff48 r6:c081e440 r5:c7823ea4
> [   13.264605]  r4:c702e400
> [   13.267139] Function entered at [<c0717954>] from [<c0101a8c>]
> [   13.272983]  r10:c072e83c r9:c07366b8 r8:c0717954 r7:c072e838 r6:c081e440 r5:00000000
> [   13.280830]  r4:c0803c08
> [   13.283363] Function entered at [<c01019dc>] from [<c0700e38>]
> [   13.289206]  r9:c07366b8 r8:c0700594 r7:c072e838 r6:c081e440 r5:c081e440 r4:00000008
> [   13.296958] Function entered at [<c0700cf8>] from [<c0506adc>]
> [   13.302802]  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c0506acc
> [   13.310641]  r4:00000000
> [   13.313175] Function entered at [<c0506acc>] from [<c0102788>]
> [   13.319015]  r5:c0506acc r4:00000000
> [   13.323289] ubi0 warning: 0xc037c9e4: error -74 (ECC error) while reading 64 bytes from PEB 114:0, read only 64 bytes, retry
> [   13.335178] ubi0 warning: 0xc037c9e4: error -74 (ECC error) while reading 64 bytes from PEB 114:0, read only 64 bytes, retry
> [   13.347066] ubi0 warning: 0xc037c9e4: error -74 (ECC error) while reading 64 bytes from PEB 114:0, read only 64 bytes, retry
> [   13.358956] ubi0 error: 0xc037ca08: error -74 (ECC error) while reading 64 bytes from PEB 114:0, read 64 bytes
> [   13.368989] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.14.25 #0
> [   13.375007] Hardware name: BCM5301X
> [   13.378496] Backtrace:
> [   13.380943] Function entered at [<c0105ccc>] from [<c0105fb4>]
> [   13.386787]  r7:00000000 r6:60000013 r5:00000000 r4:c081d988
> [   13.392450] Function entered at [<c0105f9c>] from [<c04f29a8>]
> [   13.398291] Function entered at [<c04f2918>] from [<c037ca0c>]
> [   13.404133]  r7:00000000 r6:00000040 r5:c7954000 r4:ffffffb6
> [   13.409797] Function entered at [<c037c7dc>] from [<c037cd1c>]
> [   13.415641]  r10:00000000 r9:00000040 r8:00000072 r7:c7954000 r6:c7979000 r5:c7036180
> [   13.423488]  r4:c7b72900
> [   13.426021] Function entered at [<c037cca4>] from [<c0381c5c>]
> [   13.431865]  r10:00000000 r9:c7979800 r8:c7954000 r7:c7979000 r6:00000072 r5:c7036180
> [   13.439704]  r4:c7b72900
> [   13.442237] Function entered at [<c0381a84>] from [<c0376d74>]
> [   13.448081]  r10:c7954040 r9:00000840 r8:c702e400 r7:00000000 r6:c702e400 r5:c7954000
> [   13.455928]  r4:fffff800
> [   13.458461] Function entered at [<c0376720>] from [<c0717b9c>]
> [   13.464305]  r10:c0813a88 r9:c0651c18 r8:c0651bec r7:c084ff48 r6:c081e440 r5:c7823ea4
> [   13.472152]  r4:c702e400
> [   13.474685] Function entered at [<c0717954>] from [<c0101a8c>]
> [   13.480529]  r10:c072e83c r9:c07366b8 r8:c0717954 r7:c072e838 r6:c081e440 r5:00000000
> [   13.488376]  r4:c0803c08
> [   13.490909] Function entered at [<c01019dc>] from [<c0700e38>]
> [   13.496754]  r9:c07366b8 r8:c0700594 r7:c072e838 r6:c081e440 r5:c081e440 r4:00000008
> [   13.504514] Function entered at [<c0700cf8>] from [<c0506adc>]
> [   13.510358]  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c0506acc
> [   13.518197]  r4:00000000
> [   13.520730] Function entered at [<c0506acc>] from [<c0102788>]
> [   13.526570]  r5:c0506acc r4:00000000
> [   13.530863] ubi0 warning: 0xc037c9e4: error -74 (ECC error) while reading 64 bytes from PEB 115:0, read only 64 bytes, retry
> [   13.542763] ubi0 warning: 0xc037c9e4: error -74 (ECC error) while reading 64 bytes from PEB 115:0, read only 64 bytes, retry
> [   13.554659] ubi0 warning: 0xc037c9e4: error -74 (ECC error) while reading 64 bytes from PEB 115:0, read only 64 bytes, retry
> [   13.566548] ubi0 error: 0xc037ca08: error -74 (ECC error) while reading 64 bytes from PEB 115:0, read 64 bytes
> [   13.576574] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.14.25 #0
> [   13.582589] Hardware name: BCM5301X
> [   13.586078] Backtrace:
> [   13.588526] Function entered at [<c0105ccc>] from [<c0105fb4>]
> [   13.594368]  r7:00000000 r6:60000013 r5:00000000 r4:c081d988
> [   13.600032] Function entered at [<c0105f9c>] from [<c04f29a8>]
> [   13.605872] Function entered at [<c04f2918>] from [<c037ca0c>]
> [   13.611714]  r7:00000000 r6:00000040 r5:c7954000 r4:ffffffb6
> [   13.617378] Function entered at [<c037c7dc>] from [<c037cd1c>]
> [   13.623223]  r10:00000000 r9:00000040 r8:00000073 r7:c7954000 r6:c7979000 r5:c7036180
> [   13.631071]  r4:c7b72900
> [   13.633604] Function entered at [<c037cca4>] from [<c0381c5c>]
> [   13.639447]  r10:00000000 r9:c7979800 r8:c7954000 r7:c7979000 r6:00000073 r5:c7036180
> [   13.647286]  r4:c7b72900
> [   13.649819] Function entered at [<c0381a84>] from [<c0376d74>]
> [   13.655663]  r10:c7954040 r9:00000840 r8:c702e400 r7:00000000 r6:c702e400 r5:c7954000
> [   13.663510]  r4:fffff800
> [   13.666042] Function entered at [<c0376720>] from [<c0717b9c>]
> [   13.671886]  r10:c0813a88 r9:c0651c18 r8:c0651bec r7:c084ff48 r6:c081e440 r5:c7823ea4
> [   13.679725]  r4:c702e400
> [   13.682258] Function entered at [<c0717954>] from [<c0101a8c>]
> [   13.688103]  r10:c072e83c r9:c07366b8 r8:c0717954 r7:c072e838 r6:c081e440 r5:00000000
> [   13.695949]  r4:c0803c08
> [   13.698482] Function entered at [<c01019dc>] from [<c0700e38>]
> [   13.704327]  r9:c07366b8 r8:c0700594 r7:c072e838 r6:c081e440 r5:c081e440 r4:00000008
> [   13.712087] Function entered at [<c0700cf8>] from [<c0506adc>]
> [   13.717930]  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c0506acc
> [   13.725769]  r4:00000000
> [   13.728303] Function entered at [<c0506acc>] from [<c0102788>]
> [   13.734144]  r5:c0506acc r4:00000000
> [   13.738425] ubi0 warning: 0xc037c9e4: error -74 (ECC error) while reading 64 bytes from PEB 116:0, read only 64 bytes, retry
> [   13.750319] ubi0 warning: 0xc037c9e4: error -74 (ECC error) while reading 64 bytes from PEB 116:0, read only 64 bytes, retry
> [   13.762213] ubi0 warning: 0xc037c9e4: error -74 (ECC error) while reading 64 bytes from PEB 116:0, read only 64 bytes, retry
> [   13.774103] ubi0 error: 0xc037ca08: error -74 (ECC error) while reading 64 bytes from PEB 116:0, read 64 bytes
> [   13.784130] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.14.25 #0

This is expected if you previously were using firmware programming flash
in non-BCH8 mode. The main reason for what you're seeing is that when
flashing image with CFE it doesn't erase all NAND pages.

If previously you were using firmware programming flash in BCH1 mode, it
means that after flashing firmware using BCH8 you'll end up with mess in
ECC.

Part of NAND flash programmed by CFE will use BCH8.
Part of NAND flash that remained from previous fw will use BCH1.
Linux will fail to read part of NAND flash from prev installation.

The cleanest solution: erase all NAND content of firmware partition
before flashing firmware using BCH8.

The easiest solution: ignore all these "error -74 (ECC error) while
reading" errors (they may last for few minutes!). I believe UBI should
simply recreate all pages it couldn't access and once you wait long
enough, all your NAND flash will be using BCH8.
