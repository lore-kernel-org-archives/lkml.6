Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752111AbeBHGgk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 01:36:40 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:52782 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750865AbeBHGgi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 01:36:38 -0500
Subject: Re: dell-smbios makes wireless card unusable on Dell XPS 13 9360
To: Mario Limonciello <mario.limonciello@dell.com>
Cc: =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>,
        it+platform-driver-x86@molgen.mpg.de,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <7a59dd8f-c6a1-e412-931f-629ac5aa2800@molgen.mpg.de>
 <3e2d3a0bb0f8495b8b77d282a371b28c@ausx13mpc120.AMER.DELL.COM>
 <9b358453-915f-0721-1541-6ff793f5e811@molgen.mpg.de>
 <675694ab854f40548d57d7943cb4475f@ausx13mpc120.AMER.DELL.COM>
 <79d26fc7-8e26-ec13-ca52-57bc41d58d40@molgen.mpg.de>
 <7327e792366249329b9892a226f9d5c9@ausx13mpc120.AMER.DELL.COM>
From: Paul Menzel <pmenzel+platform-driver-x86@molgen.mpg.de>
Message-ID: <9bde344e-b689-c6d9-2ef5-14ff3371f8ec@molgen.mpg.de>
Date: Thu, 8 Feb 2018 07:36:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <7327e792366249329b9892a226f9d5c9@ausx13mpc120.AMER.DELL.COM>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Mario,


Am 08.02.2018 um 05:57 schrieb Mario.Limonciello@dell.com:
>> -----Original Message-----
>> From: Paul Menzel [mailto:pmenzel+platform-driver-x86@molgen.mpg.de]
>> Sent: Wednesday, February 7, 2018 3:41 AM
>> To: Limonciello, Mario <Mario_Limonciello@Dell.com>
>> Cc: Pali Rohár <pali.rohar@gmail.com>; it+platform-driver-x86@molgen.mpg.de;
>> platform-driver-x86@vger.kernel.org; linux-kernel@vger.kernel.org
>> Subject: Re: dell-smbios makes wireless card unusable on Dell XPS 13 9360

>> On 02/06/18 20:51, Mario.Limonciello@dell.com wrote:
>>>> -----Original Message-----
>>>> From: platform-driver-x86-owner@vger.kernel.org [mailto:platform-driver-x86-
>>>> owner@vger.kernel.org] On Behalf Of Paul Menzel
>>>> Sent: Tuesday, February 6, 2018 10:08 AM
>>>> To: Limonciello, Mario <Mario_Limonciello@Dell.com>
>>>> Cc: Pali Rohár <pali.rohar@gmail.com>; it+platform-driver-x86@molgen.mpg.de;
>>>> platform-driver-x86@vger.kernel.org; linux-kernel@vger.kernel.org
>>>> Subject: Re: dell-smbios makes wireless card unusable on Dell XPS 13 9360
>>
>>>> On 02/06/18 16:58, Mario.Limonciello@dell.com wrote:
>>>>
>>>>>> -----Original Message-----
>>>>>> From: Paul Menzel [mailto:pmenzel+platform-driver-x86@molgen.mpg.de]
>>>>>> Sent: Tuesday, February 6, 2018 9:50 AM
>>>>>> To: Pali Rohár <pali.rohar@gmail.com>; Limonciello, Mario
>>>>>> <Mario_Limonciello@Dell.com>; it+platform-driver-x86@molgen.mpg.de
>>>>>> Cc: platform-driver-x86@vger.kernel.org; Linux Kernel Mailing List <linux-
>>>>>> kernel@vger.kernel.org>
>>>>>> Subject: dell-smbios makes wireless card unusable on Dell XPS 13 9360
>>>>
>>>>>> Adding `dell-smbios` to `/etc/modules` on the Dell XPS 13 9360, it seems
>>>>>> to badly effect the Wireless LAN device, causing it to be absent or to
>>>>>> not work.
>>>>>>
>>>>>> In one case, the whole system lagged, that means, the log in screen
>>>>>> stayed grayed out for 15 seconds, and the mouse pointer stopped moving
>>>>>> every 20(?) seconds for some seconds.
>>>>>
>>>>> Can you please confirm if you're indicating this is a regression in 4.15?
>>>>> Or was this present in earlier kernels too?
>>>>
>>>> Yes, it happened with Ubuntu’s 4.13 too. My original message had one log
>>>> attached where the Wifi wasn’t visible at all.
>>>
>>> Looking at that log it looks to me that the ath10k firmware crashed, not that
>>> dell-smbios lagging caused the crash.
>>>
>>> [   15.262226] ath10k_pci 0000:3a:00.0: firmware crashed! (uuid a6c40788-b7ad-4f6a-890a-62e62c1f6e5f)
>>> [   15.262233] ath10k_pci 0000:3a:00.0: qca6174 hw3.2 target 0x05030000chip_id 0x00340aff sub 1a56:1535
>>> [   15.262235] ath10k_pci 0000:3a:00.0: kconfig debug 0 debugfs 1 tracing 1 dfs 0 testmode 0
>>> [   15.262645] ath10k_pci 0000:3a:00.0: firmware ver WLAN.RM.4.4-00022-QCARMSWPZ-2 api 6 features wowlan,ignore-otp crc32 4d458559
>>> [   15.262941] ath10k_pci 0000:3a:00.0: board_file api 2 bmi_id N/A crc32 0e26ef70
>>> [   15.262943] ath10k_pci 0000:3a:00.0: htt-ver 0.0 wmi-op 4 htt-op 3 cal otp max-sta 32 raw 0 hwcrypto 1
>>> [   15.274887] ath10k_pci 0000:3a:00.0: failed to get memcpy hi address for firmware address 4: -16
>>> [   15.274900] ath10k_pci 0000:3a:00.0: failed to read firmware dump area: -16
>>> [   15.274909] ath10k_pci 0000:3a:00.0: Copy Engine register dump:
>>>
>>> Do you have a strong correlation with dell-smbios loading and the wireless
>>> firmware crashing?  You're the first account I've heard of this.
>>
>> Yes, the correlation is very strong.
> 
> In this situation you've described, can you unload ath10k and reload to recover?

No, I unloaded ath10k_pci, and that takes a few seconds, and also shows 
the Linux error messages in the log. Loading it again, there are also 
Linux error messages, and the wireless does *not* work again.

>>> Also why are you putting it in /etc/modules rather than letting the udev
>>> rules load from modaliases?  Or did you artificially prevent that in some way?
>>
>> No idea, with Ubuntu 17.10 there are log messages, that the module is
>> not loaded. So I thought adding it to `/etc/modules` will fix it. Should
>> the module smbios-dell be supported out of the box on Ubuntu 17.10?
> 
> It's only supposed to load when it's needed by another kernel module such as
> dell-laptop or dell-wmi.
> 
> I suppose the messages you were seeing were related to the backends to
> dell-smbios (dell-smbios-wmi or dell-smbios-smm) not yet being initialized
> when a driver had requested to use an SMBIOS method.
> 
> If you don't add it to /etc/modules I would expect that you'll find it's actually
> already loaded by the system when boot has completed.

Yes, it looks like it gets loaded after I removed it from `/etc/modules`.

Still, that behavior should not happen. Could you reproduce it? Is it 
actually a ath10k_pci bug, and their maintainers should be added?


Kind regards,

Paul
