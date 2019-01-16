Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC27C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 04:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C84ED20840
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 04:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732271AbfAPE7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 23:59:32 -0500
Received: from dnvrco-outbound-snat.email.rr.com ([107.14.73.232]:16554 "EHLO
        dnvrco-cmomta02.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728034AbfAPE7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 23:59:31 -0500
Received: from [192.168.1.105] ([70.114.206.4])
        by cmsmtp with ESMTPA
        id jdIUgdH2DsismjdIXgIsJi; Wed, 16 Jan 2019 04:59:30 +0000
Subject: Re: [PATCH] Input: synaptics - add PNP IDs for Dell XPS models to
 forcepad
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>
References: <20190111205430.15371-1-kim@kimphillips.com>
 <20190112014004.GA122403@dtor-ws>
 <22e2d619-0622-1816-2057-c9005288b46b@kimphillips.com>
 <20190114184012.GC117329@dtor-ws>
 <CAO-hwJKCeV5ZEw7aX58=mnfhWex5QtEVYbRdDX7OosfS5+suUw@mail.gmail.com>
From:   Kim Phillips <kim@kimphillips.com>
Message-ID: <4f0e0b88-c13a-a064-3a13-4d8abca252b3@kimphillips.com>
Date:   Tue, 15 Jan 2019 22:59:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAO-hwJKCeV5ZEw7aX58=mnfhWex5QtEVYbRdDX7OosfS5+suUw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfBuRVvacYawcGMTsFpYD2Fk//ncAb9QK2Md6Fm8LGOjPm/LeW3vykccea4XjttB6+sm0hFXqypTOp0y9BX11hwOJPb5YWInRHaOYU3BcSjZufNYhM9Un
 f0B++cF/J8f+sdH3HZzoH5JmwDSON5qwLpkB2DEssRpqXFAJdQN1uyuixR51U+yH7R2YP7jk5HQsGOJSGV4M0wavQnwaCnEA0YOQLVKKiC/6gkgxXVgn9Eos
 OH4kVTx6DwHvd9IzLRs95heypEYVJWW1xfIQKqtQL/txm5/caot5VfEpBXZiWPbCCj/dwQO6HJ8xRt/YgcOJ/KQqHhmDtjeHRfVqy0cn1RerzFQLkpsMNIsQ
 dbgI2+M8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/15/19 2:57 AM, Benjamin Tissoires wrote:
> On Mon, Jan 14, 2019 at 7:40 PM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
>>
>> On Sat, Jan 12, 2019 at 04:04:36PM -0600, Kim Phillips wrote:
>>> On 1/11/19 7:40 PM, Dmitry Torokhov wrote:
>>>> Hi Kim,
>>>
>>> Hi Dmitry,
>>>
>>>> On Fri, Jan 11, 2019 at 02:54:30PM -0600, Kim Phillips wrote:
>>>>> This patch is the result of seeing this message:
>>>>>
>>>>> psmouse serio1: synaptics: Your touchpad (PNP: DLL087c PNP0f13) says it can support a different bus. If i2c-hid and hid-rmi are not used, you might want to try setting psmouse.synaptics_intertouch to 1 and report this to linux-input@vger.kernel.org.
>>>>>
>>>>> If I set psmouse.synaptics_intertouch=1, or add the PNP ID to
>>>>> smbus_pnp_ids, the touchpad continues to work, and the above message
>>>>> goes away, but we now get:
>>>>>
>>>>> psmouse serio1: synaptics: Trying to set up SMBus access
>>>>> psmouse serio1: synaptics: SMbus companion is not ready yet
>>>>>
>>>>> With this patch applied, i.e., the PNP IDs are added to the forcepad
>>>>> array, the touchpad continues to work and all of the above messages
>>>>> disappear.
>>>>
>>>> Are you sure the touchpad in XPSes is a forcepad (i.e. it does not have
>>>> physical button underneath it)? As far as I know there were only couple
>>>> of HP laptops with forcepads and when switching to RMI mode forcepads
>>>> need F21 handler that we do not currently have in the kernel.
>>>
>>> I see, no, I'm not sure, but assuming you're right, the IDs
>>> should be added to the smbus array instead, after fixing
>>> the SMbus "companion not ready" problem?  Pointers for that and
>>> the below interrupts when touchpad idle after resume, welcome.
>>>
>>> Also, the link to get the RMI4 spec in
>>> Documentation/devicetree/bindings/input/rmi4/rmi_2d_sensor.txt
>>> is broken.  Any pointers for that also appreciated.
>>
>> OK, sorting it all out some more:
>>
>> - because we do not have support for F21 necessary for forcepads adding
>>    APIC ID to forcepad list actuallty disables SMbus companion mode, that
>>    is why you no longer see "companion not ready" messages vs. setting
>>    psmouse.synaptics_intertouch=1 module parameter.
> 
> Yep
> 
>>
>> - this does not really matter as your touchpad ends up being driven by
>>    i2c-hid and hid-multitouch drivers, and that is how we wait it to
>>    work, as we do not want to deviate from behavior on Windows since OEM
>>    tested it (the device and firmware) in tha configuration.
> 
> Yep too. The I2C-hid touchpads from Synaptics do not have the SMBus
> wired at all, so we can't enable SMBus for them. Also, the fact that
> the device gets loaded over i2c-hid means that we can't know that it
> is the case from the psmouse/synaptics point of view.

Sigh, OK, I wasn't registering the word "not" when reading
"If i2c-hid and hid-rmi are not used" too quickly.

>> - we need to figure out issue with interrupts on resume, maybe Benjamin
>>    have seen it?
> 
> First time I see it.
> 
> I just tried on a XPS 9360 and kernel v4.18 (fedora) and nothing was a problem.
> I then tried on a XPS 9575 with v4.19, and here, the wacom I2C node is
> also keeping firing the interrupts, but not the touchpad. However,
> here, the interrupts are not stopping when I touch the touchscreen or
> if I approach a pen.
> 
> Kim, rmmod-ing i2c-hid and modprobing back it with the parameter
> debug=1 doesn't show any events processed when the interrupts are
> firing. Do you see the same?

After rmmodding i2c_hid, the WCOM488F and SYNA2393 entries in /proc/interrupts
somewhat expectedly disappear, however, the modprobe (with or without debug=1)
fails to bring them back, with these messages left in dmesg:

[ 3882.073222] calling  i2c_hid_driver_init+0x0/0x1000 [i2c_hid] @ 3082
[ 3882.180938] i2c_hid i2c-WCOM488F:00: HID over i2c has not been provided an Int IRQ
[ 3882.181060] i2c_hid: probe of i2c-WCOM488F:00 failed with error -22
[ 3882.181065] probe of i2c-WCOM488F:00 returned 0 after 496 usecs
[ 3882.289196] i2c_hid i2c-SYNA2393:00: HID over i2c has not been provided an Int IRQ
[ 3882.289318] i2c_hid: probe of i2c-SYNA2393:00 failed with error -22
[ 3882.289321] probe of i2c-SYNA2393:00 returned 0 after 508 usecs
[ 3882.289418] initcall i2c_hid_driver_init+0x0/0x1000 [i2c_hid] returned 0 after 211119 usecs

In order to work around that problem, I set h2c_hid.debug=1 in the
boot command line, and after a resume, dmesg contains these messages,
relevant to i2c_hid:

[  267.235673] i2c_hid i2c-WCOM488F:00: calling i2c_hid_resume+0x0/0x140 [i2c_hid] @ 3078, parent: i2c-9
[  267.235676] input input16: calling input_dev_resume+0x0/0x50 @ 3060, parent: card0
[  267.235681] input input16: input_dev_resume+0x0/0x50 returned 0 after 0 usecs
[  267.235682] i2c_hid i2c-WCOM488F:00: i2c_hid_set_power
[  267.235687] input input17: calling input_dev_resume+0x0/0x50 @ 3060, parent: card0
[  267.235689] i2c_hid i2c-WCOM488F:00: __i2c_hid_command: cmd=04 00 00 08
[  267.235693] input input17: input_dev_resume+0x0/0x50 returned 0 after 0 usecs
[  267.235698] idma64 idma64.1: calling platform_pm_resume+0x0/0x50 @ 3060, parent: 0000:00:15.1
[  267.235701] idma64 idma64.1: platform_pm_resume+0x0/0x50 returned 0 after 0 usecs
[  267.235706] i2c_designware i2c_designware.1: calling platform_pm_resume+0x0/0x50 @ 3060, parent: 0000:00:15.1
[  267.235709] i2c_designware i2c_designware.1: platform_pm_resume+0x0/0x50 returned 0 after 0 usecs
[  267.235718] rfkill rfkill0: calling rfkill_resume+0x0/0x60 @ 3060, parent: phy0
[  267.235724] rfkill rfkill0: rfkill_resume+0x0/0x60 returned 0 after 3 usecs
[  267.235768] i2c_hid i2c-SYNA2393:00: calling i2c_hid_resume+0x0/0x140 [i2c_hid] @ 3108, parent: i2c-10
[  267.235774] i2c_hid i2c-SYNA2393:00: i2c_hid_set_power
[  267.235776] i2c_hid i2c-SYNA2393:00: __i2c_hid_command: cmd=22 00 00 08
[  267.236051] i2c_hid i2c-SYNA2393:00: i2c_hid_set_or_send_report
[  267.236053] i2c_hid i2c-SYNA2393:00: __i2c_hid_command: cmd=22 00 3d 03 23 00 04 00 0d 00
[  267.236076] i2c_hid i2c-WCOM488F:00: i2c_hid_set_or_send_report
[  267.236080] i2c_hid i2c-WCOM488F:00: __i2c_hid_command: cmd=04 00 3b 03 05 00 42 00 0b 00 fd 89 a3 07 f3 02 20 8d 49 06 d7 9c ff ff 80 59 5c 13 d7 9c ff ff 08 00 00 08 d7 9c ff ff 01 00 00 00 00 00 00 00 16 00 00 00 66 69 6c 65 75 74 6c 2e 6d 65 73 73
[  267.237691] i2c_hid i2c-SYNA2393:00: input: 20 00 03 01 3c 03 a8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 60 01 00
[  267.238137] i2c_hid i2c-SYNA2393:00: i2c_hid_set_or_send_report
[  267.238140] i2c_hid i2c-SYNA2393:00: __i2c_hid_command: cmd=22 00 34 03 23 00 04 00 04 03
[  267.238670] i2c_hid i2c-WCOM488F:00: i2c_hid_get_report
[  267.238673] i2c_hid i2c-WCOM488F:00: __i2c_hid_command: cmd=04 00 3b 02 05 00
[  267.239708] i2c_hid i2c-SYNA2393:00: input: 20 00 03 01 3c 03 a8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 60 01 00
[  267.240084] i2c_hid i2c-SYNA2393:00: i2c_hid_set_or_send_report
[  267.240087] i2c_hid i2c-SYNA2393:00: __i2c_hid_command: cmd=22 00 36 03 23 00 04 00 06 03
[  267.241377] i2c_hid i2c-WCOM488F:00: i2c_hid_set_or_send_report
[  267.241380] i2c_hid i2c-WCOM488F:00: __i2c_hid_command: cmd=04 00 3b 03 05 00 42 00 0b 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[  267.241711] i2c_hid i2c-SYNA2393:00: input: 20 00 03 01 3c 03 a8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 60 01 00
[  267.243279] i2c_hid i2c-SYNA2393:00: input: 20 00 03 01 3c 03 a8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 60 01 00
[  267.243981] i2c_hid i2c-WCOM488F:00: i2c_hid_get_report
[  267.243984] i2c_hid i2c-WCOM488F:00: __i2c_hid_command: cmd=04 00 3b 02 05 00
[  267.244847] i2c_hid i2c-SYNA2393:00: input: 20 00 03 01 3c 03 a8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 60 01 00
[  267.245360] i2c_hid i2c-SYNA2393:00: i2c_hid_resume+0x0/0x140 [i2c_hid] returned 0 after 9360 usecs
[  267.245455] input input27: calling input_dev_resume+0x0/0x50 @ 3060, parent: 0018:06CB:7A13.0002
[  267.245460] input input27: input_dev_resume+0x0/0x50 returned 0 after 0 usecs
[  267.246773] i2c_hid i2c-WCOM488F:00: i2c_hid_set_or_send_report
[  267.246777] i2c_hid i2c-WCOM488F:00: __i2c_hid_command: cmd=04 00 3b 03 05 00 42 00 0b 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[  267.246919] i2c_hid i2c-SYNA2393:00: input: 20 00 03 01 3c 03 a8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 60 01 00
[  267.248517] i2c_hid i2c-SYNA2393:00: input: 20 00 03 01 3c 03 a8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 60 01 00
[  267.249383] i2c_hid i2c-WCOM488F:00: i2c_hid_get_report
[  267.249386] i2c_hid i2c-WCOM488F:00: __i2c_hid_command: cmd=04 00 3b 02 05 00
[  267.250116] i2c_hid i2c-SYNA2393:00: input: 20 00 03 01 3c 03 a8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 60 01 00
[  267.251767] i2c_hid i2c-SYNA2393:00: input: 20 00 03 01 3c 03 a8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 60 01 00
[  267.252137] i2c_hid i2c-WCOM488F:00: i2c_hid_set_or_send_report
[  267.252140] i2c_hid i2c-WCOM488F:00: __i2c_hid_command: cmd=04 00 3b 03 05 00 42 00 0b 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[  267.253440] i2c_hid i2c-SYNA2393:00: input: 20 00 03 01 3c 03 a8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 60 01 00
[  267.254734] i2c_hid i2c-WCOM488F:00: i2c_hid_get_report
[  267.254737] i2c_hid i2c-WCOM488F:00: __i2c_hid_command: cmd=04 00 3b 02 05 00
[  267.255015] i2c_hid i2c-SYNA2393:00: input: 20 00 03 01 3c 03 a8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 60 01 00
[  267.256612] i2c_hid i2c-SYNA2393:00: input: 20 00 03 01 3c 03 a8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 60 01 00
[  267.257475] i2c_hid i2c-WCOM488F:00: i2c_hid_set_or_send_report
[  267.257478] i2c_hid i2c-WCOM488F:00: __i2c_hid_command: cmd=04 00 3b 03 05 00 42 00 0b 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[  267.258275] i2c_hid i2c-SYNA2393:00: input: 20 00 03 01 3c 03 a8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 60 01 00
[  267.259852] i2c_hid i2c-SYNA2393:00: input: 20 00 03 01 3c 03 a8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 60 01 00
[  267.260046] i2c_hid i2c-WCOM488F:00: i2c_hid_get_report
[  267.260049] i2c_hid i2c-WCOM488F:00: __i2c_hid_command: cmd=04 00 3b 02 05 00
[  267.261441] i2c_hid i2c-SYNA2393:00: input: 20 00 03 01 3c 03 a8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 60 01 00
[  267.262789] i2c_hid i2c-WCOM488F:00: i2c_hid_set_or_send_report
[  267.262792] i2c_hid i2c-WCOM488F:00: __i2c_hid_command: cmd=04 00 3b 03 05 00 42 00 0b 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[  267.263129] i2c_hid i2c-SYNA2393:00: input: 20 00 03 01 3c 03 a8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 60 01 00
[  267.264718] i2c_hid i2c-SYNA2393:00: input: 20 00 03 01 3c 03 a8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 60 01 00
[  267.265410] i2c_hid i2c-WCOM488F:00: i2c_hid_get_report
[  267.265413] i2c_hid i2c-WCOM488F:00: __i2c_hid_command: cmd=04 00 3b 02 05 00
[  267.266318] i2c_hid i2c-SYNA2393:00: input: 20 00 03 01 3c 03 a8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 60 01 00
[  267.267971] i2c_hid i2c-SYNA2393:00: input: 20 00 03 01 3c 03 a8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 60 01 00
[  267.268169] i2c_hid i2c-WCOM488F:00: i2c_hid_set_or_send_report
[  267.268172] i2c_hid i2c-WCOM488F:00: __i2c_hid_command: cmd=04 00 3e 03 05 00 05 00 0e 02 00
[  267.268728] i2c_hid i2c-WCOM488F:00: i2c_hid_resume+0x0/0x140 [i2c_hid] returned 0 after 32273 usecs
[  267.269575] i2c_hid i2c-SYNA2393:00: input: 20 00 03 01 3c 03 a8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 60 01 00
[  267.271144] i2c_hid i2c-SYNA2393:00: input: 20 00 03 01 3c 03 a8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 60 01 00
[  267.272719] i2c_hid i2c-SYNA2393:00: input: 20 00 03 01 3c 03 a8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 60 01 00
[  267.274298] i2c_hid i2c-SYNA2393:00: input: 20 00 03 01 3c 03 a8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 60 01 00

...and it goes on and on, where that same last line gets
repeated as the interrupts fire, until I start using the touchpad,
thereby stopping the interrupts.

I'm not seeing any such bad behaviour from the WCOM device.

Kim
