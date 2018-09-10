Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F924C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BC2B20865
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:58:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="hPqU7XAD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BC2B20865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aepfle.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728580AbeIJUxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 16:53:21 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:27727 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728160AbeIJUxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 16:53:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1536595112;
        s=strato-dkim-0002; d=aepfle.de;
        h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=p2XmSnMfW2bw92jiHMazRfKFFxaE1OUJBwoQwE5PWzc=;
        b=hPqU7XADOIk9Kp9s4HWIMTb8yELUDG482CR98JmAGGxQ04MKRvdQ1rniFa4pVyWYha
        tCRwmes45gBdGQkQFCmgCNqjfLGTZgsbZE5zfYvSkpALmcGXJD72QeAat4ok8QUd5fbt
        SEk6sqog+ppr9Sh58JH/Sb1jndJ69KlYbabhH+9jO9PFgV8ajgJt8TwFEPpH4ds/Z8LG
        dtf9Vw3T2KnUnNqrS7dv1II/xdG6aChMNWk6/hOJklL/oSH/PPhNhk+W0BihKHmuu0vL
        puOFKYCR6D5QbfzWD+yP6C+4hacA5SdHRa62zae8AR2JTb8LCEC20lY6ej/dT9uwPY2t
        eMGw==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QED/SSGq+wjGiUC4oa0tv22oE4L2iGxAh2DLVXcEqAmZo="
X-RZG-CLASS-ID: mo00
Received: from sender
        by smtp.strato.de (RZmta 44.0 AUTH)
        with ESMTPSA id L0862bu8AFwVNkV
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Mon, 10 Sep 2018 17:58:31 +0200 (CEST)
Date:   Mon, 10 Sep 2018 17:58:25 +0200
From:   Olaf Hering <olaf@aepfle.de>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] xen: avoid crash in disable_hotplug_cpu
Message-ID: <20180910175825.683476d9.olaf@aepfle.de>
In-Reply-To: <4f623671-e1aa-1804-449c-a26b0c4b9ce9@oracle.com>
References: <20180907143135.29608-1-olaf@aepfle.de>
        <4f623671-e1aa-1804-449c-a26b0c4b9ce9@oracle.com>
X-Mailer: Claws Mail 3.16.1 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/k.0Y+4kv1lXOeXrHWw+B8V0"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/k.0Y+4kv1lXOeXrHWw+B8V0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Am Fri, 7 Sep 2018 12:56:37 -0400
schrieb Boris Ostrovsky <boris.ostrovsky@oracle.com>:

> I was hoping you'd respond to my question about warning.
>=20
> root@haswell> xl vcpu-set 3 0 =20
> and in the guest
>=20
> [root@vm-0238 ~]# [=C2=A0=C2=A0 32.866955] ------------[ cut here ]------=
------
> [=C2=A0=C2=A0 32.866963] spinlock on CPU0 exists on IRQ1!
> [=C2=A0=C2=A0 32.866984] WARNING: CPU: 0 PID: 14 at arch/x86/xen/spinlock=
.c:90
> xen_init_lock_cpu+0xbf/0xd0

This happens to work for me, on X5550. Please send your .config.

Olaf

--Sig_/k.0Y+4kv1lXOeXrHWw+B8V0
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQSkRyP6Rn//f03pRUBdQqD6ppg2fgUCW5aUoQAKCRBdQqD6ppg2
fv4NAKDxmj1J4eiqtj+VLauAAw3K6V3DwQCcDaB3WRE4Rp47xUF8BAX+rr+o4Q4=
=Z+iq
-----END PGP SIGNATURE-----

--Sig_/k.0Y+4kv1lXOeXrHWw+B8V0--
