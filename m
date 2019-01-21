Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 475C1C41518
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 23:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07FB621019
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 23:11:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbfAUXLM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 18:11:12 -0500
Received: from dnvrco-outbound-snat.email.rr.com ([107.14.73.229]:61083 "EHLO
        dnvrco-cmomta02.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727007AbfAUXLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 18:11:10 -0500
Received: from [192.168.1.105] ([70.114.206.4])
        by cmsmtp with ESMTPA
        id liiKgRupCsismliiNgERhw; Mon, 21 Jan 2019 23:10:48 +0000
Subject: Re: [PATCH] Input: synaptics - add PNP IDs for Dell XPS models to
 forcepad
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>
References: <20190111205430.15371-1-kim@kimphillips.com>
 <20190112014004.GA122403@dtor-ws>
 <22e2d619-0622-1816-2057-c9005288b46b@kimphillips.com>
 <20190114184012.GC117329@dtor-ws>
 <CAO-hwJKCeV5ZEw7aX58=mnfhWex5QtEVYbRdDX7OosfS5+suUw@mail.gmail.com>
 <4f0e0b88-c13a-a064-3a13-4d8abca252b3@kimphillips.com>
 <CAO-hwJLBd-VGAoMBpwEZhWY2khsDEz2qKh05tNjbNVhAzQCRJA@mail.gmail.com>
From:   Kim Phillips <kim@kimphillips.com>
Message-ID: <658630d9-6ddd-12d9-4845-1f1fe6e943fc@kimphillips.com>
Date:   Mon, 21 Jan 2019 17:10:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAO-hwJLBd-VGAoMBpwEZhWY2khsDEz2qKh05tNjbNVhAzQCRJA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfJ/fd80q9+/HUnG0E5IkMorhFfQ27v6ISBcsqwSPq11Bagv/J1JjMBjvBK7dexuCikQxC9RtYc/sjdOps5H7rDY5h3W56YBtuqjR4KUtBN8QHpaNvXOQ
 CK0JasbWRLo+T7AbjgFgQSJLa4Sona9DjO1HRdHPNnnKsreUlaYUEdtJYKb1sFv6h7U3ehUzMGzeiP3xfZYdOPyKYY5fwaRQLGGuCYTKGj9sWn5HJXpYrHh3
 1DtNBqBONbxCL5RSjLHNuWZgT1/0fB9hSqmwQmUYXHpZ/j9f9goiBsxeKUGU/Dw4WKtC9v9trz+P3Q9a9raUqrWtuCIcwSQF4sil1cN45JarqHOjyCJwv+Ku
 y0P23fTe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/19 2:13 AM, Benjamin Tissoires wrote:
> On Wed, Jan 16, 2019 at 5:59 AM Kim Phillips <kim@kimphillips.com> wrote:
>>
>> On 1/15/19 2:57 AM, Benjamin Tissoires wrote:
>>> On Mon, Jan 14, 2019 at 7:40 PM Dmitry Torokhov
>>> <dmitry.torokhov@gmail.com> wrote:
>>>>
>>>> On Sat, Jan 12, 2019 at 04:04:36PM -0600, Kim Phillips wrote:
>>>>> On 1/11/19 7:40 PM, Dmitry Torokhov wrote:
>>>>>> Hi Kim,
>>>>>
>>>>> Hi Dmitry,
>>>>>
>>>>>> On Fri, Jan 11, 2019 at 02:54:30PM -0600, Kim Phillips wrote:
>>>>>>> This patch is the result of seeing this message:
>>>>>>>
>>>>>>> psmouse serio1: synaptics: Your touchpad (PNP: DLL087c PNP0f13) says it can support a different bus. If i2c-hid and hid-rmi are not used, you might want to try setting psmouse.synaptics_intertouch to 1 and report this to linux-input@vger.kernel.org.
>>>>>>>
>>>>>>> If I set psmouse.synaptics_intertouch=1, or add the PNP ID to
>>>>>>> smbus_pnp_ids, the touchpad continues to work, and the above message
>>>>>>> goes away, but we now get:
>>>>>>>
>>>>>>> psmouse serio1: synaptics: Trying to set up SMBus access
>>>>>>> psmouse serio1: synaptics: SMbus companion is not ready yet
>>>>>>>
>>>>>>> With this patch applied, i.e., the PNP IDs are added to the forcepad
>>>>>>> array, the touchpad continues to work and all of the above messages
>>>>>>> disappear.
>>>>>>
>>>>>> Are you sure the touchpad in XPSes is a forcepad (i.e. it does not have
>>>>>> physical button underneath it)? As far as I know there were only couple
>>>>>> of HP laptops with forcepads and when switching to RMI mode forcepads
>>>>>> need F21 handler that we do not currently have in the kernel.
>>>>>
>>>>> I see, no, I'm not sure, but assuming you're right, the IDs
>>>>> should be added to the smbus array instead, after fixing
>>>>> the SMbus "companion not ready" problem?  Pointers for that and
>>>>> the below interrupts when touchpad idle after resume, welcome.
>>>>>
>>>>> Also, the link to get the RMI4 spec in
>>>>> Documentation/devicetree/bindings/input/rmi4/rmi_2d_sensor.txt
>>>>> is broken.  Any pointers for that also appreciated.
>>>>
>>>> OK, sorting it all out some more:
>>>>
>>>> - because we do not have support for F21 necessary for forcepads adding
>>>>     APIC ID to forcepad list actuallty disables SMbus companion mode, that
>>>>     is why you no longer see "companion not ready" messages vs. setting
>>>>     psmouse.synaptics_intertouch=1 module parameter.
>>>
>>> Yep
>>>
>>>>
>>>> - this does not really matter as your touchpad ends up being driven by
>>>>     i2c-hid and hid-multitouch drivers, and that is how we wait it to
>>>>     work, as we do not want to deviate from behavior on Windows since OEM
>>>>     tested it (the device and firmware) in tha configuration.
>>>
>>> Yep too. The I2C-hid touchpads from Synaptics do not have the SMBus
>>> wired at all, so we can't enable SMBus for them. Also, the fact that
>>> the device gets loaded over i2c-hid means that we can't know that it
>>> is the case from the psmouse/synaptics point of view.
>>
>> Sigh, OK, I wasn't registering the word "not" when reading
>> "If i2c-hid and hid-rmi are not used" too quickly.
>>
>>>> - we need to figure out issue with interrupts on resume, maybe Benjamin
>>>>     have seen it?
>>>
>>> First time I see it.
>>>
>>> I just tried on a XPS 9360 and kernel v4.18 (fedora) and nothing was a problem.
>>> I then tried on a XPS 9575 with v4.19, and here, the wacom I2C node is
>>> also keeping firing the interrupts, but not the touchpad. However,
>>> here, the interrupts are not stopping when I touch the touchscreen or
>>> if I approach a pen.
>>>
>>> Kim, rmmod-ing i2c-hid and modprobing back it with the parameter
>>> debug=1 doesn't show any events processed when the interrupts are
>>> firing. Do you see the same?
>>
>> After rmmodding i2c_hid, the WCOM488F and SYNA2393 entries in /proc/interrupts
>> somewhat expectedly disappear, however, the modprobe (with or without debug=1)
>> fails to bring them back, with these messages left in dmesg:
>>
>> [ 3882.073222] calling  i2c_hid_driver_init+0x0/0x1000 [i2c_hid] @ 3082
>> [ 3882.180938] i2c_hid i2c-WCOM488F:00: HID over i2c has not been provided an Int IRQ
>> [ 3882.181060] i2c_hid: probe of i2c-WCOM488F:00 failed with error -22
>> [ 3882.181065] probe of i2c-WCOM488F:00 returned 0 after 496 usecs
>> [ 3882.289196] i2c_hid i2c-SYNA2393:00: HID over i2c has not been provided an Int IRQ
>> [ 3882.289318] i2c_hid: probe of i2c-SYNA2393:00 failed with error -22
>> [ 3882.289321] probe of i2c-SYNA2393:00 returned 0 after 508 usecs
>> [ 3882.289418] initcall i2c_hid_driver_init+0x0/0x1000 [i2c_hid] returned 0 after 211119 usecs
> 
> Yes, that is a weird behavior I experience the other day also. It
> looks like rmmod-ing the driver simply kills the irq description
> attached to the i2c node. This waasn't the case previously, and I
> wonder if the issue is in i2c-hid (unlikely) or in i2c-core.
> 
>>
>> In order to work around that problem, I set h2c_hid.debug=1 in the
>> boot command line, and after a resume, dmesg contains these messages,
>> relevant to i2c_hid:
>>
>> [  267.235673] i2c_hid i2c-WCOM488F:00: calling i2c_hid_resume+0x0/0x140 [i2c_hid] @ 3078, parent: i2c-9
>> [  267.235676] input input16: calling input_dev_resume+0x0/0x50 @ 3060, parent: card0
>> [  267.235681] input input16: input_dev_resume+0x0/0x50 returned 0 after 0 usecs
>> [  267.235682] i2c_hid i2c-WCOM488F:00: i2c_hid_set_power
>> [  267.235687] input input17: calling input_dev_resume+0x0/0x50 @ 3060, parent: card0
>> [  267.235689] i2c_hid i2c-WCOM488F:00: __i2c_hid_command: cmd=04 00 00 08
>> [  267.235693] input input17: input_dev_resume+0x0/0x50 returned 0 after 0 usecs
>> [  267.235698] idma64 idma64.1: calling platform_pm_resume+0x0/0x50 @ 3060, parent: 0000:00:15.1
>> [  267.235701] idma64 idma64.1: platform_pm_resume+0x0/0x50 returned 0 after 0 usecs
>> [  267.235706] i2c_designware i2c_designware.1: calling platform_pm_resume+0x0/0x50 @ 3060, parent: 0000:00:15.1
>> [  267.235709] i2c_designware i2c_designware.1: platform_pm_resume+0x0/0x50 returned 0 after 0 usecs
>> [  267.235718] rfkill rfkill0: calling rfkill_resume+0x0/0x60 @ 3060, parent: phy0
>> [  267.235724] rfkill rfkill0: rfkill_resume+0x0/0x60 returned 0 after 3 usecs
>> [  267.235768] i2c_hid i2c-SYNA2393:00: calling i2c_hid_resume+0x0/0x140 [i2c_hid] @ 3108, parent: i2c-10
>> [  267.235774] i2c_hid i2c-SYNA2393:00: i2c_hid_set_power
>> [  267.235776] i2c_hid i2c-SYNA2393:00: __i2c_hid_command: cmd=22 00 00 08
>> [  267.236051] i2c_hid i2c-SYNA2393:00: i2c_hid_set_or_send_report
>> [  267.236053] i2c_hid i2c-SYNA2393:00: __i2c_hid_command: cmd=22 00 3d 03 23 00 04 00 0d 00
>> [  267.236076] i2c_hid i2c-WCOM488F:00: i2c_hid_set_or_send_report
>> [  267.236080] i2c_hid i2c-WCOM488F:00: __i2c_hid_command: cmd=04 00 3b 03 05 00 42 00 0b 00 fd 89 a3 07 f3 02 20 8d 49 06 d7 9c ff ff 80 59 5c 13 d7 9c ff ff 08 00 00 08 d7 9c ff ff 01 00 00 00 00 00 00 00 16 00 00 00 66 69 6c 65 75 74 6c 2e 6d 65 73 73
>> [  267.237691] i2c_hid i2c-SYNA2393:00: input: 20 00 03 01 3c 03 a8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 60 01 00
>> [  267.238137] i2c_hid i2c-SYNA2393:00: i2c_hid_set_or_send_report
>> [  267.238140] i2c_hid i2c-SYNA2393:00: __i2c_hid_command: cmd=22 00 34 03 23 00 04 00 04 03
>> [  267.238670] i2c_hid i2c-WCOM488F:00: i2c_hid_get_report
>> [  267.238673] i2c_hid i2c-WCOM488F:00: __i2c_hid_command: cmd=04 00 3b 02 05 00
>> [  267.239708] i2c_hid i2c-SYNA2393:00: input: 20 00 03 01 3c 03 a8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 60 01 00
>> [  267.240084] i2c_hid i2c-SYNA2393:00: i2c_hid_set_or_send_report
>> [  267.240087] i2c_hid i2c-SYNA2393:00: __i2c_hid_command: cmd=22 00 36 03 23 00 04 00 06 03
>> [  267.241377] i2c_hid i2c-WCOM488F:00: i2c_hid_set_or_send_report
>> [  267.241380] i2c_hid i2c-WCOM488F:00: __i2c_hid_command: cmd=04 00 3b 03 05 00 42 00 0b 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> [  267.241711] i2c_hid i2c-SYNA2393:00: input: 20 00 03 01 3c 03 a8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 60 01 00
>> [  267.243279] i2c_hid i2c-SYNA2393:00: input: 20 00 03 01 3c 03 a8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 60 01 00
>> [  267.243981] i2c_hid i2c-WCOM488F:00: i2c_hid_get_report
>> [  267.243984] i2c_hid i2c-WCOM488F:00: __i2c_hid_command: cmd=04 00 3b 02 05 00
>> [  267.244847] i2c_hid i2c-SYNA2393:00: input: 20 00 03 01 3c 03 a8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 60 01 00
>> [  267.245360] i2c_hid i2c-SYNA2393:00: i2c_hid_resume+0x0/0x140 [i2c_hid] returned 0 after 9360 usecs
>> [  267.245455] input input27: calling input_dev_resume+0x0/0x50 @ 3060, parent: 0018:06CB:7A13.0002
>> [  267.245460] input input27: input_dev_resume+0x0/0x50 returned 0 after 0 usecs
>> [  267.246773] i2c_hid i2c-WCOM488F:00: i2c_hid_set_or_send_report
>> [  267.246777] i2c_hid i2c-WCOM488F:00: __i2c_hid_command: cmd=04 00 3b 03 05 00 42 00 0b 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> [  267.246919] i2c_hid i2c-SYNA2393:00: input: 20 00 03 01 3c 03 a8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 60 01 00
>> [  267.248517] i2c_hid i2c-SYNA2393:00: input: 20 00 03 01 3c 03 a8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 60 01 00
>> [  267.249383] i2c_hid i2c-WCOM488F:00: i2c_hid_get_report
>> [  267.249386] i2c_hid i2c-WCOM488F:00: __i2c_hid_command: cmd=04 00 3b 02 05 00
>> [  267.250116] i2c_hid i2c-SYNA2393:00: input: 20 00 03 01 3c 03 a8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 60 01 00
>> [  267.251767] i2c_hid i2c-SYNA2393:00: input: 20 00 03 01 3c 03 a8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 60 01 00
>> [  267.252137] i2c_hid i2c-WCOM488F:00: i2c_hid_set_or_send_report
>> [  267.252140] i2c_hid i2c-WCOM488F:00: __i2c_hid_command: cmd=04 00 3b 03 05 00 42 00 0b 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> [  267.253440] i2c_hid i2c-SYNA2393:00: input: 20 00 03 01 3c 03 a8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 60 01 00
>> [  267.254734] i2c_hid i2c-WCOM488F:00: i2c_hid_get_report
>> [  267.254737] i2c_hid i2c-WCOM488F:00: __i2c_hid_command: cmd=04 00 3b 02 05 00
>> [  267.255015] i2c_hid i2c-SYNA2393:00: input: 20 00 03 01 3c 03 a8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 60 01 00
>> [  267.256612] i2c_hid i2c-SYNA2393:00: input: 20 00 03 01 3c 03 a8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 60 01 00
>> [  267.257475] i2c_hid i2c-WCOM488F:00: i2c_hid_set_or_send_report
>> [  267.257478] i2c_hid i2c-WCOM488F:00: __i2c_hid_command: cmd=04 00 3b 03 05 00 42 00 0b 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> [  267.258275] i2c_hid i2c-SYNA2393:00: input: 20 00 03 01 3c 03 a8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 60 01 00
>> [  267.259852] i2c_hid i2c-SYNA2393:00: input: 20 00 03 01 3c 03 a8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 60 01 00
>> [  267.260046] i2c_hid i2c-WCOM488F:00: i2c_hid_get_report
>> [  267.260049] i2c_hid i2c-WCOM488F:00: __i2c_hid_command: cmd=04 00 3b 02 05 00
>> [  267.261441] i2c_hid i2c-SYNA2393:00: input: 20 00 03 01 3c 03 a8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 60 01 00
>> [  267.262789] i2c_hid i2c-WCOM488F:00: i2c_hid_set_or_send_report
>> [  267.262792] i2c_hid i2c-WCOM488F:00: __i2c_hid_command: cmd=04 00 3b 03 05 00 42 00 0b 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> [  267.263129] i2c_hid i2c-SYNA2393:00: input: 20 00 03 01 3c 03 a8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 60 01 00
>> [  267.264718] i2c_hid i2c-SYNA2393:00: input: 20 00 03 01 3c 03 a8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 60 01 00
>> [  267.265410] i2c_hid i2c-WCOM488F:00: i2c_hid_get_report
>> [  267.265413] i2c_hid i2c-WCOM488F:00: __i2c_hid_command: cmd=04 00 3b 02 05 00
>> [  267.266318] i2c_hid i2c-SYNA2393:00: input: 20 00 03 01 3c 03 a8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 60 01 00
>> [  267.267971] i2c_hid i2c-SYNA2393:00: input: 20 00 03 01 3c 03 a8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 60 01 00
>> [  267.268169] i2c_hid i2c-WCOM488F:00: i2c_hid_set_or_send_report
>> [  267.268172] i2c_hid i2c-WCOM488F:00: __i2c_hid_command: cmd=04 00 3e 03 05 00 05 00 0e 02 00
>> [  267.268728] i2c_hid i2c-WCOM488F:00: i2c_hid_resume+0x0/0x140 [i2c_hid] returned 0 after 32273 usecs
>> [  267.269575] i2c_hid i2c-SYNA2393:00: input: 20 00 03 01 3c 03 a8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 60 01 00
>> [  267.271144] i2c_hid i2c-SYNA2393:00: input: 20 00 03 01 3c 03 a8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 60 01 00
>> [  267.272719] i2c_hid i2c-SYNA2393:00: input: 20 00 03 01 3c 03 a8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 60 01 00
>> [  267.274298] i2c_hid i2c-SYNA2393:00: input: 20 00 03 01 3c 03 a8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 60 01 00
>>
>> ...and it goes on and on, where that same last line gets
>> repeated as the interrupts fire, until I start using the touchpad,
>> thereby stopping the interrupts.
> 
> It looks like valid inputs. So I would expect the firmware to unset
> the IRQ line, but it doesn't do it.
> 
> On an other thread, it has been brought to my attention that maybe we
> are not 100% compatible with the Windows driver regarding
> sleep/power_on commands. We expect the device to be ready while the
> Windows driver waits a little before sending a command. Maybe we can
> try to see if adding I2C_HID_QUIRK_DELAY_AFTER_SLEEP to this device
> changes something.

Thought I'd try DELAY_AFTER_SLEEP.  Please double check whether
I did that correctly given these diagnostics:

[    5.720289] input: SYNA2393:00 06CB:7A13 Touchpad as /devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-10/i2c-SYNA2393:00/0018:06CB:7A13.0006/input/input20
[    5.720362] hid-multitouch 0018:06CB:7A13.0006: input,hidraw5: I2C HID v1.00 Mouse [SYNA2393:00 06CB:7A13] on i2c-SYNA2393:00

I added both 2393 and 7A13 as model numbers just
because I wasn't sure which one was which:

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 27519eb8ee63..d297ad6744e2 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1072,6 +1072,9 @@
  #define USB_DEVICE_ID_SYNAPTICS_HD     0x0ac3
  #define USB_DEVICE_ID_SYNAPTICS_QUAD_HD        0x1ac3
  #define USB_DEVICE_ID_SYNAPTICS_TP_V103        0x5710
+#define I2C_VENDOR_ID_SYNAPTICS                0x06cb
+#define I2C_PRODUCT_ID_SYNAPTICS_2393  0x2393
+#define I2C_PRODUCT_ID_SYNAPTICS_7A13  0x7a13
  
  #define USB_VENDOR_ID_TEXAS_INSTRUMENTS        0x2047
  #define USB_DEVICE_ID_TEXAS_INSTRUMENTS_LENOVO_YOGA    0x0855
diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index 8555ce7e737b..cfdd5f2e4781 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -179,6 +179,10 @@ static const struct i2c_hid_quirks {
                 I2C_HID_QUIRK_DELAY_AFTER_SLEEP },
         { USB_VENDOR_ID_LG, I2C_DEVICE_ID_LG_8001,
                 I2C_HID_QUIRK_NO_RUNTIME_PM },
+       { I2C_VENDOR_ID_SYNAPTICS, I2C_PRODUCT_ID_SYNAPTICS_2393,
+               I2C_HID_QUIRK_DELAY_AFTER_SLEEP },
+       { I2C_VENDOR_ID_SYNAPTICS, I2C_PRODUCT_ID_SYNAPTICS_7A13,
+               I2C_HID_QUIRK_DELAY_AFTER_SLEEP },
         { 0, 0 }
  };
  
