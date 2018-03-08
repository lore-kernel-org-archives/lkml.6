Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1086562-1520491050-3-14159405546948007234
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
    t=1520491050; b=UkRsu2I6HGKt78W0T8KTVnXno4UgZFWOm/lbM/ACb4y13KC
    6c4dotU/pFbSONVOq6B95Dd5i8ocSPTKL6vJkopYIjvYucWCh66HApK5R95jhLzV
    oyHTANM0U9s2uF6RPm/FM2kxwJQAzv8NLTU3JjFyeZLLPnOakRl+IbTLzhjI2zM5
    IruMuk5AtYbvqrDTseVYuigOVhtLWU5EUH/XxDFqwrZmridS3YO7TQ7R+RMF/W/m
    ulW9q8XKWyEkR8yjLF3yTqWc6qq3MpQadIRoNv6o+ALlhA+4G5SDfq4BR/YkEmLL
    wnROPjRF5d7gerOxB4N2kZyl+bMvjkG9/bQvAoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520491050; bh=cSNO16
    To5upVIT3QUG5+DbFoirU//69lU8otZ7MPV7I=; b=OhOY2GpDL1w50p4s5H94UN
    bw8sPF7wRBgwlDaZgkPq83gQc3AqJ3RXZKXsgTUFeeBZSCljwSDVZ4ENPQ2nSghd
    iAOe1dF5T9m9JblkuqBs6GVOxissfwtoXUNiHIHABrIL9Mq/1uPm1VsSUajzX32H
    KN33nYiYq88JjCRjlESH3SVldaKNnxSiXGfOfU2lSVqVV7C0sCESI7Oh9vVVx2vW
    VCquNyfeV4NRlXAUcfViwm3xuT3iVceAXnpvYN/BU6Itn8egyIA9jY8/0lKx9tUR
    oGuCFBwN1u+SF8iogGWdiCLBDU2EZ3D+rUXk96PE8UwRR9rfuQ0/9Xo6OUch1oFg
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=oVI/DK9v x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=oVI/DK9v x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965370AbeCHE7S (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 23:59:18 -0500
Received: from mail-co1nam03on0126.outbound.protection.outlook.com ([104.47.40.126]:14720
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965356AbeCHE7P (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:59:15 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: James Smart <jsmart2021@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 57/67] scsi: lpfc: Fix SCSI LUN discovery
 when SCSI and NVME enabled
Thread-Topic: [PATCH AUTOSEL for 4.14 57/67] scsi: lpfc: Fix SCSI LUN
 discovery when SCSI and NVME enabled
Thread-Index: AQHTtpoGJnj5pA2FuECTsh2AkVlPPQ==
Date: Thu, 8 Mar 2018 04:57:57 +0000
Message-ID: <20180308045641.7814-57-alexander.levin@microsoft.com>
References: <20180308045641.7814-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045641.7814-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0999;7:62vEqxGsiwOYGYydStry8FBrbRpJcVbwO+8VbbNxwtsZHRqaEnQxWnlDjYzp5HsMXj1707Q2ug5ImUV746Dfshua2ps+bn5sV26tGRClUIR2e1/G0uP9b0EhUhvC6VPHzm1ADfDrb53ZV/xI88mYu6Dq9I2VB49nqGExrRU/sTHkMCi4pzrq+SkLjFs7xZIoArQSVB5nEwMYw2i2rIFnvCyvktiRfxtYl3QVU31W073/TfVHxcNZ8Bpv9jC7MgEg;20:P9/IrI1I3aIRNyftpL30tITHpuoB1rQVI6j3BdFEexD5qhew2s/1nuR30M2sa64OENgTdPaWPNPysaVaF2gTP0DuLIfDOPV7IQ96aXJiVImar1cicepmcMmkSibbIoItLkK24QmYFe6Mi4Jydgv4FYmsybgjK7tryygogr0aEqo=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 526c7924-e89b-44a8-769a-08d584b1551e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0999;
x-ms-traffictypediagnostic: DM5PR2101MB0999:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0999B5805A46AD1A7E066805FBDF0@DM5PR2101MB0999.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0999;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0999;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(39380400002)(376002)(396003)(346002)(189003)(199004)(72206003)(3846002)(106356001)(8676002)(6116002)(1076002)(6512007)(14454004)(81156014)(66066001)(2906002)(3660700001)(478600001)(10290500003)(8936002)(6486002)(305945005)(7736002)(36756003)(2900100001)(81166006)(4326008)(25786009)(6436002)(5250100002)(105586002)(54906003)(22452003)(76176011)(5660300001)(10090500001)(110136005)(316002)(39060400002)(6506007)(86362001)(186003)(2950100002)(97736004)(3280700002)(102836004)(99286004)(107886003)(59450400001)(68736007)(86612001)(53936002)(26005)(6666003)(2501003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0999;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: O/7a6jOWVO7AySAGVLRm3jbiIfvEpw8OHcTlfZJyz826snsqJhfJfmXJQY4Cq0HlQqroC884bACTdp4TuO+fShRRcxQSoBXbFvuWnfCFeNgU1hB3o3LQ+5o28viDSEVr/uWspnt7mOpIHoUR4aFSVmFfoWjTC4EKkkUMddw6sLQ8Us4mLghA/E02UpWjG5+m5FXn2t3k1dwp54YZNsAZJWYSWCcz++cBNYxrMVASVBwo96z/MuBvUGm7cclOyagOsTquqmomif9WZL5SeE96RVKZ6aEUtTL3QYma+hmOVwH3S0ZgJshH8+HTYyT9RmJP2Wq92QmGRiruIsa/OxEf9g==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 526c7924-e89b-44a8-769a-08d584b1551e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:57:57.0206
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0999
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
index 33417681f5d4..126723a5bc6f 100644
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
index 3ebf6ccba6e6..91783dbdf10c 100644
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
