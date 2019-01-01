Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6594BC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 12:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 042CC218B0
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 12:49:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nisi.nl header.i=j.vlietland@nisi.nl header.b="O5e8qQWm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728774AbfAAMte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 07:49:34 -0500
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21718 "EHLO
        sender-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728507AbfAAMte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 07:49:34 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1546346963; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=hRkWL35rWcC7jj3iPcskSMB2Mvty41XqOG0v0u3IoIboJ865X9S1yIpeR3Ql7apH5xQgNEwZKFoCK6vynr7rKOofjRFR42XGm50UhUxmGDe8+jo0RVI8nIJLx/Bs2rpCyDMkDFsuGfQRi7JboeZ0o+KnajRTmfr22lE2aZ8YmVA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1546346963; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To:ARC-Authentication-Results; 
        bh=WxBrV152C7S//4G/HV+3fpOcWS4fjTEgVnM/9tAVQ1s=; 
        b=b8r0b7vkrsgOWWR3m37dGfajMRh2rAj/qqhPycNkPxzwd89VzbkxyaiPx6rIjdwEBB9qye1GXTpZpqc8/amj6q9v1ZuJsuUd4eMszB8cXqHsqtCRgbDBSyd3wq2mmiEpHzA52w4URmhx3+HU/cAM92CZVVM5DIa8VSj/zuME7lo=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=nisi.nl;
        spf=pass  smtp.mailfrom=j.vlietland@nisi.nl;
        dmarc=pass header.from=<j.vlietland@nisi.nl> header.from=<j.vlietland@nisi.nl>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zoho; d=nisi.nl; 
  h=from:subject:to:cc:message-id:date:user-agent:mime-version:content-type; 
  b=MME/OA8SyuKxF3U8Z3yt5YfISZf9bN2XXVPIrD265RYUTn6r4QsCM6ecg5QfjoEXIvmyHXkpSPEW
    CtDz7/6p1ld0AC/vtjFq1bmm09lMKebf/9Ew3rA5l9ryjhWBZF9tPQe47yDXuyruksQ96gi1wiQq
    IYWd6J2NjSyPTjzdOIg=  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1546346963;
        s=zoho; d=nisi.nl; i=j.vlietland@nisi.nl;
        h=From:Subject:To:Cc:Message-ID:Date:MIME-Version:Content-Type:Content-Transfer-Encoding;
        l=2478; bh=WxBrV152C7S//4G/HV+3fpOcWS4fjTEgVnM/9tAVQ1s=;
        b=O5e8qQWm47ZaSHP0iEWfWJveFHlqUaZD7J4tViWWpPTlc1zvsotPWU+mINIErT4n
        iUsvOH5A1u7nmQ1jO19juNq8vMWgziQDNXWW0HslngszFa3mHsHYWsQw0OhAYtlBw2V
        Pl6oJnYwCXbnYCNPyvkmFanU/maw5NenLLJ5m34I=
Received: from [192.168.93.103] (5357467A.cm-6-8b.dynamic.ziggo.nl [83.87.70.122]) by mx.zohomail.com
        with SMTPS id 1546346960116893.1277897660914; Tue, 1 Jan 2019 04:49:20 -0800 (PST)
From:   Jan Vlietland <j.vlietland@nisi.nl>
Subject: Keyboard backlight not working on my NP900X5N laptop <previous not
 accepted due to HTML encoding>
To:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     "open list:SAMSUNG LAPTOP DRIVER" 
        <platform-driver-x86@vger.kernel.org>
Message-ID: <c3ea9b3f-5ffe-df8f-726c-0bf6f3a82701@nisi.nl>
Date:   Tue, 1 Jan 2019 13:48:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: nl
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Greg K-H suggested to mail you guys.

I installed Linux 4.20.0-rc7 (downloaded, compiled and installed) on a Sams=
ung NP900X5N laptop and have noticed 3 bugs. 2 of them I found in Bugzilla =
and replied on them (i915 and Nouveau issues). I am currently discussing th=
em with an intel engineer.

On other bug I haven't found so therefore a mail directly to you guys as ma=
intainers.

On my other machine, a Samsung NP900X4D (just bought it in the USA, 2017 mo=
del), the samsung-laptop.ko module is enabling the use of the keyboard back=
light keys.

It is not working on my new machine NP900X5N. My samsung-laptop.ko driver i=
sn't loading. If I try to load it manually it complains about 'no such devi=
ce".

My Linux kernel is working in CSM mode. The module is still not loaded.

As it is weekend I did some more reading and debugging of the module. To my=
 understanding the module checks the model and type of the laptop. The know=
n models and types are stored in the struct:

static struct dmi_system_id __initdata samsung_dmi_table[]

I wondr if the NP900X5N notebook is included in this list.

With dmidecode -t chassis it shows:
Getting SMBIOS data from sysfs.
SMBIOS 3.0.0 present.

Handle 0x0003, DMI type 3, 22 bytes
Chassis Information
         Manufacturer: SAMSUNG ELECTRONICS CO., LTD.
         Type: Notebook
         Lock: Not Present
         Version: N/A
         Serial Number: 0F4C91CJ900346
         Asset Tag: No Asset Tag
         Boot-up State: Safe
         Power Supply State: Safe
         Thermal State: Other
         Security Status: None
         OEM Information: 0x00000000
         Height: Unspecified
         Number Of Power Cords: 1
         Contained Elements: 0
         SKU Number: Chassis

If I use the -u flag. The notebook value is 0x0A, not 0x10!!!

Could that be the reason for not loading?

=09=09.matches =3D {
=09=09=09DMI_MATCH(DMI_SYS_VENDOR,
=09=09=09=09=09"SAMSUNG ELECTRONICS CO., LTD."),
=09=09=09DMI_MATCH(DMI_CHASSIS_TYPE, "10"), /* Notebook */
=09=09},

Maybe another reason could that that either the i915 and Nouveau modules=20
are not working well. I get black screens with the i915 and MMIO faults=20
with the nouveau driver. That is another issue that I need to tackle.

Oh happy new year :-)

--=20

Met vriendelijke groet,

*dr. Jan Vlietland*, namens

spin-off

Nederlands Instituut voor de Software Industrie

_j.vlietland@nisi.nl_| 06 =E2=80=93 20 411 834 | 030 =E2=80=93 268 53 98
Princetonplein 5 | 3584 CC=C2=A0 Utrecht | www.nisi.nl



