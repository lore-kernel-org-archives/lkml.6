Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 457ABC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 05:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E1BC20857
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 05:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfBAFnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 00:43:17 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:46289 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfBAFnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 00:43:17 -0500
X-Originating-IP: 141.70.45.131
Received: from localhost (hadi-gate-vlan-851.hadiko.whka.de [141.70.45.131])
        (Authenticated sender: hle@owl.eu.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 46A0960005;
        Fri,  1 Feb 2019 05:43:12 +0000 (UTC)
Date:   Fri, 1 Feb 2019 06:43:12 +0100
From:   Hugo Lefeuvre <hle@owl.eu.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Greg Hartman <ghartman@google.com>,
        Alistair Strachan <strachan@google.com>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Christian Brauner <christian@brauner.io>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/wait: introduce wait_event_freezable_hrtimeout
Message-ID: <20190201054312.GA955@behemoth.owl.eu.com.local>
References: <20190117224135.GC8100@hle-laptop.local>
 <20190118151941.GB187589@google.com>
 <20190118170801.GA4537@hle-laptop.local>
 <20190119015355.GA115342@google.com>
 <20190119102912.GA2647@hle-laptop.local>
 <20190122222054.GA37126@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
In-Reply-To: <20190122222054.GA37126@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

> I agree, it is probably better to use freezable_schedule() for all freeze
> related wait APIs, and keep it consistent. Your analysis is convincing.

I have submitted a new patchset which migrates the wait api to
freezable_schedule() and splits the changes from the previous patch.

regards,
Hugo

--=20
                Hugo Lefeuvre (hle)    |    www.owl.eu.com
RSA4096_ 360B 03B3 BF27 4F4D 7A3F D5E8 14AA 1EB8 A247 3DFD
ed25519_ 37B2 6D38 0B25 B8A2 6B9F 3A65 A36F 5357 5F2D DC4C

--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUFZhdgIWqBhwqCvuZYVUZx9w0DQFAlxT3G8ACgkQZYVUZx9w
0DT73Af/bPLYIwsxkYesoqtvCGZo5p2or99iWQKm/kkGw5lj2de1z9el2Iv2hwJn
V32MMsVGQSykFfYobEA4KfmbIiA/075GKuyB6qm+0IwTvUUUfZjDo0tIXyHpHSTA
SPtY3pHq0UZ7RjPCxQvfs0uABkMz89Hcuys485jq/RnFeKBVXGxkYOb4sWTTv4Wm
ACVWNcl/tKvtvx3ZPV6QawEUbFhPrpRGt3NWATWJ3Ly5z1rII95beyVZU4xMRJ4g
TS/WDfXnCm/Bs6UgorlTH5yR3vWbrXOh/x2CBhHnIlVE55EcTrDqQSuW7glIakF/
IE5L+G6Q4SGEhjudBZx2CQgZknhY5A==
=EfZx
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--
