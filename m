Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-966195-1520486448-2-7773224906846420728
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
    t=1520486447; b=Y5tcSM+bKousNVqQdlD0nEGlnXUi7Ro9+I0beqaJTP703uo
    LAhf73Qvyi7HEUhe19bJsP9XgZPi1Wx2EjofKlvdDGvJy3gaAFdpUxL/UYT6X8oT
    IMhaRa67tADOEZkkF3pz9ILMuaEmlCgUOCLYxTrqNwxEnO588Irapx1tUMw1QN4i
    aiSc9ORHOL4lZCPSeTy34+x/TsisWpG6mqYOaOgIbgD19pj0ewWgyjrQqLc4pIk3
    GzBSOncgfEBz+dP+KOQPOiVXaq/qQw082fvPwSm2LeieUp1akwRbKFhI3xSaUoUx
    f4k2EzC9b3NjczpBro9DECev8eu9nZ7rSVdtUqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520486447; bh=9MFZWV
    x8orA1RV+Drcvn/FY1H+hfgTbqra2EbJ7ztFg=; b=bRG5tYt8RXfYOPl3JehKB9
    WxWuuKZpJP7kogpQeggLLqCPepv3LdwULsHuIAGmBBtTasFUxkVXKCuLfJYLU8y+
    /dwMp/RaNsd0mkwkH1F6PokXVNyFmtIgv58CJvZphAmvoxcRYgHkMqACdShIFMiH
    SpskbzH2Ed7pp4TlVHFdlFgJkWm/WsfwTEhNomfgWUNwgfi6kxukROLto1cNqAdO
    R7T8WaTDo/aexhmydqmt4TZy6AgXiFKBqRJziSgWLevSHYvgLOYh5EAORQBsgPzm
    F36FXQtMRHuVKctA7JSwlXTZBPi6BnBr501Ho+hzPhoyRD1LFwypYk2j09bK9KEQ
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hNVR4E37 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hNVR4E37 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966463AbeCHFUn (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:20:43 -0500
Received: from mail-bl2nam02on0095.outbound.protection.outlook.com ([104.47.38.95]:56636
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966702AbeCHFIH (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:08:07 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 03/53] scsi: sg: check for valid direction
 before starting the request
Thread-Topic: [PATCH AUTOSEL for 3.18 03/53] scsi: sg: check for valid
 direction before starting the request
Thread-Index: AQHTtpq+/uDYKXuEykScvESrcn78rQ==
Date: Thu, 8 Mar 2018 05:03:06 +0000
Message-ID: <20180308050230.8876-3-alexander.levin@microsoft.com>
References: <20180308050230.8876-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050230.8876-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0727;7:73DGXxzfPpWGeXpGQi5k19eBZxLfV6YkUxZr5MemnwWlDDzyIuwD350alwPf6U6PtwqdiE8NmHkk3IrMH/cK8axIGMi5Z4DyiqXid7Fyv/93Zw5rqBc0r7lEIX5CbS6zUTFnYH8XSSmfUayKM816tIBrvUBa0hgrP8N85oZ0S8RQyvMqObxHVEfv9auI2rKXK3CDQI8pCxb8VX1GntbsOyq0L2QNc/BYS7TK8RxcTvZNGp1pn0O9DzKCe/mC1CQ7;20:a92crrqPrKywVXGBl/QxeQzERBRtIr8SPeA51+L6sbNkzQ+6tEbAklNUStwHsUmc0ipMZBCHY16HNcwBXwmWKEjCa2nA3yqc5DxTWWaKullOEwmeD4YVjPWSMRfuOiTDb6sJKzvkgDjmcKsCGbh2t6UY1qFV8UKKtKA9yT0Iuw8=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ffb7aa1e-b647-4161-1aae-08d584b290f4
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0727;
x-ms-traffictypediagnostic: DM5PR2101MB0727:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0727920DD71DF0660EF4D79BFBDF0@DM5PR2101MB0727.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(153496737603132)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0727;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0727;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(396003)(366004)(376002)(346002)(199004)(189003)(81156014)(4326008)(97736004)(105586002)(2906002)(8676002)(26005)(10290500003)(76176011)(186003)(110136005)(22452003)(7736002)(54906003)(25786009)(2950100002)(3280700002)(305945005)(81166006)(2900100001)(8936002)(59450400001)(102836004)(6506007)(68736007)(106356001)(10090500001)(1076002)(6512007)(86362001)(3846002)(2501003)(14454004)(478600001)(99286004)(575784001)(72206003)(6116002)(3660700001)(6306002)(5250100002)(53936002)(107886003)(6436002)(966005)(5660300001)(316002)(6486002)(36756003)(86612001)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0727;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: 1JVYyXQeKFw7/eEIkt03tZqv0mbpZx+fcQxM5UboN4znEHVEoGPaJcLLVs3URauW9c4Y12YPGBP7ns/qNebOK/c5YOIE5kuFqm81Af/WtjoJOZHIw7tev/s6h/0ey7jrUfQn8c5ehMnKtluHMU4Vxh4/0NSIAfyV8zM9LqLOWB68Lw9w9LchGc5V5poaRCzw4mtloCsi4tdSGNvd3W2yri6V3znGGnmHyviW+858GsC7iG0T+2/Hyrom3fn5yw7PUQOOqgMd2R8K3S4tLZdMCvxb15u1lpT97NzloDO/Cw4N0IOUmLnjypBLiGM9w0oulcGhJibpAQj3Q6PnFZqn4w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffb7aa1e-b647-4161-1aae-08d584b290f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:03:06.4144
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0727
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
