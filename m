Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4439CC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 11:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0482A21871
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 11:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wblp9OAs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729347AbeLSL0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 06:26:22 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41928 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729255AbeLSL0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 06:26:21 -0500
Received: by mail-lj1-f193.google.com with SMTP id k15-v6so17065325ljc.8;
        Wed, 19 Dec 2018 03:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zl/FQ02zDCdhGeqMe1/aqQs0xDd6N3gVw4SozzG/IFs=;
        b=Wblp9OAsPB428Ei3oNM3U70drzimJh80eJGllL0d9pg4zOQ+u+9SABWOroMTpgwmVZ
         1KJtxR9QUqAr4UXED0Oiuzy6SnMhIUI5AdpMH/ZqnnkdIP4CxK54Ckg87O4pzduOfV+m
         gbZXXw0GkYEFwLZv3/TIC3L0qWdDayUu27iXqVs20QKa3mAvGMWf+oDHK1y/X7U3sjOR
         KvxbzEXn91Xb6sbsG1ai7y10QwA5Qswg9Q2ImYygFOEBuepLof4Z+vkUIOKJRK7gEsIQ
         skYThRYWWt9SWuKLwh1jsz/BLDabzpv8N3w+b/qElntX04KIkvKXV2TStrdGcMGxE+9W
         DmWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zl/FQ02zDCdhGeqMe1/aqQs0xDd6N3gVw4SozzG/IFs=;
        b=bOIx5qjICvXyAJJhvIdimdsSAbOaavdyzibhQYxpaDfIY2lstxgDbmxTPxx5X80Fi7
         oeLxpsGwtGzMPCr3IF60FHZa3OT0f5rg2PgY/wLSjqMkqaSYmKyvUemZDMTKdPlsfNZ8
         ake5r0ldEAaucrRD5rOJHmgR2r3MmovhddqRyOX6hyxWQbL0axyBw61KxgzTIsx7CFim
         mCpgPJt19kA1kEIjMHeIny10fzQE4NqjTHdHs22r0VmA3ETlLyMfbFVGR+H0dhfpPwG1
         riam3Y9BmHh4209opkSdx3QSpNlLMcevDQWcXyxxgqdP3T77OqI+DCU2fS2ZEU/I6lIb
         1hxw==
X-Gm-Message-State: AA+aEWa4vxxxNLKu8nIe7M9mQCUh+HmpMGldz7gnYccnk72/DIZ+N5/O
        MDyA8TMJIyD/JukMFmBD2Es=
X-Google-Smtp-Source: AFSGD/WHjdcTKs0PGTwKxJzJza5cxp5BjEJZqo0cNLcFGY/bvkBWRkigITlyVTUPK0yboR8bQjh+ug==
X-Received: by 2002:a2e:2416:: with SMTP id k22-v6mr13671715ljk.80.1545218778727;
        Wed, 19 Dec 2018 03:26:18 -0800 (PST)
Received: from acerlaptop.localnet ([2a02:a315:5445:5300:e05f:a77f:eff8:4ba])
        by smtp.gmail.com with ESMTPSA id p186sm3761811lfd.83.2018.12.19.03.26.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Dec 2018 03:26:18 -0800 (PST)
From:   =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Bakker <xc-racer2@live.ca>
Subject: Re: [PATCH v2] Bluetooth: hci_bcm: Handle specific unknown packets after firmware loading
Date:   Wed, 19 Dec 2018 12:26:16 +0100
Message-ID: <1616107.XVYD9PJAcy@acerlaptop>
In-Reply-To: <6E62E2F9-5754-40AA-BA19-CDDABF338A1B@holtmann.org>
References: <20181205212232.3947-1-pawel.mikolaj.chmiel@gmail.com> <6E62E2F9-5754-40AA-BA19-CDDABF338A1B@holtmann.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dnia =C5=9Broda, 19 grudnia 2018 00:49:49 CET Marcel Holtmann pisze:
> Hi Pawel,
>=20
> > The Broadcom controller on aries S5PV210 boards sends out a couple of
> > unknown packets after the firmware is loaded.  This will cause
> > logging of errors such as:
> > 	Bluetooth: hci0: Frame reassembly failed (-84)
> >=20
> > This is probably also the case with other boards, as there are related
> > Android userspace patches for custom ROMs such as
> > https://review.lineageos.org/#/c/LineageOS/android_system_bt/+/142721/
> > Since this appears to be intended behaviour, treated them as diagnostic
> > packets.
> >=20
> > Note that this is another variant of commit 01d5e44ace8a
> > ("Bluetooth: hci_bcm: Handle empty packet after firmware loading")
> >=20
> > Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
> > Signed-off-by: Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com>
> >=20
> > ---
> > Changes from v1:
> > 	- Rename UNKNOWN to TYPE49
> > 	- Rename UNKNOWN2 to TYPE52
> > ---
> > drivers/bluetooth/hci_bcm.c | 22 ++++++++++++++++++++++
> > 1 file changed, 22 insertions(+)
>=20
> can you update this patch against latest bluetooth-next tree since it no =
longer applies cleanly.
I've send new version of both patches (this and Bluetooth: hci_bcm: Handle =
specific unknown packets after firmware loading), rebased against latest bl=
uetooth-next.
>=20
> Regards
>=20
> Marcel
>=20




