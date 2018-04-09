Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3752604-1523238327-2-16242230735775583545
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enroda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523238326; b=QBk/DCNh2TvdJo0JnXyM216llgFWZOiq62ilUcaCHu/ZY5D26k
    A6BZ3POEDC0yo5y4X71MdJuZ/zcfa3kGmzzwnqIXCTfLD6KLHUP8j5SFrwVZLfiQ
    s6tUUSsG0n8j/RX6Z5JFuK0BAgczl1b4Ya1Az0ET0Iyz5joJdIb26MbTS4ME3gyJ
    PnwP5JGSm14SVl+CVEQFVmLTCztTnLbHcwAlvKI5fx8viPLt6RhncjUu+ls9Awuo
    n67G4vNf0G2X9s5aOBrVK7HCQWEfnQXhcdk41jQr+jml9N1A3BjQp2II7DfyxjQw
    Qz7rbcrVm5PqL6z1Y00V8YVpcoZsqAtIBGdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523238326; bh=u2iGAJnMWO
    iN/VeMzWvl9b7MjJ+keGEAl+GqKbvXMBw=; b=nBJtb1nRnGeGO3ckKCE2xj3HnG
    BxuyFGO6SUJ9AfdFOrfv0cE0tEXtLi+W2DBaH8TpuJEIbIDfVMy/+asjemCKyhgV
    9x9WcLGSyymCmSgy7TLgKWUQqOuE7UX31VZArsenelBKFGNSWbjgbgSab8fthuwx
    vdFA0p5WJ45/NmB0MYJAK1qPeeoIvTpYSwJ+FFoIMWiUahwGLgXRUNt/WvmBCqLN
    r8LiFFgj2JRrC/lhum90y9LztIV1qBDNAycu+/zVwC623innrC+thPm4X+hMrb0U
    vSCOAkWQrRLNSAMIfQrq0FzwoQioS3GU9SiiTrG+d0ZDGMp8RdceYIilXWig==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=T9vvYS0Z x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=T9vvYS0Z x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNwV1d9MqwiXUS8sQFDikagh7iD4bktxV7lb2MpHNlJCBh03ZCvc+qk9JZEnlyKHKg0EqmzRvROiI/PTX1DvmQtvw40FOaazqdIDjt31U9W1EfSQBNgN
    yyu8l2OdKmYMHAYcKyTeJW4R3XJ3ym9sAephzWjQQRQW56asnKH6Pk64P7N1HuK1lVPE5F+wdAQEPPOmbeURJCAtw6CeJnZo3FfNoTnVBAq+brgL2/tTz71z
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=yPCof4ZbAAAA:8 a=CbDCq_QkAAAA:8 a=20KFwNOVAAAA:8
    a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8 a=EePCTitOv4r-aG-WyjYA:9
    a=OFdCgW_wg3rEB3Yd:21 a=LkQsyN4xvfA9J7OS:21 a=wPNLvfGTeEIA:10
    a=1qrBK16LubpBFNPVNq2M:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932567AbeDIBpC (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:45:02 -0400
Received: from mail-bl2nam02on0118.outbound.protection.outlook.com ([104.47.38.118]:14317
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932492AbeDIAen (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:34:43 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Guanglei Li <guanglei.li@oracle.com>,
        Honglei Wang <honglei.wang@oracle.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 277/293] RDS: IB: Fix null pointer issue
Thread-Topic: [PATCH AUTOSEL for 4.9 277/293] RDS: IB: Fix null pointer issue
Thread-Index: AQHTz5lo0Ee4+yQ9s06m2yH89j8IIw==
Date: Mon, 9 Apr 2018 00:26:32 +0000
Message-ID: <20180409002239.163177-277-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0984;7:xqI6JvDV7or5gdjT8XjqtBfYiKMx2kf0ne5FS8LxgvRb/zWMFEeckOeNWYkHBB2nbVYC4eip2KX8QkXbgyMlg+M2+AVZqd3k2M5syCm6vy3RAgoMm2DhZbKgAkG2krt55DpNc7OsNTWSGlvXqgqQnkQnFpnSag25xOsPNVp+Dq8ifpoRqmCb+WmOt6cCmWi6JsCfxAGj1rar91bN/R8tyWbd3brYpoD9h2JlSNkjFyZtAw9bkCyw6gNlQnOTotWF;20:tbs8eJZcDIYtOsi21nnPIshueO/0mFtkemP/UXc0E0aEYR9Nxpx4cs/NrvuJKnFUe2tP29ARu+mLyvqoqkkCAgNzLqUulqJJQXYwpXUTq+3rp24JUyo1J3Lxm6UIKK6UBn2koiQz2o9HX7zCNnyCuWf4I5RtE0EoCabXCu2kvVo=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8cd1a338-47a1-4d95-c565-08d59db1ada8
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0984;
x-ms-traffictypediagnostic: DM5PR2101MB0984:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0984C4A287DD1F097AC04E6FFBBF0@DM5PR2101MB0984.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0984;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0984;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(39380400002)(346002)(376002)(199004)(189003)(26005)(99286004)(2906002)(14454004)(97736004)(59450400001)(8676002)(81156014)(81166006)(8936002)(6512007)(106356001)(76176011)(186003)(3280700002)(10090500001)(36756003)(6506007)(66066001)(3660700001)(72206003)(478600001)(6666003)(53936002)(2900100001)(105586002)(102836004)(5890100001)(2501003)(110136005)(54906003)(5250100002)(486006)(1076002)(25786009)(6116002)(6436002)(11346002)(6486002)(22452003)(4326008)(446003)(7736002)(575784001)(86362001)(305945005)(2616005)(476003)(68736007)(3846002)(86612001)(5660300001)(10290500003)(107886003)(316002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0984;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: ve46yVSbz2IJxJuibrTQpU0++53NgwOvIj4UzX8GFW7Ix+zaehrLQQI4zoSfV+7/uyeMD3iY1XazKMJQiEo0xs/VGiPNHbU1kv6X1ZtnzHLxXpnR9jE6/2GpO72VP3yENTMAnFJ+HI95p1QbFrkGtC9AwZVtwZ5yhIWtsBhb7YBNtDTAPFK0slVvbMwo5JebLBFQbnuBbuS3S1YpaMnbEVhd4mS9ERhEFzrfYgtoiO8zn6EVnStXtMvKr9C6wLrDIsNyvLyDvWKQldvZ0eQnRpIm0yVk/nvRlAhY4/UT21+TAeI9yLdclbTdU5BZbS9ZHpc5auXPVWrSGgTtub1JJrEoesoP4CjxtqO0oUPjccWOOqhb296ip1faQpVkk7Eap98nuYsF08pdBiYXKDFO4fv8P/tOMG/xvK8svPNbFXk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cd1a338-47a1-4d95-c565-08d59db1ada8
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:26:32.4883
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0984
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Guanglei Li <guanglei.li@oracle.com>

[ Upstream commit 2c0aa08631b86a4678dbc93b9caa5248014b4458 ]

Scenario:
1. Port down and do fail over
2. Ap do rds_bind syscall

PID: 47039  TASK: ffff89887e2fe640  CPU: 47  COMMAND: "kworker/u:6"
 #0 [ffff898e35f159f0] machine_kexec at ffffffff8103abf9
 #1 [ffff898e35f15a60] crash_kexec at ffffffff810b96e3
 #2 [ffff898e35f15b30] oops_end at ffffffff8150f518
 #3 [ffff898e35f15b60] no_context at ffffffff8104854c
 #4 [ffff898e35f15ba0] __bad_area_nosemaphore at ffffffff81048675
 #5 [ffff898e35f15bf0] bad_area_nosemaphore at ffffffff810487d3
 #6 [ffff898e35f15c00] do_page_fault at ffffffff815120b8
 #7 [ffff898e35f15d10] page_fault at ffffffff8150ea95
    [exception RIP: unknown or invalid address]
    RIP: 0000000000000000  RSP: ffff898e35f15dc8  RFLAGS: 00010282
    RAX: 00000000fffffffe  RBX: ffff889b77f6fc00  RCX:ffffffff81c99d88
    RDX: 0000000000000000  RSI: ffff896019ee08e8  RDI:ffff889b77f6fc00
    RBP: ffff898e35f15df0   R8: ffff896019ee08c8  R9:0000000000000000
    R10: 0000000000000400  R11: 0000000000000000  R12:ffff896019ee08c0
    R13: ffff889b77f6fe68  R14: ffffffff81c99d80  R15: ffffffffa022a1e0
    ORIG_RAX: ffffffffffffffff  CS: 0010 SS: 0018
 #8 [ffff898e35f15dc8] cma_ndev_work_handler at ffffffffa022a228 [rdma_cm]
 #9 [ffff898e35f15df8] process_one_work at ffffffff8108a7c6
 #10 [ffff898e35f15e58] worker_thread at ffffffff8108bda0
 #11 [ffff898e35f15ee8] kthread at ffffffff81090fe6

PID: 45659  TASK: ffff880d313d2500  CPU: 31  COMMAND: "oracle_45659_ap"
 #0 [ffff881024ccfc98] __schedule at ffffffff8150bac4
 #1 [ffff881024ccfd40] schedule at ffffffff8150c2cf
 #2 [ffff881024ccfd50] __mutex_lock_slowpath at ffffffff8150cee7
 #3 [ffff881024ccfdc0] mutex_lock at ffffffff8150cdeb
 #4 [ffff881024ccfde0] rdma_destroy_id at ffffffffa022a027 [rdma_cm]
 #5 [ffff881024ccfe10] rds_ib_laddr_check at ffffffffa0357857 [rds_rdma]
 #6 [ffff881024ccfe50] rds_trans_get_preferred at ffffffffa0324c2a [rds]
 #7 [ffff881024ccfe80] rds_bind at ffffffffa031d690 [rds]
 #8 [ffff881024ccfeb0] sys_bind at ffffffff8142a670

PID: 45659                          PID: 47039
rds_ib_laddr_check
  /* create id_priv with a null event_handler */
  rdma_create_id
  rdma_bind_addr
    cma_acquire_dev
      /* add id_priv to cma_dev->id_list */
      cma_attach_to_dev
                                    cma_ndev_work_handler
                                      /* event_hanlder is null */
                                      id_priv->id.event_handler

Signed-off-by: Guanglei Li <guanglei.li@oracle.com>
Signed-off-by: Honglei Wang <honglei.wang@oracle.com>
Reviewed-by: Junxiao Bi <junxiao.bi@oracle.com>
Reviewed-by: Yanjun Zhu <yanjun.zhu@oracle.com>
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@oracle.com>
Acked-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/rds/ib.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/rds/ib.c b/net/rds/ib.c
index 5680d90b0b77..0efb3d2b338d 100644
--- a/net/rds/ib.c
+++ b/net/rds/ib.c
@@ -336,7 +336,8 @@ static int rds_ib_laddr_check(struct net *net, __be32 a=
ddr)
 	/* Create a CMA ID and try to bind it. This catches both
 	 * IB and iWARP capable NICs.
 	 */
-	cm_id =3D rdma_create_id(&init_net, NULL, NULL, RDMA_PS_TCP, IB_QPT_RC);
+	cm_id =3D rdma_create_id(&init_net, rds_rdma_cm_event_handler,
+			       NULL, RDMA_PS_TCP, IB_QPT_RC);
 	if (IS_ERR(cm_id))
 		return PTR_ERR(cm_id);
=20
--=20
2.15.1
