Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0DF1C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 15:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C84262077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 15:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="WAnDlvGf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C84262077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aepfle.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbeIET6E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 15:58:04 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.54]:10225 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbeIET6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 15:58:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1536161239;
        s=strato-dkim-0002; d=aepfle.de;
        h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=B4I7GRZ9OWj/kvtF1WqWGQiStfhLiyn/x1p8g5+/jR8=;
        b=WAnDlvGfekNLWZaYKoqKcqkQbPYO0Gy70hzTWUc9/WpmXSfpERcwTJI+DcV8Nn6uMU
        Xgbn4ZMngHb+cn9ohbgCleOWJVhTfwEQPzhvJTWo92xkC6Yg4uQOEPv/9QOlEjuSOF0D
        MDgXyR6ekLtZ1tlzQ9NokQMsEFP2FMWGssXTjU1LK/2pfzrb6ntfi9iY/ycHnfdmWgoU
        1WDDAZxVA4UMmgbPyb7Z5U7I/rJvc1yauR6GH3kMambQQli3biU3/QC0GPvlsWF1coUc
        lmVeBf4nwGHzBh+ypi8AyNocCt6BwR0JzUT6Z7/1qd6kfmRQA3yohGAw7TtJXghJp/01
        8npQ==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QED/SSGq+wjGiUC4oc0Nr2ihluivsAQtyRsdRVZ54BGpAypu4eYvjwzPAqxRcXNDW+"
X-RZG-CLASS-ID: mo00
Received: from sender
        by smtp.strato.de (RZmta 44.0 AUTH)
        with ESMTPSA id L0862bu85FRI6R5
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 5 Sep 2018 17:27:18 +0200 (CEST)
Date:   Wed, 5 Sep 2018 17:27:14 +0200
From:   Olaf Hering <olaf@aepfle.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     xen-devel@lists.xenproject.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] xen: avoid crash in disable_hotplug_cpu
Message-ID: <20180905172714.301ee3ca.olaf@aepfle.de>
In-Reply-To: <237d1597-6085-dffb-fb12-1965db0ee68b@suse.com>
References: <20180905104039.13512-1-olaf@aepfle.de>
        <7630aac8-8588-6e42-0807-f98b66ce37b5@suse.com>
        <20180905164719.52e02256.olaf@aepfle.de>
        <237d1597-6085-dffb-fb12-1965db0ee68b@suse.com>
X-Mailer: Claws Mail 3.16.1 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/TI5y0ZfQwVAwJKF68k8B/3J"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/TI5y0ZfQwVAwJKF68k8B/3J
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Am Wed, 5 Sep 2018 17:14:48 +0200
schrieb Juergen Gross <jgross@suse.com>:

> I'm not sure this WARN triggers because it is cpu#0. Are you sure
> the tested cpu in that WARN was 0? After all the test is just running
> on cpu#0 and I don't think it can be offline already.

If I leave cpu#0 alone, no WARN is triggered.
I resend with test cpu_is_hotpluggable.

Olaf

--Sig_/TI5y0ZfQwVAwJKF68k8B/3J
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQSkRyP6Rn//f03pRUBdQqD6ppg2fgUCW4/10gAKCRBdQqD6ppg2
fufQAKD4WbQYJa6/l2vfOvl8CTRfmE7miwCg2mhDS0UzOsyptvX7Rg1m3w3HChA=
=SfAQ
-----END PGP SIGNATURE-----

--Sig_/TI5y0ZfQwVAwJKF68k8B/3J--
