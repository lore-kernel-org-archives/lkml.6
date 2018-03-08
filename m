Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1025811-1520488215-2-12603409329932592608
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, URIBL_BLACK 1.7, LANGUAGES ensvda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520488214; b=sPdFV/IU0s7koHqrDvcA+W/nuAkt4FZ9LO0tAR8HcH2r5+8
    jecC2lhEH2eNEXk7oL4IxZ6zlB/OHm8xn3VR9ziKl2dXCE9wMwFivE3KkYiV04X0
    paKdHveL8zNNsDWMwB8MgOlFDQwXvf2ym1Xilm3jivSVVljjokYF7/EoJqocgXT7
    syhAyzFozfI+Z/grVw0M8z7PyWFuIZoRPNr9NrMVIsNWZXoB55cwMpFv2tO5U6tk
    GHoNf/BvpG1CXd4oyWDbTICH357ovvEyGmYxp7KXcOkNZKPAEdczdEGOiyKXgaKS
    7MrjWJQ1JLLlBqEmkVTf1KQDi8HQUSRBjiOBIow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520488214; bh=K9Oz2D
    gUINN3XSwy8WENKBEP3LC0JiYVgj4YpNDoM2M=; b=nEmE5EUsfqgFm25qGoNQQb
    P2WAkm+C0gbCLuowZNIYAlYfXJ0q6/o3ynVPVyDwtvPtVJa+RJDt9s/lURPA1pXW
    LHGvxiz4I0dYBThCBIPYQ3KB7aatPk9q4MuktdfspVxhSSi5v9BllsUv4aax8UdA
    ZBgwP1OF+DSUehiHAHO8Tpu8fdyAlBn0xf/Re7vhcSOy6mApEJSKE1XPXTvIxW2G
    kAOtGsqgszV3JdJ+04OtsekAesKfgcIap2h0EpclG6xpHbYIIOS3B868ujzWIXlO
    WH8cQSs80gWjiD0V7mRg2i4y+jtX+EBpGveoNOYDYTFTgyTd3obj3PEwUOE6fO0A
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LhdbPgS0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LhdbPgS0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966892AbeCHFt5 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:49:57 -0500
Received: from mail-co1nam03on0138.outbound.protection.outlook.com ([104.47.40.138]:38775
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935494AbeCHFEU (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:04:20 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Bharat Potnuri <bharat@chelsio.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 174/190] iser-target: avoid reinitializing
 rdma contexts for isert commands
Thread-Topic: [PATCH AUTOSEL for 4.9 174/190] iser-target: avoid
 reinitializing rdma contexts for isert commands
Thread-Index: AQHTtppVH2eF/CHYYUq5VdOBClFbdw==
Date: Thu, 8 Mar 2018 05:00:09 +0000
Message-ID: <20180308045810.8041-174-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0919;7:ZkQudRH/tgb5f6lYQ6ykVNg2xfSUImNf5WEhbEtmSGQ6e89RLbHNi2wtYG2yw3GFYD8C8S47ebP8AJOCZ2CGkF5XahuYoCHj6LCWFBrxqh9YsUGVBatKTyTCrVqVOjr/ucqxN8gvdUYcvLQI/NRaFEiVndeZULPqvKjVq1576uksPPSQBFIRuG/BRlK16cv1sQH1xlZ78FB99n2nzyNkC9uMx2B/fZHLYKNDS+BGnGgmclcuwYq2sZBW062SDQ8V;20:zmkLieP/D2tOqPpUN2WqJq5eZl0D9Mf5wVaOb4uyQVFn0YTdqQh+DJDX9pmj1Q3upy0fy5P4yYpu7SyH5arlEHpKbySbTWBHD6ApEWc1SWnorTVe3lVq03rBsiEz/bCt2H7Cyo5znBBKq9qSzvPchQl8OWH0jchYhX6cG15R4TE=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 89d565d2-d229-4a51-9763-08d584b20a48
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0919;
x-ms-traffictypediagnostic: DM5PR2101MB0919:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09193A8DAE8F617AFD2C233CFBDF0@DM5PR2101MB0919.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0919;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0919;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(366004)(39380400002)(39860400002)(199004)(189003)(3846002)(305945005)(2501003)(26005)(6116002)(7736002)(186003)(2906002)(316002)(3660700001)(5250100002)(8936002)(4326008)(86362001)(575784001)(76176011)(107886003)(25786009)(5660300001)(10090500001)(66066001)(10290500003)(22452003)(3280700002)(36756003)(86612001)(1076002)(478600001)(68736007)(110136005)(14454004)(54906003)(99286004)(6666003)(2950100002)(106356001)(6512007)(2900100001)(6436002)(6506007)(97736004)(102836004)(53936002)(72206003)(81156014)(6486002)(81166006)(8676002)(105586002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0919;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: fxZ2IvYquh5Y4VI+DIxOvZvYzHTiQue4VZCgH342qeXq7FaYIs3d+8wNQZGu8dAeT9lwgl0QP5iiCOTrdTpYlwXa7Zn014N815aiQNbZHQzecdDh9IfSCCIvdfQbfdQAh0kYY/D2ncJl04amvg3fKMJzHb93LKTFOXAvnwzHwyF6/z9VuRYCNZ5JJBrs/P8SPuyaOBz6E+JDBx10mR6QUoiyncPmXEsIuiK4gEjOG2zTN56NWEdJp5w3I2ubeLn/dOakutlGjoHvXfpq7k2L6cwPAuWSKeRpDXX/XfGAVy4DjqzcjiO1CdPRr+Lbm4+YZjUo77e4EkCQ7FcWKB8upA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89d565d2-d229-4a51-9763-08d584b20a48
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:00:09.5671
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0919
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Bharat Potnuri <bharat@chelsio.com>

[ Upstream commit 66f53e6f5400578bae58db0c06d85a8820831f40 ]

isert commands that failed during isert_rdma_rw_ctx_post() are queued to
Queue-Full(QF) queue and are scheduled to be reposted during queue-full
queue processing. During this reposting, the rdma contexts are initialised
again in isert_rdma_rw_ctx_post(), which is leaking significant memory.

unreferenced object 0xffff8830201d9640 (size 64):
  comm "kworker/0:2", pid 195, jiffies 4295374851 (age 4528.436s)
  hex dump (first 32 bytes):
    00 60 8b cb 2e 00 00 00 00 10 00 00 00 00 00 00  .`..............
    00 90 e3 cb 2e 00 00 00 00 10 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8170711e>] kmemleak_alloc+0x4e/0xb0
    [<ffffffff811f8ba5>] __kmalloc+0x125/0x2b0
    [<ffffffffa046b24f>] rdma_rw_ctx_init+0x15f/0x6f0 [ib_core]
    [<ffffffffa07ab644>] isert_rdma_rw_ctx_post+0xc4/0x3c0 [ib_isert]
    [<ffffffffa07ad972>] isert_put_datain+0x112/0x1c0 [ib_isert]
    [<ffffffffa07dddce>] lio_queue_data_in+0x2e/0x30 [iscsi_target_mod]
    [<ffffffffa076c322>] target_qf_do_work+0x2b2/0x4b0 [target_core_mod]
    [<ffffffff81080c3b>] process_one_work+0x1db/0x5d0
    [<ffffffff8108107d>] worker_thread+0x4d/0x3e0
    [<ffffffff81088667>] kthread+0x117/0x150
    [<ffffffff81713fa7>] ret_from_fork+0x27/0x40
    [<ffffffffffffffff>] 0xffffffffffffffff

Here is patch to use the older rdma contexts while reposting
the isert commands intead of reinitialising them.

Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/ulp/isert/ib_isert.c | 7 +++++++
 drivers/infiniband/ulp/isert/ib_isert.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/u=
lp/isert/ib_isert.c
index 0983470929bd..b879d21b7548 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.c
+++ b/drivers/infiniband/ulp/isert/ib_isert.c
@@ -2098,6 +2098,9 @@ isert_rdma_rw_ctx_post(struct isert_cmd *cmd, struct =
isert_conn *conn,
 	u32 rkey, offset;
 	int ret;
=20
+	if (cmd->ctx_init_done)
+		goto rdma_ctx_post;
+
 	if (dir =3D=3D DMA_FROM_DEVICE) {
 		addr =3D cmd->write_va;
 		rkey =3D cmd->write_stag;
@@ -2125,11 +2128,15 @@ isert_rdma_rw_ctx_post(struct isert_cmd *cmd, struc=
t isert_conn *conn,
 				se_cmd->t_data_sg, se_cmd->t_data_nents,
 				offset, addr, rkey, dir);
 	}
+
 	if (ret < 0) {
 		isert_err("Cmd: %p failed to prepare RDMA res\n", cmd);
 		return ret;
 	}
=20
+	cmd->ctx_init_done =3D true;
+
+rdma_ctx_post:
 	ret =3D rdma_rw_ctx_post(&cmd->rw, conn->qp, port_num, cqe, chain_wr);
 	if (ret < 0)
 		isert_err("Cmd: %p failed to post RDMA res\n", cmd);
diff --git a/drivers/infiniband/ulp/isert/ib_isert.h b/drivers/infiniband/u=
lp/isert/ib_isert.h
index c02ada57d7f5..85bd19753d55 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.h
+++ b/drivers/infiniband/ulp/isert/ib_isert.h
@@ -124,6 +124,7 @@ struct isert_cmd {
 	struct rdma_rw_ctx	rw;
 	struct work_struct	comp_work;
 	struct scatterlist	sg;
+	bool			ctx_init_done;
 };
=20
 static inline struct isert_cmd *tx_desc_to_cmd(struct iser_tx_desc *desc)
--=20
2.14.1