@@ -419,14 +423,19 @@ static int i2c_hid_set_power(struct i2c_client *client, int power_state)
                         delay = jiffies_to_usecs(ihid->sleep_delay - now);
                         usleep_range(delay, delay + 1);
                 }
-       }
+               dev_err(&client->dev, "%s %d: delayed after sleep with power on\n", __func__, __LINE__);
+       } else
+               dev_err(&client->dev, "%s %d: did NOT delay after sleep whilst powered on. No quirk?\n", __func__, __LINE__);
  
         ret = __i2c_hid_command(client, &hid_set_power_cmd, power_state,
                 0, NULL, 0, NULL, 0);
  
         if (ihid->quirks & I2C_HID_QUIRK_DELAY_AFTER_SLEEP &&
-           power_state == I2C_HID_PWR_SLEEP)
+           power_state == I2C_HID_PWR_SLEEP) {
                 ihid->sleep_delay = jiffies + msecs_to_jiffies(20);
+               dev_err(&client->dev, "%s %d: delayed after sleep with power set to sleep\n", __func__, __LINE__);
+       } else
+               dev_err(&client->dev, "%s %d: did NOT delay after sleep at sleep. No quirk?\n", __func__, __LINE__);
  
         if (ret)
                 dev_err(&client->dev, "failed to change power setting.\n");


