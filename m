Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1131037-1520492462-2-2597579287047663300
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
    t=1520492461; b=fmR6L87Rh9uJFE/Uf6ovo6uncp5qBd6CHLzEPTuSQZc6QMR
    kPYD0tPigWD0GaEdpIn7j7JJKOfLYxxoS6H6qHJ75+iD92VDnuXcRx8dyaKIM0TH
    L2jPaqEEHkpO6I9TTT5XWelnmKuLFDRUy4sn8ankhRNLF8JyrrqTPnlCZZFXpKX+
    1hDRLmsEOijFyvlQLvOISXImZa8tm5GWGeovROPToGtrsQNRPoTYwfZTXzUt+vTW
    SpaQi4uwGxYnO9tQ0EWZfzuDMSlLC6RdVagw1Z88X36DR5s4kBxP+uB1kRT4LJAI
    A1wOOD3Fp2LkReyPuTOTQMgS4qpBrHyE07OE3Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520492461; bh=fsBnK9
    yciSdj4mjpWmlrFfqnB9wHSpm/u1ivsEHIAoY=; b=teXW9m4iwSmAAg5gFiEbP+
    K1dvj+y/u08WWnUzSV3cSXg86aYi00V4QtWjCNypRgPxF8DNwWlYu7WweUeuEypE
    WfZgirR2f32dQRK3GX2ikFlSefnCQZB+ZRC8IP5bflDTG0g1gv/o7nnmXYGpslBa
    J5G7t3ob3Ty5R7VM7p/ip1twfEp+RdsWt9fGiQTmzi8xnOqYKVti3oZhtbq8b3p7
    D54QWlbEMBlPwUP1GIaGr+tYWCuJs/ssEWmJZJQcfeGZ8wxmSnPSLQW6AfZ8tS2l
    QDukI4x8v8JnlRr3/gYRGvQ6VXrn6CiFGlvKQhIPvdHMtE201yocsk1EKgyO+Rgg
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=EPsVRmt9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=EPsVRmt9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935031AbeCHHAq (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 02:00:46 -0500
Received: from mail-bn3nam01on0102.outbound.protection.outlook.com ([104.47.33.102]:13054
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934988AbeCHE5U (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:57:20 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Bharat Potnuri <bharat@chelsio.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 44/78] iser-target: avoid reinitializing rdma
 contexts for isert commands
Thread-Topic: [PATCH AUTOSEL for 4.15 44/78] iser-target: avoid reinitializing
 rdma contexts for isert commands
Thread-Index: AQHTtpnMwYhysmfvPk2zaZvs24L4Fw==
Date: Thu, 8 Mar 2018 04:56:20 +0000
Message-ID: <20180308045525.7662-44-alexander.levin@microsoft.com>
References: <20180308045525.7662-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045525.7662-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1079;7:3yJ1Nji4EDgD/j0o+RmO+/NX/tloeZe3Gnkjx7Fn6ZRBsHeNx1NyAbsH4vbYcHseIUyu81HLzoBiRGlR8vbQJe6FGQoWGigk264+P7OAwEOw9v6Fo8PJdjY5KfJQ3TA6oas/LORVHucJrD0x8xfgKAq1OSIvONhUrGSmFS8r4o2ZYBo0Zui7ZO5lR697xaB4jMYRmBy0ieYcmkqNrpeSy8iKThLJfaER9e0Lawi7zEulO7+mYRDU6AQqZK3LF5Sj;20:JxurlrcARGYu+T+lYjNMGaPIwTCCvrPD4XKhQrZVKiB+XJ0Mbrf8+BqSWfjxh/ndidNnacTWY7Rp3vvwHpbCtai+wxj0x4zUAb8b3jcWT5EeLKs2zuj7dsXSuBIlNETdn+Fm5fENk2C+CmSPNJ03i04AlF9pPvc62XDcWp1NQbQ=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fca3c37e-2679-4134-e331-08d584b10cc0
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1079;
x-ms-traffictypediagnostic: DM5PR2101MB1079:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB107987838FC2D5E830193C35FBDF0@DM5PR2101MB1079.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR2101MB1079;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1079;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(39380400002)(396003)(346002)(366004)(189003)(199004)(36756003)(107886003)(4326008)(97736004)(2906002)(2950100002)(1076002)(6666003)(105586002)(7736002)(186003)(3660700001)(5660300001)(106356001)(305945005)(6512007)(3280700002)(25786009)(14454004)(575784001)(86362001)(86612001)(81156014)(10090500001)(76176011)(26005)(99286004)(66066001)(102836004)(110136005)(81166006)(72206003)(54906003)(5250100002)(478600001)(10290500003)(6116002)(2501003)(8936002)(68736007)(53936002)(6506007)(6486002)(8676002)(6436002)(3846002)(22452003)(316002)(2900100001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1079;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: jPSfFKywcPoffvqqIEYtv0mm4pqA7UpjcIdcvUvevVZ/IF9ajHj8cAPN4EJEQL0LUKUbfy6+I9nQ90PehogyFmSLehuaSDASvZBqHr48j5nnmd2Z+AZWfnaOcBE7U7jakxsaMUmAijyUFNxO5jDUw3Q8tgFEbULtmCwbSZjj9BpK2MQdgPQtCjKi9yeZCyyOkjTEPDmIesV521i9T/IUzq1V9xsZeOXCGxI/mtialRaQYvsX1BKdXtOEWo7JmvhYFUskb9C1w0hzOXHaEho3mfgZax5g4Ykc0wLci6Q+feAKKAOoimg0WFSB8Z44hnPW5MIU4m0Nf62MlpxivXWHhA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fca3c37e-2679-4134-e331-08d584b10cc0
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:56:20.8524
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1079
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
index 1b02283ce20e..fff40b097947 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.c
+++ b/drivers/infiniband/ulp/isert/ib_isert.c
@@ -2124,6 +2124,9 @@ isert_rdma_rw_ctx_post(struct isert_cmd *cmd, struct =
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
@@ -2151,11 +2154,15 @@ isert_rdma_rw_ctx_post(struct isert_cmd *cmd, struc=
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
index d6fd248320ae..3b296bac4f60 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.h
+++ b/drivers/infiniband/ulp/isert/ib_isert.h
@@ -126,6 +126,7 @@ struct isert_cmd {
 	struct rdma_rw_ctx	rw;
 	struct work_struct	comp_work;
 	struct scatterlist	sg;
+	bool			ctx_init_done;
 };
=20
 static inline struct isert_cmd *tx_desc_to_cmd(struct iser_tx_desc *desc)
--=20
2.14.1
