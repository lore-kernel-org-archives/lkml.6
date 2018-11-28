Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07555C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78FAB2086B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="fe5cPxYg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78FAB2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mailbox.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbeK1U4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 15:56:19 -0500
Received: from mx1.mailbox.org ([80.241.60.212]:22316 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727662AbeK1U4T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 15:56:19 -0500
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 4067F427F4;
        Wed, 28 Nov 2018 10:55:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mailbox.org; h=
        content-type:content-type:in-reply-to:mime-version:date:date
        :message-id:from:from:references:subject:subject:received; s=
        mail20150812; t=1543398909; bh=i1wmpEFbY+K6ZBz5WtStbgvISdIFiB6mn
        h9iJHBqXu0=; b=fe5cPxYgnagdSxgZzia/xlTCDPB32RV3yXGvDyW7Geyo+YXtV
        Kj0YR0LSsYAQYvEfYOX0KPAe6IrWSxu3Nv4f1gPwMxT5LcG6dAf7JmU60YshtQMt
        4KomFVRWH1IIelIzTG6Gt7T7mZsT00cfoTlxuhHjPvYlmmvA3JRZyAqORFarGBHi
        M6Mj/KqUufoFkrhfte8pF+swSiVG+p6uje6jF/Bw07MAc02w4a2sMNw3o7+J+4fc
        5ASG6inXrRqR7T4jA7T3wmqTAT8pQQHW3r+RkB6aqvhJ6vDz2/ZiQpOCt11xwYVf
        NuxkPm/2GprVErBy8PPSvI8p7Rxei5dVL1bEA==
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id JOPuqnXW43mz; Wed, 28 Nov 2018 10:55:09 +0100 (CET)
Subject: Re: ext4 file system corruption with v4.19.3 / v4.19.4
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, grendel@twistedcode.net,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org
References: <065643a0-f9aa-a361-715a-03ca978d9228@roeck-us.net>
 <b43fb902-9b64-22d9-25ca-c970b3842a43@roeck-us.net>
 <5d94f857-b31d-a02c-5a20-2796076f447e@twistedcode.net>
 <2157925.3ZPi3Rj3bs@siriux> <20181127212255.GA2987@roeck-us.net>
From:   Rainer Fiebig <jrf@mailbox.org>
Openpgp: preference=signencrypt
Autocrypt: addr=jrf@mailbox.org; prefer-encrypt=mutual; keydata=
 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
 6/dT7HxuwnVIkER8kg==
Message-ID: <ff046ad7-5a57-c53c-2803-55f6604732b0@mailbox.org>
Date:   Wed, 28 Nov 2018 10:56:50 +0100
MIME-Version: 1.0
In-Reply-To: <20181127212255.GA2987@roeck-us.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="mFeNj4Q8ttMRQBmq2sOG9ojwA7yHwpEWm"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mFeNj4Q8ttMRQBmq2sOG9ojwA7yHwpEWm
Content-Type: multipart/mixed; boundary="SbQYsgVsPm5IkRJPb5ZHjeHBV5vK3dpP1";
 protected-headers="v1"
From: Rainer Fiebig <jrf@mailbox.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, grendel@twistedcode.net,
 Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>,
 linux-ext4@vger.kernel.org
Message-ID: <ff046ad7-5a57-c53c-2803-55f6604732b0@mailbox.org>
Subject: Re: ext4 file system corruption with v4.19.3 / v4.19.4
References: <065643a0-f9aa-a361-715a-03ca978d9228@roeck-us.net>
 <b43fb902-9b64-22d9-25ca-c970b3842a43@roeck-us.net>
 <5d94f857-b31d-a02c-5a20-2796076f447e@twistedcode.net>
 <2157925.3ZPi3Rj3bs@siriux> <20181127212255.GA2987@roeck-us.net>
In-Reply-To: <20181127212255.GA2987@roeck-us.net>

--SbQYsgVsPm5IkRJPb5ZHjeHBV5vK3dpP1
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Am 27.11.18 um 22:22 schrieb Guenter Roeck:
> On Tue, Nov 27, 2018 at 07:55:01PM +0100, Rainer Fiebig wrote:
>> Am Dienstag, 27. November 2018, 15:48:19 schrieb Marek Habersack:
>>> On 27/11/2018 15:32, Guenter Roeck wrote:
>>> Hi,
>>>
>>> You might try to see if you have CONFIG_SCSI_MQ_DEFAULT=3Dyes in your=
 kernel
>>> config. Starting with 4.19.1 it somehow interferes with ext4 and caus=
es
>>> problems similar to the ones you list below. Ever since I disabled MQ=

>>> (either recompile your kernel or add `scsi_mod.use_blk_mq=3D0` to the=
 kernel
>>> command line) none of those errors came back.
>>>
>>> hope it helps,
>>>
>>> marek
>>
>> Unfortunately, this doesn't seem to work in every case:=20
>> https://bugzilla.kernel.org/show_bug.cgi?id=3D201685#c54
>>
>> And I'm using a defconfig-4.19.3 (meaning: CONFIG_SCSI_MQ_DEFAULT=3Dye=
s) in a VM=20
>> and I'm not seeing those errors there. OK, it's a VM - but anyway.
>>
>=20
> Agreed. I disabled CONFIG_SCSI_MQ_DEFAULT, but the problem is still see=
n
> at least on one of my servers, so disabling it does not help, at least =
not
> in my case.
>=20
> If the problem is somehow related to CONFIG_SCSI_MQ_DEFAULT, you might
> have to explicitly use a scsi drive (virtio-scsi-pci or similar) to
> trigger its use in a VM.