This is as I give the suspend command, using the touchpad to
click on the pause button in Gnome (whilst holding down ALT):

[  319.326944] i2c_hid i2c-SYNA2393:00: input: 20 00 03 03 38 02 a5 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 e2 c4 01 00
[  319.334357] i2c_hid i2c-SYNA2393:00: input: 20 00 03 03 38 02 a5 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 2b c5 01 00
[  319.341692] i2c_hid i2c-SYNA2393:00: input: 20 00 03 03 38 02 a5 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 74 c5 01 00
[  319.348994] i2c_hid i2c-SYNA2393:00: input: 20 00 03 03 38 02 a5 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 bd c5 01 00
[  319.355556] i2c_hid i2c-SYNA2393:00: input: 20 00 03 01 38 02 a5 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 c6 01 00
...
[  349.858808] PM: suspend entry (deep)
[  349.858810] PM: Syncing filesystems ... done.
...
[  349.985145] i2c_hid i2c-SYNA2393:00: calling acpi_subsys_suspend+0x0/0x60 @ 7, parent: i2c-10
[  349.985147] i2c_hid i2c-SYNA2393:00: i2c_hid_set_power
[  349.985149] i2c_hid i2c-SYNA2393:00: i2c_hid_set_power 428: did NOT delay after sleep whilst powered on. No quirk?
[  349.985187] i2c_hid i2c-SYNA2393:00: __i2c_hid_command: cmd=22 00 01 08
[  349.985555] i2c_hid i2c-SYNA2393:00: i2c_hid_set_power 436: delayed after sleep with power set to sleep
[  349.985591] i2c_hid i2c-SYNA2393:00: acpi_subsys_suspend+0x0/0x60 returned 0 after 431 usecs
[  349.985636] input input17: calling input_dev_suspend+0x0/0x60 @ 12762, parent: card0
[  349.985639] input input17: input_dev_suspend+0x0/0x60 returned 0 after 0 usecs
[  349.985642] input input16: calling input_dev_suspend+0x0/0x60 @ 12762, parent: card0
[  349.985645] input input16: input_dev_suspend+0x0/0x60 returned 0 after 0 usecs
[  349.985648] input input15: calling input_dev_suspend+0x0/0x60 @ 12762, parent: card0
[  349.985650] input input15: input_dev_suspend+0x0/0x60 returned 0 after 0 usecs
[  349.985653] input input14: calling input_dev_suspend+0x0/0x60 @ 12762, parent: card0
[  349.985656] input input14: input_dev_suspend+0x0/0x60 returned 0 after 0 usecs
[  349.985659] input input13: calling input_dev_suspend+0x0/0x60 @ 12762, parent: card0
[  349.985661] input input13: input_dev_suspend+0x0/0x60 returned 0 after 0 usecs
[  349.985664] input input12: calling input_dev_suspend+0x0/0x60 @ 12762, parent: card0
[  349.985667] input input12: input_dev_suspend+0x0/0x60 returned 0 after 0 usecs
[  349.985678] i2c_designware i2c_designware.1: calling platform_pm_suspend+0x0/0x50 @ 12762, parent: 0000:00:15.1
[  349.985680] i2c_designware i2c_designware.1: platform_pm_suspend+0x0/0x50 returned 0 after 0 usecs
[  349.985684] idma64 idma64.1: calling platform_pm_suspend+0x0/0x50 @ 12762, parent: 0000:00:15.1
[  349.985695] idma64 idma64.1: platform_pm_suspend+0x0/0x50 returned 0 after 9 usecs
[  349.985698] leds dell::kbd_backlight: calling led_suspend+0x0/0x30 @ 12762, parent: dell-laptop
[  349.985700] leds dell::kbd_backlight: led_suspend+0x0/0x30 returned 0 after 0 usecs
[  349.985711] coretemp coretemp.0: calling platform_pm_suspend+0x0/0x50 @ 12762, parent: platform
[  349.985713] coretemp coretemp.0: platform_pm_suspend+0x0/0x50 returned 0 after 0 usecs
[  349.985717] snd_hda_codec_hdmi hdaudioC0D2: calling pm_runtime_force_suspend+0x0/0xe0 @ 7, parent: 0000:00:1f.3
[  349.985720] snd_hda_codec_hdmi hdaudioC0D2: pm_runtime_force_suspend+0x0/0xe0 returned 0 after 0 usecs
[  349.985727] i2c_hid i2c-WCOM488F:00: calling acpi_subsys_suspend+0x0/0x60 @ 7, parent: i2c-9
[  349.985729] i2c_hid i2c-WCOM488F:00: i2c_hid_set_power
[  349.985730] i2c_hid i2c-WCOM488F:00: i2c_hid_set_power 428: did NOT delay after sleep whilst powered on. No quirk?
[  349.985751] snd_hda_codec_realtek hdaudioC0D0: calling pm_runtime_force_suspend+0x0/0xe0 @ 311, parent: 0000:00:1f.3
[  349.985765] i2c_hid i2c-WCOM488F:00: __i2c_hid_command: cmd=04 00 01 08
[  349.986162] i2c_hid i2c-WCOM488F:00: i2c_hid_set_power 438: did NOT delay after sleep at sleep. No quirk?
[  349.986199] i2c_hid i2c-WCOM488F:00: acpi_subsys_suspend+0x0/0x60 returned 0 after 457 usecs
[  349.986250] input input11: calling input_dev_suspend+0x0/0x60 @ 12762, parent: 9DBB5994-A997-11DA-B012-B622A1EF5492
[  349.986253] input input11: input_dev_suspend+0x0/0x60 returned 0 after 0 usecs
[  349.986257] platform regulatory.0: calling platform_pm_suspend+0x0/0x50 @ 12762, parent: platform
[  349.986259] platform regulatory.0: platform_pm_suspend+0x0/0x50 returned 0 after 0 usecs
[  349.986262] dell-laptop dell-laptop: calling platform_pm_suspend+0x0/0x50 @ 12762, parent: platform
[  349.986264] dell-laptop dell-laptop: platform_pm_suspend+0x0/0x50 returned 0 after 0 usecs
[  349.986267] dell-smbios dell-smbios.1: calling platform_pm_suspend+0x0/0x50 @ 12762, parent: platform
[  349.986269] dell-smbios dell-smbios.1: platform_pm_suspend+0x0/0x50 returned 0 after 0 usecs
[  349.986272] dell-smbios dell-smbios.0: calling platform_pm_suspend+0x0/0x50 @ 12762, parent: platform
[  349.986274] dell-smbios dell-smbios.0: platform_pm_suspend+0x0/0x50 returned 0 after 0 usecs
[  349.986280] dcdbas dcdbas: calling platform_pm_suspend+0x0/0x50 @ 12762, parent: platform
[  349.986282] dcdbas dcdbas: platform_pm_suspend+0x0/0x50 returned 0 after 0 usecs
[  349.986293] leds input4::scrolllock: calling led_suspend+0x0/0x30 @ 12762, parent: input4
[  349.986295] leds input4::scrolllock: led_suspend+0x0/0x30 returned 0 after 0 usecs
[  349.986297] leds input4::capslock: calling led_suspend+0x0/0x30 @ 12762, parent: input4
[  349.986299] leds input4::capslock: led_suspend+0x0/0x30 returned 0 after 0 usecs
[  349.986301] leds input4::numlock: calling led_suspend+0x0/0x30 @ 12762, parent: input4
[  349.986303] leds input4::numlock: led_suspend+0x0/0x30 returned 0 after 0 usecs
[  349.986306] i2c_designware i2c_designware.0: calling platform_pm_suspend+0x0/0x50 @ 12762, parent: 0000:00:15.0
[  349.986308] i2c_designware i2c_designware.0: platform_pm_suspend+0x0/0x50 returned 0 after 0 usecs
[  349.986312] idma64 idma64.0: calling platform_pm_suspend+0x0/0x50 @ 12762, parent: 0000:00:15.0
[  349.986322] idma64 idma64.0: platform_pm_suspend+0x0/0x50 returned 0 after 8 usecs
[  349.986329] input input10: calling input_dev_suspend+0x0/0x60 @ 12762, parent: INT33D5:00
[  349.986332] input input10: input_dev_suspend+0x0/0x60 returned 0 after 0 usecs
[  349.986335] input input9: calling input_dev_suspend+0x0/0x60 @ 12762, parent: INT33D5:00
[  349.986337] input input9: input_dev_suspend+0x0/0x60 returned 0 after 0 usecs
[  349.986347] input input6: calling input_dev_suspend+0x0/0x60 @ 12762, parent: serio1
[  349.986349] input input6: input_dev_suspend+0x0/0x60 returned 0 after 0 usecs
[  349.986357] input input8: calling input_dev_suspend+0x0/0x60 @ 12762, parent: LNXVIDEO:01
[  349.986360] input input8: input_dev_suspend+0x0/0x60 returned 0 after 0 usecs
[  349.986363] input input7: calling input_dev_suspend+0x0/0x60 @ 12762, parent: LNXVIDEO:00
[  349.986365] input input7: input_dev_suspend+0x0/0x60 returned 0 after 0 usecs
...
[  349.987136] psmouse serio1: calling serio_suspend+0x0/0x20 @ 12762, parent: i8042
...
[  351.598355] i2c_hid i2c-SYNA2393:00: calling acpi_subsys_suspend_late+0x0/0x60 @ 12784, parent: i2c-10
[  351.598366] i2c_hid i2c-SYNA2393:00: acpi_subsys_suspend_late+0x0/0x60 returned 0 after 1 usecs
[  351.598465] i2c_designware i2c_designware.1: calling dw_i2c_plat_suspend+0x0/0x40 @ 12762, parent: 0000:00:15.1
[  351.598487] i2c_designware i2c_designware.1: dw_i2c_plat_suspend+0x0/0x40 returned 0 after 13 usecs
[  351.598529] i2c_hid i2c-WCOM488F:00: calling acpi_subsys_suspend_late+0x0/0x60 @ 87, parent: i2c-9
[  351.598540] i2c_hid i2c-WCOM488F:00: acpi_subsys_suspend_late+0x0/0x60 returned 0 after 1 usecs
[  351.598609] i2c_designware i2c_designware.0: calling dw_i2c_plat_suspend+0x0/0x40 @ 12762, parent: 0000:00:15.0
[  351.598628] i2c_designware i2c_designware.0: dw_i2c_plat_suspend+0x0/0x40 returned 0 after 12 usecs
...
[  351.633232] i2c_hid i2c-SYNA2393:00: calling acpi_subsys_suspend_noirq+0x0/0x70 @ 12784, parent: i2c-10
[  351.633235] i2c_hid i2c-SYNA2393:00: acpi_subsys_suspend_noirq+0x0/0x70 returned 0 after 0 usecs
[  351.633258] i2c_hid i2c-WCOM488F:00: calling acpi_subsys_suspend_noirq+0x0/0x70 @ 12783, parent: i2c-9
[  351.633261] i2c_hid i2c-WCOM488F:00: acpi_subsys_suspend_noirq+0x0/0x70 returned 0 after 0 usecs

