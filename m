Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751398AbeFDSYm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 14:24:42 -0400
Received: from shelob.surriel.com ([96.67.55.147]:53766 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751228AbeFDSYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 14:24:40 -0400
Message-ID: <1528136679.7898.117.camel@surriel.com>
Subject: Re: [PATCH 14/19] sched/numa: Updation of scan period need not be
 in lock
From: Rik van Riel <riel@surriel.com>
To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Thomas Gleixner <tglx@linutronix.de>
Date: Mon, 04 Jun 2018 14:24:39 -0400
In-Reply-To: <1528106428-19992-15-git-send-email-srikar@linux.vnet.ibm.com>
References: <1528106428-19992-1-git-send-email-srikar@linux.vnet.ibm.com>
         <1528106428-19992-15-git-send-email-srikar@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-xeukgwNA5R4McRnP2IPL"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-xeukgwNA5R4McRnP2IPL
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2018-06-04 at 15:30 +0530, Srikar Dronamraju wrote:
> The metrics for updating scan periods are local or task specific.
> Currently this updation happens under numa_group lock which seems
> unnecessary. Hence move this updation outside the lock.

Indeed, it looks like update_task_scan_period does
not look at any numa_group numbers (any more?).

> Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

Reviewed-by: Rik van Riel <riel@surriel.com>

--=20
All Rights Reversed.
--=-xeukgwNA5R4McRnP2IPL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlsVg+cACgkQznnekoTE
3oMBBggAmc7VyGmT80jQjwo4BYIIvCtSK6qTnB054IfwsPEudUSSFiJhSi6ywxkz
UsjaxF7p+CZ6QdniQlMzUmlogoalCLYRIR2Y3w1aRWfq3IbmsuqSDAz0XYfiJWgK
qDqRvCKEVpE0iqcmAPp5rJ4DZnDuYlZ5kXr/jVqTeHS4r4jv/gaO/HC/Jsm2a1bA
31V6Pvy7iHLNEa/O44b2gQfd/pCycj5QnFK29EB7gMSjzthAHhwuMji4AMMe2nPn
gUIRpJkA6jkYBD6ibKNv6HwAVyVzBOUhEjymqaD5FgzmOGuECoSv/S3Br9zscU9g
h3ouCaWLH661Bav9tGlVHFaEz8suoQ==
=jT3W
-----END PGP SIGNATURE-----

--=-xeukgwNA5R4McRnP2IPL--