It seems more likely to me now that it may have nothing to do with the
SCSI-settings. Perhaps with some other config-option that's not set in a
defconfig.

I had hoped the problem would show up in the VM, so I could have safely
bisected it there. But tough luck.

So long!

Rainer Fiebig


>=20
> Guenter
>=20
>> The definite cause of this can only be found by bisecting, IMO. And it=
 needs=20
>> to be pinned down because else some feeling of insecurity will remain.=

>>
>> So long!
>>
>> Rainer Fiebig
>>
>>>
>>>> [trying again, this time with correct kernel.org address]
>>>>
>>>> Hi,
>>>>
>>>> I have seen the following and similar problems several times,
>>>> with both v4.19.3 and v4.19.4:
>>>>
>>>> Nov 23 04:32:25 mars kernel: [112668.673671] EXT4-fs error (device s=
db1):
>>>> ext4_iget:4831: inode #12602889: comm git: bad extra_isize 33661 (in=
ode
>>>> size 256)
>>>> Nov 23 04:32:25 mars kernel: [112668.675217] Aborting journal on dev=
ice
>>>> sdb1-8. Nov 23 04:32:25 mars kernel: [112668.676681] EXT4-fs (sdb1):=

>>>> Remounting filesystem read-only Nov 23 04:32:25 mars kernel:
>>>> [112668.808886] EXT4-fs error (device sdb1): ext4_iget:4831: inode
>>>> #12602881: comm rm: bad extra_isize 33685 (inode size 256)
>>>> ...
>>>>
>>>> Nov 25 00:12:43 saturn kernel: [59377.725984] EXT4-fs error (device =
sda1):
>>>> ext4_lookup:1578: inode #238034131: comm updatedb.mlocat: deleted in=
ode
>>>> referenced: 238160407
>>>> Nov 25 00:12:43 saturn kernel: [59377.766638] Aborting journal on de=
vice
>>>> sda1-8. Nov 25 00:12:43 saturn kernel: [59377.779372] EXT4-fs (sda1)=
:
>>>> Remounting filesystem read-only ...
>>>>
>>>> Nov 24 01:52:31 saturn kernel: [189085.240016] EXT4-fs error (device=

>>>> sda1): ext4_lookup:1578: inode #52038457: comm nfsd: deleted inode
>>>> referenced: 52043796
>>>> Nov 24 01:52:31 saturn kernel: [189085.263427] Aborting journal on d=
evice
>>>> sda1-8. Nov 24 01:52:31 saturn kernel: [189085.275313] EXT4-fs (sda1=
):
>>>> Remounting filesystem read-only
>>>>
>>>>
>>>> The same systems running v4.18.6 never experienced a problem.
>>>>
>>>> Has anyone else seen similar problems ? Is there anything I can do
>>>> to help tracking down the problem ?
>>>>
>>>> Thanks,
>>>> Guenter
>>
>> --=20
>> The truth always turns out to be simpler than you thought.
>> Richard Feynman
>=20
>=20



--SbQYsgVsPm5IkRJPb5ZHjeHBV5vK3dpP1--

--mFeNj4Q8ttMRQBmq2sOG9ojwA7yHwpEWm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE6yx5PjBNuGB2qJXG8OH3JiWK+PUFAlv+Zm8ACgkQ8OH3JiWK
+PUagQ//Vz3/FSlRLfrQhm/b0kAhVJPdT+zQ0CYratQQBYl/1ETHgUkmsWJY9u5H
5m0DlBkT2LTRWaaZT6eFpOkdnSK+xofn8cgPfBPvnpbeFf+AYAO6wupxRwsBZnJb
JIdhvWg25spx5EEgPircp5l2ZYk9eO74dPgNkskjhWOYfvplLRZ43rd6tRL9hi4U
hxVDMD4cC/cpFgY0vkMtz1c8HKUtAhKs329kS9zhFa6+4h/vwwy+XxkltCzWwsYj
s4vWKPUR6cMGmLTAy6uzPPZruFO9UiLlT97Qw6culB3wyovftAfubVjbrerPGZrV
kuZxYrxFyS4lBxfxGXYJ2W8v6detvO0imGHh/4wtConJCY4vWpxJA6KX3IrwYucF
k5H6ekz5IjMv+kZZPZ/IYYqDAdUIgZKAlAaI5ZV5zzVs6I3AhftdfxBOrKu1aosH
sOZ//stbZtP3DV/g0wx+6siZGbEoexTUBtwe5ZiauTNCN0/Q6y0JcZ7TJcnkgcC5
DD1rncm7gSy1gDe86VyyxbSf1kPS/WDycJ6tIEIqD9IbADyKq5tbBR4PeZsT+lBw
9sD+kQ/RUSaTKQBjrKPbX3/6eanSmuwqVSyFOZosYZJzQB/0ZnyRNLXnt8IlEA2H
lwHOfP9GE+XCXi/jNfR9omJxYf1eJeyme9USWBg09q+2hdyYM4o=
=bFdK
-----END PGP SIGNATURE-----

--mFeNj4Q8ttMRQBmq2sOG9ojwA7yHwpEWm--
