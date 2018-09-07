Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0654CC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 05:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6E9E20645
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 05:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="p0yjpKT3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6E9E20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aepfle.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbeIGKYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 06:24:42 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.216]:20984 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbeIGKYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 06:24:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1536299123;
        s=strato-dkim-0002; d=aepfle.de;
        h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=S+CE7bZJZNIEjj6hOGWIr2sWzXIHVWJuoqQwoeMT5cc=;
        b=p0yjpKT3FpLEelJXXV5ZqEatPuZBvB1D2FvDaKR25n5DrbQ14V8GE6AHYtZrw4sUUx
        vQutnJdeBMN81xOf4vQ4mj18DSMmAvxw/xqwQof0V121mhiD6C+r0E0rayP10/GGJH9E
        ZxE/C8yGvtBcHY2HjQlQAy5WAqzvshPMfAfzaH7EkJKHlNsIWdPXuvfkbtCwkhua2vk3
        7yNsPY5EKjDngrAW9H/O5F9KIa2NxLhNqR5tYjEqQMn22r26KYdMITUhTdqnGNt7ivOR
        9n0guVlw/BhfqYUXRchDelGVefF0P5PiL4LVRzyJ+kSp/bMT933Bzin94GaDxr44sNg2
        XUVw==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QED/SSGq+wjGiUC4oc0Nr2ihluivsAQtyRsdRVZ54BGpAypu4eYvjwzPAqxRcXNDW+"
X-RZG-CLASS-ID: mo00
Received: from sender
        by smtp.strato.de (RZmta 44.0 AUTH)
        with ESMTPSA id L0862bu875jLCvg
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Fri, 7 Sep 2018 07:45:21 +0200 (CEST)
Date:   Fri, 7 Sep 2018 07:45:16 +0200
From:   Olaf Hering <olaf@aepfle.de>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] xen: avoid crash in disable_hotplug_cpu
Message-ID: <20180907074516.0b41c22c.olaf@aepfle.de>
In-Reply-To: <20180906223145.37f7009b.olaf@aepfle.de>
References: <20180906063712.28639-1-olaf@aepfle.de>
        <b7306d7f-e827-6556-e1bb-4b934a162e46@oracle.com>
        <20180906223145.37f7009b.olaf@aepfle.de>
X-Mailer: Claws Mail 3.16.1 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/brc6enfNc+w_nEhkbdKk8pt"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/brc6enfNc+w_nEhkbdKk8pt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Am Thu, 6 Sep 2018 22:31:45 +0200
schrieb Olaf Hering <olaf@aepfle.de>:

> IF cpu0_hotpluggable is broken, then only "if (!cpu) return;" can help.

Another option is to do cpu_online() twice to check if device_offline did a=
nything.
Not sure if the compiler would fold the two checks into a single check.

Olaf

--Sig_/brc6enfNc+w_nEhkbdKk8pt
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQSkRyP6Rn//f03pRUBdQqD6ppg2fgUCW5IQbAAKCRBdQqD6ppg2
fonmAJ43xS6t1EFuJyUjloE4fVpnnuEtTwCgzjLUMBW90a4+dgJfyWxEbKC4g3Y=
=GVQ8
-----END PGP SIGNATURE-----

--Sig_/brc6enfNc+w_nEhkbdKk8pt--
