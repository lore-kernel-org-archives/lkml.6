Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753595AbeFDO5U (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 10:57:20 -0400
Received: from shelob.surriel.com ([96.67.55.147]:50978 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751473AbeFDO5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 10:57:19 -0400
Message-ID: <1528124238.7898.106.camel@surriel.com>
Subject: Re: [PATCH 03/19] sched/numa: Simplify load_too_imbalanced
From: Rik van Riel <riel@surriel.com>
To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Thomas Gleixner <tglx@linutronix.de>
Date: Mon, 04 Jun 2018 10:57:18 -0400
In-Reply-To: <1528106428-19992-4-git-send-email-srikar@linux.vnet.ibm.com>
References: <1528106428-19992-1-git-send-email-srikar@linux.vnet.ibm.com>
         <1528106428-19992-4-git-send-email-srikar@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-solBE/0ZvhJA4if6sX6C"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-solBE/0ZvhJA4if6sX6C
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2018-06-04 at 15:30 +0530, Srikar Dronamraju wrote:
> Currently load_too_imbalance() cares about the slope of imbalance.
> It doesn't care of the direction of the imbalance.
>=20
> However this may not work if nodes that are being compared have
> dissimilar capacities. Few nodes might have more cores than other
> nodes
> in the system. Also unlike traditional load balance at a NUMA sched
> domain, multiple requests to migrate from the same source node to
> same
> destination node may run in parallel. This can cause huge load
> imbalance. This is specially true on a larger machines with either
> large
> cores per node or more number of nodes in the system. Hence allow
> move/swap only if the imbalance is going to reduce.

> Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

Reviewed-by: Rik van Riel <riel@surriel.com>

--=20
All Rights Reversed.
--=-solBE/0ZvhJA4if6sX6C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlsVU04ACgkQznnekoTE
3oNSDAgApd4DNcPeeQL7l42ZqQcPYgiCFvaSlzr8bHWc9COVNw4EAbxrogTFxlK7
MjA/1psoN7inf0PkUf9R5N16QI2mbNiAA6B5hKgUQHdnVKsrhUPLA3Fv/uM1D8hd
wOWNQCTzhkp+nkgFhxu1VhrpKrSrkg1sUliOj0I5MMC5daAhzZ6K4EMsj1VCxDkw
9bM5tg28R7kfFgW/xEi18wEkfexZxg8WYYcL60PpGceI+eDzm9pmziyi19zh2o2x
M6/cOslctQS+27J0CM5bMlMMmEDWQwKoGXZJ/rPduHLUKVYlI37t/xNWpe7CDdo5
CCX9+rmg+sb5wSl8EtQUnf1/IERw6Q==
=LBNN
-----END PGP SIGNATURE-----

--=-solBE/0ZvhJA4if6sX6C--
