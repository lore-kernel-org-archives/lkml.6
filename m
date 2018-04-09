Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3689844-1523235356-2-11447840525020863185
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523235356; b=SqZYsk0dCOLBeC6OIpZer/+M7dHMkBVjP1sozf+Wn5+7yMLyTp
    9dYKhZm1eMpj3kfoRskEJ6vQSBjIfdASCxvfZ90PN6ExGxgL62kjfmBmSY854aVv
    WWgndPWm/L/FhCGzjNuTtXbTRWEku+r00KH2AfstTrwkrJofyrK1xW+rMmJnabN4
    +VB+/3f0kDIoLjTBWnOT+3fqVkJDqslCs5Fzxns2cYrSpCt0jr9AG/HXJ7OWd3hK
    G43ngnSC1P24mevLRr5aeaOBCMB5tW8P5fJRTzsgx3aIt+3k+C5K130AiWo5NC6r
    RZHgwqN9zUIh0dUs6EQ3qX9F+taNa2fcipuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523235356; bh=NnhVPSnQD3
    BQLwCqD9cvxTeJqPc7cwpbBBWdL+SX0q4=; b=qldvMlEyKQxkAVmlcxY3VK3HVJ
    m0JC7mrZfPcK3bs+ReZjKualAQ4jy54I+ZqL4SQdbm9ZKIeVNkwfFsQI1J751J+X
    h+3Hn+JO17eeSV2lsHU1wiwagxlfEPrwJzKj2pl9nQWim020dxgpsZMalpDU+iPN
    vqhkZbt58z5mPSsG8cq5L6ZoWH+yc0/yq1QOZVEK9MrbVWCzEu7pEXkrZk/zPIZq
    lJuZiXq3lxED2xj51qK05vrzB2VbmiiTtyNuAbpYs1cYK8IRakrc6bZQDCTOanDL
    cUFe5Nwo1yFXOkP3IWFRmSuvo4Z/P4GR1LDIfjCM5hwz+sYm+6x4XNUEb4uQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=GsoPqYJd x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=GsoPqYJd x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfG9yWtJWrdxM3TbWpbOSOzJiNlK1qIBCZDoxPicZva3I6jen5Eloc9FYIRXZdloj80E+67lGbLfPp4WL6w1p3P1eoAqh5tfNlpFCO5lIdU4o9JicM2DU
    RnQ465Np3yhF1DodULvQGkCfTyfDq2aUwOVJ8AijRgJW7asBTiy48mNgacROms2bgn6UjMeeKHQVXqOt5POoB66VRbzyZ3z9inmN2pCo3rdAQSSeVgPMlhG+
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8 a=J1Y8HTJGAAAA:8
    a=yMhMjlubAAAA:8 a=NYyNbeCAREXVZh5JZR8A:9 a=wPNLvfGTeEIA:10
    a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932937AbeDIAzl (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:55:41 -0400
Received: from mail-sn1nam02on0130.outbound.protection.outlook.com ([104.47.36.130]:38544
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933288AbeDIAkZ (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:40:25 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Xin Long <lucien.xin@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 042/101] dccp: call inet_add_protocol after
 register_pernet_subsys in dccp_v4_init
Thread-Topic: [PATCH AUTOSEL for 3.18 042/101] dccp: call inet_add_protocol
 after register_pernet_subsys in dccp_v4_init
Thread-Index: AQHTz5q2PhK5Xpg4WEKDIIDJdteQNA==
Date: Mon, 9 Apr 2018 00:35:52 +0000
Message-ID: <20180409003505.164715-42-alexander.levin@microsoft.com>
References: <20180409003505.164715-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409003505.164715-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0870;7:hXhj3RpkaZqRmugaa12PrR55HLqXx48HWWXOTCLKkSpzjdASu2bbuJwpm9j9lW5euH/10lAvopAxfr88gie1UQFXdI/4ocjNRoSyYh6JrxZ/BNgzInDrO5rfHCIG5PfJFhOW/tVlazn9nqrDsSCPMe87JXlTRIVhjKCiCDYYjUOAnllXQHIcS7rUEgF8wY3OlbgnES77Q1ho41LNyKicdRDx0bAenjv71elELYEdIx2f1Yl67UzyROR5kV+sdlKm;20:O0gIUZ/aLgnXiiRbyc7th+skFSMLktSpOWtO0ZsXdCMkZU96tu8h4OPVIllW2SDWtRYz8YNczAqsdGZF1MHaY0H239lJVcMJQu6yjzVBUcExwSbs/B2NOIMVlld9DotmVuiU9/E8sAIJb0zq4+tpORjy3k9Ltw/QidYzIqeW3N0=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 662008f3-4bea-41fc-32d8-08d59db2798e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0870;
x-ms-traffictypediagnostic: DM5PR2101MB0870:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB087023415C8B98B991B4791FFBBF0@DM5PR2101MB0870.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0870;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0870;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(366004)(376002)(39860400002)(346002)(199004)(189003)(5250100002)(5660300001)(26005)(10290500003)(2501003)(478600001)(68736007)(8676002)(8936002)(81156014)(81166006)(22452003)(3846002)(86362001)(36756003)(1076002)(305945005)(54906003)(72206003)(186003)(316002)(4326008)(25786009)(6486002)(110136005)(7736002)(446003)(10090500001)(76176011)(14454004)(11346002)(476003)(2900100001)(97736004)(107886003)(39060400002)(486006)(59450400001)(2906002)(6512007)(53936002)(102836004)(2616005)(86612001)(6116002)(3280700002)(6666003)(6506007)(66066001)(6436002)(3660700001)(105586002)(99286004)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0870;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: K3dEM6WRHQPu80mw37WTnwExg86fu9771NQ5zxRa3bnDyPhZDEIn+8Cxt3rk8dM5qFtBLMX/flyEl+AW5a6+ZDnrOxCBWPf8L+JunxALWr5DMEBLw8DzUcoXnEB8Y6TfE+x8rGItSKUH66wlUNdfLOLVHuRrSeIqSnltEmHPU1pLj3SCCNG9+0aIWwbl2x07ZCckz/Lv69OLOj3Sv49EwCZdpWM7FwDXiJDT11tavtSKmPGwRKTofXsy9uVzInS5eKS4PBWR/qe02gl9x4kT0SXvS7Zs6S4xDBbQvi/4xLlB1cF/J7rxR38cOj9gVMEWazwa0JQVeDILt6iC5uaTZ7LQaXwO3iXEE4UJcpF42NrfDbNP1zm/YZ/5pEoxP6VIAcE+B5+YxF6NW4eITexutU9r7x+dPt5fix2JNwenR+4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 662008f3-4bea-41fc-32d8-08d59db2798e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:35:52.4703
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0870
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit d5494acb88aa9dd1325079c9b8855008a52c19b3 ]

Now dccp_ipv4 works as a kernel module. During loading this module, if
one dccp packet is being recieved after inet_add_protocol but before
register_pernet_subsys in which v4_ctl_sk is initialized, a null pointer
dereference may be triggered because of init_net.dccp.v4_ctl_sk is 0x0.

Jianlin found this issue when the following call trace occurred:

[  171.950177] BUG: unable to handle kernel NULL pointer dereference at 000=
0000000000110
[  171.951007] IP: [<ffffffffc0558364>] dccp_v4_ctl_send_reset+0xc4/0x220 [=
dccp_ipv4]
[...]
[  171.984629] Call Trace:
[  171.984859]  <IRQ>
[  171.985061]
[  171.985213]  [<ffffffffc0559a53>] dccp_v4_rcv+0x383/0x3f9 [dccp_ipv4]
[  171.985711]  [<ffffffff815ca054>] ip_local_deliver_finish+0xb4/0x1f0
[  171.986309]  [<ffffffff815ca339>] ip_local_deliver+0x59/0xd0
[  171.986852]  [<ffffffff810cd7a4>] ? update_curr+0x104/0x190
[  171.986956]  [<ffffffff815c9cda>] ip_rcv_finish+0x8a/0x350
[  171.986956]  [<ffffffff815ca666>] ip_rcv+0x2b6/0x410
[  171.986956]  [<ffffffff810c83b4>] ? task_cputime+0x44/0x80
[  171.986956]  [<ffffffff81586f22>] __netif_receive_skb_core+0x572/0x7c0
[  171.986956]  [<ffffffff810d2c51>] ? trigger_load_balance+0x61/0x1e0
[  171.986956]  [<ffffffff81587188>] __netif_receive_skb+0x18/0x60
[  171.986956]  [<ffffffff8158841e>] process_backlog+0xae/0x180
[  171.986956]  [<ffffffff8158799d>] net_rx_action+0x16d/0x380
[  171.986956]  [<ffffffff81090b7f>] __do_softirq+0xef/0x280
[  171.986956]  [<ffffffff816b6a1c>] call_softirq+0x1c/0x30

This patch is to move inet_add_protocol after register_pernet_subsys in
dccp_v4_init, so that v4_ctl_sk is initialized before any incoming dccp
packets are processed.

Reported-by: Jianlin Shi <jishi@redhat.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/dccp/ipv4.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/net/dccp/ipv4.c b/net/dccp/ipv4.c
index 502d9a885329..adce7f5d4f07 100644
--- a/net/dccp/ipv4.c
+++ b/net/dccp/ipv4.c
@@ -1051,33 +1051,34 @@ static int __init dccp_v4_init(void)
 {
 	int err =3D proto_register(&dccp_v4_prot, 1);
=20
-	if (err !=3D 0)
+	if (err)
 		goto out;
=20
-	err =3D inet_add_protocol(&dccp_v4_protocol, IPPROTO_DCCP);
-	if (err !=3D 0)
-		goto out_proto_unregister;
-
 	inet_register_protosw(&dccp_v4_protosw);
=20
 	err =3D register_pernet_subsys(&dccp_v4_ops);
 	if (err)
 		goto out_destroy_ctl_sock;
+
+	err =3D inet_add_protocol(&dccp_v4_protocol, IPPROTO_DCCP);
+	if (err)
+		goto out_proto_unregister;
+
 out:
 	return err;
+out_proto_unregister:
+	unregister_pernet_subsys(&dccp_v4_ops);
 out_destroy_ctl_sock:
 	inet_unregister_protosw(&dccp_v4_protosw);
-	inet_del_protocol(&dccp_v4_protocol, IPPROTO_DCCP);
-out_proto_unregister:
 	proto_unregister(&dccp_v4_prot);
 	goto out;
 }
=20
 static void __exit dccp_v4_exit(void)
 {
+	inet_del_protocol(&dccp_v4_protocol, IPPROTO_DCCP);
 	unregister_pernet_subsys(&dccp_v4_ops);
 	inet_unregister_protosw(&dccp_v4_protosw);
-	inet_del_protocol(&dccp_v4_protocol, IPPROTO_DCCP);
 	proto_unregister(&dccp_v4_prot);
 }
=20
--=20
2.15.1
