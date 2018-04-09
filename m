Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3913452-1523242659-2-11413452284619504908
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
    1523242659; b=a2kkvQWJvmg42NolwqRVAT3PjOkarzPSbqEd19e7Dnqkhmp7Gr
    9rC6aZX+aJagJPugMht66ghxjDBpghLlnyiLRKO1NCHVjcwLzEmUMQ4Fg91xLctr
    JbJuqDjvHyWU+5HKUSkloQOSLXOunahOKRDn3oQkzzaHkBLCMz2+HNK7ZftMvRK8
    YZkCQfwr1BZTEDrQIzJrjGjqsH8uP+4EPaFjLA/AYSzfMrUxtzXLX76siRpowSwj
    6MPebiUKRo81ngNh1e4ZHWnCvyCy2kQHZIEaqrv0GzosBeGOJakewaCbm13bcPXa
    sx/hDIPyuy3twiknEzy3I6/gIPwo4l35EFCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523242659; bh=Hmc+RhWZwO
    M2zyBlMO1/Su0o5J1riolvkQ4/duZtGO8=; b=K7anMpxIdjRDqS5dZ+vljxykro
    MR1lSJQZdsAqqw/vfl8KoGnwgpKjMIjoJhDt6eR5nkkntwtiVON5U1dYJ4d+MuyG
    yzQNxAMj5V/TTAgVHJcaNLoNk143rTRwO2qUw4sNxdvJxM2xgSy1yPC85ELfqy2J
    joBTRfLkAx/uRusW4vmp5IUuMTQ1ZQG8OfoqHrANegwSNGhIcMdov1X7DdY+BC+M
    6Zh0BWg/EVktJFMxkaYp4c999pOHz7xPi19GLjTQzvbdAtPovcEVd74DOjZ0Llro
    rbBbng5QVCh/ZH1fo5pdkn3ORw4gSVvPOF/GrE02xHT0s/B+dBjdP699a8BA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Qk7utUbU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Qk7utUbU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJevFl/NFpTW6Y+eb6AlFh+llFgi5KnT0ONcdBBigCw/xgx95aTmO2Hn61VVS0GkM+4VUuCFuNlzfA6tZki1Ru9bz5PO22+YwZXiJ1wxskyC1Er+8ZzK
    JbbYVN3fvk5DJOJSGd3pJ5fty3khBW6zH2BbjsavTnYkKqeY7sGN+jgXCxdJQ8mGDhC0/P55j8D+WLw1ZiCK/Y6v4fwwVDDXxT4m7z7tj4LNc7gZTtdKIx/P
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=yPCof4ZbAAAA:8 a=CbDCq_QkAAAA:8 a=20KFwNOVAAAA:8
    a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8 a=EePCTitOv4r-aG-WyjYA:9
    a=OFdCgW_wg3rEB3Yd:21 a=LkQsyN4xvfA9J7OS:21 a=wPNLvfGTeEIA:10
    a=1qrBK16LubpBFNPVNq2M:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755646AbeDIC5W (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:57:22 -0400
Received: from mail-bn3nam01on0139.outbound.protection.outlook.com ([104.47.33.139]:14848
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755232AbeDIAZn (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:25:43 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Guanglei Li <guanglei.li@oracle.com>,
        Honglei Wang <honglei.wang@oracle.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 131/161] RDS: IB: Fix null pointer issue
Thread-Topic: [PATCH AUTOSEL for 4.14 131/161] RDS: IB: Fix null pointer issue
Thread-Index: AQHTz5i7NC2U+DbD8EC3sGung731Nw==
Date: Mon, 9 Apr 2018 00:21:40 +0000
Message-ID: <20180409001936.162706-131-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1013;7:mWQGAuYxPSN2sYofGSTD+YMWdnPTb8GfHAM0V5Mxb0hMBZAKn+yjBx50LOlRhByXa7cNMdkYV/lLNEJ0jzmZtHFWxVZQHivOH3JDnSxk6R1Fb1JVQsdvnaAWuEq+JB5DHoOn13FnNUjWmDe+FtXqxpmpbe5hCQCbN4C1scG0vro062xcI7M1le5t1Y1y8J9FI1xqZbV3EquUGLeXvQ1bKtbcZyk+nV6h7Y2j9vzBQ53igxSGjA+ZX/YTW3jIiD5B;20:0xctkDzhZj9BlhK3ob5UQhKAtCC7YLTOatDpO6ePGZpUO7Q7rTgJ/ycV4iOMILQe5VIehVe1xoUeSeKGob7deIHIzR9o844e4aGsEl6MJ0YBGSLyGohS0gQ0NmGUPBskSGwzTrtFwzz59BVZaKCNhjtEVWZ3jWjUAnKE7OcL+a4=
X-MS-Office365-Filtering-Correlation-Id: f17a40d8-6db0-49ae-0409-08d59db06b12
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1013;
x-ms-traffictypediagnostic: DM5PR2101MB1013:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1013668B0C30EE9D0327887CFBBF0@DM5PR2101MB1013.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1013;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1013;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(376002)(396003)(39860400002)(39380400002)(189003)(199004)(3280700002)(2616005)(8936002)(7736002)(476003)(446003)(11346002)(53936002)(3660700001)(86362001)(575784001)(86612001)(81156014)(2906002)(186003)(81166006)(105586002)(1076002)(8676002)(26005)(97736004)(25786009)(6512007)(3846002)(68736007)(72206003)(106356001)(5660300001)(6486002)(6666003)(6116002)(14454004)(4326008)(305945005)(6436002)(2501003)(5890100001)(5250100002)(10290500003)(478600001)(2900100001)(59450400001)(22452003)(110136005)(316002)(99286004)(66066001)(10090500001)(107886003)(76176011)(102836004)(54906003)(6506007)(36756003)(486006)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1013;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: V6a8FfIelDif6qCHh3G/bjM/2gc1D1IARNfA9iB9k1T1iJ0INZiFYyg1WtLg1+lsBbJaVrQoSMuKk3yELD8qnkV27NHelVtj+l+Zy6/ISkvnJmpdq/5soDWyCXHQGeDtiOwCopHooWX5/j86/mMwc1bXs59LH67FEvd+iIl+VrbR1PjDFC/epkwGGsqDRBrdtASxLh5CfyKCNdM+B20mBbBkOi7Vui4l9FXjLkmWk10NH4jpotat1hMfMMsrS2f1PhA4aJd2faFENFbaNDhwNbGdu9+OK/ua4E/2R88G6yQCdsuqw6x2LMIiZNjU7rgEzK7jY0BjXQyri7XDjbRTds4/KaOZlN2VmV7jDcqKoHv/cJN9GbXDL0Jl6yrFsHDA5S7lPfVZ3dg3vR8hZqYQihTniRE9msiOlXMM/kzlCS8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f17a40d8-6db0-49ae-0409-08d59db06b12
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:21:40.6749
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1013
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
index a0954ace3774..c21eb4850b9d 100644
--- a/net/rds/ib.c
+++ b/net/rds/ib.c
@@ -346,7 +346,8 @@ static int rds_ib_laddr_check(struct net *net, __be32 a=
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
