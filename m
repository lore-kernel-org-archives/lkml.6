Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1153505-1520117234-2-13538173068822907680
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
    t=1520117233; b=PDQj8V2XhEmXp0hFe+BipnNT5SQs5/24sieVueL7gwskaQr
    d2I2jcpxOZuItTdq3X1JzQ4fNacVD2pPSXknfNrGXBzr912qQ0B6XfyLraVe5kS9
    zzYKoQir+M7qp2xnRDHs7yRGMxLA9iyqshACXYHpx7iepKM4qhm8Pe3tl7lwm4GN
    FJTd8s+eeKVJbzVw1fgz7v7OCkXWBBx8IOF6Kz9nhRPqr3CpwICDFPXix3ZMdwOl
    4QD09GhdVR/QD5MjjZLw2kNIyeuj/MB4Py7D/wJMdPRsshMnn0lG+Sto/Mw8C3nq
    Pu8gPli/gI4LIdwPucFg7dqBU0mmOtOde0g+rJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520117233; bh=9MFZWV
    x8orA1RV+Drcvn/FY1H+hfgTbqra2EbJ7ztFg=; b=lSUQusIMiTanGIBPf9bUTN
    8oWExMajnlHqFcHikVWstPp/ptK5/edlEzKUUYoRESkgzeZmLjpGi5NaRcuuZDlF
    6vcIEznNdV9/4RRenEi+tvN3fUSn20CSNPIQ2ddLLSMxgGKzwvky8YHriXe6RYtq
    acPyC4vqP/CKIHX9TwVuCzg3wdleXIpHBv6apJePC0CMfwYg5nlB8V4Pdepy6XSR
    sAMMhGhpNb68hW1emkqrPfrwv0MTlwWTeh6W6rZfZ89UavQWC7RP3hP8eoj+dPgP
    PSBEItFmAdW5GVeh7VHfvz7yattGket4KmnwQR3BDtnGpMzUl0CF7XRR2gfNTsmA
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gcfJAaM4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gcfJAaM4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935556AbeCCWl4 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:41:56 -0500
Received: from mail-by2nam01on0129.outbound.protection.outlook.com ([104.47.34.129]:5824
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935112AbeCCWlv (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:41:51 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 42/63] scsi: sg: check for valid direction
 before starting the request
Thread-Topic: [PATCH AUTOSEL for 3.18 42/63] scsi: sg: check for valid
 direction before starting the request
Thread-Index: AQHTsz+qO9eJlzKSQEaAeGhRxsmTjg==
Date: Sat, 3 Mar 2018 22:33:35 +0000
Message-ID: <20180303223228.27323-42-alexander.levin@microsoft.com>
References: <20180303223228.27323-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223228.27323-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2SPR01MB06;7:/qI3g4rU/YYCuvGc3QdclD8ox6v0lgYMjXSHgkCPKazPiryoPolaJ5L1LQZhQbAvvlWYGKOl7bonaVxe0LPs1c7EO9dViwdnPxxlPt+NvlFbmHpJiKbKquZNyJwJFpPvdoMtFDpa1dvonzeXEDzOUXv1QzF0diFRiS4u34vByjvLlYEOus9Atgyd6b5jv4FgJL+/MeeklC/XlovVDUJeeaDAgL4cPk+SrUmhwCC93a7bCojDLIc6JJnm2ObHIJQo
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a4151d2d-020a-4e42-6fa5-08d58157f3e9
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2SPR01MB06;
x-ms-traffictypediagnostic: MW2SPR01MB06:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2SPR01MB0632706F61CA11142AD1FDFBC40@MW2SPR01MB06.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(153496737603132)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MW2SPR01MB06;BCL:0;PCL:0;RULEID:;SRVR:MW2SPR01MB06;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(39860400002)(39380400002)(366004)(376002)(189003)(199004)(3660700001)(575784001)(8936002)(72206003)(5660300001)(14454004)(110136005)(6512007)(4326008)(6506007)(26005)(2501003)(66066001)(86362001)(7736002)(54906003)(305945005)(25786009)(966005)(6306002)(10290500003)(53936002)(6436002)(2906002)(81156014)(59450400001)(8676002)(478600001)(102836004)(106356001)(316002)(186003)(5250100002)(81166006)(6486002)(76176011)(86612001)(6666003)(2900100001)(3846002)(68736007)(97736004)(36756003)(1076002)(107886003)(2950100002)(105586002)(99286004)(6116002)(3280700002)(22452003)(10090500001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2SPR01MB06;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: lqhFKAbuhynwEbpWNoQEP2WppuW2UyQHVK97rWNbw6F/mtVuVsCLxZLGZvAr3uQzv+JW9goSkiIgpodq2XPYTVf9KW41xvnZ0YQrnI8/LzLRdQOXEOUMiczvftlKGBmLpOVujCOM29OB9xaLJGOnXo38CNH2gm6Ltt10WqebYFY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4151d2d-020a-4e42-6fa5-08d58157f3e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:33:35.7634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2SPR01MB06
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
index 783040af3ead..bba2dcd4f324 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -674,18 +674,14 @@ sg_write(struct file *filp, const char __user *buf, s=
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
@@ -764,6 +760,29 @@ sg_new_write(Sg_fd *sfp, struct file *file, const char=
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
@@ -784,6 +803,9 @@ sg_common_write(Sg_fd * sfp, Sg_request * srp,
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
