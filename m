Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB1AC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 23:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D66F420874
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 23:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nisi.nl header.i=j.vlietland@nisi.nl header.b="DRppX+Wr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729940AbfABXVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 18:21:12 -0500
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21820 "EHLO
        sender-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729521AbfABXVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 18:21:12 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1546471256; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=FCSZsvxavWY51S81TIAjJplIanPj+b4Fqri3hQT5Ra7g0m6xh5dnPNH66ZVpn5uAjiHMQO9kyxCl3a7i5d0t/8jEOR45fn8umWfmtahzUxmvDNwRvLQDxaM9HTH3kZTt0fkDgOxFPILPVtJOguQZqKwFniRM5iUhxTN8KYyhoBM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1546471256; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=xcGqOifgzpddqBFavnZYWRxPO+PGGxHhoRu3AiLG07k=; 
        b=J7ZRJoLrCHbFmOLOnUaKhGbrBtCU+rgF8/hf87U2fSVmawer75f/7GQtvx9XUN+ygh5aMIIme8JsP5OUxR1HU4Ns3aF7gXS1wZeOnwkn/WV+seU+gPU4TASGAVUa0Lw/CDh64pp7J1LURpQIYEumeYvjaaNhopagviFw06boSpM=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=nisi.nl;
        spf=pass  smtp.mailfrom=j.vlietland@nisi.nl;
        dmarc=pass header.from=<j.vlietland@nisi.nl> header.from=<j.vlietland@nisi.nl>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zoho; d=nisi.nl; 
  h=subject:to:cc:references:from:message-id:date:user-agent:mime-version:in-reply-to:content-type; 
  b=RSqToULC1bjXLRaopPpqFr00VS/V0f1LdIR9PiwUH751qO5sEaixBbEojb4ox1nzo7bv0dOfZByR
    jjA0q+G/rrMsxL1ZFLpFaTMEgrjUVebudtTpY6Vlf9fVhLtHb+rLQIXLqTqVw4+/Say22VsnaPbE
    cIujdT49iK+j+O0V/E8=  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1546471256;
        s=zoho; d=nisi.nl; i=j.vlietland@nisi.nl;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        l=3549; bh=xcGqOifgzpddqBFavnZYWRxPO+PGGxHhoRu3AiLG07k=;
        b=DRppX+WrVs/uBvrBappiYH9MFN/9eR9Cws+fNpU5eeJgkHfTT3N9H3Y6YW8THeHn
        skRmLUkdXPWtY57s6Awc9Oym7Av5czhyxQJM9PPK/btfDJ5XJSM5dJd3sEwBRWj5oji
        v7SKNZpSq6sITJYtbs/m65Awgcyb1BFEHzB3veXw=
Received: from [192.168.93.103] (5357467A.cm-6-8b.dynamic.ziggo.nl [83.87.70.122]) by mx.zohomail.com
        with SMTPS id 1546471253406681.2572921603587; Wed, 2 Jan 2019 15:20:53 -0800 (PST)
Subject: Please help!: Keyboard backlight not working on my NP900X5N laptop
 <previous not accepted due to HTML encoding>
To:     Jan Vlietland <j.vlietland@nisi.nl>,
        Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     "open list:SAMSUNG LAPTOP DRIVER" 
        <platform-driver-x86@vger.kernel.org>
References: <c3ea9b3f-5ffe-df8f-726c-0bf6f3a82701@nisi.nl>
From:   Jan Vlietland <j.vlietland@nisi.nl>
Message-ID: <0e16bba8-046c-c559-9ee1-88c0341a51d5@nisi.nl>
Date:   Thu, 3 Jan 2019 00:20:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <c3ea9b3f-5ffe-df8f-726c-0bf6f3a82701@nisi.nl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: nl
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

Sorry but still walking with this bug under my arm.

I can't find the right group to file the bug on bugzilla and also on=20
freenode I cannot find the right group.

Please help!

Regards,

Jan


On 01-01-19 13:48, Jan Vlietland wrote:
> Hi all,
>
> Greg K-H suggested to mail you guys.
>
> I installed Linux 4.20.0-rc7 (downloaded, compiled and installed) on a=20
> Samsung NP900X5N laptop and have noticed 3 bugs. 2 of them I found in=20
> Bugzilla and replied on them (i915 and Nouveau issues). I am currently=20
> discussing them with an intel engineer.
>
> On other bug I haven't found so therefore a mail directly to you guys=20
> as maintainers.
>
> On my other machine, a Samsung NP900X4D (just bought it in the USA,=20
> 2017 model), the samsung-laptop.ko module is enabling the use of the=20
> keyboard backlight keys.
>
> It is not working on my new machine NP900X5N. My samsung-laptop.ko=20
> driver isn't loading. If I try to load it manually it complains about=20
> 'no such device".
>
> My Linux kernel is working in CSM mode. The module is still not loaded.
>
> As it is weekend I did some more reading and debugging of the module.=20
> To my understanding the module checks the model and type of the=20
> laptop. The known models and types are stored in the struct:
>
> static struct dmi_system_id __initdata samsung_dmi_table[]
>
> I wondr if the NP900X5N notebook is included in this list.
>
> With dmidecode -t chassis it shows:
> Getting SMBIOS data from sysfs.
> SMBIOS 3.0.0 present.
>
> Handle 0x0003, DMI type 3, 22 bytes
> Chassis Information
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Manufacturer: SAMSUNG ELECTRON=
ICS CO., LTD.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Type: Notebook
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Lock: Not Present
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Version: N/A
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Serial Number: 0F4C91CJ900346
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Asset Tag: No Asset Tag
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Boot-up State: Safe
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Power Supply State: Safe
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Thermal State: Other
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Security Status: None
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 OEM Information: 0x00000000
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Height: Unspecified
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Number Of Power Cords: 1
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Contained Elements: 0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SKU Number: Chassis
>
> If I use the -u flag. The notebook value is 0x0A, not 0x10!!!
>
> Could that be the reason for not loading?
>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .matches =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DMI_MA=
TCH(DMI_SYS_VENDOR,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "SAMSUNG ELECTRONICS CO., LTD.")=
,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DMI_MA=
TCH(DMI_CHASSIS_TYPE, "10"), /* Notebook */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
>
> Maybe another reason could that that either the i915 and Nouveau=20
> modules are not working well. I get black screens with the i915 and=20
> MMIO faults with the nouveau driver. That is another issue that I need=20
> to tackle.
>
> Oh happy new year :-)
>


