Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1379734-1520124028-3-8241803045428305420
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520124027; b=TtmQVLKjMtaQ+oXhTFrpbilgd9pyU4fMeM//TSjhMow2Jsb
    g+3QiJjsGO+9+852p2LmFrMeEuIHAQIBzj5QWoupLqlw9W1yzSIl3J87ETH6Yhhm
    UfmeSG1rLo4HjpiHn8c6UXRWpv1CrTcnrwHv8XgqXEfaMng77ZVp1XKmglGCbUly
    f9z91MmY4Sz6rSh+6QqzcnotasCYCkRKycTIfbnl6zyudwqYCfap+hZjZJFJBdWu
    0u41Ybjr+zshw8taiowg/PlqkwfH/1VatLZ0QR8mEDAfqXEYeL/D4L3mnEo67dMP
    9ktvZJ+ecjZZNz5OlvZ9eDXSMFCkPVlNxNHED8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520124027; bh=AnRJLb
    Dq7hX4vVGjlgx1J282QHVQPaErjPlnqAwakKg=; b=wJPs5uB1wTW5vq4h3F6iq6
    4Ueo6AnqMh+NVQ9QV0WPkMNQrBIb02kmlucefIfgKLcSh86Aq6BRCxpdJaC5qdpS
    6nwXseOCeqaY5A0g9f4Che96sezzXSGK1ThneDXSJBUvbGX8lkYgqUpkA/Xtw19V
    XaDQXTY1OffTeXGT/qwz4GvDELxQN+lhqI/llBag4Rl7mQFcjer1oPTlgDX/SvIL
    EOhA5CH25MHbYyZUhQUJuUbKVaw/sFpRicnjI9lUINYkxRXdaWWrVQ8ZLArWJY1q
    S5N0zldk9qBXVFtYV7QPzz06DlBICYHYTKP1QZmEpuDZMu2AZy6h1ZgBvizBwhiQ
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gsC5FY2A x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gsC5FY2A x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932437AbeCDAkH (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:40:07 -0500
Received: from mail-sn1nam01on0131.outbound.protection.outlook.com ([104.47.32.131]:14704
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932662AbeCCW0X (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:26:23 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: James Smart <jsmart2021@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 056/102] scsi: lpfc: Fix crash during driver
 unload with running nvme traffic
Thread-Topic: [PATCH AUTOSEL for 4.15 056/102] scsi: lpfc: Fix crash during
 driver unload with running nvme traffic
Thread-Index: AQHTsz5sOmEIL++yU02KAbChMZoxvQ==
Date: Sat, 3 Mar 2018 22:24:41 +0000
Message-ID: <20180303222318.26006-56-alexander.levin@microsoft.com>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0970;7:8B65ydH+DbCBHCg7nyzfyNVRv3qS33FiA8T34nnRgXLuH9W1vqhYUtMNhS6qe8GaTYYpDw9J06zRV/a93qWxxC89FdvCyUhKnw0/1HCZjE8PgoEZJNnyR8M+NsDXStO5MF/WNnJJ8g7lSqXhzEvHAeTph5LcchzLa+9uS3cG21+6/KWmzrfaTl3oO86fStqBzTP1xDoiP3/7o1SHA80qXw6ZHEK0CtnJlxhNw+oUpVGGe31+RyqLigf5gVtQggTH
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6ef57381-fee4-4ba9-75b6-08d58155c6e1
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB0970;
x-ms-traffictypediagnostic: MW2PR2101MB0970:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB0970418C5D85B8570405CD41FBC40@MW2PR2101MB0970.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0970;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0970;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(366004)(39380400002)(376002)(396003)(199004)(189003)(3660700001)(10290500003)(2950100002)(3846002)(2900100001)(22452003)(10090500001)(86612001)(6116002)(6666003)(68736007)(105586002)(5660300001)(5250100002)(106356001)(97736004)(2501003)(66066001)(8936002)(1076002)(99286004)(2906002)(36756003)(39060400002)(86362001)(14454004)(6506007)(110136005)(4326008)(102836004)(6512007)(81156014)(305945005)(81166006)(7736002)(8676002)(53936002)(72206003)(59450400001)(6436002)(316002)(478600001)(76176011)(25786009)(6486002)(26005)(54906003)(3280700002)(186003)(107886003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0970;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: 0Z6S6iM8jdBOmr7d6FIB3UJdT7mb0FuNozyRJpyFuRsqyUQJkMJ22hGxap/fQt/QZmtmxwC7XkHS6sKVQMg46D56XQ6TzMQnXr5bIB1d+WnT2whwYS0wXoxeCV6qHn6uqrq+iPULq1b/AVAvroJfsv2LeksjMZaH4S8ahoRkSUU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ef57381-fee4-4ba9-75b6-08d58155c6e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:24:41.9628
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0970
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: James Smart <jsmart2021@gmail.com>

[ Upstream commit 3386f4bdd243ad5a9094d390297602543abe9902 ]

When the driver is unloading, the nvme transport could be in the process
of submitting new requests, will send abort requests to terminate
associations, or may make LS-related requests.  The driver's abort and
request entry points currently is ignorant of the unloading state and is
starting the requests even though the infrastructure to complete them
continues to teardown.

Change the entry points for new requests to check whether unloading and
if so, reject the requests. Abort routines check unloading, and if so,
noop the request. An abort is noop'd as the teardown paths are already
aborting/terminating the io outstanding at the time the teardown
initiated.

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <james.smart@broadcom.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/scsi/lpfc/lpfc_nvme.c  | 14 ++++++++++++++
 drivers/scsi/lpfc/lpfc_nvmet.c | 11 +++++++++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/scsi/lpfc/lpfc_nvme.c b/drivers/scsi/lpfc/lpfc_nvme.c
index 517ae570e507..0e63c88441a3 100644
--- a/drivers/scsi/lpfc/lpfc_nvme.c
+++ b/drivers/scsi/lpfc/lpfc_nvme.c
@@ -416,6 +416,9 @@ lpfc_nvme_ls_req(struct nvme_fc_local_port *pnvme_lport=
,
 	lport =3D (struct lpfc_nvme_lport *)pnvme_lport->private;
 	vport =3D lport->vport;
=20
+	if (vport->load_flag & FC_UNLOADING)
+		return -ENODEV;
+
 	if (vport->load_flag & FC_UNLOADING)
 		return -ENODEV;
=20
@@ -534,6 +537,9 @@ lpfc_nvme_ls_abort(struct nvme_fc_local_port *pnvme_lpo=
rt,
 	vport =3D lport->vport;
 	phba =3D vport->phba;
=20
+	if (vport->load_flag & FC_UNLOADING)
+		return;
+
 	ndlp =3D lpfc_findnode_did(vport, pnvme_rport->port_id);
 	if (!ndlp) {
 		lpfc_printf_vlog(vport, KERN_ERR, LOG_NVME_ABTS,
@@ -1260,6 +1266,11 @@ lpfc_nvme_fcp_io_submit(struct nvme_fc_local_port *p=
nvme_lport,
 		goto out_fail;
 	}
=20
+	if (vport->load_flag & FC_UNLOADING) {
+		ret =3D -ENODEV;
+		goto out_fail;
+	}
+
 	/* Validate pointers. */
 	if (!pnvme_lport || !pnvme_rport || !freqpriv) {
 		lpfc_printf_vlog(vport, KERN_INFO, LOG_NVME_IOERR | LOG_NODE,
@@ -1487,6 +1498,9 @@ lpfc_nvme_fcp_abort(struct nvme_fc_local_port *pnvme_=
lport,
 	vport =3D lport->vport;
 	phba =3D vport->phba;
=20
+	if (vport->load_flag & FC_UNLOADING)
+		return;
+
 	/* Announce entry to new IO submit field. */
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_NVME_ABTS,
 			 "6002 Abort Request to rport DID x%06x "
diff --git a/drivers/scsi/lpfc/lpfc_nvmet.c b/drivers/scsi/lpfc/lpfc_nvmet.=
c
index 84cf1b9079f7..2b50aecc2722 100644
--- a/drivers/scsi/lpfc/lpfc_nvmet.c
+++ b/drivers/scsi/lpfc/lpfc_nvmet.c
@@ -632,6 +632,9 @@ lpfc_nvmet_xmt_ls_rsp(struct nvmet_fc_target_port *tgtp=
ort,
 	struct ulp_bde64 bpl;
 	int rc;
=20
+	if (phba->pport->load_flag & FC_UNLOADING)
+		return -ENODEV;
+
 	if (phba->pport->load_flag & FC_UNLOADING)
 		return -ENODEV;
=20
@@ -721,6 +724,11 @@ lpfc_nvmet_xmt_fcp_op(struct nvmet_fc_target_port *tgt=
port,
 		goto aerr;
 	}
=20
+	if (phba->pport->load_flag & FC_UNLOADING) {
+		rc =3D -ENODEV;
+		goto aerr;
+	}
+
 #ifdef CONFIG_SCSI_LPFC_DEBUG_FS
 	if (ctxp->ts_cmd_nvme) {
 		if (rsp->op =3D=3D NVMET_FCOP_RSP)
@@ -820,6 +828,9 @@ lpfc_nvmet_xmt_fcp_abort(struct nvmet_fc_target_port *t=
gtport,
 	struct lpfc_hba *phba =3D ctxp->phba;
 	unsigned long flags;
=20
+	if (phba->pport->load_flag & FC_UNLOADING)
+		return;
+
 	if (phba->pport->load_flag & FC_UNLOADING)
 		return;
=20
--=20
2.14.1
