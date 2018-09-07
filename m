Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F5D5C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 13:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C35120869
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 13:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="H5ruSBKw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C35120869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aepfle.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729492AbeIGSUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 14:20:37 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.23]:9180 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbeIGSUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 14:20:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1536327574;
        s=strato-dkim-0002; d=aepfle.de;
        h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=7am7UAeqSoR3TRSMtO17MW3MrN4gUsl8+hX+rpgjL04=;
        b=H5ruSBKw4z9NLe8HZdKod03/ftHVaZAuP/yyZmzn2MxfTtFyeBSkS0b07Wqxf+RR3/
        naaG5cLSHCnyab5wokxrWMM+98pTGm0ivuMWQgZbqOD2ON5XneeAOACNBzqRS9bpA6ST
        UMDjYDiWuWS8A5PIiFj1ZRzdKKLY58+jNvTvunV3kgO3sFz23mU+pTef4jlr7ZTnBooI
        lSJKjUrHMDqpMgFyOzk9M7uOJRF0Uior2PAI59t2CQBWADWusE/Swe6G7wgEkd9UiIFV
        Wf5uPNm9U3FYyjXjtREkm++Kfv2Nn8cE2XtrunC93K8LEpfKOSBMm9psAnHz3pRnwXtj
        OnKw==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QED/SSGq+wjGiUC4oc0Nr2ihluivsAQtyRsdRVZ54BGpAypu4eYvjwzPAqxRcXNDW+"
X-RZG-CLASS-ID: mo00
Received: from sender
        by smtp.strato.de (RZmta 44.0 AUTH)
        with ESMTPSA id L0862bu87DdXFNp
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Fri, 7 Sep 2018 15:39:33 +0200 (CEST)
Date:   Fri, 7 Sep 2018 15:39:29 +0200
From:   Olaf Hering <olaf@aepfle.de>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] xen: avoid crash in disable_hotplug_cpu
Message-ID: <20180907153929.17d82e95.olaf@aepfle.de>
In-Reply-To: <26bef656-a1ec-8b81-98e2-ea723d095f03@oracle.com>
References: <20180907063023.16913-1-olaf@aepfle.de>
        <26bef656-a1ec-8b81-98e2-ea723d095f03@oracle.com>
X-Mailer: Claws Mail 3.16.1 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/dqoXiiKj2tZPOgK2yTzd_Y="; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/dqoXiiKj2tZPOgK2yTzd_Y=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Am Fri, 7 Sep 2018 09:33:20 -0400
schrieb Boris Ostrovsky <boris.ostrovsky@oracle.com>:

> what is the purpose of 'xl vcpu-set <domid> 0'?

Likely just a script that went wrong. But that command should not break the=
 dom0.

Olaf

--Sig_/dqoXiiKj2tZPOgK2yTzd_Y=
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQSkRyP6Rn//f03pRUBdQqD6ppg2fgUCW5J/kQAKCRBdQqD6ppg2
foPVAKDBMAZro1uFQQ8JlSqyU2Nmnsw4PgCeJMskAcPHeieR6XyXCnV1lpg0Tkg=
=6+u2
-----END PGP SIGNATURE-----

--Sig_/dqoXiiKj2tZPOgK2yTzd_Y=--
