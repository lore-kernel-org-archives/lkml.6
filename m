Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E070C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 19:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF08A20869
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 19:46:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="iaFJoj8w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF08A20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbeKQGAB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 01:00:01 -0500
Received: from mail.andi.de1.cc ([85.214.239.24]:46738 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbeKQGAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 01:00:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BFXFaEKcscgkScbVPZKLnvJdnbdJOocvRoWbJZ3kMgY=; b=iaFJoj8wDDaFgPUsN/PdvilPA
        ZDBqP47E7DUO1rJfoWRNIVNR9XvQveWbwdqhAzN5tP6j4Q3obG6XdjzgRyKbiV+PeynYsVsLHR7NU
        1GaZ6yuvsyQx6wZUUk2UYP1+TDjI8qZD5XJulHlk7j6Syu7nIvKeCUIBfL9rsT3UTXX/U=;
Received: from x590fed94.dyn.telefonica.de ([89.15.237.148] helo=localhost)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gNk4C-0000V0-6U; Fri, 16 Nov 2018 20:46:12 +0100
Received: from [::1] (helo=localhost)
        by localhost with esmtp (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gNk48-0007dE-LQ; Fri, 16 Nov 2018 20:46:08 +0100
Date:   Fri, 16 Nov 2018 20:46:01 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Rob Herring <robh@kernel.org>, sebastian.reichel@collabora.com,
        hns@goldelico.com, devicetree@vger.kernel.org,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-bluetooth@vger.kernel.org, letux-kernel@openphoenux.org
Subject: Re: [Letux-kernel] [PATCH RFC] bluetooth: add uart h4 devices via
 serdev/devicetree
Message-ID: <20181116204601.4e1aa0de@kemnade.info>
In-Reply-To: <86A3A2E6-FC89-42FE-8410-9C8273EC9CF7@holtmann.org>
References: <20181110232034.17277-1-andreas@kemnade.info>
        <20181111024648.7rt7rlhaqihtqecv@earth.universe>
        <20181112215812.18ebca35@aktux>
        <2C74C837-A6D3-47C9-BE59-CCA594289B94@goldelico.com>
        <20181112222726.73m2oca7hankvcjs@earth.universe>
        <CABGGisxsdv+BTd5-HMzF8asEcWtL5F4CMzmkrBCwK=NibvqjLQ@mail.gmail.com>
        <20181113170128.0f59ef0e@kemnade.info>
        <86A3A2E6-FC89-42FE-8410-9C8273EC9CF7@holtmann.org>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/mDijiKpFyv=Lgc7SNi0J1bT"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/mDijiKpFyv=Lgc7SNi0J1bT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

On Wed, 14 Nov 2018 08:51:17 +0100
Marcel Holtmann <marcel@holtmann.org> wrote:
[...[
> Btw. I see nothing standing in the way of merging btuart.c driver and the=
n go from there. Either I dig this out and submit or someone else does.
>=20
Do you mean this?
https://patchwork.kernel.org/patch/10490651/

Regards,
Andreas

--Sig_/mDijiKpFyv=Lgc7SNi0J1bT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE7sDbhY5mwNpwYgrAfb1qx03ikyQFAlvvHnkACgkQfb1qx03i
kyR9qQ/+K2Abq9GwLl4Jt232U9wItKWwkfDgv1TeqM4yNPupS994y4/CXOIz/58v
SWitIU1xIL88pIc7OpZXVNF4SZagQWn4m3krfmb9mN9TD8XeeT6bQmsB4p2/CsaA
PMzFZR6p3Lqa+ai81Emy6L/eaKYHmn1gOARrqamw8izO4ZL0LsOk8X3zf/tuv3/V
S9Dcsfym88tvjPTqzCESk4A+AXhH5G04otd0546zaugxu+snH9H+21rxxT+WRcEQ
0c5gok6G6ohwOlB+1i4SNO6qcgDH26OYoO5u/gn5TFQvbk1riXQunTwnfoaikLGk
rH6yBtuov3ZlHD0d3zl8H6I/cONeQKnBCKL7n5Z+x/buuSLr9//z99vX7ezxkJqm
nY3Ym2pZLZ1rOEgA+iRJ5f+IuOCmfGj0bhCtJrqPzwQ5SGIdIGcR57yuXbDBHHBM
MpPMLaZPyyVbLhnCRe3biRPU6kTASc2ENMHdru6WgtmEI5S5/8JDeS+1EqImCdyc
oYbuEqhC2RpypskKR2/bPcTlIILul1jF0Mt+kZ8GJbvKT8taUCUQ695W1zbzyyMz
IANeudeJZ2AGKG/zcDoNC8ynm8n0LdR4DNqvqobJ9SRSSokZq9jooBlW5Gn78wDa
fD60AggnsCuXdg38xlYt412IrzcCuZUoJcYMoDct/xKRB5d951o=
=++Bb
-----END PGP SIGNATURE-----

--Sig_/mDijiKpFyv=Lgc7SNi0J1bT--
