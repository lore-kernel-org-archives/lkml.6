Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 777C3C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 14:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE6F320663
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 14:39:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE6F320663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dominikbrodowski.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbeJVW6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 18:58:10 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:35118 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727742AbeJVW6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 18:58:10 -0400
Received: from light.dominikbrodowski.net (isilmar.linta [10.0.0.1])
        by isilmar-4.linta.de (Postfix) with ESMTPS id DBE9920092F;
        Mon, 22 Oct 2018 14:39:18 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id 9566D210EF; Mon, 22 Oct 2018 16:39:15 +0200 (CEST)
Date:   Mon, 22 Oct 2018 16:39:15 +0200
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: [GIT PULL] pcmcia odd fixes for v4.20-rc1
Message-ID: <20181022143915.GA387@light.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

please pull the following changes since commit
17b57b1883c1285f3d0dc2266e8f79286a7bef38:

  Linux 4.19-rc6 (2018-09-30 07:15:35 -0700)

which are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/brodo/linux.git pcmcia-next

up to 95691e3eddc41da2d1cd3cca51fecdfb46bd85bc:

  pcmcia: Implement CLKRUN protocol disabling for Ricoh bridges (2018-10-01 12:17:03 +0200)

These are just a few odd fixes and improvements to the PCMCIA core
and to a few PCMCIA device drivers.

Thanks,
	Dominik

----------------------------------------------------------------
Colin Ian King (1):
      pcmcia: remove KERN_INFO level from debug message

Jia-Ju Bai (2):
      char: pcmcia: cm4000_cs: Replace mdelay with usleep_range in set_protocol
      pcmcia: pcmcia_resource: Replace mdelay() with msleep()

Maciej S. Szmigiero (1):
      pcmcia: Implement CLKRUN protocol disabling for Ricoh bridges

Vaishali Thakkar (1):
      pcmcia: Use module_pcmcia_driver for scsi drivers

Zhouyang Jia (1):
      pcmcia: add error handling for pcmcia_enable_device in qlogic_stub

 drivers/char/pcmcia/cm4000_cs.c    |  4 ++--
 drivers/char/pcmcia/cm4040_cs.c    |  2 +-
 drivers/pcmcia/pcmcia_resource.c   |  4 ++--
 drivers/pcmcia/ricoh.h             | 35 +++++++++++++++++++++++++++++++++++
 drivers/pcmcia/yenta_socket.c      |  3 ++-
 drivers/scsi/pcmcia/aha152x_stub.c | 14 +-------------
 drivers/scsi/pcmcia/nsp_cs.c       | 15 +--------------
 drivers/scsi/pcmcia/nsp_cs.h       |  4 ----
 drivers/scsi/pcmcia/qlogic_stub.c  | 19 ++++++-------------
 drivers/scsi/pcmcia/sym53c500_cs.c | 16 +---------------
 10 files changed, 51 insertions(+), 65 deletions(-)

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEmgXaWKgmjrvkPhLCmpdgiUyNow0FAlvN4RAACgkQmpdgiUyN
ow1t+RAApMvwnU7uwIFlYDrCiBXZECN5RsBgR0QQPkG7Qc812hE7/oxHWt2VZceJ
JMkrYv/flk9ntXrIvdbOxHuc/iOyEweMXP445J8QUOQXr79Fi6Ju3fMOkYxQ1cK8
e71lKB/m1v4Uf1qKsVoNZ9Kd6QHlcy6iBt3csyRjb8QE8+uGZA0AmKr9bqDT6zDB
0Wg3Pj3l+EQnn58c0zaHtgBwGNrC9wfcSid1WIqV4Wv3wHEjKLtNpin6JcUy1Pdy
Sz6APA828ErpN6lxJ3LP2jo5lJBAqRLP12s3ZHoliYPr/r6TqTP39jF9hOu8cNWW
OWawMEALCo21JFl0S0EZVw+VyNVaB0sFZpDmzTNHP3fWfPien/ovUoTdWVy2fl4R
z/HiMBDI4hpt5HV44kGj6oFHjdcHY0eyEhCpL54bjJWbuttBKhrALgnft2k9jtDs
Cq+eF422VAUwAp2CVFQBWVT39ERxsgFea1naRLdzp/pnirrCHnzTZZk5alMzRu/2
wHNPTGM5sN+07kretSLVDdlqJFIC/IchXppv3lib65SpqLvz64ot3sNuVOrChpY0
bp4VVfP+qAdO//Fnf6d7+FevFgS5xDbDNNjxmB/W+xoQIKYY/R6oM/hj0+s0KJ77
jVvtWpv2r/okshMSck3kil+ggkxnjmLdri67EKaOi6dPF1lvot0=
=Q7jH
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--
