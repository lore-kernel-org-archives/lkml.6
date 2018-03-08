Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1131037-1520491351-5-11305185347894664609
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
    t=1520491351; b=oIkT1rWXAtbiLgKXzgTx+NImZDZWUFuaO8nPzQmLp9wJ+tk
    IAk8RqlxEOTzAh9l+V7YieumQ/9bTRUvPzmKyxwHrwwo/xWVDkXZnUIArJ0zAx3s
    0P6/dMWlM6bl9z11y3jJ1OYyx7uahy6krK43rRcZJ3KeAoIdmf5bJe7hL69YD/PD
    3jQXY7ae/uo6qK6Hpx6yXtE1avAos5jxKGM7anX1T4J48c6fIxeGVTf6KldiZfz7
    03MR40DgbtCm2Ao6BSo40isEAXdUbEAIRWSN04eDNSixq1vXaSzl/fY9pz4Py1tb
    wT/mzRslhhuALk0UJGK4okNldN27gl2GsSwpydw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520491351; bh=M/p5lL
    tKVEsGnu8qL3M0hVb15Bjpd+oQ0upQvRJcHbU=; b=u+bF5IX8wywgzG1fsADgy/
    2hbMlVf0K1DUAzZYjcgTG1JhGGM6vkiGlvvqSUS6z0hCfWrbD0H/IDgT3X/xzaG+
    ZU7inNFNomKS4DdUeujUNdK3XZ9bRUpdjLdfpiP7M9f8ivXh5a49vL9wPeb892JI
    qmOJe+fLMwXu0Glar6GU726pXV1cMBHWv21zKswvVB/FgeREVYECdV2oHyx2xmMl
    WTBTmWkhGeS7N/yXb3hOJkjRLOzOgvfMhacOEyH9xbzx0BrTHmg3XWmwA/9AOJa/
    OQ8+rlWwvl1gnF2Q3sMX8941cqTTBTktbkQUA/7EcmlrdLP0OGoQ8zVdU4NCehkQ
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=nVh4a4od x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=nVh4a4od x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965379AbeCHGm0 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:42:26 -0500
Received: from mail-sn1nam01on0102.outbound.protection.outlook.com ([104.47.32.102]:61147
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935243AbeCHE7A (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:59:00 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Bharat Potnuri <bharat@chelsio.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 39/67] iser-target: avoid reinitializing rdma
 contexts for isert commands
Thread-Topic: [PATCH AUTOSEL for 4.14 39/67] iser-target: avoid reinitializing
 rdma contexts for isert commands
Thread-Index: AQHTtpoBojOIARTzaE2eLQNdl3gbjw==
Date: Thu, 8 Mar 2018 04:57:48 +0000
Message-ID: <20180308045641.7814-39-alexander.levin@microsoft.com>
References: <20180308045641.7814-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045641.7814-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1015;7:8WaKrYgYwtrHkTAcpi51e5MCtklLSnXqh/Ns6wI+95nQRIc+9F8oT12R59PTALtaXG59ZsMM4fWWdmBHMoWpyxnAT2XUEfX3UydjYVgBM+SwJL3vQ0QSGBsiFjyxNc4YkHV9xcs0jNXawHH0HTkXOt6g9jB4sF9O/pZb+JvLG3++zyeF6/P7EGqdP6W6gnZaLGM3Igo1DnhqTdImZx5FJCARSglG+0dcMEAHl6S5IbTCH1kRdxKV3LX7RABgMFVI;20:okiNS/yoMXBvbcrpC/RaGQjb/FwX/tKUVNbzCJ6EYpj1SIiiAOW1S5gRrr4tP06I5fWwvX5nLmp/EYazJV89Jh4zBNwdU4CiXl3KRMsVq2QMT3p5j3kupAZejs/YrHqS2HGZjG/GtZ2clOUwKTiGNZNCqj5fo3SP8fJEONHAEHc=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e6f47a21-2b84-49ca-81ec-08d584b14ccc
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
x-ms-traffictypediagnostic: DM5PR2101MB1015:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1015997C877C9CCE41BE75BFFBDF0@DM5PR2101MB1015.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(39860400002)(39380400002)(346002)(189003)(199004)(6116002)(53936002)(1076002)(107886003)(3846002)(3660700001)(10090500001)(6666003)(2950100002)(2906002)(6512007)(99286004)(8936002)(6486002)(76176011)(6506007)(68736007)(316002)(110136005)(81156014)(81166006)(8676002)(54906003)(3280700002)(2900100001)(6436002)(97736004)(72206003)(25786009)(10290500003)(86612001)(4326008)(305945005)(7736002)(66066001)(22452003)(478600001)(5660300001)(86362001)(575784001)(14454004)(106356001)(36756003)(102836004)(5250100002)(105586002)(26005)(2501003)(186003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: e9YNFhXCmpkq/8hawviEEQJSEMJCrX4WjheaHpLn9CV9TGqSH/h4/s4jjznLSSFNj1vBIwuZxq8Bq1EAFMFFLd1RhJSK2Wl/Q/AUopE0fe/87x28SNJb58vyjZSpcr3u7b8M5Mg4MNOdrOgU4E3SehkEbCTQCtP4SxveLr1dg+FbLVKShBSDwHGElV5xvEAtK/7+TdAi04RfqYKt2pdLt1FhYMvVeso/8C0E/ctczpnPSRnHsbuWA3DVrQvOvbog8uVxEy05mOQe7fvBX+HRVOktSUadOsjg6tuXHdYdorpTkYrKfkhZPuU4SzPqp+j+aXRxsukST/T3drFLaSJ2mQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6f47a21-2b84-49ca-81ec-08d584b14ccc
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:57:48.6287
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
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
index 9d4785ba24cb..e770c17cbca9 100644
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
