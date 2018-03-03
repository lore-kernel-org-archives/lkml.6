Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1204544-1520117662-2-3901583567859588199
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520117662; b=iAgPj17ZyGb9nFs9DJ7fs10IKRbvMdlzedMjw4rj8si4bUA
    19VmX2BuiyVbiQa2ITT+7DFGX2sAdnmGlBB40VwYMJnGgD34nZYwmHdrQJJP7ko9
    PGzFVgt9yq1rimH83eIs8O6WKrYvAPjUGu9moeoREqzkKhwbf5bE2rgzrCCrf8r1
    OhEhwKgw85zKu2/iPCSzx83gfsCrhcVywCnsljVkN6MZU4I6Wh6uMiJpcakllrVn
    6vjHrNvv0OSQitNFyQyZD7AW3dPP0TP6SaUQA1lPHkQClekyC4TQ1r4TTgdI5B7p
    n8bg4LkbpxSUGhprV2zohQ1blCbDkeg0z/WEHhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520117662; bh=0DQr0p
    Si01PxhAStt+38QvkA4iOHXsNnApnlF1lNrbI=; b=tcpXPODRwhBJvdckFs9bUO
    GyKdcexSapdlWWO04qq7j6hpmhybZ1SMEeUWd7BrpKS8pKk5Z0H5zP6WVWhFRRaJ
    +PHbUfg0FlYPj3665dmy//sBxr6QO436u5xq/uoc3sPmSWEhW1gvG3mB1xUxVpg7
    rhdYTKgYuAS/exbsnZ43jtuNb/XWGkntvCUGGvmAfmHmbQC1U21vvv9BPACcFeV6
    sZBb4OYzyhhMzxCSb133wA3sOc6wnWSOrCklaU/mPHvfGN2OYq/cMC9G0n82aY8j
    nLiHTtwEr+l2nVJvOwq7E02x8Wz7c2rSEtTJWZa8TcEmwciH+0mZ9HmwtwTRfjSA
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gnDW2wCA x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gnDW2wCA x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934033AbeCCWyF (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:54:05 -0500
Received: from mail-by2nam01on0095.outbound.protection.outlook.com ([104.47.34.95]:48488
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935398AbeCCWlE (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:41:04 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Brian King <brking@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 15/63] scsi: ipr: Fix missed EH wakeup
Thread-Topic: [PATCH AUTOSEL for 3.18 15/63] scsi: ipr: Fix missed EH wakeup
Thread-Index: AQHTsz+ghzMtJBc53kGZCx0fsqeepQ==
Date: Sat, 3 Mar 2018 22:33:17 +0000
Message-ID: <20180303223228.27323-15-alexander.levin@microsoft.com>
References: <20180303223228.27323-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223228.27323-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0940;6:ozzCNpW7D3XtQagDhqHcikWRMNp2NRiHa2emmNdh9tjxeRFyFjZa0Nvyys3wRccGtV+Ig9epo5DPZnl2kzBMtwVnA2yHwZ532JVuX5hVa48KsYHn4hKxedPpK5HYYDDXhmk2jJVbQ/Xuf4SXAPsBbECtYW+cpI4tOH9i5H83wjURxm/ZYtmyp3kHfhWgMrEv9gXjBz8DDGzdiHufUcTKR218WzGjBOuljFPX0dzMfZnMlfZs73/G03FuHNbg4yCaYnlUIeT5pZqfhDXRXolpYKf5h35d8XNIBMj9/F1veDSXQBpQMZTDJd+ROpUFsZzunH9+FehJwfr6WrD7XJXKGpjZE8B0TNx7NKuvFnmezMkjInIL3nhIaizVP6hjFRlF;5:02OGYud8u7F7T+S4r8LkjXar41xZ6C5YwfFuOybilGJAiw3eH4YBFS7S2MdBx0dor5b6QTsSIn8wDjoVlBIFzqdZFe+5xpXrxhmEBbLdYMFvrbR4aXCAlN47uVD32fs8plNhZ7BuU0tJVNmHK+18XbZCzNMEI2tVXPQ4rTjKhzM=;24:ac60h43JSpzWvhVn3wzOTeCTRXrvwQOg936jFcbyaSVDuGduWUuWhfwqvRlYdyoG92h+VYVMxcy06HCPv5R9y22086UYly5PeDpNA9zDpYU=;7:C590S9XRTHiMyvF7Eh9V4OT8rQakupZGFLPxli6afOTGx1YqKT0nJgkz5M40DOb3oQw1Bw533wfz+aPJfhMJtx7pt2HfsWW9X35lFG+uOnfIHaKVff3MLN7C185YO97GHsqJpa8zO6aZelAgmhh6RUoa0G5dbFgncR/3rvFoezzlJQGYSq6Sep/DgW64Ny6uwTsk2SscdZw22/g/HZLewSWEzVdAnp/FFdaV5g/kxkGXL9WdHbRRnv0qT55FBACR
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 34455db2-e814-4377-f7b1-08d58157d7ff
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB0940;
x-ms-traffictypediagnostic: MW2PR2101MB0940:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB094069E3A80C6503A42F26ADFBC40@MW2PR2101MB0940.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(104084551191319)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0940;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0940;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(346002)(366004)(39860400002)(396003)(199004)(189003)(106356001)(68736007)(6486002)(25786009)(22452003)(6436002)(186003)(2906002)(81156014)(81166006)(10090500001)(66066001)(8676002)(36756003)(6512007)(2900100001)(316002)(97736004)(59450400001)(102836004)(53936002)(6506007)(3280700002)(26005)(4326008)(5250100002)(305945005)(2501003)(76176011)(2950100002)(86362001)(99286004)(3846002)(72206003)(14454004)(3660700001)(478600001)(1076002)(5660300001)(10290500003)(6666003)(6116002)(7736002)(86612001)(107886003)(110136005)(54906003)(105586002)(8936002)(575784001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0940;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: tIIElJZTmggIs4b77WpDmlSRWcpi6loB+T1qECs5Iz8jqKOG3uA7PAn0T/0Kds0ahllNjEll1Z1t1ZCxpOSNTxydx8+jhS2oj9hrsfHiEUyzhxJyMXGPF3GSY+JPc/CIa/aYofRzdybeaUQSBmW+wCtcSy7JcLD5+uha5M6nURU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34455db2-e814-4377-f7b1-08d58157d7ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:33:17.6222
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0940
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Brian King <brking@linux.vnet.ibm.com>

[ Upstream commit 66a0d59cdd12546ddf01d229de28b07ccf6d637f ]

Following a command abort or device reset, ipr's EH handlers wait for
the commands getting aborted to get sent back from the adapter prior to
returning from the EH handler. This fixes up some cases where the
completion handler was not getting called, which would have resulted in
the EH thread waiting until it timed out, greatly extending EH time.

Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
Reviewed-by: Wendy Xiong <wenxiong@linux.vnet.ibm.com>
Tested-by: Wendy Xiong <wenxiong@linux.vnet.ibm.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/scsi/ipr.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/ipr.c b/drivers/scsi/ipr.c
index 105adb4cf6a8..54dfae5c8ee3 100644
--- a/drivers/scsi/ipr.c
+++ b/drivers/scsi/ipr.c
@@ -828,8 +828,10 @@ static void ipr_sata_eh_done(struct ipr_cmnd *ipr_cmd)
=20
 	qc->err_mask |=3D AC_ERR_OTHER;
 	sata_port->ioasa.status |=3D ATA_BUSY;
-	list_add_tail(&ipr_cmd->queue, &ipr_cmd->hrrq->hrrq_free_q);
 	ata_qc_complete(qc);
+	if (ipr_cmd->eh_comp)
+		complete(ipr_cmd->eh_comp);
+	list_add_tail(&ipr_cmd->queue, &ipr_cmd->hrrq->hrrq_free_q);
 }
=20
 /**
@@ -5830,8 +5832,10 @@ static void ipr_erp_done(struct ipr_cmnd *ipr_cmd)
 		res->in_erp =3D 0;
 	}
 	scsi_dma_unmap(ipr_cmd->scsi_cmd);
-	list_add_tail(&ipr_cmd->queue, &ipr_cmd->hrrq->hrrq_free_q);
 	scsi_cmd->scsi_done(scsi_cmd);
+	if (ipr_cmd->eh_comp)
+		complete(ipr_cmd->eh_comp);
+	list_add_tail(&ipr_cmd->queue, &ipr_cmd->hrrq->hrrq_free_q);
 }
=20
 /**
@@ -6214,8 +6218,10 @@ static void ipr_erp_start(struct ipr_ioa_cfg *ioa_cf=
g,
 	}
=20
 	scsi_dma_unmap(ipr_cmd->scsi_cmd);
-	list_add_tail(&ipr_cmd->queue, &ipr_cmd->hrrq->hrrq_free_q);
 	scsi_cmd->scsi_done(scsi_cmd);
+	if (ipr_cmd->eh_comp)
+		complete(ipr_cmd->eh_comp);
+	list_add_tail(&ipr_cmd->queue, &ipr_cmd->hrrq->hrrq_free_q);
 }
=20
 /**
@@ -6241,8 +6247,10 @@ static void ipr_scsi_done(struct ipr_cmnd *ipr_cmd)
 		scsi_dma_unmap(scsi_cmd);
=20
 		spin_lock_irqsave(ipr_cmd->hrrq->lock, lock_flags);
-		list_add_tail(&ipr_cmd->queue, &ipr_cmd->hrrq->hrrq_free_q);
 		scsi_cmd->scsi_done(scsi_cmd);
+		if (ipr_cmd->eh_comp)
+			complete(ipr_cmd->eh_comp);
+		list_add_tail(&ipr_cmd->queue, &ipr_cmd->hrrq->hrrq_free_q);
 		spin_unlock_irqrestore(ipr_cmd->hrrq->lock, lock_flags);
 	} else {
 		spin_lock_irqsave(ioa_cfg->host->host_lock, lock_flags);
--=20
2.14.1
