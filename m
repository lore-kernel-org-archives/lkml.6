Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EDFBC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 11:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 129A020857
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 11:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="eEmD40/G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 129A020857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aepfle.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbeIEQUU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 12:20:20 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.24]:19386 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbeIEQUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 12:20:20 -0400
X-Greylist: delayed 4194 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Sep 2018 12:20:19 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1536148225;
        s=strato-dkim-0002; d=aepfle.de;
        h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=A+eJmaJDrDcA/dBJZg94K8jc1FAAIH0z9Qir5owBZGQ=;
        b=eEmD40/GDqVn68BD+hDVEFJ+NHnl/7j8aLxEE9VwbC4iijwqpOxdU0pkfDp3R92ZJ8
        sweTN4JInNnOVVsjG08xvMRSMhpPaK+/ZMSn3tI9MsV3Zm7ZzUE/WMkqbaI6Wyd+PXXM
        aHfXQZoD/osFGoT/yPxw9aJdqQ++WroqsoTU06zToXHVRMBvsjlP/92V5Palc+N6Hq/j
        zdCa9+a0GGIYq+wDUWDCL+0mRGaX1c5/+VD2adnx8QimvHFTCU2yTKeXIcvoOaTcHZto
        iwyJNthMkwCDs1gBnnwtfN+c5aXileRPYiaamvSA+U9E0BiZYNQRfzEWJjPqZXHUgtK4
        Bbrw==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QED/SSGq+wjGiUC4oc0Nr2ihluivsAQtyRsdRVZ54BGpAypu4eYvjwzPAqxRcXNDW+"
X-RZG-CLASS-ID: mo00
Received: from sender
        by smtp.strato.de (RZmta 44.0 AUTH)
        with ESMTPSA id L0862bu85BoO5DZ
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 5 Sep 2018 13:50:24 +0200 (CEST)
Date:   Wed, 5 Sep 2018 13:50:19 +0200
From:   Olaf Hering <olaf@aepfle.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     xen-devel@lists.xenproject.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] xen: avoid crash in disable_hotplug_cpu
Message-ID: <20180905135019.56b303da.olaf@aepfle.de>
In-Reply-To: <7630aac8-8588-6e42-0807-f98b66ce37b5@suse.com>
References: <20180905104039.13512-1-olaf@aepfle.de>
        <7630aac8-8588-6e42-0807-f98b66ce37b5@suse.com>
X-Mailer: Claws Mail 3.16.1 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/9_A9212rbA3FEtpY02kkZAv"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/9_A9212rbA3FEtpY02kkZAv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Am Wed, 5 Sep 2018 12:55:58 +0200
schrieb Juergen Gross <jgross@suse.com>:

> the last cpu

Which one is the "last" one? I mean, if cpu#0 never can be offlined than pe=
rhaps the code should check for just that and return early. But if cpu#0 co=
uld be disabled while some other cpu is the remaining cpu, some other check=
 is needed I think.

Olaf

--Sig_/9_A9212rbA3FEtpY02kkZAv
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQSkRyP6Rn//f03pRUBdQqD6ppg2fgUCW4/C+wAKCRBdQqD6ppg2
frlGAJ9IqMrNEZ+KR+wJ/FSquh6l+aGV6ACeN8hFlwCo1KKm1VhjD09C4UsVH4Y=
=zyjz
-----END PGP SIGNATURE-----

--Sig_/9_A9212rbA3FEtpY02kkZAv--
