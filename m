Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3695087-1523236060-2-9731054426020241168
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
    1523236059; b=LuvM9z41HssZNuydPS8ElTG43MWEuYOSPgOmN7QrLXI5DvxFQ/
    JA+2ArCavRR6vDiMhgyxypm7N8U2zfN0ZAPW40KSyEWUy/1QkDhahkMjhuPyk3h/
    9G0Y/hcjCHqfMGkyjC4PCOEkCHIjX5lJm7gJgyABAzHXugVygUX8gp7tDE55Sldz
    GLyudlkpfJv0Ta7fs8GaMgVhhdrM5+i6Az8FnbD2h7GQ76D8KLPBAi0lbBaZuWZc
    PcZ45jp+ok8rxRsIRCrrar4dWbg0c6l52hM8Jv3lnGjy1mjIY/5nhW2MZK50Jytv
    tR1ICCtCX/8qvvhakgaREZl3dUUXcxBZxFIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523236059; bh=cmVIY6Dwbt
    tFG7uI58VHB+LDmCi8h2AbkOx/fbzaQEQ=; b=akcXGexfZ9YCKM+eZ5s+uWIWcg
    rExsW791my190wbVYqvZYXzQFuOC6b92Xgq1tvMo/ww9BLAkBaETsKHpyq1RWhEp
    LEmJ+0uc5xN23Wa7eTiLr66TenliskT+vbEMiy5j2AeMezpo7nKQPCiiiyGBtXn5
    2OCiZL4FlSauchtsjgyWZAQfBBu2t/XKxKuv2g7c2J9zapv3L9SObbJPaTThZIHk
    ipu8ninKLEHjYRKuvU/iFZKsY0dsca3uYAwcoVwKLhBkkY4FSJR1FDXI2iFsl3y3
    HRt3ynMQFn6eKFMwe+EY8PB2Fsl95NnmzK1lz6p5xn0RWAg6cmzhnlrxi6Uw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=YV2XUva/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=YV2XUva/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfP1fbTBa48iTW+7v7xJg7a8wwXKwQxfVq/F8DSvOkf766PyFpBYqF2THVjzy1lKDqLMJ17Asm63R0WXnBl8ujHKNUiZ6KPqjl8jb65JkkXQxPtltlbzv
    Kt9YeeRg8lUacUMp+PGDXeuoi5Ee2VyJ/Ad8RB7Af2itmxYFYa78w3LLY3O2/32iFZ96uy+NB3Iv4wCLiJ/mQrtHxHJwCBbUtOMT+0eB1VdiwiIoNBnSsakg
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=yPCof4ZbAAAA:8 a=CbDCq_QkAAAA:8 a=20KFwNOVAAAA:8
    a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8 a=EePCTitOv4r-aG-WyjYA:9
    a=OFdCgW_wg3rEB3Yd:21 a=LkQsyN4xvfA9J7OS:21 a=wPNLvfGTeEIA:10
    a=1qrBK16LubpBFNPVNq2M:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753565AbeDIBHh (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:07:37 -0400
Received: from mail-co1nam03on0104.outbound.protection.outlook.com ([104.47.40.104]:37663
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932168AbeDIAjU (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:39:20 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Guanglei Li <guanglei.li@oracle.com>,
        Honglei Wang <honglei.wang@oracle.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 151/162] RDS: IB: Fix null pointer issue
Thread-Topic: [PATCH AUTOSEL for 4.4 151/162] RDS: IB: Fix null pointer issue
Thread-Index: AQHTz5ndg+8bZ9IBkUyXnCjou2vE6g==
Date: Mon, 9 Apr 2018 00:29:47 +0000
Message-ID: <20180409002738.163941-151-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1125;7:8v+jQLLhM4aU/Qx6jYcjXUq8NYL0tYZnSjje02KO8ixUmLfUniflmPErPSF1kkpVrpbjavkW62D/6e9EmyJDsDT+WqiRvUpJYLltKzr4pME35VyaM6fwMTvmzKy5DIDOR4VEYKp/wKtov0fQpH2Bgcl182a9zdVW0DxRpCbsbn9kXqDAm1akPVYwulrU/8UFWlHTBr4f8mgaBLA9f8SV5L5kTdCH9XL20Z/VhzU8C6jTBHUFUirQHSYdRmqrfjS1;20:UpSyUXmYlgWHQqxOhQMEwpuq/MqVG2kwH0ClmuIjQDIjuap+OFrLWfdq8YT0S0SO6xdYpuYkHjzQmY+XOb18TjfSqKnWAAKAhkvsIZkEv+TZXCJ1nYkidcyfsOMQxCp1cgGCsO/rrcWBB6p3DsOYg+5VfxFmO3xMpqz95tyR+hc=
X-MS-Office365-Filtering-Correlation-Id: 0a7ca494-5211-4f1b-c1cf-08d59db253df
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1125;
x-ms-traffictypediagnostic: DM5PR2101MB1125:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB11258349483C840BA3745E2EFBBF0@DM5PR2101MB1125.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1125;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1125;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(39380400002)(366004)(376002)(396003)(189003)(199004)(2906002)(25786009)(6512007)(10090500001)(3280700002)(10290500003)(6666003)(3660700001)(316002)(110136005)(54906003)(11346002)(107886003)(2616005)(476003)(446003)(36756003)(99286004)(86612001)(53936002)(4326008)(486006)(6436002)(3846002)(81156014)(305945005)(5250100002)(1076002)(102836004)(14454004)(66066001)(5890100001)(7736002)(105586002)(81166006)(59450400001)(106356001)(8676002)(97736004)(6116002)(6506007)(6486002)(5660300001)(186003)(76176011)(22452003)(72206003)(478600001)(2501003)(2900100001)(26005)(86362001)(575784001)(8936002)(68736007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1125;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 0VzlcKkoP4xQjYV/IBM/XM1TC5zBwUW91cQTdjMSRxBgEL38VtI/i5sgUz91noOccne8XuyJdwhikvumgvfEg/dj+adhQ4+hL5yL7umbFCaEDtQdEUg1M9iOFcS7fUMIeCOUNA11IvFxJL7E4REoijdDiAMbJ3YB2vUErrTq/8rlhusFvl3jSsRosyvYOLeI8dWY7UjPm3swsNuY6HioTV3siaWU5Ejvn9PBQEiliOLcXlAVx4EUtAelHYrXx8eU+4/TKxW0v1GEIyS+aY8iTbvqDx6uZMxhir92UwWPLasAbyQfkczBnS6cV1NTqmmluyd9HNgyJ+G9uB07J3f/CKwdTndExsD6DQ3/BVRaF1oQQOsqL4B/PfLDxK34enL1MdvwLph3UUpOJhlJpRQDJuGExuTf5hEdeDm3Q3utADk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a7ca494-5211-4f1b-c1cf-08d59db253df
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:29:47.8496
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1125
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
index f222885ac0c7..ed51ccc84b3a 100644
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
