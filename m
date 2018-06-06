Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D1FC860767
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752309AbeFFNz0 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 09:55:26 -0400
Received: from shelob.surriel.com ([96.67.55.147]:57216 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751982AbeFFNzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 09:55:24 -0400
Message-ID: <1528293314.7898.132.camel@surriel.com>
Subject: Re: [PATCH 16/19] sched/numa: Detect if node actively handling
 migration
From: Rik van Riel <riel@surriel.com>
To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc: Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Thomas Gleixner <tglx@linutronix.de>
Date: Wed, 06 Jun 2018 09:55:14 -0400
In-Reply-To: <20180606125529.GF30328@linux.vnet.ibm.com>
References: <1528106428-19992-1-git-send-email-srikar@linux.vnet.ibm.com>
         <1528106428-19992-17-git-send-email-srikar@linux.vnet.ibm.com>
         <1528142755.7898.122.camel@surriel.com>
         <20180605035616.GD30328@linux.vnet.ibm.com>
         <1528204074.7898.126.camel@surriel.com>
         <20180606125529.GF30328@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-KiK0vFt07XNaT+6KuIyG"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-KiK0vFt07XNaT+6KuIyG
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2018-06-06 at 05:55 -0700, Srikar Dronamraju wrote:
> > >=20
> > > While we can't complete avoid this, the second check will try to
> > > make
> > > sure we don't hop on/hop off just for small incremental numa
> > > improvement.
> >=20
> > However, all those racing tasks start searching
> > the CPUs on a node from the same start position.
> >=20
> > That means they may all get stuck on the same
> > task/cpu A, and not select the better task/cpu B.
> >=20
> > What am I missing?=20
>=20
> All tasks will not be stuck at task/cpu A.
>=20
> "[PATCH 10/19] sched/numa: Stop multiple tasks from moving to the
> cpu..." the first task to set cpu A as swap target will ensure
> subsequent tasks wont be allowed to set cpu A as target for swap till
> it
> finds a better task/cpu. Because of this there a very very small
> chance
> of a second task unable to find a task to swap.

Would it not be better for task_numa_compare to skip
from consideration CPUs that somebody else is already
trying to migrate a task to, but still search for the
best location, instead of settling for a worse location
to migrate to?

--=20
All Rights Reversed.
--=-KiK0vFt07XNaT+6KuIyG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlsX58IACgkQznnekoTE
3oPhsQf/eEvDFKdnEQscf0wG4HGhP353YSjvkppRSJZQ2ztkIbiRsIyFwuoby2kR
xVRw7Yu/czLlMaqBwTu0G75DCddrbPH/V9xNmLQJ6VWWA6Bg1XMknojTCnoyTjMf
lWTKf+KHTc05F0J0b3HSCooc4JImzyESMpHtnxj12YgnOklalnE0eI33i4Prfhmg
o+TwzQzpAgalJqmw4II/D1vp9nE1Kcxi0lNHSMByw52nuzFrDPQOLou34YibQrqM
R7TQrXUStB2piZsKr2C7W+RIV5uAOMUHWcqKoRcgHhiKU24Nrlm35fTUMDcfDVg+
2+Okqz2PSFZZRnojeg9yZb0oj3o1QQ==
=zBdd
-----END PGP SIGNATURE-----

--=-KiK0vFt07XNaT+6KuIyG--