Here is the relevant portion of the resume cycle,
which is similar to the one I posted earlier:

[  353.256580] leds dell::kbd_backlight: led_resume+0x0/0x30 returned 0 after 0 usecs
[  353.256585] idma64 idma64.1: calling platform_pm_resume+0x0/0x50 @ 12762, parent: 0000:00:15.1
[  353.256589] idma64 idma64.1: platform_pm_resume+0x0/0x50 returned 0 after 0 usecs
[  353.256594] i2c_designware i2c_designware.1: calling platform_pm_resume+0x0/0x50 @ 12762, parent: 0000:00:15.1
[  353.256597] i2c_designware i2c_designware.1: platform_pm_resume+0x0/0x50 returned 0 after 0 usecs
[  353.256606] input input12: calling input_dev_resume+0x0/0x50 @ 12762, parent: card0
[  353.256611] input input12: input_dev_resume+0x0/0x50 returned 0 after 0 usecs
[  353.256616] input input13: calling input_dev_resume+0x0/0x50 @ 12762, parent: card0
[  353.256625] i2c_hid i2c-WCOM488F:00: calling i2c_hid_resume+0x0/0x140 [i2c_hid] @ 12809, parent: i2c-9
[  353.256630] input input13: input_dev_resume+0x0/0x50 returned 0 after 0 usecs
[  353.256632] i2c_hid i2c-WCOM488F:00: i2c_hid_set_power
[  353.256635] i2c_hid i2c-WCOM488F:00: i2c_hid_set_power 428: did NOT delay after sleep whilst powered on. No quirk?
[  353.256639] input input14: calling input_dev_resume+0x0/0x50 @ 12762, parent: card0
[  353.256645] input input14: input_dev_resume+0x0/0x50 returned 0 after 0 usecs
[  353.256708] i2c_hid i2c-WCOM488F:00: __i2c_hid_command: cmd=04 00 00 08
[  353.256712] input input15: calling input_dev_resume+0x0/0x50 @ 12762, parent: card0
[  353.256717] input input15: input_dev_resume+0x0/0x50 returned 0 after 0 usecs
[  353.256722] input input16: calling input_dev_resume+0x0/0x50 @ 12762, parent: card0
[  353.256727] input input16: input_dev_resume+0x0/0x50 returned 0 after 0 usecs
[  353.256732] input input17: calling input_dev_resume+0x0/0x50 @ 12762, parent: card0
[  353.256736] input input17: input_dev_resume+0x0/0x50 returned 0 after 0 usecs
[  353.256759] i2c_hid i2c-SYNA2393:00: calling i2c_hid_resume+0x0/0x140 [i2c_hid] @ 12791, parent: i2c-10
[  353.256767] i2c_hid i2c-SYNA2393:00: i2c_hid_set_power
[  353.256771] i2c_hid i2c-SYNA2393:00: i2c_hid_set_power 426: delayed after sleep with power on
[  353.256833] i2c_hid i2c-SYNA2393:00: __i2c_hid_command: cmd=22 00 00 08
[  353.257109] i2c_hid i2c-WCOM488F:00: i2c_hid_set_power 438: did NOT delay after sleep at sleep. No quirk?
[  353.257135] i2c_hid i2c-SYNA2393:00: i2c_hid_set_power 438: did NOT delay after sleep at sleep. No quirk?
[  353.257176] i2c_hid i2c-WCOM488F:00: i2c_hid_set_or_send_report
[  353.257233] i2c_hid i2c-WCOM488F:00: __i2c_hid_command: cmd=04 00 3b 03 05 00 42 00 0b 00 1c 1c 15 40 25 ac 00 10 ba 13 17 be ff ff 02 00 00 00 00 00 00 00 38 07 00 7e a3 94 ff ff 18 0f 00 7e a3 94 ff ff d8 29 ca 75 a3 94 ff ff b0 07 00 7e a3 94 ff ff
[  353.257240] i2c_hid i2c-SYNA2393:00: i2c_hid_set_or_send_report
[  353.257244] i2c_hid i2c-SYNA2393:00: __i2c_hid_command: cmd=22 00 3d 03 23 00 04 00 0d 00
[  353.258737] i2c_hid i2c-SYNA2393:00: input: 20 00 03 01 38 02 a5 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 c6 01 00
[  353.259889] i2c_hid i2c-WCOM488F:00: i2c_hid_get_report
[  353.259892] i2c_hid i2c-WCOM488F:00: __i2c_hid_command: cmd=04 00 3b 02 05 00
[  353.260345] i2c_hid i2c-SYNA2393:00: input: 20 00 03 01 38 02 a5 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 c6 01 00
[  353.261936] i2c_hid i2c-SYNA2393:00: input: 20 00 03 01 38 02 a5 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 c6 01 00
[  353.262416] i2c_hid i2c-SYNA2393:00: i2c_hid_set_or_send_report
[  353.262420] i2c_hid i2c-SYNA2393:00: __i2c_hid_command: cmd=22 00 34 03 23 00 04 00 04 03
[  353.262646] i2c_hid i2c-WCOM488F:00: i2c_hid_set_or_send_report
[  353.262650] i2c_hid i2c-WCOM488F:00: __i2c_hid_command: cmd=04 00 3b 03 05 00 42 00 0b 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[  353.264051] i2c_hid i2c-SYNA2393:00: input: 20 00 03 01 38 02 a5 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 c6 01 00
[  353.265306] i2c_hid i2c-WCOM488F:00: i2c_hid_get_report
[  353.265309] i2c_hid i2c-WCOM488F:00: __i2c_hid_command: cmd=04 00 3b 02 05 00
[  353.265631] i2c_hid i2c-SYNA2393:00: input: 20 00 03 01 38 02 a5 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 c6 01 00
[  353.267232] i2c_hid i2c-SYNA2393:00: input: 20 00 03 01 38 02 a5 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 c6 01 00
[  353.267705] i2c_hid i2c-SYNA2393:00: i2c_hid_set_or_send_report
[  353.267708] i2c_hid i2c-SYNA2393:00: __i2c_hid_command: cmd=22 00 36 03 23 00 04 00 06 03
[  353.268076] i2c_hid i2c-WCOM488F:00: i2c_hid_set_or_send_report
[  353.268080] i2c_hid i2c-WCOM488F:00: __i2c_hid_command: cmd=04 00 3b 03 05 00 42 00 0b 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[  353.269304] i2c_hid i2c-SYNA2393:00: input: 20 00 03 01 38 02 a5 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 c6 01 00
[  353.270683] i2c_hid i2c-WCOM488F:00: i2c_hid_get_report
[  353.270687] i2c_hid i2c-WCOM488F:00: __i2c_hid_command: cmd=04 00 3b 02 05 00
[  353.270877] i2c_hid i2c-SYNA2393:00: input: 20 00 03 01 38 02 a5 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 c6 01 00
[  353.272471] i2c_hid i2c-SYNA2393:00: input: 20 00 03 01 38 02 a5 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 c6 01 00
[  353.272983] i2c_hid i2c-SYNA2393:00: i2c_hid_resume+0x0/0x140 [i2c_hid] returned 0 after 15834 usecs
[  353.273091] input input27: calling input_dev_resume+0x0/0x50 @ 12762, parent: 0018:06CB:7A13.0002
[  353.273096] input input27: input_dev_resume+0x0/0x50 returned 0 after 0 usecs
[  353.273104] rfkill rfkill0: calling rfkill_resume+0x0/0x60 @ 12762, parent: phy0
[  353.273112] rfkill rfkill0: rfkill_resume+0x0/0x60 returned 0 after 4 usecs
[  353.273121] input input29: calling input_dev_resume+0x0/0x50 @ 12762, parent: 1-12:1.0
[  353.273125] input input29: input_dev_resume+0x0/0x50 returned 0 after 0 usecs
[  353.273130] rfkill rfkill1: calling rfkill_resume+0x0/0x60 @ 12762, parent: hci0
[  353.273134] rfkill rfkill1: rfkill_resume+0x0/0x60 returned 0 after 0 usecs
[  353.273436] i2c_hid i2c-WCOM488F:00: i2c_hid_set_or_send_report
[  353.273439] i2c_hid i2c-WCOM488F:00: __i2c_hid_command: cmd=04 00 3b 03 05 00 42 00 0b 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[  353.274593] i2c_hid i2c-SYNA2393:00: input: 20 00 03 01 38 02 a5 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 c6 01 00
[  353.276065] i2c_hid i2c-WCOM488F:00: i2c_hid_get_report
[  353.276069] i2c_hid i2c-WCOM488F:00: __i2c_hid_command: cmd=04 00 3b 02 05 00
[  353.276212] i2c_hid i2c-SYNA2393:00: input: 20 00 03 01 38 02 a5 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 c6 01 00
[  353.277809] i2c_hid i2c-SYNA2393:00: input: 20 00 03 01 38 02 a5 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 c6 01 00
[  353.278839] i2c_hid i2c-WCOM488F:00: i2c_hid_set_or_send_report
[  353.278843] i2c_hid i2c-WCOM488F:00: __i2c_hid_command: cmd=04 00 3b 03 05 00 42 00 0b 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00: input: 20 00 03 01 38 02 a5 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 c6 01 00
[  353.281024] i2c_hid i2c-SYNA2393:00: input: 20 00 03 01 38 02 a5 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 c6 01 00
[  353.281449] i2c_hid i2c-WCOM488F:00: i2c_hid_get_report
[  353.281453] i2c_hid i2c-WCOM488F:00: __i2c_hid_command: cmd=04 00 3b 02 05 00
[  353.282614] i2c_hid i2c-SYNA2393:00: input: 20 00 03 01 38 02 a5 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 c6 01 00
[  353.284248] i2c_hid i2c-WCOM488F:00: i2c_hid_set_or_send_report
[  353.284251] i2c_hid i2c-WCOM488F:00: __i2c_hid_command: cmd=04 00 3b 03 05 00 42 00 0b 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[  353.284326] i2c_hid i2c-SYNA2393:00: input: 20 00 03 01 38 02 a5 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 c6 01 00
[  353.285890] i2c_hid i2c-SYNA2393:00: input: 20 00 03 01 38 02 a5 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 c6 01 00
[  353.286847] i2c_hid i2c-WCOM488F:00: i2c_hid_get_report
[  353.286850] i2c_hid i2c-WCOM488F:00: __i2c_hid_command: cmd=04 00 3b 02 05 00
[  353.287489] i2c_hid i2c-SYNA2393:00: input: 20 00 03 01 38 02 a5 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 c6 01 00
[  353.289099] i2c_hid i2c-SYNA2393:00: input: 20 00 03 01 38 02 a5 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 c6 01 00
[  353.289595] i2c_hid i2c-WCOM488F:00: i2c_hid_set_or_send_report
[  353.289598] i2c_hid i2c-WCOM488F:00: __i2c_hid_command: cmd=04 00 3e 03 05 00 05 00 0e 02 00
[  353.290178] i2c_hid i2c-WCOM488F:00: i2c_hid_resume+0x0/0x140 [i2c_hid] returned 0 after 32758 usecs
[  353.290275] input input30: calling input_dev_resume+0x0/0x50 @ 12762, parent: 0018:056A:488F.0001
[  353.290281] input input30: input_dev_resume+0x0/0x50 returned 0 after 0 usecs
[  353.290287] input input31: calling input_dev_resume+0x0/0x50 @ 12762, parent: 0018:056A:488F.0001
[  353.290292] input input31: input_dev_resume+0x0/0x50 returned 0 after 0 usecs
[  353.290804] i2c_hid i2c-SYNA2393:00: input: 20 00 03 01 38 02 a5 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 c6 01 00
[  353.291066] acpi LNXPOWER:07: Turning OFF
[  353.292115] acpi LNXPOWER:02: Turning OFF
[  353.292403] i2c_hid i2c-SYNA2393:00: input: 20 00 03 01 38 02 a5 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 c6 01 00
[  353.293924] acpi LNXPOWER:01: Turning OFF
[  353.294004] i2c_hid i2c-SYNA2393:00: input: 20 00 03 01 38 02 a5 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 c6 01 00
[  353.295015] OOM killer enabled.
[  353.295017] Restarting tasks ...
[  353.295617] i2c_hid i2c-SYNA2393:00: input: 20 00 03 01 38 02 a5 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 c6 01 00
[  353.297197] done.
[  353.297238] i2c_hid i2c-SYNA2393:00: input: 20 00 03 01 38 02 a5 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 c6 01 00
[  353.298871] i2c_hid i2c-SYNA2393:00: input: 20 00 03 01 38 02 a5 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 c6 01 00
[  353.300494] i2c_hid i2c-SYNA2393:00: input: 20 00 03 01 38 02 a5 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 c6 01 00
[  353.302107] i2c_hid i2c-SYNA2393:00: input: 20 00 03 01 38 02 a5 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 c6 01 00
[  353.303732] i2c_hid i2c-SYNA2393:00: input: 20 00 03 01 38 02 a5 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 c6 01 00
[  353.305342] i2c_hid i2c-SYNA2393:00: input: 20 00 03 01 38 02 a5 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 c6 01 00
[  353.306955] i2c_hid i2c-SYNA2393:00: input: 20 00 03 01 38 02 a5 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 c6 01 00
[  353.308955] i2c_hid i2c-SYNA2393:00: input: 20 00 03 01 38 02 a5 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 c6 01 00
...and so on until I touch the touchpad...

Note that, as without DELAY_AFTER_SLEEP, the last repeated
input values above after resume equal those in the last input
prior to suspend, so it's as if the touchpad's last interrupt
didn't get handled/acknowledged, and the contents of buffer
survived the suspend-resume cycle?  I can't really tell what
those values mean - asked Dell for the manual for the touchpad
and got told they don't support Linux :(

Kim
