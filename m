Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEFEBC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 16:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6477D21872
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 16:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nisi.nl header.i=j.vlietland@nisi.nl header.b="mFWB+v6m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbfADQRk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 11:17:40 -0500
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21751 "EHLO
        sender-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbfADQRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 11:17:39 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1546618643; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=aJ+kuTtb4xedKMeLUxPSEkhgxNpza21TqYzel4LnRvN5DJBflzbeTqfSx3Zxn+lh3Kk48xVZf9bjlfCrdEpbgmfiPjKtZupwbFIfJQxtFC8REEC4Je3Xyg8DHn3jgCQbPdqb3TO+j3asbiktn3u2wLx/UEY5PZd3arCdCq2OO+o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1546618643; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=LhaVccpxBh2QmmCbl5XfXy83RYFK6hr5PUNIOMQTyJ8=; 
        b=C88FfMF9YbiuOvAQkTO2Wo62QWvhhj9oGXnVy64eMFBn+FBnll445FYahuALkJfI0f/+2Uolc5dWcrlbl4pS3iz+QRbFqkNIgbnaJ6lnuvtcNdVdbEAAfPOzYka4NQX1AmfW/lvD1gt18ERJ4JvEOaOsT0afSafWVROU0UgEUog=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=nisi.nl;
        spf=pass  smtp.mailfrom=j.vlietland@nisi.nl;
        dmarc=pass header.from=<j.vlietland@nisi.nl> header.from=<j.vlietland@nisi.nl>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zoho; d=nisi.nl; 
  h=subject:to:cc:references:from:message-id:date:user-agent:mime-version:in-reply-to:content-type; 
  b=C5Z1H/AyZm4ncY3QcV3PvXjemHgCwJUVp9euvcB3sj4A/mLc5Ks8sFdqlMq5BsFAoOVu3XkB2ovG
    086RVr5s/g5AQ/XXpvur2/0++I+9BMoorz8DE1GsMzw9OzGnSxQizOyvedlCcPvd/k5uwYvRmPZ/
    0w8QJhmazjEBMqTbJ+o=  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1546618643;
        s=zoho; d=nisi.nl; i=j.vlietland@nisi.nl;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        l=4005; bh=LhaVccpxBh2QmmCbl5XfXy83RYFK6hr5PUNIOMQTyJ8=;
        b=mFWB+v6m2uTKojKpZsUAi57OOOvGZwa/zcfLby7YWeWuL5rqyTV5PZsld21TW7uz
        HnBqMd2bKecZiT07MmIEGFLW/YsW2sB6pRf/XSTjhdQv9FKJ6qm+OehjNS37ojH7/Kq
        bMywquln92KBlPgs7vSWCqg0dNse4nfK86vwQdX8=
Received: from [192.168.93.103] (5357467A.cm-6-8b.dynamic.ziggo.nl [83.87.70.122]) by mx.zohomail.com
        with SMTPS id 1546618641826213.7016628757657; Fri, 4 Jan 2019 08:17:21 -0800 (PST)
Subject: Re: Keyboard backlight not working on my NP900X5N laptop
To:     Darren Hart <dvhart@infradead.org>,
        Jan Vlietland <j.vlietland@nisi.nl>
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Andy Shevchenko <andy@infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:SAMSUNG LAPTOP DRIVER" 
        <platform-driver-x86@vger.kernel.org>
References: <ffa49970-ce0a-614e-3c90-03eb4924fbef@nisi.nl>
 <20190103020323.GA21617@wrath>
From:   Jan Vlietland <j.vlietland@nisi.nl>
Message-ID: <a675b43e-b40b-5049-2045-294325053723@nisi.nl>
Date:   Fri, 4 Jan 2019 17:16:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190103020323.GA21617@wrath>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: nl
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Darren,

I understand your extra workload. For me it is just being another user=20
complaining about some bug. Sorry for that :-) Good to know the response=20
time. I will keep that in mind.

Anyway. I have changed the static variable to "0A", recompiled the=20
module and I get the same output 'no such device'.

However I am now running in EFI mode based on another bug:

https://bugs.freedesktop.org/show_bug.cgi?id=3D109209

