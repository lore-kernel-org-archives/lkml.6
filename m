Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1145125-1520116712-2-14294357508744875847
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
    t=1520116711; b=XkDs89LeQEGsSLJhGow36GRGJwvDMv1HzX9OsiQVjI/rm5Y
    XfC0BsIakh79WzRuXSpv8c/NftFoCFh2RlPLR1sCdp85+XO2NxEgFdyLidDg7e6r
    m6HeF/SktfKMbHP73lulgjF5uu+e3CQZIuC11KloimtkigRAAic0McG+GUbLTK/k
    YXVMavfCt3L9geGhH/IcgAceby5hi+N2upVwSVDSl7doZuCJRmyjietalHzp2fDi
    Hg1wzmshYW094IPPu38h1JbZqNm8FVS6pphvpYYBIVZiJ4+lcZAx1D38AiKI4CUS
    XldUFUK1HeWyPCPr9lKYKKEo7IwVFe1hYqDID6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520116711; bh=FaDV+L
    QQlRSHyhTIn0803pXS+THFsAMjzSlBUqv/jR8=; b=O+NwHhs2p/nNjSfVgTT7Gr
    yglqsWUoSsuATWPuOv+eKT4fKtUOir2ml5Rv3D5dFp7RGxGpUZnUHIEc96QjiFMr
    iPALxlzEcgzRu4LC6eJoOCzeg0cfCwNQWpExLtNDEh42wfJue4bLyDB592lcB5jZ
    s4Xks7FlbrbF5OAYO+uw7LjyzFx5rvYZyZtFy4Jgv3x2eiZTbBbI+Mr/DFj5+zld
    mSR60x+0BRCE3aTzSN05G3mpaOriKgAKzLPe6YZO/Q71eO4hSsq+95VEeMnchmHy
    7uRQ/3Gk1gNQAInaSiQ1O08ivkGFubJQhlt/HMSr3VQb5/zBNmZQ4GyyEltuct2g
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=L5WgjRPc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=L5WgjRPc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934562AbeCCWiQ (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:38:16 -0500
Received: from mail-cys01nam02on0126.outbound.protection.outlook.com ([104.47.37.126]:19904
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934912AbeCCWiO (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:38:14 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Brian King <brking@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 025/115] scsi: ipr: Fix missed EH wakeup
Thread-Topic: [PATCH AUTOSEL for 4.4 025/115] scsi: ipr: Fix missed EH wakeup
Thread-Index: AQHTsz9QSFGSm38NOE+Cs8IB3SXSYg==
Date: Sat, 3 Mar 2018 22:31:03 +0000
Message-ID: <20180303223010.27106-25-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1067;6:0vckpzWXYfq12oR6MyH3OjP0BzPIgLU5T9mYdKy8jvWDqY85LktlRX3biKHg8TjGH+Ik3D10d4VHPzB887GdL8tvigsFOf0sN1c5jkyJeyrEoFxMAINPh7NCAENNWASo4Eq2xOJHSw6St6+o1oQzENxs3Z16IaAh9DIQXiPl3I4LSD9FbQSL+gUaxZzgD9S+Q3sqw77+prW+3sIi8BTQosrgOLwqRgiwUrljtDtEER2Vrgz7UWFRD8UxjJKaXkNo8PcdR5pqFylg+H3GNPVugKmme9OBDKace+9SNB3e6MiR+rItCl3s5VaMpN7vaVGp7kwfgQ9u3mMhjmkArsWk8L4eIvub3bVjOd8q11M3aaUnGNE3Tq0kfWkxkZtSu42N;5:ymcZZmu73uTFT9qkZ5lS0PTd9wi0keOVjnXaDrrP9ViXnQfYf1IdDXEOvwjSyqQnZaZI3x+T0j0AlBQpmTnRZpZYHQ0W7Mkals/ovFpP3nXGShZduLls+FHt/NYreNloHeKVshvXdcOwIb19281L3F6an4azXOb3QzcV1Z1v2dk=;24:VeXKcUS/HiZbHjB5iYm1KNGtYwtChI5l/QiFzomcbGUh37B13ve3zbyLFwgw8ZCw7XSEHmzUaZmoYTfJ20cG9pthyYgHUO2n9JB9nDHBLFA=;7:q19IVRT4XfS6v140unmc45zDJ6F9UwuGvfdhlAs4LF2mDKY1WQ7wAk8GpQFC+C8hQSpQ0W5W5AFf1+0Qdbk/p3vKL59mbgw1ZVWZ+v81v+5nRJ2ECle//+QImjVjAucWHv7zFvEWm2YbSGHtWzDw8AAkTp4pQfKxyKRqJ23LvNiEZKwPIC97Poqtw6J8FIycL6BF2gkvFPF0m2crk0vuLG/Ck3bW+dyC0qeZ7dYePDoHav1gbBuVgr7a+yv0uhSR
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: eb269922-d9d8-4d09-4ea4-08d581577055
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1067;
x-ms-traffictypediagnostic: MW2PR2101MB1067:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB10677C518A6F585EF9353049FBC40@MW2PR2101MB1067.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(104084551191319)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3231220)(944501244)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB1067;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1067;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(376002)(39860400002)(39380400002)(346002)(199004)(189003)(4326008)(5250100002)(86362001)(1076002)(2501003)(110136005)(6666003)(81156014)(2906002)(8936002)(305945005)(81166006)(2950100002)(7736002)(10290500003)(26005)(186003)(3660700001)(478600001)(72206003)(107886003)(8676002)(3280700002)(59450400001)(2900100001)(76176011)(6116002)(25786009)(3846002)(102836004)(575784001)(6506007)(5660300001)(97736004)(10090500001)(86612001)(106356001)(99286004)(6512007)(66066001)(316002)(53936002)(14454004)(105586002)(36756003)(6486002)(54906003)(6436002)(68736007)(22452003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1067;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: jKEynhYoOHDdWHfg2eAHYd0vArbtKfspBHp1OmfffWiP4ErXwm1djG/ZmDWBqQUiB53+8Bbqbp59leekYlC+egIN7MdYIAmObRWh9EVuc/WY+4nkUTJqwQVsejO0kY2aeIwJ0YImmflGRvDjR2Dx90zOMw/f/CU+V53t41S5/po=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb269922-d9d8-4d09-4ea4-08d581577055
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:31:03.3071
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1067
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
index 7a58128a0000..2f61d8cd5882 100644
--- a/drivers/scsi/ipr.c
+++ b/drivers/scsi/ipr.c
@@ -835,8 +835,10 @@ static void ipr_sata_eh_done(struct ipr_cmnd *ipr_cmd)
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
@@ -5864,8 +5866,10 @@ static void ipr_erp_done(struct ipr_cmnd *ipr_cmd)
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
@@ -6255,8 +6259,10 @@ static void ipr_erp_start(struct ipr_ioa_cfg *ioa_cf=
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
@@ -6282,8 +6288,10 @@ static void ipr_scsi_done(struct ipr_cmnd *ipr_cmd)
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
