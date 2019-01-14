Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BE2C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FD0820663
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nisi.nl header.i=j.vlietland@nisi.nl header.b="WPtwVews"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfANJsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 04:48:30 -0500
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21718 "EHLO
        sender-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726306AbfANJsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 04:48:30 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1547459294; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=M4Ug+jUsQ5WaEH/7tA3q9RJqnaV7uipvCayMdSe/SKfXzoidQbbva7+dYMnO0SzzZy8qh1BSwpmXHvy6M6J11OXsPU4KaeqWgm9i+lq/o2Ph3kioPIBcXbQcsE3/ctubrtrYfseCDMwJ8DLChndT8BTPWpBLQmIl2Ef4QZn2ArM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1547459294; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=G6MmoHlz2K9muXgUJf/HInMs5YRWs40nE8K2HXfyWno=; 
        b=Xbi8lyFfcrTrI9uvSjJFaVsEmEFKkB1MrdZ+pwFqLlsHOY4ZvfRHp6qIqlYgwEwuUktVzOHx1XjhsjEsWVoNUexliPGWKuHyK+f3f6UmcsYBCA2eKCbsPuyy+9USv2/d747WZLeq9IiDUDncX3pqeT2Xn4KZeuAPEB0/ZVsrSZs=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=nisi.nl;
        spf=pass  smtp.mailfrom=j.vlietland@nisi.nl;
        dmarc=pass header.from=<j.vlietland@nisi.nl> header.from=<j.vlietland@nisi.nl>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zoho; d=nisi.nl; 
  h=subject:to:cc:references:from:message-id:date:user-agent:mime-version:in-reply-to:content-type; 
  b=nUtrN+LxmfvPi+uz2C1Nd4bnaRHKGcNBegdJrlpCrYfUknGiBCd8HiiZV/BOMMae+3+sZdF5JMZO
    tq3pVtOh48MRrgNpj+1o+CWtXY63L8w1yaatw5ehDAb8x8muW7PRDP7hxKlwU2VgNMHbYe92Igau
    v7PTqPBBcRCv0t/PZao=  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1547459294;
        s=zoho; d=nisi.nl; i=j.vlietland@nisi.nl;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        l=6441; bh=G6MmoHlz2K9muXgUJf/HInMs5YRWs40nE8K2HXfyWno=;
        b=WPtwVewsJ2HbUGGB9KwMfp9Tij0xuEjTVOs911p/2mgdcLmj1M/aQwR4LGL+pj76
        vaJI77w903rrW1WM6tAtGtyy0DKYt+GK2mzISH//Onp2RNmhiNkvDEfE2+8nRss5K7d
        sIRfqW0hI37Wx8M+AI8zHHOCwo/Cv8jO+OxoiuUw=
Received: from [192.168.43.157] (62.140.137.126 [62.140.137.126]) by mx.zohomail.com
        with SMTPS id 1547459293747576.3665567821793; Mon, 14 Jan 2019 01:48:13 -0800 (PST)
Subject: Re: Keyboard backlight not working on my NP900X5N laptop
To:     Darren Hart <dvhart@infradead.org>
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Andy Shevchenko <andy@infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:SAMSUNG LAPTOP DRIVER" 
        <platform-driver-x86@vger.kernel.org>
References: <ffa49970-ce0a-614e-3c90-03eb4924fbef@nisi.nl>
 <20190103020323.GA21617@wrath> <a675b43e-b40b-5049-2045-294325053723@nisi.nl>
 <20190113040201.GA1349@wrath>
From:   Jan Vlietland <j.vlietland@nisi.nl>
Message-ID: <c7109c47-1588-f870-fefe-0ed1350c6a6e@nisi.nl>
Date:   Mon, 14 Jan 2019 10:47:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190113040201.GA1349@wrath>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: nl
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-01-19 05:02, Darren Hart wrote:
> On Fri, Jan 04, 2019 at 05:16:38PM +0100, Jan Vlietland wrote:
>> Hi Darren,
>>
>> I understand your extra workload. For me it is just being another user
>> complaining about some bug. Sorry for that :-) Good to know the response
>> time. I will keep that in mind.
>>
>> Anyway. I have changed the static variable to "0A", recompiled the modul=
e
>> and I get the same output 'no such device'.
>>
>> However I am now running in EFI mode based on another bug:
>>
>> https://bugs.freedesktop.org/show_bug.cgi?id=3D109209
>>
>> ...and I see in the code....
>>
>>  =C2=A0=C2=A0=C2=A0 struct samsung_laptop *samsung;
>>  =C2=A0=C2=A0=C2=A0 int ret;
>>
>>  =C2=A0=C2=A0=C2=A0 if (efi_enabled(EFI_BOOT))
>>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return -ENODEV;
>>
>>  =C2=A0=C2=A0=C2=A0 quirks =3D &samsung_unknown;
>>  =C2=A0=C2=A0=C2=A0 if (!force && !dmi_check_system(samsung_dmi_table))
>>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return -ENODEV;
>>
>>  =C2=A0=C2=A0=C2=A0 samsung =3D kzalloc(sizeof(*samsung), GFP_KERNEL);
>>  =C2=A0=C2=A0=C2=A0 if (!samsung)
>>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return -ENOMEM
>>
>> Is that EFI restriction still valid. As far as I remember Samsung repair=
ed
>> their BIOS. Or does the driver not work in EFI mode anyway?
> Hi Jan,
>
> Taking a closer look at the driver and the git log, the driver was disabl=
ed for
> EFI because it pokes at BIOS memory and that would mean poking at a compl=
etely
> different memory map when in EFI mode - it would be expected to fail - an=
d in
> some cases it failed by bricking the laptop. See:
>
> e0094244e41c samsung-laptop: Disable on EFI hardware
I know the story. Btw in EFI there is backwards compatibility wrt to=20
memory. Should work but it is not needed anyway (read on :-)
> What appears to be needed here is for someone with the hardware and some
> experience tracing ACPI calls from whatever OS it ships with to figure ou=
t the
> new interface. I suspect it is either pure ACPI or possibly WMI, and a ne=
w
> driver may be needed.

