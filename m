Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A107ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 04:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C93682083A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 04:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="kmxtQtRl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C93682083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbeJSMzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 08:55:05 -0400
Received: from ozlabs.org ([203.11.71.1]:38883 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726542AbeJSMzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 08:55:05 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42btlP5K8Jz9sBn;
        Fri, 19 Oct 2018 15:50:41 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1539924641;
        bh=ZC3c8xnQaox8jbPn3nPb3Bqpl0B4LJsz1IqFAwGU8Os=;
        h=Date:From:To:Cc:Subject:From;
        b=kmxtQtRl8QPo0g3nN1+S3VdqF26j5oohzgC/GQml+/ymTuuicRcOvQaBFZACE/oEc
         TWaBCP53Z6Ce/9LAU77O/crr67ey/au0YUn4EgQZ+i+gV6n/kRTPjmvzO+dJwF/OIq
         FQJE4W8Tqhdsxdy2TbI/DHz+Iz5InMLgKHWn0tsHFZDMTw248Ny/tuHKDfbJkuw0iX
         f1dtxOsb4lEwtkUZAsl2SA9r7X+xDe7EsMZCnZn4RiyHPE4SscYeM0fDxtHd4B4Gvx
         JeBQ/PpxEJKnrJf52EZNvYg7MzyAkKiEG4MK71ZaW55kGi7fqK3eOnSO3YNJfejMTl
         +MSZ6nOEqjivQ==
Date:   Fri, 19 Oct 2018 15:50:34 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: linux-next: build warning after merge of the scsi tree
Message-ID: <20181019155034.2cf7f864@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/YhnTqcejkmKsHIn==Lt+2KQ"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/YhnTqcejkmKsHIn==Lt+2KQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi James,

After merging the scsi tree, today's linux-next build (powerpc
ppc64_defconfig) produced this warning:

drivers/scsi/lpfc/lpfc_debugfs.c: In function 'lpfc_debugfs_nodelist_open':
drivers/scsi/lpfc/lpfc_debugfs.c:706:17: warning: 'nrport' may be used unin=
itialized in this function [-Wmaybe-uninitialized]
   switch (nrport->port_state) {
           ~~~~~~^~~~~~~~~~~~
drivers/scsi/lpfc/lpfc_debugfs.c:553:30: note: 'nrport' was declared here
  struct nvme_fc_remote_port *nrport;
                              ^~~~~~

I am not sure where this has come from :-(

--=20
Cheers,
Stephen Rothwell

--Sig_/YhnTqcejkmKsHIn==Lt+2KQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlvJYpoACgkQAVBC80lX
0GzAzAf/Q29BgDltr7uqPOkiypn8fnVrlkvwvHw06lO8/CXLrrLKiFIWxrzHyaTW
d46aWRHrGiu00wwhI2juf3K9w4H+yGXYGCxS8g2/GdMhoTSJucYSPzx69w81pKL1
//6Grth0xYldeHNhbIQyE0kan/5ffanJgi9OqnITaSYyTrw3Nv9Vj13Moaaqwm31
Z2r7UFiivKt2ArBNRFF637PVCO7FRNK5gVg1erJAqQLvi3SFGw9UAeRTzA8WWQlE
kD24vV3+B16t+ci9PewtLQFh8Qrc08DNta8nwmWejIdzFs1mejtz4gdtJ/Ww2Y7E
G6BP9hlwJPQ3VaBzCagHgB/7adrX/A==
=o9z7
-----END PGP SIGNATURE-----

--Sig_/YhnTqcejkmKsHIn==Lt+2KQ--
