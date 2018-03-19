Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3907919-1521498768-2-11685276718117887063
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
    t=1521498767; b=l+T9odHM5exUsgXRIOW41jMwX90ukcRp6Xlgjr2dKLssPr6
    tKB/EOQoaE3vXvRorXV4njvw1kV8duEIlHhJtMuTY7KR0+XA/gYeab+rk7PF1OMY
    y3PAYmXA0soHRi3AXEwpAHuioT26vUakx1CTBmnsv6JSVTjS29TKmr77DDUbAvaK
    /Y8C77krlyghJ6qvc2whBrky8ZThBeGBQMWScdNjuDyqk/y8WuV++dllgJbxrop4
    0UxSZWhrQggvxp4MoXQB7GKy1OFN8v1eNepe0cGpWpNQqaHYM3VBxSREhH0S6qIF
    e0bQIK4pHJCukn9oVWBUK9I/R4+o6PwFzoCIw8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521498767; bh=a+uVwg
    4HgdXBdSwbXEAwIlr2BGTFEJow6Hq5nYjgKnQ=; b=AO16ARO8AsuoUy/wDY7K1h
    FM6QlsElQPWHnM2yFrFr9VDFaG/6f8raDiTjRG9tejsQcDG4UAitUZcvcHJMh9N3
    R84fJoC70G2U9Kzdymmjo/VgNE0St8ZMAHuj7SwKn1ByVi9mSBlcdJfvJZ5JSN7D
    jruFyJQbEnmYAjwLUlvD956ftkWiMHqNkx6dQ9uenokOxt4heaEdjst2KFdwprOj
    nAT7IkBH8Ka6t6mMATw4H2FNwIbrhOJUctNHa+trMtY4fIrZ7vvsRpCHt9lFBZyS
    Y4QOLP2Xw+rS8EFNW+CC+I30sTON02mOoNC6lfc20ypjHg0/8h9mW0++ExChHZxQ
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=AlYGadYb x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduieefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpedutddtiedvnecuvehluhhsthgvrhfuihiivgepjeeg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=AlYGadYb x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduieefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpedutddtiedvnecuvehluhhsthgvrhfuihiivgepjeeg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936529AbeCSWcN (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:32:13 -0400
Received: from mail-by2nam01on0123.outbound.protection.outlook.com ([104.47.34.123]:15712
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933742AbeCSPsQ (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:48:16 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Chaitra P B <chaitra.basappa@broadcom.com>,
        Suganath Prabu S <suganath-prabu.subramani@broadcom.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 043/124] scsi: mpt3sas: Proper handling of
 set/clear of "ATA command pending" flag.
Thread-Topic: [PATCH AUTOSEL for 4.15 043/124] scsi: mpt3sas: Proper handling
 of set/clear of "ATA command pending" flag.
Thread-Index: AQHTv5megtQYpWRZ402Ep7wIZdl6sg==
Date: Mon, 19 Mar 2018 15:47:44 +0000
Message-ID: <20180319154645.11350-43-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1031;7:rV3HfArYUr9L4sePXcGDKDRvl5Q5TpPtkEpXJ4g8Cv5cjA1qiK/6I6lswMjpnh4inK67LrJMvvTViDci0k8TKBTqMiKGuDVB3csCXNdhyyZ1NGOCdy7Lqg28w2ceExEGCWcR1B0TDfuZVpz9OY3l6Lf4lQDiLxrF/7CQZbNEUjXVfM4wvHSmNGfFS031li5zd/apZiATDbcPuJcWhaWRXBgPKLuyOjMqYmjEEQsw+yaLz42xfm7LrPnFS3UWGkOb;20:HDStt8m6o6LfYm47CkecorZqGXYnrcchCN71JcbSmP4cnrpFZIllb6Sk+nXICqotPKW7LyKG7RDetasuDO3ARH+7J/U+m/gvDQg/89vjN8ihxE0UbN8y2Eyahrl4Ux/EupPW57Dq5yxv54MOwYG70iOwbtHX0E3cXw7sr+4HAc4=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: df536e7a-94dd-4e2a-87b0-08d58db0cff3
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1031;
x-ms-traffictypediagnostic: DM5PR2101MB1031:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1031F887DCF8384B139055F3FBD40@DM5PR2101MB1031.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1031;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1031;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(396003)(39860400002)(39380400002)(376002)(189003)(199004)(6436002)(6512007)(6666003)(3280700002)(2950100002)(7736002)(6116002)(3846002)(10090500001)(105586002)(4326008)(5660300001)(305945005)(1076002)(81156014)(2906002)(6486002)(81166006)(8676002)(8936002)(2900100001)(106356001)(36756003)(68736007)(54906003)(3660700001)(22452003)(97736004)(6506007)(25786009)(59450400001)(99286004)(10290500003)(76176011)(66066001)(14454004)(72206003)(478600001)(102836004)(26005)(186003)(316002)(2501003)(110136005)(5250100002)(575784001)(86362001)(53936002)(107886003)(86612001)(22906009)(32563001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1031;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 6q/FtPHGHmgZihR30KYtwaDC6B6W0Dnoub8UVzGSSdb+NymvVXmTffuxnkz1lbWyZEACoC+mW3r8TaT5lmYi9WHt1NJyoZ0AI2jE1HXJnfzyna3SRLM1PyHeNAboEt+19mpTI5LZs/iM9hUDAmygR/Th5jGfkcTerr5aOG/4ASzjR31UHcV3A3UYmV/Bi3eOfvQ/bcgXiE/s0VYUg/cfRgaU6fTFoJ9AZL98L/fMR8gTW/a3UC6GrcBL9qiT8YkbG2UadhKzT0Jud3JmR2uCOzZ3SKdI56jHYuOJHqzjR2StHfVqlZniDrHEH0ukDscPqeY7idYe/RL1U3d/df9ikQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df536e7a-94dd-4e2a-87b0-08d58db0cff3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:47:44.1316
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1031
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
index 741b0a28c2e3..fecc19eb1d25 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -4761,19 +4761,6 @@ scsih_qcmd(struct Scsi_Host *shost, struct scsi_cmnd=
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
@@ -4799,6 +4786,19 @@ scsih_qcmd(struct Scsi_Host *shost, struct scsi_cmnd=
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
@@ -4826,6 +4826,7 @@ scsih_qcmd(struct Scsi_Host *shost, struct scsi_cmnd =
*scmd)
 	if (!smid) {
 		pr_err(MPT3SAS_FMT "%s: failed obtaining a smid\n",
 		    ioc->name, __func__);
+		_scsih_set_satl_pending(scmd, false);
 		goto out;
 	}
 	mpi_request =3D mpt3sas_base_get_msg_frame(ioc, smid);
@@ -4857,6 +4858,7 @@ scsih_qcmd(struct Scsi_Host *shost, struct scsi_cmnd =
*scmd)
 		pcie_device =3D sas_target_priv_data->pcie_dev;
 		if (ioc->build_sg_scmd(ioc, scmd, smid, pcie_device)) {
 			mpt3sas_base_free_smid(ioc, smid);
+			_scsih_set_satl_pending(scmd, false);
 			goto out;
 		}
 	} else
--=20
2.14.1
