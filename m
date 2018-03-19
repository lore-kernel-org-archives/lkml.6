Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3205673-1521475100-2-11094043711628860187
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521475100; b=cDsXSeAhYNB6MWr/j8aO8kkx9ApRcaCFQ96SeXsE1LWaMSm
    Qs4rm+nBYRAopUkaWro/9sOB+MksIktPuLovEE62zzD/iKVUedoeJJPOpEksaM5z
    JK6SbnyIUqedeJeBcpMrHBfa50b8KifpVl7l5SumFLXkJzY2LxtvzDYwZoO7PjVK
    2+JryGpMaEQLQ2i6SELkSAzl/IDKz55GgDyUBnW1tho/gR6qvIGQdqQI095SJlPm
    2Pl2CsEHsmQ9SSf/58joNRa5vKOR4b+OZbqk5ZwrYtDaq/fDgVpCImKa/2ANm8Ga
    Q0BxwmwYYb7g6LsqCYdkQa8WJRd+0NZqe3v8rcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521475100; bh=fvb/0f
    vVHKOOhZKJJnnVcNXRTtCLcb/VUEjbC24Qg/Y=; b=NdXYl/AKiJ5RzFUDJmhCGB
    RUXZkMI6+aHvd5OvS2Mq9ybSVorKm/7qiJ6UXTaWqYEVzG3o3DDXsvv/kpe88ro6
    eQxSVrqKMHOTALPTOHSQlN3sfkr71IE6YwYkfnxqHqYijaeLRPBOXmqGZR0cmMLv
    +fwlfuuQHBHTknkNdIkaPflzcQ1wrEFvvOyDCTcDK9N7mr9Ko4D/+46IXwpvFWw0
    SxjZ6k5A+9gEGbSC+ETcoWW1BZu+LDg9SPYs7B/LLiZLHvVuWasJrlKL1EL/MXQ2
    j5Y6dButGevWeJI1GZ/+gNMUVNm7YKx6xPlR39skcbh3Fg1+QLp20QM9TN2QInLQ
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=YBUmqoNi x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekvdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkeegfeelnecuvehluhhsthgvrhfuihiivgepudefvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=YBUmqoNi x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekvdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkeegfeelnecuvehluhhsthgvrhfuihiivgepudefvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933487AbeCSP6Q (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:58:16 -0400
Received: from mail-co1nam03on0113.outbound.protection.outlook.com ([104.47.40.113]:13408
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933564AbeCSP6M (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:58:12 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Bart Van Assche <bart.vanassche@sandisk.com>,
        Doug Ledford <dledford@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        David Disseldorp <ddiss@suse.de>,
        Nicholas Bellinger <nab@linux-iscsi.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 011/281] IB/srpt: Avoid that aborting a
 command triggers a kernel warning
Thread-Topic: [PATCH AUTOSEL for 4.9 011/281] IB/srpt: Avoid that aborting a
 command triggers a kernel warning
Thread-Index: AQHTv5sP6UVk36onMkSDa6t046dblQ==
Date: Mon, 19 Mar 2018 15:58:03 +0000
Message-ID: <20180319155742.13731-11-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0933;7:SnqdddbBogiXdX5Z/Wmev27rLTgj7nV8JDMCHTT5yFX134aXsPwPrEi3jqJ2B2NKTcsXosYROlgDS6Fkj6dlJBoBT6jlUu5lyJVRHCkUPBhky83Qmi7GUtcZR++WUjhlHNBU3q95MDBMrEVZRVKH6x7h6dcTyKrudGHShPtFi4DCljx5UOF1p3UZT5yYvyFzdwyuW2lnn4Q4mEDfzgmpMzeeulU5KZcrBi+hDFN0cXRFNJh84hA53iofeH67wKNw;20:U1iimTzG2qg5L8fXo3CB/sglTSBMAzQmGQWmf9phKBhJCn+IG6jceVC7E8u0Jg00zfg94n1TWNAnrj11O4e2FHjuWcM/EUcrBqB69tznR0G0DTC1nJFhBqz64QrATihy/xxBawDkOWZcjgloIapodDnZ/H7cmASpPHyWExgLexA=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5b2cfbcd-564b-4092-7ee9-08d58db23275
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0933;
x-ms-traffictypediagnostic: DM5PR2101MB0933:
x-microsoft-antispam-prvs: <DM5PR2101MB09337E8AD2D83C5599145C20FBD40@DM5PR2101MB0933.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(42932892334569);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501300)(52105095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0933;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0933;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(39380400002)(366004)(346002)(376002)(51234002)(199004)(189003)(2501003)(72206003)(1076002)(66066001)(10290500003)(99286004)(10090500001)(7736002)(14454004)(6116002)(5660300001)(2906002)(97736004)(6346003)(102836004)(22452003)(86612001)(3660700001)(186003)(2900100001)(25786009)(478600001)(5250100002)(26005)(6486002)(6436002)(81156014)(81166006)(36756003)(4326008)(86362001)(76176011)(6512007)(8936002)(106356001)(3846002)(53936002)(105586002)(3280700002)(305945005)(68736007)(110136005)(2950100002)(54906003)(8676002)(107886003)(316002)(8656006)(6506007)(59450400001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0933;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: hsqUxEgxem7vPESb0x65vV/LLw3TbsGNlVj9OcyRPJWKif+BxEmPUVTk4sfn1XPSC4uQxsTGth6o/UAyX3F75SaQY0tCB3XBR0A718GIlPy+Gj6acGmiDNgtkYFHff9XzddzUHSWAsAqug7aGFmaBYi9JtWsdjMBlotF3OSsM8AJ2SbflhT70b6M3HAI/fb2UGtSKu7FSPG/Sz+2kurhoMnd/k2Ydww8YkDmwOjXc+wcBCgcbVWVzjpcXXb+Zee9TOfso2j2AHNQKKwaGqcdDObhMnlQipyRMPr3Ktcs3JBQersQ6oz9lyO4DvuR8Hv1zJKVN7pXI9y5Vh3vtS7AJA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b2cfbcd-564b-4092-7ee9-08d58db23275
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:58:03.1248
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0933
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Bart Van Assche <bart.vanassche@sandisk.com>

[ Upstream commit bd2c52d733f126ff75f99c537a27655b2db07e28 ]

Avoid that the following warning is triggered:

WARNING: CPU: 10 PID: 166 at ../drivers/infiniband/ulp/srpt/ib_srpt.c:2674 =
srpt_release_cmd+0x139/0x140 [ib_srpt]
CPU: 10 PID: 166 Comm: kworker/u24:8 Not tainted 4.9.4-1-default #1
Workqueue: tmr-fileio target_tmr_work [target_core_mod]
Call Trace:
 [<ffffffffaa3c4f70>] dump_stack+0x63/0x83
 [<ffffffffaa0844eb>] __warn+0xcb/0xf0
 [<ffffffffaa0845dd>] warn_slowpath_null+0x1d/0x20
 [<ffffffffc06ba429>] srpt_release_cmd+0x139/0x140 [ib_srpt]
 [<ffffffffc06e4377>] target_release_cmd_kref+0xb7/0x120 [target_core_mod]
 [<ffffffffc06e4d7f>] target_put_sess_cmd+0x2f/0x60 [target_core_mod]
 [<ffffffffc06e15e0>] core_tmr_lun_reset+0x340/0x790 [target_core_mod]
 [<ffffffffc06e4816>] target_tmr_work+0xe6/0x140 [target_core_mod]
 [<ffffffffaa09e4d3>] process_one_work+0x1f3/0x4d0
 [<ffffffffaa09e7f8>] worker_thread+0x48/0x4e0
 [<ffffffffaa09e7b0>] ? process_one_work+0x4d0/0x4d0
 [<ffffffffaa0a46da>] kthread+0xca/0xe0
 [<ffffffffaa0a4610>] ? kthread_park+0x60/0x60
 [<ffffffffaa71b775>] ret_from_fork+0x25/0x30

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: David Disseldorp <ddiss@suse.de>
Signed-off-by: Nicholas Bellinger <nab@linux-iscsi.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/ulp/srpt/ib_srpt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp=
/srpt/ib_srpt.c
index 860bb59f6326..876f438aa048 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -2666,7 +2666,8 @@ static void srpt_release_cmd(struct se_cmd *se_cmd)
 	struct srpt_rdma_ch *ch =3D ioctx->ch;
 	unsigned long flags;
=20
-	WARN_ON(ioctx->state !=3D SRPT_STATE_DONE);
+	WARN_ON_ONCE(ioctx->state !=3D SRPT_STATE_DONE &&
+		     !(ioctx->cmd.transport_state & CMD_T_ABORTED));
=20
 	if (ioctx->n_rw_ctx) {
 		srpt_free_rw_ctxs(ch, ioctx);
--=20
2.14.1
