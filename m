Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D150C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 10:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 298A920866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 10:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="R3yW5Yk3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 298A920866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aepfle.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbeIKPrB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 11:47:01 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:16576 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbeIKPrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 11:47:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1536662893;
        s=strato-dkim-0002; d=aepfle.de;
        h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=zMIo+QlP6NjELxgWRYGvAFr9yVC1RA7i3HR5e/ce+28=;
        b=R3yW5Yk3VZWVM4V8xodXtyAuLbNy0H+Aj7tNYicUWMxxlg1tj8Jk2Vy4+vRhXkn9RS
        APnNcQfIK40eALXrkEQH6dAAlaYjRGUyijR6ViiuSXJRSwetkro+Vxf0iVIGZalorMdK
        pcgqfObtViTTXf4jx6F0sb6W/J5yXlm4tXe8QEhycTxkEvjQ3QCIxjPuv/1cnct/f6Mp
        aaJ4J5dciybFkiPpl06fFos6XM7D2hfLHpenFJ3IBzujVlBsRl6MJlgG42Dv9PXO+HW7
        PR4i9WnGSaPmvE+CCj3rg9P8/1vjwUHXDfZ0HUeVvKQUaASuzxRKy12IUmGQ4OtfLBF3
        ECXA==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QED/SSGq+wjGiUC4oc0Nr2ihluivIFRoeSV8ZanCUTzXkL91T4E0V3TMz5ObAI+PLPmQ=="
X-RZG-CLASS-ID: mo00
Received: from sender
        by smtp.strato.de (RZmta 44.0 AUTH)
        with ESMTPSA id L0862bu8BAmDQUb
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Tue, 11 Sep 2018 12:48:13 +0200 (CEST)
Date:   Tue, 11 Sep 2018 12:48:08 +0200
From:   Olaf Hering <olaf@aepfle.de>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] xen: avoid crash in disable_hotplug_cpu
Message-ID: <20180911124808.18dfe8bf.olaf@aepfle.de>
In-Reply-To: <20180911095258.5ed9e9b7.olaf@aepfle.de>
References: <20180907143135.29608-1-olaf@aepfle.de>
        <4f623671-e1aa-1804-449c-a26b0c4b9ce9@oracle.com>
        <20180911095258.5ed9e9b7.olaf@aepfle.de>
X-Mailer: Claws Mail 3.16.1 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/Sfd2.ijTAWqtljGsgLZh_Oj"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Sfd2.ijTAWqtljGsgLZh_Oj
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Am Tue, 11 Sep 2018 09:52:58 +0200
schrieb Olaf Hering <olaf@aepfle.de>:

> As J=C3=BCrgen suggested in another mail, Xen should probably disable hot=
plugging
> for cpu#0 in the generic setup code. Then cpu_is_hotpluggable(cpu) would
> do the right thing.

The relevant code is all private to arch/x86/kernel/topology.c.
There is no way to set .hotpluggable prior to register_cpu.
I guess you need to work that out with the x86 maintainers.

Olaf

--Sig_/Sfd2.ijTAWqtljGsgLZh_Oj
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQSkRyP6Rn//f03pRUBdQqD6ppg2fgUCW5edaAAKCRBdQqD6ppg2
fjWwAKCrFv/vHuKzbfIPZpQl9g2/TGaUigCg5UQ5+KRUfGnXJOUk7MH2kT2H6uo=
=QfE0
-----END PGP SIGNATURE-----

--Sig_/Sfd2.ijTAWqtljGsgLZh_Oj--
