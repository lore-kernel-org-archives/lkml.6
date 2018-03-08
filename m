Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1086562-1520489300-3-4361269721340534752
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
    t=1520489300; b=aIlnjPTAIgpGcxPIP6g9W7eLJSJMLVXNzC4ir9rOpqHozez
    Q0DH00yu0JTOMAAndOMAndzl7qwdr1OOF1opUnx18nkr3wA9VkOhlXPFpgWJFTw2
    6yvxPLJf4t/+fdj4CBVowsKCjIVO4J7VPq0Avu8F97e5a2NW0h+zVdcJIi+2d+nt
    QqWoLajJmj5mZeWgxzUeh23sS9ftD7BP95i4ytCdCDfVEIi7dSzSSqKOza05M5f6
    6OV9+Nh+4WDIXgeBOBeKHAlhH3Z9Z1N/lgg7f1jFJyPT7nZ7TVDxe2FBjxOjmyqs
    PRVik7+idwBYJ5D7ocMecJmTPLA89WRD7aUudHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520489300; bh=zhXSCF
    4qtTs9gASuccV5S/qovRwMHT+kTn6V2nHHEWI=; b=qsLZIflEimKmcCPPvuO/76
    l7GLc6E0ISD8bceco9prr+c7lNwktzLAhu0x1pseLvhbe4crtlz3uCiPkcRZblmp
    ifBFcFXEeq+zYj4iIu0Bzy8SmPaMXuB6Vk9q9KGJi0eSpmBhSNwGkBqVkNWRg+uy
    NV0KGEiuEu5FGsOGPviscvU11uE+95Cy6Dw6pw1pBRIiCvb7Ab1PTPUfHduL6u/M
    B1+DNr72duk3jU8R+0dQ2AwrzMAj/8bcTcdUpD7vyYOpBunTRBbrTQaFSoKbzNMQ
    OxFqHMgDx6prNf+284y3m2KyP0igpmjEje9s3KXwiGt4X5EgNQwUsaroy8l1oMOA
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=nIWeNlW4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=nIWeNlW4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755279AbeCHGHs (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:07:48 -0500
Received: from mail-bl2nam02on0104.outbound.protection.outlook.com ([104.47.38.104]:33440
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965806AbeCHFCQ (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:02:16 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@fb.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 102/190] mtip32xx: use runtime tag to
 initialize command header
Thread-Topic: [PATCH AUTOSEL for 4.9 102/190] mtip32xx: use runtime tag to
 initialize command header
Thread-Index: AQHTtppBX+INSK0Xx0G/7p6XNXfInQ==
Date: Thu, 8 Mar 2018 04:59:36 +0000
Message-ID: <20180308045810.8041-102-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0997;20:dglxll5pANb9ACaE3F/M/+G97sXmUYGHKZYmsbftujgjYuNK2U/ELy8xyw6BxuP6QrKnNRYXpiZei+CUqckNzcNrvGPTM0/CL3xJd9o80+MStzqwltop2MsdrrEgF6BVhWmQSZ7sVEkaYXhDAFS173qxw4M0aybuNrcgUrjatxo=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0ef1a81f-0445-4958-863e-08d584b1c078
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0997;
x-ms-traffictypediagnostic: DM5PR2101MB0997:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09978976D3CE78874E421C35FBDF0@DM5PR2101MB0997.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(67672495146484);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0997;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0997;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(39860400002)(376002)(366004)(346002)(189003)(199004)(97736004)(54906003)(76176011)(2900100001)(106356001)(99286004)(110136005)(316002)(3280700002)(22452003)(10290500003)(105586002)(36756003)(25786009)(72206003)(66066001)(3846002)(6116002)(3660700001)(4326008)(14454004)(1076002)(478600001)(2906002)(10090500001)(5250100002)(6486002)(86362001)(5660300001)(186003)(305945005)(8936002)(81166006)(2501003)(26005)(2950100002)(107886003)(81156014)(6512007)(86612001)(6666003)(8676002)(102836004)(6506007)(53936002)(59450400001)(68736007)(7736002)(6436002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0997;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: c7aCujUg6cYV7fBaiWru2eNyZMXDd6fHD1Zsx/GszrlJhQ5aXro1lI/EoascC/KaVKIG7DM7phlTBM6fcT9xUP9uTxh4iE8vE1MzeHsds7zgHsF7Ary20IFuLgoF/IIsHnG95R5LBLmtRaHlru3Zh6EydE3ovk4gWi5jSlOvGSyHQ5/AeVwhOySzIWPFuLgRailsWHLPcmiCF4nIaT7vCbu5WMSALvID6s+JATr3lynDjhUqBRIv5DcK3y3fm9nqAVSE1ELHwRNm0UAD1CSaMngp5QvQ103Y8nTCVO9QN19rBkKgWMsl4Qo1Jih7Qs5k1fFz3b0EgPxfJnaFF1OuRQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ef1a81f-0445-4958-863e-08d584b1c078
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:36.3116
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0997
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Ming Lei <ming.lei@redhat.com>

[ Upstream commit a4e84aae8139aca9fbfbced1f45c51ca81b57488 ]

mtip32xx supposes that 'request_idx' passed to .init_request()
is tag of the request, and use that as request's tag to initialize
command header.

After MQ IO scheduler is in, request tag assigned isn't same with
the request index anymore, so cause strange hardware failure on
mtip32xx, even whole system panic is triggered.

This patch fixes the issue by initializing command header via
request's real tag.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Jens Axboe <axboe@fb.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/block/mtip32xx/mtip32xx.c | 36 ++++++++++++++++++++++++-----------=
-
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mti=
p32xx.c
index 3cfd879267b2..b86273fdf48e 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -169,6 +169,25 @@ static bool mtip_check_surprise_removal(struct pci_dev=
 *pdev)
 	return false; /* device present */
 }
=20
+/* we have to use runtime tag to setup command header */
+static void mtip_init_cmd_header(struct request *rq)
+{
+	struct driver_data *dd =3D rq->q->queuedata;
+	struct mtip_cmd *cmd =3D blk_mq_rq_to_pdu(rq);
+	u32 host_cap_64 =3D readl(dd->mmio + HOST_CAP) & HOST_CAP_64;
+
+	/* Point the command headers at the command tables. */
+	cmd->command_header =3D dd->port->command_list +
+				(sizeof(struct mtip_cmd_hdr) * rq->tag);
+	cmd->command_header_dma =3D dd->port->command_list_dma +
+				(sizeof(struct mtip_cmd_hdr) * rq->tag);
+
+	if (host_cap_64)
+		cmd->command_header->ctbau =3D __force_bit2int cpu_to_le32((cmd->command=
_dma >> 16) >> 16);
+
+	cmd->command_header->ctba =3D __force_bit2int cpu_to_le32(cmd->command_dm=
a & 0xFFFFFFFF);
+}
+
 static struct mtip_cmd *mtip_get_int_command(struct driver_data *dd)
 {
 	struct request *rq;
@@ -180,6 +199,9 @@ static struct mtip_cmd *mtip_get_int_command(struct dri=
ver_data *dd)
 	if (IS_ERR(rq))
 		return NULL;
=20
+	/* Internal cmd isn't submitted via .queue_rq */
+	mtip_init_cmd_header(rq);
+
 	return blk_mq_rq_to_pdu(rq);
 }
=20
@@ -3811,6 +3833,8 @@ static int mtip_queue_rq(struct blk_mq_hw_ctx *hctx,
 	struct request *rq =3D bd->rq;
 	int ret;
=20
+	mtip_init_cmd_header(rq);
+
 	if (unlikely(mtip_check_unal_depth(hctx, rq)))
 		return BLK_MQ_RQ_QUEUE_BUSY;
=20
@@ -3842,7 +3866,6 @@ static int mtip_init_cmd(void *data, struct request *=
rq, unsigned int hctx_idx,
 {
 	struct driver_data *dd =3D data;
 	struct mtip_cmd *cmd =3D blk_mq_rq_to_pdu(rq);
-	u32 host_cap_64 =3D readl(dd->mmio + HOST_CAP) & HOST_CAP_64;
=20
 	/*
 	 * For flush requests, request_idx starts at the end of the
@@ -3859,17 +3882,6 @@ static int mtip_init_cmd(void *data, struct request =
*rq, unsigned int hctx_idx,
=20
 	memset(cmd->command, 0, CMD_DMA_ALLOC_SZ);
=20
-	/* Point the command headers at the command tables. */
-	cmd->command_header =3D dd->port->command_list +
-				(sizeof(struct mtip_cmd_hdr) * request_idx);
-	cmd->command_header_dma =3D dd->port->command_list_dma +
-				(sizeof(struct mtip_cmd_hdr) * request_idx);
-
-	if (host_cap_64)
-		cmd->command_header->ctbau =3D __force_bit2int cpu_to_le32((cmd->command=
_dma >> 16) >> 16);
-
-	cmd->command_header->ctba =3D __force_bit2int cpu_to_le32(cmd->command_dm=
a & 0xFFFFFFFF);
-
 	sg_init_table(cmd->sg, MTIP_MAX_SG);
 	return 0;
 }
--=20
2.14.1
