Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1310899-1520121482-2-17113915408996299790
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
    t=1520121481; b=neVhHnU8HyPxckO87MgT3kONAK5/rUC1SmL0XjD7tqEUTqc
    TE/MtkDjvjYuMWfxLV/buHX0PG4EYlm8qIvolQTGvdvWuL/rzto2bFO88Ql4bE4d
    ffcAOcDuiKI22bw9vOZNXp5uAx7njvBlnnJgs9jHCCX2qPJSHyCxJFFq+lBExd6E
    wZ7+2kWV60OdfXGn9EB2MYO/vom49ESaxgUpdwprzjwzCU6/VCuM+tHSaz2L4EeT
    syqqz1YseHfHOq4SurfBMQuAfS/Fl2hmgWL5Jnx29v88BiyeXpdYaL3n3F+4eZgW
    LPfLEQE5+NRrwRAsIiUSmqBh4gWB7XyeMp4/hCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520121481; bh=oSuWvp
    m5ZYdRcDhLTvuR2aP4iipixl/Gv92AXLumpi0=; b=nW2Ejg7y1BkSS5KAhEJTbZ
    0FX7rZ0GvJZheF+3oY/hjZKXL4nBsN2wzBWQnoooG9MuqcseqjXlRcD5ApvvuV8Z
    q9pu71Rcn0vpeBxij74j0VP3XPAI38O5noSpeimjJWk1K8sdL2xwowoykO/sU+Cg
    gkqtTd5Dm38iCf5QKnwoqOnxHAs84JyrvzWQ6xqkYZYSpc7PioGl9CZoXjENtZ/N
    esN7zGwLkOpOwEyrI9lVirV7XI5LvR+LBUGiEQMc0Ioyspp/x+DgVXlmpOxtuDn0
    9evullYkBfEq8zHbLQgFYlm5eTbrDx4VojP8OLTOu9SvyK8rnNKaUn8AIrhlSVLQ
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=DIc7MpWC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=DIc7MpWC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751554AbeCCX5p (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:57:45 -0500
Received: from mail-by2nam01on0120.outbound.protection.outlook.com ([104.47.34.120]:24496
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932971AbeCCWcY (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:32:24 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Brian King <brking@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 056/219] scsi: ipr: Fix missed EH wakeup
Thread-Topic: [PATCH AUTOSEL for 4.9 056/219] scsi: ipr: Fix missed EH wakeup
Thread-Index: AQHTsz70aMWeXPdQUUK+WxDCg0JqUQ==
Date: Sat, 3 Mar 2018 22:28:28 +0000
Message-ID: <20180303222716.26640-56-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1036;7:Z4KSPx+OMxPObRfssLXTlRlptRcXlI+0bmbztK87KRQ39nwdy5wFjSPRm/6/glrppOSkSVCNXEjVTWlJhIDR2gu/5vKcuG97cFYPW3rlvIFXogLHsscUGdQG9LvzxlheSoHI8fgX2Hmxww4TEqep16NbA18QSHnFnXqSH1OJ1n8XnT0rGv8YJnLnErGF5asPuKtNNzLhb7MqwXReY81sv/28uOR3+VPM47IIO28XwCCWRveGV2gHJgnLw1g87AWJ
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b36ceb33-08c6-4df3-da39-08d581569e38
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1036;
x-ms-traffictypediagnostic: MW2PR2101MB1036:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB103670FA58997EA661048ACBFBC40@MW2PR2101MB1036.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(104084551191319)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1036;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1036;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39380400002)(346002)(376002)(39860400002)(199004)(189003)(10290500003)(81166006)(5660300001)(107886003)(8936002)(81156014)(3846002)(6506007)(2906002)(8676002)(3280700002)(59450400001)(72206003)(76176011)(4326008)(478600001)(6116002)(6486002)(53936002)(1076002)(68736007)(6512007)(102836004)(2501003)(66066001)(3660700001)(5250100002)(6436002)(105586002)(86612001)(36756003)(316002)(7736002)(97736004)(26005)(186003)(110136005)(305945005)(22452003)(575784001)(86362001)(99286004)(6666003)(25786009)(106356001)(2900100001)(14454004)(54906003)(10090500001)(2950100002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1036;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: 44fyr1qNI7s2q1/AebSLU2FIBDrKl5ez0yp9h/CTE8MmUcsMrooxeHQe1YPRKJkzGT84++jfaOIsUGPgdftFG26PL6UWhnuOZZzPXQiIUHLIhOVdToy6R4pUoywjsLUCK70wG/A3+bnNeAL9FTDXVg6rm7v7ieh6Zl8qcFTCQnA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b36ceb33-08c6-4df3-da39-08d581569e38
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:28.8694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1036
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
index 532474109624..c5bc41d97f84 100644
--- a/drivers/scsi/ipr.c
+++ b/drivers/scsi/ipr.c
@@ -836,8 +836,10 @@ static void ipr_sata_eh_done(struct ipr_cmnd *ipr_cmd)
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
@@ -5947,8 +5949,10 @@ static void ipr_erp_done(struct ipr_cmnd *ipr_cmd)
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
@@ -6338,8 +6342,10 @@ static void ipr_erp_start(struct ipr_ioa_cfg *ioa_cf=
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
@@ -6365,8 +6371,10 @@ static void ipr_scsi_done(struct ipr_cmnd *ipr_cmd)
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
