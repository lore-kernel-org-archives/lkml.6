Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34439C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 23:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0123A218AF
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 23:51:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfBFXv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 18:51:29 -0500
Received: from anholt.net ([50.246.234.109]:52416 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726161AbfBFXv2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 18:51:28 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 41EBF10A2BF3;
        Wed,  6 Feb 2019 15:51:28 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id YpGqCJs-K-s6; Wed,  6 Feb 2019 15:51:27 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 10AB410A282F;
        Wed,  6 Feb 2019 15:51:27 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 9E5772FE464C; Wed,  6 Feb 2019 15:51:26 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Eben Upton <eben@raspberrypi.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: Re: [PATCH v4 3/4] drm/vc4: Detect and ignore underruns caused by out-of-sync dlists
In-Reply-To: <20190206144906.24304-4-paul.kocialkowski@bootlin.com>
References: <20190206144906.24304-1-paul.kocialkowski@bootlin.com> <20190206144906.24304-4-paul.kocialkowski@bootlin.com>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date:   Wed, 06 Feb 2019 15:51:26 -0800
Message-ID: <875ztwlblt.fsf@anholt.net>
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

> When the pipeline is reconfigured with a different mode, changes take
> effect immediately for the CRTC and encoder while the HVS takes some
> time to switch the active display list. This results in a period of
> time where the pipeline is out of sync, that is very likely to cause
> an underrun to be reported. Because the underrun is not related to the
> new configuration, reporting it to userspace is a false positive.

This seems like a serious issue.  How are we enabling a CRTC with the
corresponding HVS still scanning out old contents?  Did we need to wait
for HVS to finish its old frame when we turned off the CRTC, so it's
ready to receive the START when it's been set up with the new dlist and
the CRTC is turned back on?  Or maybe do some sort of reset of that
dlist when a crtc is being enabled?

If we can't sort that out, it feels to me like we should be enabling the
interrupts from the flip_done path (when we know that the HVS is
scanning out the new frame) instead of trying to mitigate enabling them
too early.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlxbcv4ACgkQtdYpNtH8
nuiTkhAAoKL/4v+X/hB+t3PxDjzBWduI0qDjJKwgKHROEBW2HTrWNd/J71r9+6P4
SSVRoqvFE05GbxX0UxibpcjKpTScfBwhC24Ofkl3FYfNJM+R0HV0VQw7DuUCIQjR
KoZ96MgAfeCy72lq0RmDLlXOZLh/DgUauWeN8VUVmT2G+TSpvB00ImU0sv4ZuIZB
sFJ59q1JFIPyJs/E3M6K/gtcpHiOvFwakjPDEOPlyFht3+G9PDatXepakHmtA1FK
ybx1oid23GMx6Dtd/EAvHPdSPIb7jNlEWvs5nJhlDnWgHnO7Oi+wrb7EdWh/eCyP
0i5dl+7uTdo/MfjIrIGBbViwkgrS5uO8WMHYr9DojqhGIriQ76mEGDxeecrwK8Sm
USXtMvClXmMxqskAZCo74zVGC8vg76LAqMffRZT06k54jzTr4XpErmjBe+r/uJ84
SRdWK5z0EXkxREEPXPkFdAVdAxAApqVVbS9o1zfNiYu09CxZwJ5DIOjulXCcJBvX
VXvSnyTY6XZs28ScUFIymVH/tlKmqCPgqoiNnz/mP7Km/dgBJr1d5PrnoX82eB3+
Ylp41b44xSuRR8uK/b0UNjneFiFU70gI14G9+G4NYAeF3l67luoNpyvzJ7XTf7Ak
TJiDv885cez3w88ShN1klKVx7KjoM9OAHD7SySyh0aGhkdbPVzc=
=uaei
-----END PGP SIGNATURE-----
--=-=-=--
