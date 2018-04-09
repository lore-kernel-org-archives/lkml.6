Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3878504-1523240644-2-6331438188433849287
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
    1523240643; b=fip8ERYsoj8vOmu0z9MhFSu4YiPTrQ8N68x2dMK2jLjQN2n1kR
    Gh6v2mQXm3vtTuLXKciz8WMqKwdOhL9Q69sPKPPvRw/CmQTPr0CD3RDPssbtZs5U
    nv7xUbbUVku2Eg3QBnttwEDbR3l4lCv8BaYd7Jad1XsXSBH6UuBNiwdp5LPnigY/
    3WnaOS03uR90TTJAp9V5IF4Y32OXe0/KnSfEXu3nWeO5GV5STzHSVM+1wS9XMcj/
    pd1OfKkGn8t8Scf+Z2BYKdyV5XD5tvj7FwdQKnbZ/pRAALXFeBpVK9rtkL0cRWxD
    MyoOGaFI/2FF1z6kvnTD9g8bPERAXRKtumLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523240643; bh=0bcP/Y1DGt
    YTXuQRKKj3u/m9QxjOWfY/hZewRpZS0pA=; b=P0dRaIzQlKN3c1nZTqiwd7qj0I
    Nw9/Uq8ssA6KTFhfv0CF7tI+inLw7XAQtT2yaYcWK1M72pLrNpp6KnGknXQZYz5G
    IicdCj6iY8o59o5Y4kC63O9Ishz/92NgvxMeoBOqGtg4Old7rlg5Vu2sEM/hAeFx
    TwUZiIfpX2ZPwWdzzQSwbNCxcmeA6MaKiHGToQgVs1Vqb/eZLkekH3NijBXCJ5N+
    E6FkHFeU0SmfetZfmD+/89BEpLZpqee+6ezJXWxnAmS9R6wHUbjsO5cJoqPCBEcP
    KKJQC+IcEnVS5JpG2XlvvLo8AVHzIFV6uZ159kK2V+VcCm9MUTp0EGi4iUCw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LE1tJo7D x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LE1tJo7D x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDVweabKR2qrIFqImvbh4dfkQIB3AaNUN39rsWpnzGCbIYdWeUD+YrSMakqrKZx6AnYceLLazkmq5hnVe+Stk15drVj6ljK7yl6nUxuX0gsPNglH/vJw
    Wcv6YxB0uf1FPYxsdNlHq80rdL2pWwyPKPmb58y0t5V8+PsxKsm1xS+gw8BouP2WqIZdDej4GdhKVR6JN4Erhn5MLNz3TjKV5ENL7VoAAdKeZOrGLPRFCY/6
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8 a=J1Y8HTJGAAAA:8
    a=yMhMjlubAAAA:8 a=NYyNbeCAREXVZh5JZR8A:9 a=wPNLvfGTeEIA:10
    a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756066AbeDICXq (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:23:46 -0400
Received: from mail-by2nam03on0107.outbound.protection.outlook.com ([104.47.42.107]:6816
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756004AbeDIA3h (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:29:37 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Xin Long <lucien.xin@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 107/293] dccp: call inet_add_protocol after
 register_pernet_subsys in dccp_v4_init
Thread-Topic: [PATCH AUTOSEL for 4.9 107/293] dccp: call inet_add_protocol
 after register_pernet_subsys in dccp_v4_init
Thread-Index: AQHTz5kYibFtGCXaWUKUWAOWb9Qn1w==
Date: Mon, 9 Apr 2018 00:24:17 +0000
Message-ID: <20180409002239.163177-107-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0967;7:MnLlMOO3feO0NTzOqxUlr2HGbQYUGn5RnR9r5IlQpApFlbdeqdlTVYOmvgH8SjNDGla2VIxT/L9xZPMGZPNFDxcpGTmKLLzXahweB1+nfboXB4X2XuJEUiqo0aosZk99AjnoQgCEjd7hE2jYvJoA3YDMIyuYVVqTMmftXjQg/19hUf2M7xdOOI4Wv5NoXtaY6Kji9+UIGcko23qAJvjjGEIw59/boIuKxvQfHh5fsgEHiRFz82N4RGsGhpX50+qS;20:lOQ9PQWi2TZoZJC6Nn/Nry+yd3G/dQZ+wIEPutKe4YXbZC1d1sufnF8niLrbfFC/uWswqeT52ucsv7JxZw8mrrSTPIYH2MpVBzLi2Gw5sbCjn05N3ySoR62uYeMboL6DmiHe+pRttAINyZ4Yv1VSQXetL0FUluLxWur1xTdmMYI=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7f99f3e7-cc84-4e3b-d9a9-08d59db0f83d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0967;
x-ms-traffictypediagnostic: DM5PR2101MB0967:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB096743061003D79486823886FBBF0@DM5PR2101MB0967.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0967;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0967;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(376002)(39380400002)(346002)(199004)(189003)(6506007)(486006)(86362001)(14454004)(59450400001)(68736007)(102836004)(99286004)(26005)(3846002)(6116002)(186003)(476003)(2616005)(1076002)(3280700002)(86612001)(72206003)(4326008)(446003)(54906003)(76176011)(11346002)(2906002)(22452003)(3660700001)(110136005)(97736004)(316002)(6666003)(5660300001)(478600001)(8676002)(6512007)(8936002)(39060400002)(107886003)(6486002)(53936002)(81166006)(36756003)(81156014)(10290500003)(6436002)(10090500001)(25786009)(66066001)(106356001)(305945005)(7736002)(2501003)(5250100002)(105586002)(2900100001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0967;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: pi2zM4wPHSeEa1EjQDd1k/7VTaCMEUZuXgrcYRkVhk9Rf8V68SiWOGdD+36UvDUP3A9YXu0digN16CYqiuargSEvZqMRf3WNa//Azv/zdzGWa7B8XE9zWCxmk5ySjMvUzYw6rOV4RmD1wmHEzEwlXas91JfFKDhmwyQX97XHwNFh1BLCyjdXzyH6ib24ukyxfmfkI7ugFrKKKzE4SrKDUTAqme6jhDo59osZPL3Psq8guUrCDt2nbUw5dKzgq+bPZ+2KXLMYJNIbXnuG5WopVGNK1KyRf7/s9QUa8hgumqtQttYmlIv9i6vYn1z6H/pD1bx7YL1HaQg07WBwM3H5nTcyDA6Tg+C+sdFEWFNLgl1t46iD0xepvT4LRt8aNNahcADP7udrA5R2cvWynJGH8IO99EchzSReTqigmXgWqeE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f99f3e7-cc84-4e3b-d9a9-08d59db0f83d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:24:17.0656
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0967
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
index 8c7799cdd3cf..1b455741b750 100644
--- a/net/dccp/ipv4.c
+++ b/net/dccp/ipv4.c
@@ -1038,33 +1038,34 @@ static int __init dccp_v4_init(void)
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
