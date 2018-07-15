Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC1FECDFB3
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 23:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 645172086E
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 23:58:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 645172086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbeGPAX3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 20:23:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:56812 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727051AbeGPAX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 20:23:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 17356ACF1;
        Sun, 15 Jul 2018 23:58:47 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     David Miller <davem@davemloft.net>
Date:   Mon, 16 Jul 2018 09:58:40 +1000
Cc:     tgraf@suug.ch, herbert@gondor.apana.org.au, tom@quantonium.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] rhashtable: add rhashtable_walk_last_seen()
In-Reply-To: <20180710.165547.1599531889181336348.davem@davemloft.net>
References: <153086101070.2825.6850140624411927465.stgit@noble> <153086109260.2825.1459722786871837620.stgit@noble> <20180710.165547.1599531889181336348.davem@davemloft.net>
Message-ID: <87d0vot5jj.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

On Tue, Jul 10 2018, David Miller wrote:

> From: NeilBrown <neilb@suse.com>
> Date: Fri, 06 Jul 2018 17:11:32 +1000
>
>> rhashtable_walk_last_seen() returns the object returned by
>> the previous rhashtable_walk_next(), providing it is still in the
>> table (or was during this grace period).
>> This works even if rhashtable_walk_stop() and rhashtable_talk_start()
>                                                            ^^^^
>
> "walk"

Thanks :-)  Fixed for when I next post.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAltL37AACgkQOeye3VZi
gbnxNxAAkp8A4O7UQY5TbVwLd6F5uANm19VN3tjAkxJXFtjNdwOD2BLEXgJLrcqg
KS2OMPlb7olHC4M0+i4XQk3zDG4fLMxs3sG826nAdhNPIOuzFX80XmLJUYBnPsxy
kJcVXJB8KzKtIVGuwYSPMibkidtZuSOcPDB61cIT3itmMO+liHGE9/3OtBT/4UTM
HIuj1K7AoPDFNTUUryQrEtfZiXhLszrKAsivRvoiubW428CVNIbpWPOU8GCFhhQy
nhCqqUA1paseB3iSjOXTEkt1Fg+CxMCJ7tPyIrxlR7n+vQkJx+q45LQXXWcVaLMO
5iCdUvStCf5snbuNOJZWRD98VHufQZyERZaZT9DpjGzcdcnBAjFwPQveM+74SzUY
MLBKkWC1+zaniXxM1/h7YRUT4gGMYYq9eJJETX70JLbsd8QxVj8tqvUryNqSkPUp
ORKoGGBDgrZFCsYVByH7eLGdrpihd2lolFQpiGHw4H7kUY8H0jhGf1D3bT84m1nT
SUEnDMYup7QkFX2kQ9wuBdoQabr/pueo1tsPQRaXvnkjY11wQ56TOn6BDPWDEGKk
GVgRTkANtWKhPYA4Qx2uIhrOkkio2QlTdYP8AYV1V8MRmb8xm4NwcIBCJvJUWegJ
NhsJZAcqZ1fJf9/Gl7ibKsxU02lsPaKphTOLUAT4Zc7+ohhdfW0=
=rmFw
-----END PGP SIGNATURE-----
--=-=-=--