I have the hardware and I can read C code..... so understand that it is=20
disabled.... However when using the EFIVars the backlight can be enabled=20
with:

"The (UEFI based) kernel creates /sys/firmware/efi/efivars with the=20
variable:
KBDBacklitLvl-5af56f53-985c-47d5-920c-f1c531d06852

The set immutable flag can be disabled with:
chattr -i=20
/sys/firmware/efi/efivars/KBDBacklitLvl-5af56f53-985c-47d5-920c-f1c531d0685=
2

After that the variable can be altered from 00 - 03:
echo 0700000002 | xxd -p -r >=20
/sys/firmware/efi/efivars/KBDBacklitLvl-5af56f53-985c-47d5-920c-f1c531d0685=
2=20
(GUID dependent on the manufacturer)

00 - Backlight off (always)
01 - Backlight on DIM level (by low ambient light; detected by light sensor=
)
02 - Backlight on NORM level (by low ambient light)
03 - Backlight on FULL level (by low ambient light)

for details my posts:=20
https://bugzilla.freedesktop.org/show_bug.cgi?id=3D109178

This need/could/should to be added to the module. In that case the=20
distribution can control the maximum brightness with the FN keys. Actual=20
control is done with the Embedded controller on the board.

Please let me know your view on this.

> Have you tried this driver in BIOS mode with the OA change above?
I tested in BIOS mode and it works then.
>
>>
>> On 03-01-19 03:03, Darren Hart wrote:
>>> On Mon, Dec 31, 2018 at 08:40:43PM +0100, Jan Vlietland wrote:
>>>> Hi all,
>>>>
>>> Hey Jan,
>>>
>>>> Greg K-H suggested to mail you guys.
>>>>
>>>> I installed Linux 4.20.0-rc7 (downloaded, compiled and installed) on a=
 Samsung NP900X5N laptop and have noticed 3 bugs. 2 of them I found in Bugz=
illa and replied on them (i915 and Nouveau issues). I am currently discussi=
ng them with an intel engineer.
>>>>
>>>> On other bug I haven't found so therefore a mail directly to you guys =
as maintainers.
>>>>
>>>> On my other machine, a Samsung NP900X4D (just bought it in the USA, 20=
17 model), the samsung-laptop.ko module is enabling the use of the keyboard=
 backlight keys.
>>>>
>>>> It is not working on my new machine NP900X5N. My samsung-laptop.ko dri=
ver isn't loading. If I try to load it manually it complains about 'no such=
 device".
>>>>
>>>> My Linux kernel is working in CSM mode. The module is still not loaded=
.
>>>>
>>> That's correct.
>>>
>>>> As it is weekend I did some more reading and debugging of the module. =
To my understanding the module checks the model and type of the laptop. The=
 known models and types are stored in the struct:
>>>>
>>>> static struct dmi_system_id __initdata samsung_dmi_table[]
>>>>
>>>> I wondr if the NP900X5N notebook is included in this list.
>>>>
>>>> With dmidecode -t chassis it shows:
>>>> Getting SMBIOS data from sysfs.
>>>> SMBIOS 3.0.0 present.
>>>>
>>>> Handle 0x0003, DMI type 3, 22 bytes
>>>> Chassis Information
>>>>           Manufacturer: SAMSUNG ELECTRONICS CO., LTD.
>>>>           Type: Notebook
>>>>           Lock: Not Present
>>>>           Version: N/A
>>>>           Serial Number: 0F4C91CJ900346
>>>>           Asset Tag: No Asset Tag
>>>>           Boot-up State: Safe
>>>>           Power Supply State: Safe
>>>>           Thermal State: Other
>>>>           Security Status: None
>>>>           OEM Information: 0x00000000
>>>>           Height: Unspecified
>>>>           Number Of Power Cords: 1
>>>>           Contained Elements: 0
>>>>           SKU Number: Chassis
>>>>
>>>> If I use the -u flag. The notebook value is 0x0A, not 0x10!!!
>>>>
>>>> Could that be the reason for not loading?
>>> Seems likely.
>>>
>>>> =09=09.matches =3D {
>>>> =09=09=09DMI_MATCH(DMI_SYS_VENDOR,
>>>> =09=09=09=09=09"SAMSUNG ELECTRONICS CO., LTD."),
>>>> =09=09=09DMI_MATCH(DMI_CHASSIS_TYPE, "10"), /* Notebook */
>>>> =09=09},
>>>>
>>>> Maybe another reason could that that either the i915 and Nouveau modul=
es are
>>>> not working well. I get black screens with the i915 and MMIO faults wi=
th the
>>>> nouveau driver. That is another issue that I need to tackle.
>>>>
>>> I would expect a different error than "no such device" in that case.
>>> I think your first thought was correct.
>>>
>>> As a simple test, I'd suggest replacing "10" with "0A" in the existing
>>> DMI_CHASSIS_TYPE match, recompile, and see if it loads and works
>>> correctly.  Would you be able to test this?
>>>
>>>> Oh happy new year :-)
>>> Happy New Year!
>>>
>>
>>


