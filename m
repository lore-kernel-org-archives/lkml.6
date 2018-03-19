Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3907919-1521497118-2-3197452746939340254
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521497117; b=vjIs4aD8kFt28YQv2KDWmNBX3yUhnrOQdgq7E3RSzEBvmDj
    BKbEj1KUnDZltgP4x1tyIfxa17RqhCC9JO0+dIdv3y75cIlsoFCW781uSU6Sjonz
    rt8FaCqIgE4UKbBvykzGRfiLuRDGNc+oZY00q7aU1qhYNkKpXH/+N4A6lwim02HG
    A0BGKb3wR0KB24IOokRwKaFjWnuGFXru1k3ZWvS8ijr/5YYc/SKfIALANpImL6Yl
    GrcwjfgCC+FVbSBuQpvgpjzTQ/byHPI2v3Hrm781v+bTHRrAON91lH4kyfKrGeo0
    ShhwT5m0DunIBdF+Kjd0CwusIBTVO8zcIBQ38dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521497117; bh=4bY7sI
    SE7RVUkK6KMNNS3CC9ahe2U4JJ9Pzzkc/Vh8M=; b=VU+o9Wff2sLqqI791m8unQ
    l3DEujeWGMiuAqxsLA61LR4JVWFfbilcbWfqzz69Cv3IymuTm6fvYxylXyzA/YdM
    Ut3JtrEUfhRyaDS/ffnQnaGn19/N5MpIyApPN+BweHjdGmB4YbgPS1aY1YuFuuU2
    c81VKtutiTiC9dsZCu2h2dLtBCqgwS4xQCkLZaajbVGQpx2wZ5pFItPcoSjrIAXO
    uvNFj7TbajKBwL6V7GMX90E8bXxgfVZV9g010B9p7hf19vtPsKRHi5iZO4sWXPWA
    sqm4JSoj72pdIPoiWj/bPUqrbWSBbAL52R0/eDSR3z2tiBtoIaCbYodBG9daxAdQ
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=KFQr9LiE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheekucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpedutddtvdeinecuvehluhhsthgvrhfuihiivgepuddu;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=KFQr9LiE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheekucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpedutddtvdeinecuvehluhhsthgvrhfuihiivgepuddu;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934390AbeCSPzr (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:55:47 -0400
Received: from mail-by2nam01on0098.outbound.protection.outlook.com ([104.47.34.98]:21274
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933974AbeCSPzj (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:55:39 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Chaitra P B <chaitra.basappa@broadcom.com>,
        Suganath Prabu S <suganath-prabu.subramani@broadcom.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 32/97] scsi: mpt3sas: Proper handling of
 set/clear of "ATA command pending" flag.
Thread-Topic: [PATCH AUTOSEL for 4.14 32/97] scsi: mpt3sas: Proper handling of
 set/clear of "ATA command pending" flag.
Thread-Index: AQHTv5qmWPLU3TaoCUya48F2tA7zww==
Date: Mon, 19 Mar 2018 15:55:06 +0000
Message-ID: <20180319155411.12348-32-alexander.levin@microsoft.com>
References: <20180319155411.12348-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155411.12348-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0807;7:a38PuT1OuXLeySMzIaXtXWI22GdGJqkQw7JisOWf+Vo7ZzwiBNGeEmFaxmMqaQcjIJ+T0jy9Zis0uNBRfKPfWi5jn/heswsnG2ysdxtK3gkAiv7V1544JL9HvMz23Kdl4lzONMwXkg8e0okxhNe8p78dNW9QQDWoNR0BwnnUu29ZKXFfx0BybYbHghlb2xQjsIecFgU0hzM7aCD5djLWuCWpNISsyOPH3WpBcl81WXz+IJCEDPpV8flI+aan+Jtx;20:Z2Qsxm2F+VndnGmhNqHN1dcOMEVc7VBo6VkVoEezg1VrHOkimL93GMe5OAtPxNNTy/fAwXJOCWx8CEz78iJxMOCCiaFQzycau5vmXlmJwT+SJOF+BnIIghFttYS3+oM7t9sEDkmcPznCPZWcmgLqf6+PzJUwDZjz+0slW/UiHG8=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a3ca99df-2eeb-4822-3e63-08d58db1da9e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0807;
x-ms-traffictypediagnostic: DM5PR2101MB0807:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0807E6A02FDC1B176A720744FBD40@DM5PR2101MB0807.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0807;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0807;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(396003)(39380400002)(39860400002)(199004)(189003)(26005)(10290500003)(305945005)(6666003)(68736007)(186003)(102836004)(4326008)(25786009)(66066001)(6506007)(8676002)(59450400001)(2900100001)(5660300001)(7736002)(2950100002)(81166006)(10090500001)(81156014)(97736004)(2501003)(5250100002)(3280700002)(316002)(76176011)(478600001)(8936002)(99286004)(53936002)(575784001)(36756003)(86612001)(72206003)(107886003)(110136005)(54906003)(6512007)(14454004)(6436002)(22452003)(3660700001)(3846002)(6486002)(6116002)(106356001)(1076002)(105586002)(2906002)(86362001)(22906009)(32563001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0807;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: tSPj6S93qRSWGZQDN2Fly945QniF/v5gmr+wyjU6r47Z5gKDvAJOvHtEAtr8LIK0z9TOZ6wBbPi1qniwMJWKV3xqkvcb0KSaIDk9NBkziB2hk5OawYO09xQRXaroVePKuT86asOit8E3Z4vJS6RyGQL8sD+9CHIKZT3livJGZ57Q1XNxobbJgh2FtgLSOpV/bfDp9BprjRGJXBqKFKM7OOVXjDO9mkyHUJ33AsDFmsYSVFbha96HQkRt7/WKctKgo9n0oVWEmtVnOffOSartoJi/v7UO2k3rU2pY26hRpGDU+Z83PGuYvDdUsTRRrf7j93oEeB5d1nJlxQB8WesB7w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3ca99df-2eeb-4822-3e63-08d58db1da9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:55:06.3335
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0807
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Chaitra P B <chaitra.basappa@broadcom.com>

[ Upstream commit f49d4aed1315a7b766d855f1367142e682b0cc87 ]

1. In IO path, setting of "ATA command pending" flag early before device
   removal, invalid device handle etc., checks causes any new commands
   to be always returned with SAM_STAT_BUSY and when the driver removes
   the drive the SML issues SYNC Cache command and that command is
   always returned with SAM_STAT_BUSY and thus making SYNC Cache command
   to requeued.

2. If the driver gets an ATA PT command for a SATA drive then the driver
   set "ATA command pending" flag in device specific data structure not
   to allow any further commands until the ATA PT command is completed.
   However, after setting the flag if the driver decides to return the
   command back to upper layers without actually issuing to the firmware
   (i.e., returns from qcmd failure return paths) then the corresponding
   flag is not cleared and this prevents the driver from sending any new
   commands to the drive.

This patch fixes above two issues by setting of "ATA command pending"
flag after checking for whether device deleted, invalid device handle,
device busy with task management. And by setting "ATA command pending"
flag to false in all of the qcmd failure return paths after setting the
flag.

Signed-off-by: Chaitra P B <chaitra.basappa@broadcom.com>
Signed-off-by: Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/scsi/mpt3sas/mpt3sas_scsih.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mp=
t3sas_scsih.c
index 33ff691878e2..5b953aee19c2 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -4103,19 +4103,6 @@ scsih_qcmd(struct Scsi_Host *shost, struct scsi_cmnd=
 *scmd)
 		return 0;
 	}
=20
-	/*
-	 * Bug work around for firmware SATL handling.  The loop
-	 * is based on atomic operations and ensures consistency
-	 * since we're lockless at this point
-	 */
-	do {
-		if (test_bit(0, &sas_device_priv_data->ata_command_pending)) {
-			scmd->result =3D SAM_STAT_BUSY;
-			scmd->scsi_done(scmd);
-			return 0;
-		}
-	} while (_scsih_set_satl_pending(scmd, true));
-
 	sas_target_priv_data =3D sas_device_priv_data->sas_target;
=20
 	/* invalid device handle */
@@ -4141,6 +4128,19 @@ scsih_qcmd(struct Scsi_Host *shost, struct scsi_cmnd=
 *scmd)
 	    sas_device_priv_data->block)
 		return SCSI_MLQUEUE_DEVICE_BUSY;
=20
+	/*
+	 * Bug work around for firmware SATL handling.  The loop
+	 * is based on atomic operations and ensures consistency
+	 * since we're lockless at this point
+	 */
+	do {
+		if (test_bit(0, &sas_device_priv_data->ata_command_pending)) {
+			scmd->result =3D SAM_STAT_BUSY;
+			scmd->scsi_done(scmd);
+			return 0;
+		}
+	} while (_scsih_set_satl_pending(scmd, true));
+
 	if (scmd->sc_data_direction =3D=3D DMA_FROM_DEVICE)
 		mpi_control =3D MPI2_SCSIIO_CONTROL_READ;
 	else if (scmd->sc_data_direction =3D=3D DMA_TO_DEVICE)
@@ -4167,6 +4167,7 @@ scsih_qcmd(struct Scsi_Host *shost, struct scsi_cmnd =
*scmd)
 	if (!smid) {
 		pr_err(MPT3SAS_FMT "%s: failed obtaining a smid\n",
 		    ioc->name, __func__);
+		_scsih_set_satl_pending(scmd, false);
 		goto out;
 	}
 	mpi_request =3D mpt3sas_base_get_msg_frame(ioc, smid);
@@ -4197,6 +4198,7 @@ scsih_qcmd(struct Scsi_Host *shost, struct scsi_cmnd =
*scmd)
 	if (mpi_request->DataLength) {
 		if (ioc->build_sg_scmd(ioc, scmd, smid)) {
 			mpt3sas_base_free_smid(ioc, smid);
+			_scsih_set_satl_pending(scmd, false);
 			goto out;
 		}
 	} else
--=20
2.14.1
