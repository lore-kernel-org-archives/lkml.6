Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F767C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 07:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EE53205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 07:09:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="oxjPm4LQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EE53205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbeLJHJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 02:09:50 -0500
Received: from ozlabs.org ([203.11.71.1]:35081 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726292AbeLJHJt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 02:09:49 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43CvMs28Bxz9s47;
        Mon, 10 Dec 2018 18:09:45 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1544425786;
        bh=/jbQTIRYHuHACMPNz83Mb/rTBzfuXa8XB6k4Kf/xmsI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oxjPm4LQ/33DhacERNa99rfx35YnAVc9SRYPR0PASUxFbhbC3Sh3hkUXGyBNnKObM
         AqGXUYWWL7YSpUnUkcurOYB0bNz5gAmti/aExM5mZilildbNWGSIca3U8EelSZoP2X
         bLbyKT1mw0uoMZUa8Iykj0LhzpfjZqb/y3OXRuqh/IokqZtjsUQZSyGOoe1EgCeSJa
         eq2TG+9EBPxPRc70Z4s2u5RR1JRgITKWynsIosKRZdPC5coYfK82p0DsAI9Uq74N7n
         P3wYuw4YlF+7rDe1VdZ/wWbp+tpqerM+3TrWwtyGAiCw98lJCvDl/YZxdYF4waqH/5
         DSBmzrxvWIo1A==
Date:   Mon, 10 Dec 2018 18:09:44 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Bill Kuzeja <William.Kuzeja@stratus.com>
Subject: Re: linux-next: manual merge of the scsi-mkp tree with Linus' tree
Message-ID: <20181210180944.0fb13ead@canb.auug.org.au>
In-Reply-To: <20181210171716.77cbf9fe@canb.auug.org.au>
References: <20181210171716.77cbf9fe@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/tWFfAALYS_p+LreYcNwSvG0"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/tWFfAALYS_p+LreYcNwSvG0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 10 Dec 2018 17:17:16 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> I fixed it up (see below) and can carry the fix as necessary. This

See below :-)

Also I accidentally left the declaration of "status" in __qla2x00_abort_all=
_cmds().
--=20
Cheers,
Stephen Rothwell

diff --cc drivers/scsi/qla2xxx/qla_os.c
index f92196ec5489,643cd7c0efc1..000000000000
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@@ -1742,6 -1746,41 +1742,49 @@@ qla2x00_loop_reset(scsi_qla_host_t *vha
  	return QLA_SUCCESS;
  }
 =20
+ static void qla2x00_abort_srb(struct qla_qpair *qp, srb_t *sp, const int =
res,
+ 			      unsigned long *flags)
+ 	__releases(qp->qp_lock_ptr)
+ 	__acquires(qp->qp_lock_ptr)
+ {
+ 	scsi_qla_host_t *vha =3D qp->vha;
+ 	struct qla_hw_data *ha =3D vha->hw;
+=20
+ 	if (sp->type =3D=3D SRB_NVME_CMD || sp->type =3D=3D SRB_NVME_LS) {
+ 		if (!sp_get(sp)) {
+ 			/* got sp */
+ 			spin_unlock_irqrestore(qp->qp_lock_ptr, *flags);
+ 			qla_nvme_abort(ha, sp, res);
+ 			spin_lock_irqsave(qp->qp_lock_ptr, *flags);
+ 		}
+ 	} else if (GET_CMD_SP(sp) && !ha->flags.eeh_busy &&
+ 		   !test_bit(ABORT_ISP_ACTIVE, &vha->dpc_flags) &&
+ 		   !qla2x00_isp_reg_stat(ha) && sp->type =3D=3D SRB_SCSI_CMD) {
+ 		/*
+ 		 * Don't abort commands in adapter during EEH recovery as it's
+ 		 * not accessible/responding.
+ 		 *
+ 		 * Get a reference to the sp and drop the lock. The reference
+ 		 * ensures this sp->done() call and not the call in
+ 		 * qla2xxx_eh_abort() ends the SCSI cmd (with result 'res').
+ 		 */
+ 		if (!sp_get(sp)) {
++			int status;
++
+ 			spin_unlock_irqrestore(qp->qp_lock_ptr, *flags);
 -			qla2xxx_eh_abort(GET_CMD_SP(sp));
++			status =3D qla2xxx_eh_abort(GET_CMD_SP(sp));
+ 			spin_lock_irqsave(qp->qp_lock_ptr, *flags);
++			/*
++			 * Get rid of extra reference causedby early
++			 * exit from qla2xxx_eh_abort
++			 */
++			if (status =3D=3D FAST_IO_FAIL)
++				atomic_dec(&sp->ref_count);
+ 		}
+ 	}
+ 	sp->done(sp, res);
+ }
+=20
  static void
  __qla2x00_abort_all_cmds(struct qla_qpair *qp, int res)
  {

--Sig_/tWFfAALYS_p+LreYcNwSvG0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwOETgACgkQAVBC80lX
0GxOmAgAjYkb1y2sk+o5lldWva1EcGz3nDY9D91DZjFOlH3WDHQkAyHUg4zXhsDh
9SCren51iBIn8vG0vE8t9O2dyiEt6WXY6JdMwfhef0tauHS8T9oAIUHeFDYsKz+1
4yMqS5nuOGm/QfosW+T/xNEQxyc7HxJ/FQybt/np3syKETcuNfqj2+e2V0sit1U8
sVt7hhE7fabTTpUMEwNkepb9Lyr59boqv5Dtc/UvERjKbZ9F9C4+2FV9K8vlQ8J0
lIC8qDTWLlD2DmpWp2ep+Kxi0EdzmNVM1NNlMTAaRSJd3yLM47yvZ9rTlxoJ1y9N
04cA0FMfPQxuy869dtVGX96E45QLMg==
=nohu
-----END PGP SIGNATURE-----

--Sig_/tWFfAALYS_p+LreYcNwSvG0--
