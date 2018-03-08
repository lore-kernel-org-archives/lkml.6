Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1131037-1520492174-2-8468907593033725758
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520492173; b=CUN7HtL0tFyGPDrAmzE1avw1RGIKKe4G55E2pnZDErXdZI+
    gcDyzjjIthNdWgHVrvnp1SIPEtKO/+elI1fSXFk0UKynuvv61/IG82EoGnh2CFDU
    cSlDac5InH/pkr1pDeQxQ1ToSovZaJel3BEP4PLg+flOhc4XHqVqKq73IBCBHM/W
    BJGjCPy8j/+n+TQV1vBbSS8YYBM6H6tB/QRcgxDjHwcKjT+r/BmgVU/ZNWwEY6MB
    e2k5MoJlG0KfG5nDxZyh5h6CmOQpfReBtGorWa1gODJI7fZZBNBPmwikduykgwFu
    FXr/Qip2vXCvQwh4Xybmr/2y1AeqA21RpadFvtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520492173; bh=9JwCqv
    LwgPidFySbpB3klQdjTPVgXfaCFPiMwaOZ2Zs=; b=iUD/KsapoLsApxFxLRHbrG
    X+qT52XkDTfStBCqLEWd0aU6Lag7ZIFDKQnYcSnKtSBBWE3E9Y735uzmwBPAf3+O
    cVaYnSqydNsdwZDa3o32G+8Tsbs5gqHHkQRqeYcGtcUCDcp3bYRV+F+wunJDYWy0
    Ltb3fouWTukf1d0zeS2Urhjkg/EmEPcLEr/OWuMp8YvXbKgvWVRCF2gI82WY0hZw
    4R/RV0dKASlsNILUKeFJfyccr7t81cQOPL243VzOF/CBwKojU3YxH61WmDsM073V
    fSyxvYavS25ImIZHY8UhvOMfjXFFNDpBpPbOfZ4IZ18mjTTm4OnQiFRm3xaFiUrQ
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BRBcmCUB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BRBcmCUB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935083AbeCHGz6 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:55:58 -0500
Received: from mail-sn1nam01on0120.outbound.protection.outlook.com ([104.47.32.120]:33969
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935169AbeCHE6A (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:58:00 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: James Smart <jsmart2021@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 67/78] scsi: lpfc: Fix SCSI LUN discovery
 when SCSI and NVME enabled
Thread-Topic: [PATCH AUTOSEL for 4.15 67/78] scsi: lpfc: Fix SCSI LUN
 discovery when SCSI and NVME enabled
Thread-Index: AQHTtpnTPFI6Bs98P0CvK1vXB9QZTQ==
Date: Thu, 8 Mar 2018 04:56:31 +0000
Message-ID: <20180308045525.7662-67-alexander.levin@microsoft.com>
References: <20180308045525.7662-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045525.7662-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0888;7:DFHAewe9fig8yxN5whFTa4Hc2DOLAG1BigcNTXtJOQmf+dCVcAT1/TdeYQEVXk41AxG67E9ChvyygcttD9z8HeFDA2c/pUUcxooefSJ/BzbTaHCGe3SzeYcZWI5d6co7i/3bignBeCp/r1A+9UWDZarXnYfas7vvmm7jHZ9RSVIXtAIvmSy9320KpmIz4fPweN5fQWMyDJjFF6FmY+x1iNUyYFwU7UlPRUMwvkn1TLw4RGPLI0a7iAEzaOi0otQK;20:uzgD8DK1zqEPYi4ppEFY096AX+MF3KuVhf3zp2aoN4Yd/WXVg4ffGhtNH9gPPuYQ/k3sgBKUV02fqei+60D6NxQb3E+uuU6K/xyPbIwNyyIbJJ/lNocRVAv9n+Qrxo9+JxS/tdQqwyoLcxk2+mdiwkC4yo0hVltJ7+8Grzzw+Ds=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6b4cac19-a651-4157-234d-08d584b1281d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0888;
x-ms-traffictypediagnostic: DM5PR2101MB0888:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0888CC83333B2E37B64401C3FBDF0@DM5PR2101MB0888.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0888;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0888;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(39860400002)(366004)(346002)(376002)(39380400002)(396003)(189003)(199004)(6116002)(99286004)(2950100002)(6512007)(6666003)(10290500003)(36756003)(5660300001)(106356001)(1076002)(22452003)(39060400002)(3846002)(97736004)(316002)(53936002)(68736007)(105586002)(4326008)(25786009)(54906003)(478600001)(2501003)(186003)(66066001)(76176011)(3280700002)(86362001)(575784001)(14454004)(2900100001)(5250100002)(110136005)(305945005)(7736002)(72206003)(3660700001)(6436002)(2906002)(26005)(6486002)(10090500001)(8676002)(81156014)(107886003)(81166006)(86612001)(6506007)(59450400001)(8936002)(102836004)(22906009)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0888;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: lYthjrBeLBlkN4f6g5Sg/WTH9UZ29lVsjcSPNN2vtN1bQ8Bbia3I5ZmO4sWyNaKSM4Tdwz4Ku1HWBHVHq4FRWwTQAA17EEDaqNaZ17TINfdzTnCG3GK/g2LRywr58jXn/DILbXDAA/WngewA1K7MFIvodZT/ldggU9c9s8P+5ol5RfLoVgMLl/46tEM67bvE0RNOsKfyoBFPNwcKIf8rtl7QVLhrkU3k+cxIjSB6xIvsuekmq/RFqCV9FvTVLHXAZnfBtIqOeHBbYHBwOwAWoXsGJPXiF7wPtkg4VzNf1ztvv6fARKDlz0iFhAYn6tf7hCcV4GTNhFyEWKefeoej3g==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b4cac19-a651-4157-234d-08d584b1281d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:56:31.1006
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0888
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: James Smart <jsmart2021@gmail.com>

[ Upstream commit 9de416ac67b54d666327ba927a190f4b7259f4a0 ]

When enabled for both SCSI and NVME support, and connected pt2pt to a
SCSI only target, the driver nodelist entry for the remote port is left
in PRLI_ISSUE state and no SCSI LUNs are discovered. Works fine if only
configured for SCSI support.

Error was due to some of the prli points still reflecting the need to
send only 1 PRLI. On a lot of fabric configs, targets were NVME only,
which meant the fabric-reported protocol attributes were only telling
the driver one protocol or the other. Thus things worked fine. With
pt2pt, the driver must send a PRLI for both protocols as there are no
hints on what the target supports. Thus pt2pt targets were hitting the
multiple PRLI issues.

Complete the dual PRLI support. Track explicitly whether scsi (fcp) or
nvme prli's have been sent. Accurately track protocol support detected
on each node as reported by the fabric or probed by PRLI traffic.

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <james.smart@broadcom.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/scsi/lpfc/lpfc_ct.c        |  1 +
 drivers/scsi/lpfc/lpfc_els.c       | 30 ++++++++++++++++++++----------
 drivers/scsi/lpfc/lpfc_nportdisc.c | 30 +++++++++++++-----------------
 3 files changed, 34 insertions(+), 27 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_ct.c b/drivers/scsi/lpfc/lpfc_ct.c
index f77673ab4a84..3a8ec82e685a 100644
--- a/drivers/scsi/lpfc/lpfc_ct.c
+++ b/drivers/scsi/lpfc/lpfc_ct.c
@@ -471,6 +471,7 @@ lpfc_prep_node_fc4type(struct lpfc_vport *vport, uint32=
_t Did, uint8_t fc4_type)
 				"Parse GID_FTrsp: did:x%x flg:x%x x%x",
 				Did, ndlp->nlp_flag, vport->fc_flag);
