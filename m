Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 339CAC6778D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6DEA20880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="hG6thmDl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6DEA20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mailbox.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbeILUZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 16:25:19 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:48836 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726640AbeILUZT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 16:25:19 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 32ED5419BB
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 17:20:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mailbox.org; h=
        content-type:content-type:mime-version:date:date:message-id
        :subject:subject:from:from:received; s=mail20150812; t=
        1536765617; bh=fipLrZI3lkzzaQQtm8ZCATwn/aDtzx+Dq7QruVsYyeo=; b=h
        G6thmDlRd8HGjA+lqo2DoV5yYpmyaf6pRYaqnSqzGjWS/6Pk2+YeT0RfdQUSHI9O
        fgHALywXYt40iqAu9Jy/DyxRu578xXnZ9OSj4UiClmJaiGplhtgDNVtbdJgoOlBZ
        IpM3BVbmRElDMXFDaLTkIP1p1g5moayKnC+YWeS+KOfweEFidoonSOpIElPFbj/R
        xvrQOx0UWOrMKZeTFzzd0w9I9S+Y+PsX/y15rNYu3lVASehxnyNISLGl8YGW08R+
        U0SqutFwegO0hBV6HWgJ1S2DVh5lyJimUM9mmArJVYZdMfMD0Eqhta12wjmao0lQ
        3pMxehvHIbafnnhFhB6ew==
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
        with ESMTP id zKg7cg7gP9pM for <linux-kernel@vger.kernel.org>;
        Wed, 12 Sep 2018 17:20:17 +0200 (CEST)
To:     linux-kernel@vger.kernel.org
From:   Jack Henschel <jackdev@mailbox.org>
Subject: Custom PMI Handler
Openpgp: preference=signencrypt
Autocrypt: addr=jackdev@mailbox.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <4d1c3f6a-f0e5-2494-1ef7-a6383eb9fcb0@mailbox.org>
Date:   Wed, 12 Sep 2018 17:20:16 +0200
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="pWc7q1j8p4MLSWPVLSxh6fkQ15bm1RhvA"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pWc7q1j8p4MLSWPVLSxh6fkQ15bm1RhvA
Content-Type: multipart/mixed; boundary="bDAyWkKdow2t87aKS8Fihyy2EGG20qG9N";
 protected-headers="v1"
From: Jack Henschel <jackdev@mailbox.org>
To: linux-kernel@vger.kernel.org
Message-ID: <4d1c3f6a-f0e5-2494-1ef7-a6383eb9fcb0@mailbox.org>
Subject: Custom PMI Handler

--bDAyWkKdow2t87aKS8Fihyy2EGG20qG9N
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

Hi there,

is it possible to register a custom interrupt handler for a NMI/PMI
Interrupt?

In particular, I want to catch the Intel PT interrupt (generated by the
PMU and sent over the LAPIC) in a kernel module. Is such a thing possible=
?

Regards,
Jack


--bDAyWkKdow2t87aKS8Fihyy2EGG20qG9N--

--pWc7q1j8p4MLSWPVLSxh6fkQ15bm1RhvA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE5SNfW5QVort2C78YV5HQ+s4K8DwFAluZLrAACgkQV5HQ+s4K
8DwjKw/+Ibqe+oEQL14yexFjKIC0JtyGhjT3iGDvWV7O/YI1itv0ldz9d/NmELd0
/+8c2+gsj3kRU1+9zvgiu4kgBgmKoBnONVs/jK8salZAD4W+zEUsnuG5LHe7WbpT
dfyKkmJxeZQB/LxY2Prn1nD2D2qKHeUxxlUwdIXGPwGMLFa3zBOeXyB1g/kRYx+h
DjLJbv9oEuSftAipY+YLQy+fKuZCxpfo6oTo7Bo4FeTi40JML0vr3pJc9tVqpBQA
GyvnPAZCsz8agxQjGpEvaV6ERVgldO1kQTmUJseMgTKw7KW+K1CwNrF1GhydgclV
J31RgbE8VyVPfWJ5aZPvyEJoUrv2Wdw+XLCQsEjZCTqihwCyG6QBu3A2wOVA40yF
GZW8PlqRFwDEp+Lc13aF+M+0ujg58+GhX8ixIANZ73NpGB89GAVYyH17Kkl2JSI+
e+ucsWfxCgov1bre9riSSj5ouf1jm7qjm7nJMBjTAeWaYmXmO5RxJTOXN8xIQNE3
Zl6wPqyMtD00qq/37TTgXPiYwE52QFeyr73GmvIskalarLpeCLqQmcVNVEw90bKZ
PkNNcFeocfckJpXZZ0sxjb0b5B7hOIaiWAR42S4wX/HnOz60xkBNbyPfVRfppJam
UnsFj9PR16UUEZwUgl3UmCIok71xWjxhEUNKOY2+jOBCrICRZiU=
=KurI
-----END PGP SIGNATURE-----

--pWc7q1j8p4MLSWPVLSxh6fkQ15bm1RhvA--
