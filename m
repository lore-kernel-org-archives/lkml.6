Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B7C6C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 23:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB40320875
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 23:57:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB40320875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbeH2DvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 23:51:01 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39569 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727094AbeH2DvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 23:51:01 -0400
Received: from ben by shadbolt.decadent.org.uk with local (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1funqz-0000k4-5a; Wed, 29 Aug 2018 00:56:57 +0100
Date:   Wed, 29 Aug 2018 00:56:57 +0100
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Sasha Levin <Alexander.Levin@microsoft.com>
Cc:     linux-kernel@vger.kernel.org
Message-ID: <20180828235656.GH18030@decadent.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GBDnBH7+ZvLx8QD4"
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


--GBDnBH7+ZvLx8QD4
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


--GBDnBH7+ZvLx8QD4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUBW4XhSOe/yOyVhhEJAQohxg/+ImzjKkx2cAECTR9rcRoT/5erp4tg03rY
45DkbLxOMW3rEBVqo4e9GRgNSzccWga3bLySTHNzVMU0bdv1tx6bl/aTEmj13Ms2
mn/8GXrtuif0vv0BmBFD0D4F/ZoHZKtYjsZQ8oC4j9YR+0GC03KikzOyhjPPE9Gi
1JDC+dgijE22BSZahr+uMhXcGdibDEn01WFb9WElt4kGgNU0wayHDjBRf3AXUsT0
mY+B4CeW/c8XKCSce21qRPclFSg3rkZN9dUTZxTLm9q7IQK2yygTuxHzH5rHxHIa
SFgafvEmEVpCKyptEiMRpb+bNI/MO1072Na/Nut/WJPn22zrEKn60fIoBGm1dgF3
lAjcgSduv3Wkui3b7XLzHo0K3rRZYm8HrIOBO0Z63Xcxc2CLUKFUiuplYpKZc77l
Rr2E2hI13rdHN079nyknNwny5IQjOs+vr0TN61bUq2E3fL/7bRqHFk/whcqeR+Es
uJ+rIIezz1wvZwEnqa3T8KIreshZ4y5Zt3vxI9G50PrVLPIpIW0g/2gyYZL69s5J
BoNsZ9nHnindvdsECnViDZyUGgb4AbPKeR0Xlzea8OtTykp+TSkbOzRErWiOOOxO
KKDWi8q6AVZjQoK6jjmRuYTT73+Gwlin3go6tAb5svle2m44dh8r4rlU5IICxxSk
NimFw6k+AqY=
=fnw9
-----END PGP SIGNATURE-----

--GBDnBH7+ZvLx8QD4--
