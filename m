Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF67C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 20:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 140BF2146D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 20:30:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 140BF2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbeLAHlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 02:41:23 -0500
Received: from anholt.net ([50.246.234.109]:41096 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725790AbeLAHlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 02:41:23 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 91E4C10A150B;
        Fri, 30 Nov 2018 12:30:54 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id mjsMh1a8_Wnj; Fri, 30 Nov 2018 12:30:53 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 9B8F210A01E5;
        Fri, 30 Nov 2018 12:30:53 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 2AF592FE2D5E; Fri, 30 Nov 2018 12:30:53 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     David Airlie <airlied@linux.ie>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: Re: [PATCH v2] drm/vc4: Add a debugfs entry to disable/enable the load tracker
In-Reply-To: <20181130161104.16352-1-paul.kocialkowski@bootlin.com>
References: <20181130161104.16352-1-paul.kocialkowski@bootlin.com>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date:   Fri, 30 Nov 2018 12:30:52 -0800
Message-ID: <87r2f2patf.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

Paul Kocialkowski <paul.kocialkowski@bootlin.com> writes:

> In order to test whether the load tracker is working as expected, we
> need the ability to compare the commit result with the underrun
> indication. With the load tracker always enabled, commits that are
> expected to trigger an underrun are always rejected, so userspace
> cannot get the actual underrun indication from the hardware.
>
> Add a debugfs entry to disable/enable the load tracker, so that a DRM
> commit expected to trigger an underrun can go through with the load
> tracker disabled. The underrun indication is then available to
> userspace and can be checked against the commit result with the load
> tracker enabled.
>
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Given that the load tracker is going to be conservative and say things
will underrun even when they might not in practice, will this actually
be useful for automated testing?  Or is the intent to make it easier to
tune the load tracker by disabling it so that you can experiment freely?

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlwBnfwACgkQtdYpNtH8
nujXZw/+KuKh2GVi6ZB7AucHRjOryoXV4Bmp3aK60fhZM0uL/sRoJAIqCPotYf1b
xlJblJ9H8Deg7B4r0aHmkuOASdgjGWSUoyyTkLh9IZKlM0ejlzAr2KSXk2XBLpyp
0SrYEmCBFrbSfFlXJt8CRpl+dujDfHq+b8mm2n7aj7egGhrAJRXC7FDMs2zsD4JT
GivlBwDw32ysCT8wp7YhIHZ7lEkZBqhD2k5/oABL7Qa3/96JFjFu2ukeadKG0Hwk
ib9F+tH3CFwOrCeKRjJwbI7AIKzQ1KHiqY1doTximwlg0fxw3n4HyOe7Pn14izWX
4rpd7OvECqfCDY9a48wJzdQOJOC8eM/qwtBn+2h4Z+eU0n6i2MnLhUBQs2geqGAz
WNYUJUbnzTOMA2EHMGwryAGjkEZk5U70vamg3UyyGsdanTuDBVHMO4oqu48PqHmd
IeM1KQqVdptbLwB95WlqUAnR3G+xJaCFnEF7l4C4jlctFmsEDpcCbUt6Ey/gn+hx
CceSsk8QuNFi3u5c7pfXSLtIQxKRRILAb060exMFuFqDdIHcyjLC3SO+sxftlhiG
9ksklB0g49JBvkuFZqOXiDgC/26MS7uIS77iOMOg6kp4FFjbNmSACPeyk9vCE/7u
Cqxact55PR1Fg1iECgYoP6CGz0LIFQxypGw858C4nT2p0v+g0FI=
=jCqI
-----END PGP SIGNATURE-----
--=-=-=--