=20
+			ndlp->nlp_fc4_type &=3D ~(NLP_FC4_FCP | NLP_FC4_NVME);
 			/* By default, the driver expects to support FCP FC4 */
 			if (fc4_type =3D=3D FC_TYPE_FCP)
 				ndlp->nlp_fc4_type |=3D NLP_FC4_FCP;
diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
index 39d5b146202e..537ee0c44198 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -2088,6 +2088,10 @@ lpfc_cmpl_els_prli(struct lpfc_hba *phba, struct lpf=
c_iocbq *cmdiocb,
 	ndlp =3D (struct lpfc_nodelist *) cmdiocb->context1;
 	spin_lock_irq(shost->host_lock);
 	ndlp->nlp_flag &=3D ~NLP_PRLI_SND;
+
+	/* Driver supports multiple FC4 types.  Counters matter. */
+	vport->fc_prli_sent--;
+	ndlp->fc4_prli_sent--;
 	spin_unlock_irq(shost->host_lock);
=20
 	lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_CMD,
@@ -2095,9 +2099,6 @@ lpfc_cmpl_els_prli(struct lpfc_hba *phba, struct lpfc=
_iocbq *cmdiocb,
 		irsp->ulpStatus, irsp->un.ulpWord[4],
 		ndlp->nlp_DID);
=20
-	/* Ddriver supports multiple FC4 types.  Counters matter. */
-	vport->fc_prli_sent--;
-
 	/* PRLI completes to NPort <nlp_DID> */
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS,
 			 "0103 PRLI completes to NPort x%06x "
@@ -2111,7 +2112,6 @@ lpfc_cmpl_els_prli(struct lpfc_hba *phba, struct lpfc=
_iocbq *cmdiocb,
=20
 	if (irsp->ulpStatus) {
 		/* Check for retry */
-		ndlp->fc4_prli_sent--;
 		if (lpfc_els_retry(phba, cmdiocb, rspiocb)) {
 			/* ELS command is being retried */
 			goto out;
@@ -2190,6 +2190,15 @@ lpfc_issue_els_prli(struct lpfc_vport *vport, struct=
 lpfc_nodelist *ndlp,
 		ndlp->nlp_fc4_type |=3D NLP_FC4_NVME;
 	local_nlp_type =3D ndlp->nlp_fc4_type;
=20
+	/* This routine will issue 1 or 2 PRLIs, so zero all the ndlp
+	 * fields here before any of them can complete.
+	 */
+	ndlp->nlp_type &=3D ~(NLP_FCP_TARGET | NLP_FCP_INITIATOR);
+	ndlp->nlp_type &=3D ~(NLP_NVME_TARGET | NLP_NVME_INITIATOR);
+	ndlp->nlp_fcp_info &=3D ~NLP_FCP_2_DEVICE;
+	ndlp->nlp_flag &=3D ~NLP_FIRSTBURST;
+	ndlp->nvme_fb_size =3D 0;
+
  send_next_prli:
 	if (local_nlp_type & NLP_FC4_FCP) {
 		/* Payload is 4 + 16 =3D 20 x14 bytes. */
@@ -2298,6 +2307,13 @@ lpfc_issue_els_prli(struct lpfc_vport *vport, struct=
 lpfc_nodelist *ndlp,
 	elsiocb->iocb_cmpl =3D lpfc_cmpl_els_prli;
 	spin_lock_irq(shost->host_lock);
 	ndlp->nlp_flag |=3D NLP_PRLI_SND;
+
+	/* The vport counters are used for lpfc_scan_finished, but
+	 * the ndlp is used to track outstanding PRLIs for different
+	 * FC4 types.
+	 */
+	vport->fc_prli_sent++;
+	ndlp->fc4_prli_sent++;
 	spin_unlock_irq(shost->host_lock);
 	if (lpfc_sli_issue_iocb(phba, LPFC_ELS_RING, elsiocb, 0) =3D=3D
 	    IOCB_ERROR) {
@@ -2308,12 +2324,6 @@ lpfc_issue_els_prli(struct lpfc_vport *vport, struct=
 lpfc_nodelist *ndlp,
 		return 1;
 	}
=20
-	/* The vport counters are used for lpfc_scan_finished, but
-	 * the ndlp is used to track outstanding PRLIs for different
-	 * FC4 types.
-	 */
-	vport->fc_prli_sent++;
-	ndlp->fc4_prli_sent++;
=20
 	/* The driver supports 2 FC4 types.  Make sure
 	 * a PRLI is issued for all types before exiting.
diff --git a/drivers/scsi/lpfc/lpfc_nportdisc.c b/drivers/scsi/lpfc/lpfc_np=
ortdisc.c
index b6957d944b9a..678bfdd53eb2 100644
--- a/drivers/scsi/lpfc/lpfc_nportdisc.c
+++ b/drivers/scsi/lpfc/lpfc_nportdisc.c
@@ -390,6 +390,11 @@ lpfc_rcv_plogi(struct lpfc_vport *vport, struct lpfc_n=
odelist *ndlp,
 		break;
 	}
=20
+	ndlp->nlp_type &=3D ~(NLP_FCP_TARGET | NLP_FCP_INITIATOR);
+	ndlp->nlp_type &=3D ~(NLP_NVME_TARGET | NLP_NVME_INITIATOR);
+	ndlp->nlp_fcp_info &=3D ~NLP_FCP_2_DEVICE;
+	ndlp->nlp_flag &=3D ~NLP_FIRSTBURST;
+
 	/* Check for Nport to NPort pt2pt protocol */
 	if ((vport->fc_flag & FC_PT2PT) &&
 	    !(vport->fc_flag & FC_PT2PT_PLOGI)) {
@@ -742,9 +747,6 @@ lpfc_rcv_prli(struct lpfc_vport *vport, struct lpfc_nod=
elist *ndlp,
 	lp =3D (uint32_t *) pcmd->virt;
 	npr =3D (PRLI *) ((uint8_t *) lp + sizeof (uint32_t));
=20
-	ndlp->nlp_type &=3D ~(NLP_FCP_TARGET | NLP_FCP_INITIATOR);
-	ndlp->nlp_fcp_info &=3D ~NLP_FCP_2_DEVICE;
-	ndlp->nlp_flag &=3D ~NLP_FIRSTBURST;
 	if ((npr->prliType =3D=3D PRLI_FCP_TYPE) ||
 	    (npr->prliType =3D=3D PRLI_NVME_TYPE)) {
 		if (npr->initiatorFunc) {
@@ -769,8 +771,12 @@ lpfc_rcv_prli(struct lpfc_vport *vport, struct lpfc_no=
delist *ndlp,
 		 * type.  Target mode does not issue gft_id so doesn't get
 		 * the fc4 type set until now.
 		 */
-		if ((phba->nvmet_support) && (npr->prliType =3D=3D PRLI_NVME_TYPE))
+		if (phba->nvmet_support && (npr->prliType =3D=3D PRLI_NVME_TYPE)) {
 			ndlp->nlp_fc4_type |=3D NLP_FC4_NVME;
+			lpfc_nlp_set_state(vport, ndlp, NLP_STE_UNMAPPED_NODE);
+		}
+		if (npr->prliType =3D=3D PRLI_FCP_TYPE)
+			ndlp->nlp_fc4_type |=3D NLP_FC4_FCP;
 	}
 	if (rport) {
 		/* We need to update the rport role values */
@@ -1552,7 +1558,6 @@ lpfc_rcv_prli_reglogin_issue(struct lpfc_vport *vport=
,
 		if (ndlp->nlp_flag & NLP_RPI_REGISTERED) {
 			lpfc_rcv_prli(vport, ndlp, cmdiocb);
 			lpfc_els_rsp_prli_acc(vport, cmdiocb, ndlp);
-			lpfc_nlp_set_state(vport, ndlp, NLP_STE_UNMAPPED_NODE);
 		} else {
 			/* RPI registration has not completed. Reject the PRLI
 			 * to prevent an illegal state transition when the
@@ -1568,6 +1573,7 @@ lpfc_rcv_prli_reglogin_issue(struct lpfc_vport *vport=
,
 			stat.un.b.lsRjtRsnCodeExp =3D LSEXP_CMD_IN_PROGRESS;
 			lpfc_els_rsp_reject(vport, stat.un.lsRjtError, cmdiocb,
 					    ndlp, NULL);
+			return ndlp->nlp_state;
 		}
 	} else {
 		/* Initiator mode. */
@@ -1922,13 +1928,6 @@ lpfc_cmpl_prli_prli_issue(struct lpfc_vport *vport, =
struct lpfc_nodelist *ndlp,
 		return ndlp->nlp_state;
 	}
=20
-	/* Check out PRLI rsp */
-	ndlp->nlp_type &=3D ~(NLP_FCP_TARGET | NLP_FCP_INITIATOR);
-	ndlp->nlp_fcp_info &=3D ~NLP_FCP_2_DEVICE;
-
-	/* NVME or FCP first burst must be negotiated for each PRLI. */
-	ndlp->nlp_flag &=3D ~NLP_FIRSTBURST;
-	ndlp->nvme_fb_size =3D 0;
 	if (npr && (npr->acceptRspCode =3D=3D PRLI_REQ_EXECUTED) &&
 	    (npr->prliType =3D=3D PRLI_FCP_TYPE)) {
 		lpfc_printf_vlog(vport, KERN_INFO, LOG_NVME_DISC,
@@ -1945,8 +1944,6 @@ lpfc_cmpl_prli_prli_issue(struct lpfc_vport *vport, s=
truct lpfc_nodelist *ndlp,
 		if (npr->Retry)
 			ndlp->nlp_fcp_info |=3D NLP_FCP_2_DEVICE;
=20
-		/* PRLI completed.  Decrement count. */
-		ndlp->fc4_prli_sent--;
 	} else if (nvpr &&
 		   (bf_get_be32(prli_acc_rsp_code, nvpr) =3D=3D
 		    PRLI_REQ_EXECUTED) &&
@@ -1991,8 +1988,6 @@ lpfc_cmpl_prli_prli_issue(struct lpfc_vport *vport, s=
truct lpfc_nodelist *ndlp,
 				 be32_to_cpu(nvpr->word5),
 				 ndlp->nlp_flag, ndlp->nlp_fcp_info,
 				 ndlp->nlp_type);
-		/* PRLI completed.  Decrement count. */
-		ndlp->fc4_prli_sent--;
 	}
 	if (!(ndlp->nlp_type & NLP_FCP_TARGET) &&
 	    (vport->port_type =3D=3D LPFC_NPIV_PORT) &&
@@ -2016,7 +2011,8 @@ lpfc_cmpl_prli_prli_issue(struct lpfc_vport *vport, s=
truct lpfc_nodelist *ndlp,
 		ndlp->nlp_prev_state =3D NLP_STE_PRLI_ISSUE;
 		if (ndlp->nlp_type & (NLP_FCP_TARGET | NLP_NVME_TARGET))
 			lpfc_nlp_set_state(vport, ndlp, NLP_STE_MAPPED_NODE);
-		else
+		else if (ndlp->nlp_type &
+			 (NLP_FCP_INITIATOR | NLP_NVME_INITIATOR))
 			lpfc_nlp_set_state(vport, ndlp, NLP_STE_UNMAPPED_NODE);
 	} else
 		lpfc_printf_vlog(vport,
--=20
2.14.1
