Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E49B2C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 07:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED34C2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 07:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="NKJ1LZ3k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED34C2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aepfle.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727596AbeIKMvN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 08:51:13 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.22]:16179 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbeIKMvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 08:51:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1536652387;
        s=strato-dkim-0002; d=aepfle.de;
        h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=VN5K/D5hf+7rTG12AsLJ6RBBD+9zNkeHfyaEnNLObcU=;
        b=NKJ1LZ3kWayefxC3kDVg05hFw9VtKVZ4x9hOZLKejJzacjRFNTCaZrtwKSgHHt65i9
        QSVyC/6E6w9t6YAMmMGu7jQUmObGFyAAyYkyjTsh2kX1azzA7MuY/BewQpjubZvyQ6dZ
        Ly0CCPkucMiPO42C8f92EokWqroe7jetEPlNOytkOUrxUz9nzoK+7q0yhfA2hRghbogw
        0IuS/GpTFM9WASfjNEECSHOIFtzlBa/FTIofoGSq2TPhObSFMZUSd2Tnv9UBlG4pCIdt
        niyZR4JWjYQgPA0c6PX3zkwdY3845OK17m+xkao6XJuzmNlD+Lbbovc7h32aML8MUdgw
        fWoA==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QED/SSGq+wjGiUC4oc0Nr2ihluivIFRoeSV8ZanCUTzXkL91T4E0V3TMz5ObAI+PLPmQ=="
X-RZG-CLASS-ID: mo00
Received: from sender
        by smtp.strato.de (RZmta 44.0 AUTH)
        with ESMTPSA id L0862bu8B7r6PR4
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Tue, 11 Sep 2018 09:53:06 +0200 (CEST)
Date:   Tue, 11 Sep 2018 09:52:58 +0200
From:   Olaf Hering <olaf@aepfle.de>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] xen: avoid crash in disable_hotplug_cpu
Message-ID: <20180911095258.5ed9e9b7.olaf@aepfle.de>
In-Reply-To: <4f623671-e1aa-1804-449c-a26b0c4b9ce9@oracle.com>
References: <20180907143135.29608-1-olaf@aepfle.de>
        <4f623671-e1aa-1804-449c-a26b0c4b9ce9@oracle.com>
X-Mailer: Claws Mail 3.16.1 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/CPClJ/MMcjkzZUX9ZJc226I"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/CPClJ/MMcjkzZUX9ZJc226I
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Am Fri, 7 Sep 2018 12:56:37 -0400
schrieb Boris Ostrovsky <boris.ostrovsky@oracle.com>:

> I was hoping you'd respond to my question about warning.

It looks like CONFIG_BOOTPARAM_HOTPLUG_CPU0=3Dy is the reason for the warni=
ng.
As J=C3=BCrgen suggested in another mail, Xen should probably disable hotpl=
ugging
for cpu#0 in the generic setup code. Then cpu_is_hotpluggable(cpu) would
do the right thing.

Do you want me to merge that extra change into this patch?

Olaf

--Sig_/CPClJ/MMcjkzZUX9ZJc226I
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQSkRyP6Rn//f03pRUBdQqD6ppg2fgUCW5d0WgAKCRBdQqD6ppg2
flNNAKCxtgFIZPAviAgZkf3DXwrkLC/2EQCg751qjqAtbIv/pXtyiEZ23CD7CA8=
=J0Xp
-----END PGP SIGNATURE-----

--Sig_/CPClJ/MMcjkzZUX9ZJc226I--
