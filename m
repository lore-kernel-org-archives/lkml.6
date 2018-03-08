Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-981117-1520487094-2-3775313547859096345
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
    t=1520487093; b=oXlqRms91XTsClXFD+8Mlh3cUd+qr7QSUDfN0hP6Gl/XE0+
    fajO8c2WR5jeEeQyr8dVgMX2388MoaF5SMEUDxm/jUgxwDw/dXFmTSsqanMxilkl
    33mr5RSnhPlus0ckFd+3TPaN8/G108JZhoYNliXi9Fqir6fO/vKKxzMD0+Dyt7bO
    w6r8Q8jI5LtGcTklnt8PVZxluKybXdp9m2IBBHAvvSr7ulufwffRGsBI/z6NmgyQ
    BgxEF5krhE+O6fOAhtEWOZGUUCbCSQBplOD2kiN6BCfjUGTrZ1/LyFu3uBsHiTCR
    uV691jldG0NhXWypSHTLjJQljTYf3qdiWcdSmAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520487093; bh=7l5KDv
    C2J76ewxA5bHr4lmP4oDezktM1IMFjfSWV3JI=; b=sFbWveFc9ojoQ1kOGThHAe
    XUf469dNLEyrVBs5/l6zs/7egia8vLMKGh/KgeU5rpEOqRaBDFDjplQ9YfAI7UiB
    XiVr++ADWPoy5b8eTfo5XBF0G2/TqECrjINv+Qb2U+C0u8CKuCsZlZ0GPjTb5U9U
    4+ncR+6dYagC+RgEIGHmG7nDjrNuPNi/mNnsvGx8Y63i0kWydGp3O5wASh6Hm0v4
    ZMSbPSYsquvau62UI5lobcr54u/T4jZuujs1IOMIk4WLJsyDxcMHYULKLR7naoo0
    GxKb2d3tFCtg5g2DLvWDePNLV1dv9jZqkdQ0haZax8+hMhlRe94/UD4Ic/ItkrBw
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZjU1Pqic x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZjU1Pqic x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966373AbeCHFGY (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:06:24 -0500
Received: from mail-by2nam01on0104.outbound.protection.outlook.com ([104.47.34.104]:18336
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966401AbeCHFGU (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:06:20 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@fb.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 057/101] mtip32xx: use runtime tag to
 initialize command header
Thread-Topic: [PATCH AUTOSEL for 4.4 057/101] mtip32xx: use runtime tag to
 initialize command header
Thread-Index: AQHTtpqUJ4NpGgZ/Fkme4Qy/2bLMqg==
Date: Thu, 8 Mar 2018 05:01:55 +0000
Message-ID: <20180308050023.8548-57-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0917;20:NnYH1yHr9L6KayRSu+0JsrUKBMopJm8EK+vdZKzUzzQLatlUqOY0Id+lUAL2yJlUQB9CcvUVMFqayLv8aH1UkLlyFyFjwrd5pPf9P9JpdRJi7VK8y1IH9tI48TF10UzUMoV5kXI4Du4/QPZ6GOvRTDNn3h1f2JK6e+Jiv36zcBo=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 72f28134-86b1-42af-2b86-08d584b25173
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0917;
x-ms-traffictypediagnostic: DM5PR2101MB0917:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0917378E718744E85CF47F34FBDF0@DM5PR2101MB0917.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(67672495146484);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0917;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0917;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(376002)(346002)(39860400002)(39380400002)(189003)(199004)(478600001)(2906002)(6512007)(6116002)(1076002)(7736002)(3280700002)(5250100002)(2501003)(6436002)(3846002)(186003)(99286004)(86612001)(59450400001)(53936002)(26005)(36756003)(305945005)(22452003)(6486002)(102836004)(10290500003)(72206003)(76176011)(110136005)(4326008)(10090500001)(105586002)(316002)(25786009)(97736004)(107886003)(6506007)(81156014)(14454004)(81166006)(54906003)(8936002)(68736007)(8676002)(106356001)(6666003)(3660700001)(5660300001)(66066001)(2900100001)(2950100002)(86362001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0917;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: 7Tc1TlfiBImc5ln23mMlI44bTl9acLRg0tM6BXeFUihBtwOkUj5C9l2UJfpF+FBBoKUUq4iETr5lPLKvhAenYEJS7tfAGElL3evqjR795cVzRzXLic8K5kHp1K9AObBrla7iwB4NVzD715yn6zRQmQNGXaNoxXR9DE5i/5Fsnu5Pd7uauzdnb/Vh+a6rixbO5FlitA2iB/zW8FLUI2tS0E/yVoRnnDWejkxBu11e+F05zhJOp5jfNNuoXrq0UasRNUJAFpFTl/yYDBt7BWv7BYm+BjcogtSchDUVu2NbjqrqCv5Mq83tH1yJX6Og/ECQKBlyWJpTY0cXNKOQFmqPtQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72f28134-86b1-42af-2b86-08d584b25173
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:01:55.5151
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0917
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
index 55d3d1da72de..9ba89315dae1 100644
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
@@ -3818,6 +3840,8 @@ static int mtip_queue_rq(struct blk_mq_hw_ctx *hctx,
 	struct request *rq =3D bd->rq;
 	int ret;
=20
+	mtip_init_cmd_header(rq);
+
 	if (unlikely(mtip_check_unal_depth(hctx, rq)))
 		return BLK_MQ_RQ_QUEUE_BUSY;
=20
@@ -3849,7 +3873,6 @@ static int mtip_init_cmd(void *data, struct request *=
rq, unsigned int hctx_idx,
 {
 	struct driver_data *dd =3D data;
 	struct mtip_cmd *cmd =3D blk_mq_rq_to_pdu(rq);
-	u32 host_cap_64 =3D readl(dd->mmio + HOST_CAP) & HOST_CAP_64;
=20
 	/*
 	 * For flush requests, request_idx starts at the end of the
@@ -3866,17 +3889,6 @@ static int mtip_init_cmd(void *data, struct request =
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
