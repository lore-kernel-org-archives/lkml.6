Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3205673-1521475801-2-6247327613219316058
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
    t=1521475800; b=n67e1B6760svYamficqps2XR5FLEr6N0oxvypqYqOYRawpr
    G9nhigBVcVoiRh5cYBVOFKW7pUl6b1lNU4BfBpT+I8FD98d61JlB4ZGA1bvfkoRO
    POMuVx1BJ2iIecw3L2OMTSGmD09cKSneHdo4MkR/9B844IO3w/QnMyOV61RO+IMk
    lzYnoR7P6i2VzUF4U+128l6ynnzE0zBZL+0hwhCnxxCrWlIcrMlyfCig4FiU/ixF
    Dgjt7OGEUTejyhcKZr7Kfpg0R8K1PYllw/UU59oQpTCMh0AHv6RS0gbcoy/qBa93
    FQ2+nauHXrPfcVncAQRzNCPAQGqBSLg57j6G04g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521475800; bh=KMbzit
    eic9HaYRfc1/hLoeDylLaoud+SNSCnP9UCcvM=; b=aol+MU1bvKoy+oeHtwMMbI
    G2a6vFuWVOu8A59tN1pSBbbC89u/zdMV5/AUiz85J+bjg84uHW60Nq9YAcEZJ8+E
    lduAgAFk85ngURqczRZ2uSWF0zwEnEyaoWJN3dbYlSywl5veFMRWe/C6ai61wWpt
    lCJiw9tFpCDEW0hdcRMHlc89V9cGw+/fZmPrYUoBNEFi0JrzKBinRsaMoluixFYk
    zXRx38WvpyKLCR3bT40kgSCMjsOA/by/FqIDcpIb5CqfRa4vN3jEJC597mR8udkA
    cwjtJFYwbLLuyZknMQBdzT7kygjjMMHXa4R+Ls3UL5HF8qHEsGCZYV6v+dmDWjnw
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ie3cMDth x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekheculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepuddttddvleenucevlhhushhtvghrufhiiigvpeelie;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ie3cMDth x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekheculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepuddttddvleenucevlhhushhtvghrufhiiigvpeelie;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966539AbeCSQJ5 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:09:57 -0400
Received: from mail-sn1nam01on0103.outbound.protection.outlook.com ([104.47.32.103]:51328
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966204AbeCSQJo (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:09:44 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Chaitra P B <chaitra.basappa@broadcom.com>,
        Suganath Prabu S <suganath-prabu.subramani@broadcom.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 091/167] scsi: mpt3sas: Proper handling of
 set/clear of "ATA command pending" flag.
Thread-Topic: [PATCH AUTOSEL for 4.4 091/167] scsi: mpt3sas: Proper handling
 of set/clear of "ATA command pending" flag.
Thread-Index: AQHTv5xZQkfj4Sls2kqEeoJr0YySoQ==
Date: Mon, 19 Mar 2018 16:07:16 +0000
Message-ID: <20180319160513.16384-91-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0902;7:YV7h5PjwoQlj9oDnx5J2GiOJHQ1UI8CF2t74IfiauO9xT3UngJ/98fbORK3+f2WuYAFRyF0crbgGrnd7gyfTuh5OceccHoylV7LrCd/6YyfZpy4WQv+wJNa9m/OWlJbXAN3+2Kxn3oGOaMC1EsLCJM2m4FVJFM+5sgUeRkEyiUgGFPBEhfxVa6KeA+6xHjGvyUjybJD9E3BY+e4DJcgbbh3l0XW/Safi6uzU47oeTf1qLoQrL3L9vTgcKvn83R57;20:LXWgl5010cniQ4fiYNC6HhNxPG56+bPpOcA5vfZqfbY6lAJ3gr1xnAnAGsugFnPwNkA76E98qzg4jpo49xhkFX7dCdISz4gDBWyQ/FKiMfOjb2/K5FAKJ6un3ogCR4RyH25K1ZvMEMbHds+qcLTcWyQGCzKv9kq+56CktzAPGpE=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a7f0a8db-7361-474d-45e6-08d58db3d199
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0902;
x-ms-traffictypediagnostic: DM5PR2101MB0902:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0902687106A65B2D82B95A05FBD40@DM5PR2101MB0902.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0902;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0902;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39860400002)(396003)(39380400002)(376002)(199004)(189003)(4326008)(305945005)(7736002)(66066001)(105586002)(316002)(8676002)(25786009)(8936002)(6666003)(2950100002)(5660300001)(97736004)(81166006)(81156014)(3280700002)(22452003)(99286004)(186003)(2906002)(76176011)(5250100002)(59450400001)(54906003)(10090500001)(110136005)(6116002)(2900100001)(3846002)(2501003)(1076002)(86612001)(107886003)(106356001)(6436002)(6512007)(575784001)(86362001)(53936002)(6506007)(6486002)(26005)(14454004)(10290500003)(102836004)(68736007)(3660700001)(478600001)(72206003)(36756003)(22906009)(32563001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0902;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: NeEVBw4lrbxcxJ/ThouyVfMuY9Qrt6OLFWR6a2J/OMdBUrgpG7WaW2xqtNAjGlGtcRsThu77bRkKqdHv9hf/8++3EE1FDw2R8ymEJzw+a0t8IRybrjSTnlOtyv3r6sys9mQZoEum6vgLRzqsg4EvJ4SgtPlWm37UToUI6iNiOq7s52FeuSeBNfvN6LpooZOqYmU0RFJJdjwmeG4S3lxPx03J/QEUOZG1cGXZidTqg6tVPZW/M0h5UT2GhUYSkGAkJBZIsgpbJyTCPWrBKcLjA0Y+y2eLJ5q9uuRC7GFcxDL78HMs/8oz8ayXhpoZgIgHBt3Bvbo/B1sgfSij2ZQFIA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7f0a8db-7361-474d-45e6-08d58db3d199
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:07:16.2221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0902
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
index e111c3d8c5d6..b868ef3b2ca3 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -3886,19 +3886,6 @@ scsih_qcmd(struct Scsi_Host *shost, struct scsi_cmnd=
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
@@ -3924,6 +3911,19 @@ scsih_qcmd(struct Scsi_Host *shost, struct scsi_cmnd=
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
@@ -3945,6 +3945,7 @@ scsih_qcmd(struct Scsi_Host *shost, struct scsi_cmnd =
*scmd)
 	if (!smid) {
 		pr_err(MPT3SAS_FMT "%s: failed obtaining a smid\n",
 		    ioc->name, __func__);
+		_scsih_set_satl_pending(scmd, false);
 		goto out;
 	}
 	mpi_request =3D mpt3sas_base_get_msg_frame(ioc, smid);
@@ -3975,6 +3976,7 @@ scsih_qcmd(struct Scsi_Host *shost, struct scsi_cmnd =
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
