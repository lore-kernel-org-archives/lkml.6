Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3763980-1521493814-2-8474419632059625087
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
    t=1521493813; b=tAqPvzbo6sgRBaJhmBXJtgruCut0atGVmude0h9NkSaxUU8
    TavZGruEk2kMFNkCQ+/c2LAhyBU/j2AIka0biDPJ0kG1JM4v3S3860/7kVcoXfJ4
    31eeZVQj44tgvqQFkTq+sva5/5O7oHRyrGhcLEEsGyOqfwPdoc1+Zk1xTpvYqT9X
    BATuBUHxr4FVnV55pdxAYnfHPDYJEY2DRCJeOpbuL3M3yGBDrZFW+DHy36QyPOyX
    jKSfTzOIv7F4lzFUO5bM2VQvcLS1qf6D8SunAvB0rae6QoISELTabfy/Dl+mXPQk
    ydl4YKUbBWtRxEdGIbKComxNvYK2aAS/7/xFNNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521493813; bh=EFd2dq
    flcmXYMNjWguvksQBhgWL/Qu6/lm9YX6dlu7o=; b=u3U96MaA1lECVOaxwYOrio
    0TzZzZhGcUqWl3CB334lmdqdHdNhXukmEhvKp2rOibOO3Ir3Aw3DdaTBU3FKhMfA
    fWvM4xCL+xu84uvkiDZs54oZfOXRw7SW8fTXwlC1767C2B4Zb3vwpyyn7lMkZsIe
    PDBmKLcngLMkablUqwFrVZFWCbie4LcDKwyGLNMaptHnRUPs8seV+t7ZewYvZOxc
    JtFQsPO5VTslwNxFVFectUJ1QsZcSwZFSTNh+emHSVFefqyZ4s8vHP++34f3wB6T
    mrD2xB4gPWrkTp+kZ+/fkzhJc8SGnI58HN4e1J7HReJWslNMFPcU8xPo9V+0rJjw
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZCuc2pa/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpedutddtfedtnecuvehluhhsthgvrhfuihiivgepgeef;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZCuc2pa/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpedutddtfedtnecuvehluhhsthgvrhfuihiivgepgeef;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935662AbeCSVJj (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:09:39 -0400
Received: from mail-by2nam03on0113.outbound.protection.outlook.com ([104.47.42.113]:47488
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934952AbeCSQCA (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:02:00 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Chaitra P B <chaitra.basappa@broadcom.com>,
        Suganath Prabu S <suganath-prabu.subramani@broadcom.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 137/281] scsi: mpt3sas: Proper handling of
 set/clear of "ATA command pending" flag.
Thread-Topic: [PATCH AUTOSEL for 4.9 137/281] scsi: mpt3sas: Proper handling
 of set/clear of "ATA command pending" flag.
Thread-Index: AQHTv5tqLA7XhOPQfU2kVAqVVPKo0Q==
Date: Mon, 19 Mar 2018 16:00:35 +0000
Message-ID: <20180319155742.13731-137-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0919;7:uyWW3ooffKCmVg8nPlJ8l2mTfhxLRGhoDK7AvtDWSH+v4re+w6Ir6d6cYX1EQ+KWUsi+tEIJ3sl87RERQLLo2Q1YszADWET7a1L/EO2JBD0zt//kdzZNt3nrfzvBkyEbv4ocpNJzFACSglF/H9azoBPwU/MnNl6TmRlYrwGYdLuzbFz5kRpmOfUZELSQxzADsZ2onRpMcunqYEuzWkjO67nH77Bpmx2bo/M1R2bnDNa5K+XJqY+aMDdCYV419H38;20:mI2+XEW09d7/RN2kaq8oKbINX/HSTira2DluMYK/Gn37Noa9bJIe4myXTuaZRhCMDNMZIxen299f82DRDXcokK5frkycSIGrapb25qHuHWanfbwdjU/ckadzADO2tsVnpyP2iX40FFBOgKE7a1HDIGLEEyCVcNTewwOzpKiXFhI=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bad99f6f-e2a7-4ff9-2093-08d58db2ba80
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0919;
x-ms-traffictypediagnostic: DM5PR2101MB0919:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0919BBF28197C745BFD9DC6AFBD40@DM5PR2101MB0919.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0919;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0919;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(396003)(39860400002)(376002)(366004)(199004)(189003)(66066001)(575784001)(2906002)(86362001)(10290500003)(105586002)(8676002)(305945005)(110136005)(478600001)(4326008)(7736002)(81166006)(3280700002)(6506007)(97736004)(107886003)(5660300001)(36756003)(8936002)(53936002)(86612001)(14454004)(59450400001)(1076002)(2501003)(6116002)(10090500001)(76176011)(186003)(3846002)(5250100002)(6512007)(99286004)(102836004)(106356001)(72206003)(81156014)(2950100002)(6666003)(54906003)(3660700001)(22452003)(68736007)(6486002)(25786009)(26005)(316002)(2900100001)(6436002)(22906009)(32563001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0919;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: q+kYJsllnmG5oRQUHwTReZpNwvm2uA8Ji4tTnTD4wRKFs+m0+75OqK1O1VDRzYvVtriL5ZdJt1ztaZiEJU2hE8OujYvOt+YxxZtS0LFoC8b4EgGQDdoefNweRrue/y7Vn3+EEpgT4WdRXbdKtrLc/S10Zw68fP36cdTAmN2OIZWsp+WzOBRm2EKKt3QrFaDyGB3Tpi4uOoLoEZOTPoSdB4/dwQuw9/nisWgqSbZIKGG3e73pXGWKZtmNVloKrtmNQ0ZGC7Zy/3Wt8fx1Tqu8wh8feFl94OPq3JlGJpoau3Wdn9+fjWjK6izpeBAkSGtVAFMDn5tLlA3BSY/dicIaFg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bad99f6f-e2a7-4ff9-2093-08d58db2ba80
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:00:35.5491
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0919
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
index 468acab04d3d..b8589068d175 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -4065,19 +4065,6 @@ scsih_qcmd(struct Scsi_Host *shost, struct scsi_cmnd=
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
@@ -4103,6 +4090,19 @@ scsih_qcmd(struct Scsi_Host *shost, struct scsi_cmnd=
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
@@ -4124,6 +4124,7 @@ scsih_qcmd(struct Scsi_Host *shost, struct scsi_cmnd =
*scmd)
 	if (!smid) {
 		pr_err(MPT3SAS_FMT "%s: failed obtaining a smid\n",
 		    ioc->name, __func__);
+		_scsih_set_satl_pending(scmd, false);
 		goto out;
 	}
 	mpi_request =3D mpt3sas_base_get_msg_frame(ioc, smid);
@@ -4154,6 +4155,7 @@ scsih_qcmd(struct Scsi_Host *shost, struct scsi_cmnd =
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
