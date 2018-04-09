Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3752604-1523237249-2-9243648761579710074
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523237248; b=XabEFYoxfoSlzOErsaTFgQDI/MJkDjxeYsq4Js3gGOUG+jzGaW
    ND96G4BMlNAkLHlyAV+TrBR6cr/L0fYgvqWZNMHzpqYsrOdhvzEHCfAoJ0o5GtGW
    K4JEia/5Imj1Rrcw6edhc7ZjeMOym3xzpnhCgzkWwgXmWDLlualclplGHkNs6m5k
    /RZwNGRJ/+r5eH7er92jb5QH5FBk+hilYi0G2NXI8nlDcI6znycGAH2jTp0IUqVb
    tV0P8XB4TZ0H4m32s3Wk/7fRGO1ftBFdyBsPV9LtXU7bvN9lyURKg0DLur86w1KC
    yY/fLFF8yrlZ/UjmMaHColMXErsMORqvv2nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523237248; bh=Oo6K1AURdv
    37HGXcYzUo02YUdWsfHu3JUUKvzXhPQWw=; b=rTdyUV9TqLzWoFR+eiZ3GbBllI
    GOnDsKqVLI6JfNpM8ANasKbFyZz5UKRs1VnVnHHWw+AKbcYhfbkOZrihohN142DU
    GgM1Gwa3465GZtnfXYn9gCXpHqJan5Ga8zm5N1l53KnJGXq2iSQkW8lC5NeM/z2g
    DTzBbytBcuLuau+hDpV4oaYFTi6YscXoDyMsTwQ6h4oA7j9s6e3nZGO32L+vddVn
    Zgy4+5+TaYD2i/fzO84Rzg45NTsB8krkcP0HckB9OrbE2FJHs2A6IvN3HtBsmJQ+
    BNQgKRdkWR1HCCagcxuCQqky66ExveT/40b8fVGiUNS2K+RNR4ai/MO5Dtaw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=joYDN01h x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=joYDN01h x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAO8uhDzntiX7GlUFJk2A2pwpKI4ZmiSzBoqVOolwl9QrsBieNpfYiFqRbGd+CpJ5E/h84GX3ggL1W0CG1usd5CNwIeEMZtPLVO0dh1qLei3a0h7lnWq
    +aUdFJztvcNUtU5mmuIGqrfY2JmCjHWYimTRl2yCtZ15dzpo36zPhcqxRETIU7AJeNdj89LUquO7emBOON4kV6gdu1OXoYavAsUzOjmHdezPtCXvGExOnynH
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8 a=J1Y8HTJGAAAA:8
    a=yMhMjlubAAAA:8 a=NYyNbeCAREXVZh5JZR8A:9 a=wPNLvfGTeEIA:10
    a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932610AbeDIAgQ (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:36:16 -0400
Received: from mail-cys01nam02on0106.outbound.protection.outlook.com ([104.47.37.106]:1992
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756700AbeDIAgO (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:36:14 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Xin Long <lucien.xin@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 057/162] dccp: call inet_add_protocol after
 register_pernet_subsys in dccp_v4_init
Thread-Topic: [PATCH AUTOSEL for 4.4 057/162] dccp: call inet_add_protocol
 after register_pernet_subsys in dccp_v4_init
Thread-Index: AQHTz5mrrZZndyU7cEWJn7bCpnwPMQ==
Date: Mon, 9 Apr 2018 00:28:23 +0000
Message-ID: <20180409002738.163941-57-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1015;7:wF9UZK1O7WfvKKECzC7x/6M5Ou9TbjUY10EY/LY0vUCfO25kx19m0Yvq8d8YgEFxK4sGCylBdgcs4SmdxxCJk4kRkvUzZraQ7rXcHojVgaiYYHtPKeEQJrBkB/qHMu5FryY4BEmszSt2dm4CAxQ+jcaxF9U7B769+wo4HA91KsGqhXSJ7srSuI7GnPziY4X79F71Y7y2MOqt8I2PEn4/Pd5KXxQFZOxzpWHy+ep7+zavk4VVQ/DMfD8NaF7vZJEU;20:mLXeEsSTt7JTnvvX0TUQ86iO7qgdOarPfJUCL3ONp1R8uoIbjSorDERDYvV0EcySxwnNh6/7bWD8uVDVsu4noWb/D2/t4/J2vnL8axEKBGm0BbvLEOsZuUNsYnWrZRf9lJalzrAko4/5FrZardHVcXS1n3Tm15BW0SMLxRVC3fA=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6d58481b-2c20-47c0-8bc0-08d59db1e46e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
x-ms-traffictypediagnostic: DM5PR2101MB1015:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10153A0CBA1987C5E1406FE6FBBF0@DM5PR2101MB1015.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(39380400002)(376002)(346002)(366004)(189003)(199004)(53936002)(4326008)(478600001)(72206003)(3280700002)(2616005)(14454004)(305945005)(5250100002)(3660700001)(2501003)(2900100001)(54906003)(110136005)(86362001)(1076002)(107886003)(6506007)(36756003)(446003)(68736007)(6512007)(7736002)(486006)(2906002)(5660300001)(6436002)(3846002)(86612001)(6486002)(66066001)(11346002)(476003)(6666003)(59450400001)(26005)(10090500001)(316002)(22452003)(8676002)(81156014)(81166006)(6116002)(105586002)(99286004)(186003)(106356001)(76176011)(39060400002)(25786009)(97736004)(10290500003)(102836004)(8936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: hiUVsXYalumlqE1vrJmEHgBT1Q+RD9eaDnmYb3GEI9kJIgTznpumU6w1uGLT5tcy68WGzlNLVlC/Vnnb+zEtj3dHcVQhKLtsZ9XPN6xHsx0RI5c/94mqe6+nT5vdpjOD76MpupM1wxQBUcACQHRyRsd+eaoHvDcNiR9s88BDygs7ZLEt5YZO0FS24oP3eZDosH9XYAD2jB/nJXOknH9EB9yVWDaJZqEehmhSIEMJ5uAlLS4dP9Q+jOlpNZLodde1O53O4cfQyHDJeubHKFjbj5lD8ntuTJkoA4DOkPI44fWpM0Mw0oIRZqvbpxOdhD6r46X1vIxkVAdcc+YXbiKUedcbk8WEP9FtmJYhwL9LczqUB+hmYN9k1kglOSzGs7/phNg7IAfhFRPW/dG+Qg+kfOcxtuKv8IwnRhxCYWpANs0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d58481b-2c20-47c0-8bc0-08d59db1e46e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:28:23.7550
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
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
index 6eb2bbf9873b..dfda437cd86b 100644
--- a/net/dccp/ipv4.c
+++ b/net/dccp/ipv4.c
@@ -1033,33 +1033,34 @@ static int __init dccp_v4_init(void)
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
