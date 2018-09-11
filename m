Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0757C43143
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 03:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84D1B2075A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 03:07:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84D1B2075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbeIKIEE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 04:04:04 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51423 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726256AbeIKIEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 04:04:04 -0400
Received: from [2a02:8011:400e:2:aa26:2157:ccdc:cbdb] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fzZ0x-0007mG-N5; Tue, 11 Sep 2018 04:06:55 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fzZ0s-0005s1-Gz; Tue, 11 Sep 2018 04:06:50 +0100
Message-ID: <7cfcd0da8aba77488feb7403055596d434772545.camel@decadent.org.uk>
Subject: Compiler flags for libapi and libtraceevent
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 11 Sep 2018 04:06:46 +0100
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-4oMiTsT6BZuMrZ1PTedp"
User-Agent: Evolution 3.29.92-1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:aa26:2157:ccdc:cbdb
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-4oMiTsT6BZuMrZ1PTedp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I noticed that tools/lib/api/Makefile has these conditional
assignments, similar to tools/perf/Makefile.config:

ifeq ($(DEBUG),0)
ifeq ($(CC_NO_CLANG), 0)
  CFLAGS +=3D -O3
else
  CFLAGS +=3D -O6
endif
endif

ifeq ($(DEBUG),0)
  CFLAGS +=3D -D_FORTIFY_SOURCE
endif

But it doesn't set DEBUG to 0 by default, and nothing under tools/perf
exports its value of CFLAGS or DEBUG.

tools/lib/traceevent/Makefile doesn't seem to have any logic to enable
optimisation or Fortify.

Shouldn't these libraries both have optimisations and Fortify turned on
by default, like perf itself?

Ben.

--=20
Ben Hutchings
Computers are not intelligent.	They only think they are.


--=-4oMiTsT6BZuMrZ1PTedp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAluXMUYACgkQ57/I7JWG
EQke4Q/+Jh8sXjinf7fvHvNlOgneNVepaFU8wOPITbngE8ndhkZL4n03yAoipFKQ
5pq/Lp8U+4Qsv4jEdPavEweNWiD10bQ3hubgql8ZQO7Q/vSFpI3gOQVY6LjoLkbc
vv3MCUcoow4jP2DYvrOKzqOqzbWx1NWQ1mtD5WBO1O8PKa2g3B5/LNMlS5qE0YyH
GNPG2p2T+P7ngbQZT1Z2Z4Dfr5iTb/Mep+MroRKZIgMr+MLlDbGcUEcDOJ6mNsBH
JKk3d6FLKxc+7+GmpCC0GrNsk1fLanLGbhQByMPzVWrwDb//XPtVSXfen9YMiq6a
XdJd3CmETtLgdMCYwjq+dahJ09AkN3OE7Qr/7lIxfoKw+OzcmzaJfchIhXdYuB9u
syngDHjGS5iKiGdYkhWlge8oB0EHqyyVD2evqVI5Q6u6y2zxxibCxfBhq588Ody4
We5ZV0jq27W9ROIteXzzw7Y/ILTt1ii2vRVEOa6aZFGCrJXbeTeCf0c9IKG2KZYX
H5CxAzA0KsnTXGM38RrWUFQvPzLyfHB2AjWloUPdxE/P9IeyBCuFVzahMcbpTaGc
s4rtE68y7tZwoCUPyBddi5o8DROlWkH0KsT725XmOAEdmYoejvPG5JoH9GBo1DfZ
Cp9o/p4pbUBGPGetHw9CxmtTdkl8Uf0+EudVEPbdatoahgpeFjM=
=hOCK
-----END PGP SIGNATURE-----

--=-4oMiTsT6BZuMrZ1PTedp--
