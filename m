Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94FD7C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 23:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 475012087F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 23:36:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 475012087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727568AbeH2DaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 23:30:07 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39525 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727072AbeH2DaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 23:30:07 -0400
Received: from ben by shadbolt.decadent.org.uk with local (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1funWo-0008BS-DO; Wed, 29 Aug 2018 00:36:06 +0100
Date:   Wed, 29 Aug 2018 00:36:06 +0100
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Sasha Levin <alexander.levin@verizon.com>
Cc:     linux-kernel@vger.kernel.org
Message-ID: <20180828233606.GE18030@decadent.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gDGSpKKIBgtShtf+"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: ben@decadent.org.uk
Subject: [PATCH 0/2] Build fixes for liblockdep
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
X-SA-Exim-Scanned: Yes (on shadbolt.decadent.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gDGSpKKIBgtShtf+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

In addition to the patch I recently sent for lockdep itself, the
following fixes are also needed to make liblockdep build.

Ben.

Bastian Blank (1):
  liblockdep: Stub NMI watchdog reset

Ben Hutchings (1):
  liblockdep: Stub task_struct::state

 tools/include/linux/lockdep.h |  4 ++++
 tools/include/linux/nmi.h     | 12 ++++++++++++
 2 files changed, 16 insertions(+)
 create mode 100644 tools/include/linux/nmi.h


--gDGSpKKIBgtShtf+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUBW4XcZee/yOyVhhEJAQrZFg//RN81S7D1GXnkWfrNVL8x7o2mSn2lCQRz
IS0JlkIQWbT4eO4OdubW5+IDWQS8xk1w1PyHzgj91RkxZsZCL/IWfBsG8SDneVQP
2kK2HWaWeeWMEUzEYb9S/p4K/y4soC3UM7/pwRCia9jIkeQ0Kvo0S+hWfZfoRYMl
nVXlw9ATxjWAJdkGbEgYYNERGCEZtco+7eoQCD6HGHuihaqEb02jWG8SfGiWT065
1rIAQva+RCnNqUfgnPpKlON5mkIjz5ckINliFUWbLvv48a0DbsDLpaJCOEqBi6tE
42oHc4zd8g25Ch41DRhRu5terXQGk3+Jx6YBrW7pJjhauJ2Aw35AQLOUWD61wCUL
KNwexP3kj6/KlimO6RwRZjC58jogLhUf222db/7ryvaYitZGgMIKNppvf+OW0Ysh
OPc3UNIFQwvlC+5eiHgMJgeyH/A96HpHS1jxdTXQxduTcOst87PySQCijhlrP1dT
bH6jKuVfnBzwgTEmZDjJZW97TEK5O2ZFw1ex61g1ieXgQ3FEh0tFU3e8QzAQ1iM/
muIFMT86g29EXy9jgWWqNks/vA+dHCFf0/jCbMg9zKB/bVk0xlU/zyL9Ndttr7lk
wv935JJkPa5h3EmXtubhMWLlsX22XfopDHJ9okJ7OhENORHjyfqbuyJg9C6h+dSC
a0icw3ph1lw=
=O+d0
-----END PGP SIGNATURE-----

--gDGSpKKIBgtShtf+--
