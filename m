Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753176AbeFDHZ2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 03:25:28 -0400
Received: from merlin.infradead.org ([205.233.59.134]:32832 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751820AbeFDHZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 03:25:27 -0400
Date: Mon, 4 Jun 2018 09:25:18 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Rik van Riel <riel@surriel.com>
Cc: Mike Galbraith <efault@gmx.de>, LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: 4.13..4.14 scheduling overhead regression (bisected  -
 b956575bed91)
Message-ID: <20180604072518.GM12217@hirez.programming.kicks-ass.net>
References: <1527857873.4674.11.camel@gmx.de>
 <20180601132055.GT12198@hirez.programming.kicks-ass.net>
 <1527879389.7898.84.camel@surriel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="H7BIH7T1fRJ3RGOi"
Content-Disposition: inline
In-Reply-To: <1527879389.7898.84.camel@surriel.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--H7BIH7T1fRJ3RGOi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 01, 2018 at 02:56:29PM -0400, Rik van Riel wrote:

> > IIRC all page freeing does indeed go through tlb_remove_page(), it
> > shouldn't be too hard to make that work.
>=20
> Page freeing does. However, page table freeing
> does not, and might need to be done in a different
> way.

We have tlb_remove_table() for those. And that had better work otherwise
the whole 'RCU'-freed page table mess is broken :-)


--H7BIH7T1fRJ3RGOi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEv3OU3/byMaA0LqWJdkfhpEvA5LoFAlsU6V4ACgkQdkfhpEvA
5Lo2Sg/+POW/AM/uOX/nJ+HwD8nB4EkmDwIgBKD9dZPchWZIiyGuaaYQYZ4LlLBp
UyVClGaUb/frWPeC0dZl6hh85tVSJPFbY8Q44iVwUYsDWZYIbWW8WBiGv3nZrfr8
omApelSCn6uhRtSbV9MZgL4b/Bm83bzaGAuzBwuXAkTqwlbuP11GV86rK7OSs/SD
ROKmD7g0A4Rcj+b08Dc6gXGIYCNsU9LULW2s8f2Sbp89aB4SZbQtbbCtoiH+RwcK
UEWqtDIzpGKB3p2lVFe/rVJrweiLhxRJyn9UzfIsqgugm/V1BCcvHfe0/2xwLRpC
zA2oNUz9Q8OJOodKywvvXuC82k1GViO85SisVnXNlkBfpf5T1ByGw2bv+UJsoz6R
A9zjuPHZ+IMp/1Bx3WqhWqK3QxxGbdrmjqZterwLpHG1LmwbN4EEJKESKt+3FDtX
2PQakzS4S2Y2TYTw30jKaejotBt5zYMR5EQs+Y9KsgiRJC7Sv97fs7UTVP4CQm+7
qDrn7EsRmrSH2qMhGe8GDwUivytqlwcahIfTaTEwOxsNCtoXtSCwEVKERK7WKxP1
qsNVYfD+L2xdYCOfnB3zO9KO88LmTCxBnRAvzwSBAPqXgh/8DVRXetLnuhm7loZK
1J0JFO3LQTVhOVBfy/bTKJC5nDHrMiSoRSbKoyOPx/r+4ity6vI=
=Wo+r
-----END PGP SIGNATURE-----

--H7BIH7T1fRJ3RGOi--
