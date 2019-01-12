Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E86EC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 12:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03C3420870
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 12:15:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="Wfuf/o7R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725859AbfALMPo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 07:15:44 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.167]:26248 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbfALMPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 07:15:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1547295337;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=CxSOw4BgpsEPtywcCm9QpO7XiE3I6drZc0oPoSe07Ic=;
        b=Wfuf/o7RSrsnNNgLaClv5nFIP5lQ2A6AE/P2+3w1WERLOt0Q5Yv9LZlQYdfP9Dkebe
        oN+ATykjzF8HZyt/Tr185+82Ky/8RJPp8y/wfNSV030o/ILB04cU7co7BSRbo4CAuKz9
        BgMIln3TcrreYv8kkiKa4xaS9ndeECMP0LF/uSYXgbnqctdTuuO8DZl+Kgc990vEXBDV
        GqthGVejuIbHsZ8L7Er+6tEHE/wDbhoX7ZffKVyA19RWXdL/rKIn1Oy9gCUxMBtgaVTQ
        00jHGua5NH2TTueXNlyAO/DDDkaAfOaatzPMe297388vPMINGEPbBFjRp7NzdLtlcyFx
        hIxg==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBp5hRw/qOxWRk4dCz2bu0M03KjNDR7J5QXDJRMIEU1BODrFBRYTjk="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2001:16b8:26cb:ce00:cff:a27b:eae1:f1ea]
        by smtp.strato.de (RZmta 44.9 AUTH)
        with ESMTPSA id 608499v0CCFSg9t
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Sat, 12 Jan 2019 13:15:28 +0100 (CET)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [Letux-kernel] [PATCH RFC] bluetooth: add uart h4 devices via serdev/devicetree
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <CABdtJHuHrp6iPEWaCJ1_dMg0reED8ScKTjnW9aRa2JvMnHtH_A@mail.gmail.com>
Date:   Sat, 12 Jan 2019 13:15:28 +0100
Cc:     Andreas Kemnade <andreas@kemnade.info>,
        Marcel Holtmann <marcel@holtmann.org>,
        Rob Herring <robh@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        devicetree <devicetree@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-bluetooth@vger.kernel.org, letux-kernel@openphoenux.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A88AE17C-28B7-4CD9-9F3B-AD436A64460B@goldelico.com>
References: <20181110232034.17277-1-andreas@kemnade.info> <20181111024648.7rt7rlhaqihtqecv@earth.universe> <20181112215812.18ebca35@aktux> <2C74C837-A6D3-47C9-BE59-CCA594289B94@goldelico.com> <20181112222726.73m2oca7hankvcjs@earth.universe> <CABGGisxsdv+BTd5-HMzF8asEcWtL5F4CMzmkrBCwK=NibvqjLQ@mail.gmail.com> <20181113170128.0f59ef0e@kemnade.info> <86A3A2E6-FC89-42FE-8410-9C8273EC9CF7@holtmann.org> <20181116204601.4e1aa0de@kemnade.info> <09AFE47C-D188-4397-A2CD-C70FFAC3B677@holtmann.org> <20190104064403.325771fd@kemnade.info> <B5CEA49A-0F54-40C5-BCEA-7875BE1358E3@holtmann.org> <20190104205600.3e6b31c9@aktux> <CABdtJHuHrp6iPEWaCJ1_dMg0reED8ScKTjnW9aRa2JvMnHtH_A@mail.gmail.com>
To:     Jon Nettleton <jon@solid-run.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sean Wang <sean.wang@mediatek.com>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

> Am 12.01.2019 um 12:16 schrieb Jon Nettleton <jon@solid-run.com>:
>=20
> On Fri, Jan 4, 2019 at 8:57 PM Andreas Kemnade <andreas@kemnade.info> =
wrote:
>>=20
>> Hi Marcel,
>>=20
>> On Fri, 4 Jan 2019 10:07:34 +0100
>> Marcel Holtmann <marcel@holtmann.org> wrote:
>>=20
>>> Hi Andreas,
>>>=20
>>>>>>> Btw. I see nothing standing in the way of merging btuart.c =
driver and then go from there. Either I dig this out and submit or =
someone else does.
>>>>>>>=20
>>>>>> Do you mean this?
>>>>>> https://patchwork.kernel.org/patch/10490651/
>>>>>=20
>>>>> yes, that one.
>>>>>=20
>>>> Hmm, there seemed to be nothing in the pull requests regarding =
btuart.
>>>> Did you change plans?
>>>=20
>>> because I only submitted it as RFC. We can easily merge that one =
upstream since it is rather trivial. The main problem is how you want to =
do the device matching. Do you have a DT entry for your really simple =
devices?
>>>=20
>> Hmm, in that link it is non-rfc. So someone picked you rfc patch up =
and
>> submitted it?

I have researched a little the patchwork entry and it makes me think =
that Sean did post it as part of a series for MediaTek Bluetooth drivers =
to the mediatek mailing list (which is why we can find it in patchwork):

	=
https://patchwork.kernel.org/project/linux-mediatek/list/?series=3D&submit=
ter=3D169671&state=3D&q=3D%5Bv5&archive=3D&delegate=3D

It wasn't discussed there and some other patches of the series have been =
merged to other trees (e.g. for serdev core).

So I assume Sean is also waiting to get this patch upstream.

>> You might see what we are already doing here:
>> =
http://git.goldelico.com/?p=3Dletux-kernel.git;a=3Dblobdiff;f=3Darch/arm/b=
oot/dts/omap3-gta04.dtsi;h=3D4d2bac4293938de4a15a59979616909cf8842524;hp=3D=
bfced960d63ec40cf9db4901374b331737a9a168;hb=3Df78bf51754e35010de40518b9a8a=
148d0269bbc8;hpb=3Db6805813a9ab5b0d66b44cc54a0059eca4dd0a98
>>=20
>> We are using compatible =3D "wi2wi,w2cbw003-bluetooth"
>>=20
>> But I think we should also add a generic device string like
>> bluetooth,h4
>> So if people dig out older hardware, they can just add that to their
>> device trees and have bluetooth
>>=20
>> The full patchset we are currently using is here:
>> =
http://git.goldelico.com/?p=3Dletux-kernel.git;a=3Dshortlog;h=3Drefs/heads=
/letux/bluetooth-h4-serdev
>>=20
>> Regards,
>> Andreas
>=20
> Good timing for this thread.  I have just integrated the mynewt blehci
> firmware for the nina-b1 chip integrated onto our SOM.  This is
> exactly the functionality I need in the kernel to make the
> initialization seamless.  A generic device string is exactly what
> would be needed for most devices that are running in this
> configuration.  We may also want to have a generic reset_gpio handler.
>=20
> -Jon

BR,
Nikolaus


