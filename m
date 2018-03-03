Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1254417-1520120140-2-10873696771728915672
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
    t=1520120139; b=mfus4rApnrfIZ3DHZYrE0l/3wBVvpbzh7BsN5jQyuZ2d0sZ
    JbEU7rg1rGHzEH2Km77wU5K8KtGm46jIng1fyxN+rxyqd50y/R2gj3UJe8usagTe
    B44ULH2P2ok3pBHaiVDtEvDIdkELmCgpZ+hYR71Xz8vXI+T6kmQEeDX3lgYpwHs7
    YPSJJGP/Y/CPFzKtrEFlcRbutCKwCn0s/o9llKoperCKg41qtcAWT4yLkztnhATE
    euMb2TDcR2+2n0K3Sx3tWcWvpKkcP4+Trfs4kNr+eHjpxcsGf4GyNHH5VEtNgSPN
    LntQMPd5UNEgUwXd/l3QsX0eo7yVN5Th5EqOTbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520120139; bh=39/Gbw
    HUt23t9BhaEjrHVJ+zPBha8pGGyHl4jCn/cBw=; b=Uc+8iLL2rmdZiDuphLSyL5
    B8S3cKSCUApHf4tdtUliZ9dfAI8xXH1KtmvNZLPcwZGvyXlkixyTZ5tJBRa/k08p
    B93gof0w3zmTTtcJTM7VGDXGxKxOV8iTezF/oyvZYmXhLRK1R1VvOdISTHM05RU0
    g8v7CVgz5KgIO95DRReELLqEhYTpspJFGwsqmIjv9+RHRbg3w/Xr0YSegpLovD5V
    DDffoOcEoXQrtrlRRadwPSEm6zYWjSRAzRSz/cULVxrN/A2n6F5+p+93gDHGh0nf
    HdOUdiP2QTSE/vHVJ+yT0JFKw8eAg//xnHlgPS0szvGjoMRovdQEHl7vz/0RchRw
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=L+r7ouNy x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=L+r7ouNy x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934448AbeCCWfy (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:35:54 -0500
Received: from mail-bn3nam01on0133.outbound.protection.outlook.com ([104.47.33.133]:8222
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934433AbeCCWfv (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:35:51 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 156/219] scsi: sg: check for valid direction
 before starting the request
Thread-Topic: [PATCH AUTOSEL for 4.9 156/219] scsi: sg: check for valid
 direction before starting the request
Thread-Index: AQHTsz8XQ4UxKZ4ItEiezym3Kc81Fw==
Date: Sat, 3 Mar 2018 22:29:27 +0000
Message-ID: <20180303222716.26640-156-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1034;7:KqB4eOcLq1cxchJGcGHmonf+RiCT9bYuu981AFEU2HaVwJuZiHJoRfF0WmQPoJ6O/0E8NzoFTTeKBv3p/vtwhSA27KEirtL5jJhXJXDuPNpzL7sjSifsdOgQEnSEvln7rw4FrMiTlORWbXXw4utuXVYZ2zVVuxzVAdZONE8Jt5CZMqAHV5uQ4tJNjHklY9sSPqyxigTtxt/EZ80QB3v0wCgELeGhERrTK6BsLDPKhUg5RjXq0VqOkIK4jH2PKWqq
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a534d2f4-9a86-420f-2d02-08d5815718e6
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1034;
x-ms-traffictypediagnostic: MW2PR2101MB1034:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1034754FF3F5CEEB298AB3CDFBC40@MW2PR2101MB1034.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(153496737603132)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:MW2PR2101MB1034;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1034;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39860400002)(39380400002)(366004)(396003)(199004)(189003)(99286004)(22452003)(72206003)(316002)(3846002)(6116002)(186003)(26005)(478600001)(76176011)(54906003)(110136005)(102836004)(97736004)(1076002)(2501003)(966005)(3660700001)(66066001)(5250100002)(5660300001)(86362001)(10090500001)(10290500003)(86612001)(6506007)(68736007)(575784001)(106356001)(25786009)(8676002)(4326008)(59450400001)(6512007)(305945005)(2906002)(14454004)(107886003)(8936002)(7736002)(81166006)(3280700002)(53936002)(105586002)(81156014)(6666003)(6486002)(6306002)(36756003)(2900100001)(6436002)(2950100002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1034;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: 9oXk+QJGDMWi1qrXgmCRJilNSpuPNaKZuXaBY5B1o3D1FGDD/Njbtio2KcqNnCUIzuQyUcnrJeB/+26Bvu2Z7kw1+EpoPY5PlyS9d1IYA1iuxrDVtXDYINn/ZAkFbJe0u8fLdicg5BLNAdGspSJ6WIf1w8tYexWpEzNjGXDOnPw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a534d2f4-9a86-420f-2d02-08d5815718e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:29:27.5101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1034
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Johannes Thumshirn <jthumshirn@suse.de>

[ Upstream commit 28676d869bbb5257b5f14c0c95ad3af3a7019dd5 ]

Check for a valid direction before starting the request, otherwise we
risk running into an assertion in the scsi midlayer checking for valid
requests.

[mkp: fixed typo]

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
Link: http://www.spinics.net/lists/linux-scsi/msg104400.html
Reported-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Hannes Reinecke <hare@suse.com>
Tested-by: Johannes Thumshirn <jthumshirn@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/scsi/sg.c | 46 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 34 insertions(+), 12 deletions(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index cd9537ddc19f..6b6064dc3467 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -663,18 +663,14 @@ sg_write(struct file *filp, const char __user *buf, s=
ize_t count, loff_t * ppos)
 	 * is a non-zero input_size, so emit a warning.
 	 */
 	if (hp->dxfer_direction =3D=3D SG_DXFER_TO_FROM_DEV) {
-		static char cmd[TASK_COMM_LEN];
-		if (strcmp(current->comm, cmd)) {
-			printk_ratelimited(KERN_WARNING
-					   "sg_write: data in/out %d/%d bytes "
-					   "for SCSI command 0x%x-- guessing "
-					   "data in;\n   program %s not setting "
-					   "count and/or reply_len properly\n",
-					   old_hdr.reply_len - (int)SZ_SG_HEADER,
-					   input_size, (unsigned int) cmnd[0],
-					   current->comm);
-			strcpy(cmd, current->comm);
-		}
+		printk_ratelimited(KERN_WARNING
+				   "sg_write: data in/out %d/%d bytes "
+				   "for SCSI command 0x%x-- guessing "
+				   "data in;\n   program %s not setting "
+				   "count and/or reply_len properly\n",
+				   old_hdr.reply_len - (int)SZ_SG_HEADER,
+				   input_size, (unsigned int) cmnd[0],
+				   current->comm);
 	}
 	k =3D sg_common_write(sfp, srp, cmnd, sfp->timeout, blocking);
 	return (k < 0) ? k : count;
@@ -753,6 +749,29 @@ sg_new_write(Sg_fd *sfp, struct file *file, const char=
 __user *buf,
 	return count;
 }
=20
+static bool sg_is_valid_dxfer(sg_io_hdr_t *hp)
+{
+	switch (hp->dxfer_direction) {
+	case SG_DXFER_NONE:
+		if (hp->dxferp || hp->dxfer_len > 0)
+			return false;
+		return true;
+	case SG_DXFER_TO_DEV:
+	case SG_DXFER_FROM_DEV:
+	case SG_DXFER_TO_FROM_DEV:
+		if (!hp->dxferp || hp->dxfer_len =3D=3D 0)
+			return false;
+		return true;
+	case SG_DXFER_UNKNOWN:
+		if ((!hp->dxferp && hp->dxfer_len) ||
+		    (hp->dxferp && hp->dxfer_len =3D=3D 0))
+			return false;
+		return true;
+	default:
+		return false;
+	}
+}
+
 static int
 sg_common_write(Sg_fd * sfp, Sg_request * srp,
 		unsigned char *cmnd, int timeout, int blocking)
@@ -773,6 +792,9 @@ sg_common_write(Sg_fd * sfp, Sg_request * srp,
 			"sg_common_write:  scsi opcode=3D0x%02x, cmd_size=3D%d\n",
 			(int) cmnd[0], (int) hp->cmd_len));
=20
+	if (!sg_is_valid_dxfer(hp))
+		return -EINVAL;
+
 	k =3D sg_start_req(srp, cmnd);
 	if (k) {
 		SCSI_LOG_TIMEOUT(1, sg_printk(KERN_INFO, sfp->parentdp,
--=20
2.14.1