...and I see in the code....

 =C2=A0=C2=A0=C2=A0 struct samsung_laptop *samsung;
 =C2=A0=C2=A0=C2=A0 int ret;

 =C2=A0=C2=A0=C2=A0 if (efi_enabled(EFI_BOOT))
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return -ENODEV;

 =C2=A0=C2=A0=C2=A0 quirks =3D &samsung_unknown;
 =C2=A0=C2=A0=C2=A0 if (!force && !dmi_check_system(samsung_dmi_table))
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return -ENODEV;

 =C2=A0=C2=A0=C2=A0 samsung =3D kzalloc(sizeof(*samsung), GFP_KERNEL);
 =C2=A0=C2=A0=C2=A0 if (!samsung)
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return -ENOMEM

Is that EFI restriction still valid. As far as I remember Samsung=20
repaired their BIOS. Or does the driver not work in EFI mode anyway?


On 03-01-19 03:03, Darren Hart wrote:
> On Mon, Dec 31, 2018 at 08:40:43PM +0100, Jan Vlietland wrote:
>> Hi all,
>>
> Hey Jan,
>
>> Greg K-H suggested to mail you guys.
>>
>> I installed Linux 4.20.0-rc7 (downloaded, compiled and installed) on a S=
amsung NP900X5N laptop and have noticed 3 bugs. 2 of them I found in Bugzil=
la and replied on them (i915 and Nouveau issues). I am currently discussing=
 them with an intel engineer.
>>
>> On other bug I haven't found so therefore a mail directly to you guys as=
 maintainers.
>>
>> On my other machine, a Samsung NP900X4D (just bought it in the USA, 2017=
 model), the samsung-laptop.ko module is enabling the use of the keyboard b=
acklight keys.
>>
>> It is not working on my new machine NP900X5N. My samsung-laptop.ko drive=
r isn't loading. If I try to load it manually it complains about 'no such d=
evice".
>>
>> My Linux kernel is working in CSM mode. The module is still not loaded.
>>
> That's correct.
>
>> As it is weekend I did some more reading and debugging of the module. To=
 my understanding the module checks the model and type of the laptop. The k=
nown models and types are stored in the struct:
>>
>> static struct dmi_system_id __initdata samsung_dmi_table[]
>>
>> I wondr if the NP900X5N notebook is included in this list.
>>
>> With dmidecode -t chassis it shows:
>> Getting SMBIOS data from sysfs.
>> SMBIOS 3.0.0 present.
>>
>> Handle 0x0003, DMI type 3, 22 bytes
>> Chassis Information
>>          Manufacturer: SAMSUNG ELECTRONICS CO., LTD.
>>          Type: Notebook
>>          Lock: Not Present
>>          Version: N/A
>>          Serial Number: 0F4C91CJ900346
>>          Asset Tag: No Asset Tag
>>          Boot-up State: Safe
>>          Power Supply State: Safe
>>          Thermal State: Other
>>          Security Status: None
>>          OEM Information: 0x00000000
>>          Height: Unspecified
>>          Number Of Power Cords: 1
>>          Contained Elements: 0
>>          SKU Number: Chassis
>>
>> If I use the -u flag. The notebook value is 0x0A, not 0x10!!!
>>
>> Could that be the reason for not loading?
> Seems likely.
>
>> =09=09.matches =3D {
>> =09=09=09DMI_MATCH(DMI_SYS_VENDOR,
>> =09=09=09=09=09"SAMSUNG ELECTRONICS CO., LTD."),
>> =09=09=09DMI_MATCH(DMI_CHASSIS_TYPE, "10"), /* Notebook */
>> =09=09},
>>
>> Maybe another reason could that that either the i915 and Nouveau modules=
 are
>> not working well. I get black screens with the i915 and MMIO faults with=
 the
>> nouveau driver. That is another issue that I need to tackle.
>>
> I would expect a different error than "no such device" in that case.
> I think your first thought was correct.
>
> As a simple test, I'd suggest replacing "10" with "0A" in the existing
> DMI_CHASSIS_TYPE match, recompile, and see if it loads and works
> correctly.  Would you be able to test this?
>
>> Oh happy new year :-)
>
> Happy New Year!
>


