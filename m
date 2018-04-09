Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3550853-1523233664-2-17736438778008182948
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523233664; b=FREcZdaE5uQF1Y9QkXhGREteLEDvWa3XvNVK8gk0gcBJH6xCap
    qJcjWsH8rigrBjcNoglp6kPR9lpjtFB6/iBkXGnsN8fHGY2I5FgPplXAaDo2yv33
    PH5XSxrUv3G0jUBbekQ9ClHzYedGOmHIxEswX74tIC5Qp+zQXAnPtfHN76QVjWi3
    cILbgvJrt4fkb/NZgSjMPPC8zamRvzqq8uP41YjbWRKdt+XeeLg5N+dxpCUIyhri
    0NdGPZXUAPg8QN9GGrJSvanx4FDfsN6KYe8U2Q2R3dhwb8yXSbiy3A4+Aq2sgVQ5
    j3FJOupTpy/owF8aqMzYw7QYM1Ce4Zkcx+SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523233664; bh=3yY/BJkivB
    8GGOuLMYpiTggdb0NuM1vQ00E1P5e0Py0=; b=V3kiRTZWxnOW5gngvryQ933ALr
    4dOAQAO3VOgE4rLylV54j+BKzEFjueR7pUBnCwUKmHtkuc+xKzRWz+C8MXdCGgz/
    4VwZMzWVyGSGl87QlZbj1XxM5PgQ61TAWIB/xfT3AWQ5r6JeQM9A+roi8mJAmpg3
    HW17bst77nQw+Y2zAeq3Xaxh0w3lBXaSV1+T7RXzwgqkZIhzJPcaM+MIEeiQoj1z
    zL/KDDgP1OiQxQQE8YLvAuUCQ+RjZsor43vCSre3alqry7RiTOlvLkitVqTXDXSz
    rYlazCKaqtAKn4yfrEfQpGsd220bSGjT58HBtvsnnalRomYtYzqMcW5YnmGg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=YbUAw66S x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=YbUAw66S x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfN+/jxuKa8ZWcLg2AnjD17ogbLIC5MlQuRXjuVIdUA2a1JHbK2Z5Z8QUl3W051y3WFi6U729+UjIuhUBnKMbbi8Qu7bKGa/yXB9VsY7ERxJdMrpomSIO
    4cDFjTtVqhfqCv4Oz7yrlOCq/oHES+ktTD/YTqJp7MuNqJ344jcQsf/zAZ9dF8gMmgE9TQ1QIdNZhOL7Y004E2sxBRFEtzai4+F06VGr1Ba1WoTRUOrelHD8
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=sozttTNsAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8
    a=1IKCCceyvx1ZhNYduq4A:9 a=wPNLvfGTeEIA:10 a=aeg5Gbbo78KNqacMgKqU:22
    a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755661AbeDIA1k (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:27:40 -0400
Received: from mail-cys01nam02on0094.outbound.protection.outlook.com ([104.47.37.94]:22752
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755609AbeDIA1c (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:27:32 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "Karicheri, Muralidharan" <m-karicheri2@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 046/293] hsr: fix incorrect warning
Thread-Topic: [PATCH AUTOSEL for 4.9 046/293] hsr: fix incorrect warning
Thread-Index: AQHTz5j5Eklnu9BFXE+nCzM81Ca1hw==
Date: Mon, 9 Apr 2018 00:23:25 +0000
Message-ID: <20180409002239.163177-46-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1031;7:lJE4IVU6kyPLtoRYi84QqybyW4EBkHGe4d5aUSikO3vNKMtYUCPbVX/TEcS+B09yua2vyYWrEQ2tkMRROkk8ErVlyC7eQDdq6jqE38Dfc1vStNLx2k55aw9Rios9+bB9D5+lAIS4Qv2yCI0N4BrunbZXguRev6V6IGgoCXTpWLZw5UQmSVkJ3lAbW9R89gW8n5TW/B3NDQQ5/+KtCxkj5D7wO00dbGJPypRLaWXJcq0oLcy/YjUthxlHwU3W4lB3;20:f6Vy+IqVyxZo8JaR/tUkDE4cz/Y4OCwwHyofP7cojmwuD4jn25WbzfHklkX3b7piXYDTYdK5T92wGpQIhOnCtG8cjRhbcXxs/9R/VKnjDmC93yLuF+3vbZ3qGjNWN32FHruA0x+7OdAI/H0jS/0xcd+m0V6Pw36LRQoi3rRxU24=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 76265e5f-3408-4d39-42c1-08d59db0abeb
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1031;
x-ms-traffictypediagnostic: DM5PR2101MB1031:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1031ED50A7C11010536E8B65FBBF0@DM5PR2101MB1031.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(31051911155226)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1031;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1031;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(39380400002)(346002)(39860400002)(189003)(199004)(2900100001)(10290500003)(99286004)(76176011)(14454004)(7736002)(11346002)(26005)(86612001)(72206003)(478600001)(36756003)(106356001)(66066001)(2616005)(186003)(575784001)(22452003)(86362001)(68736007)(305945005)(54906003)(102836004)(486006)(59450400001)(110136005)(316002)(6506007)(446003)(107886003)(53936002)(4326008)(105586002)(6436002)(6486002)(476003)(6512007)(5660300001)(5250100002)(25786009)(3846002)(6116002)(1076002)(97736004)(3280700002)(2501003)(2906002)(81156014)(8676002)(10090500001)(81166006)(8936002)(3660700001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1031;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: PA4SZ22LjsijkfJZLAEHANNrSXx59DW7ZH3zx/h1EcRv0RpRqwDXk1WUcSbpWOq8uXHdfjhAUQ3od3PYUdXxta7dgHDGooU+qj0Rmpkw+Pc1LdCmtDDtTJbASusx4Huwey0Jf1iMIeo3VZRomng+ublTdACdaiPlo3POQ47M6deaeh7VhOJnYGXbyIOJgJNtYmwqI4fw++sB5RlwizkgyIwEt8ot4CXYOhUpRjNxbyPzQt7RXRD7EBtfzBP2p5G3snnuqztMGcbZlxOHUf7MRsesUeyr8B89FSbUDoczDksoPdtJTINcsqDxKbwCzMd5H92GCcBnAAqTYp7M92ZH/pNaEEsuhqX8nHh7uvirxKdsGrsSF8ZTJWNowVt87WW5FTYs7Z3tn5g9KSFFX40W2fDf4nw8LE5XoItx0q7e21s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76265e5f-3408-4d39-42c1-08d59db0abeb
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:23:25.8155
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1031
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "Karicheri, Muralidharan" <m-karicheri2@ti.com>

[ Upstream commit 675c8da049fd6556eb2d6cdd745fe812752f07a8 ]

When HSR interface is setup using ip link command, an annoying warning
appears with the trace as below:-

[  203.019828] hsr_get_node: Non-HSR frame
[  203.019833] Modules linked in:
[  203.019848] CPU: 0 PID: 158 Comm: sd-resolve Tainted: G        W       4=
.12.0-rc3-00052-g9fa6bf70 #2
[  203.019853] Hardware name: Generic DRA74X (Flattened Device Tree)
[  203.019869] [<c0110280>] (unwind_backtrace) from [<c010c2f4>] (show_stac=
k+0x10/0x14)
[  203.019880] [<c010c2f4>] (show_stack) from [<c04b9f64>] (dump_stack+0xac=
/0xe0)
[  203.019894] [<c04b9f64>] (dump_stack) from [<c01374e8>] (__warn+0xd8/0x1=
04)
[  203.019907] [<c01374e8>] (__warn) from [<c0137548>] (warn_slowpath_fmt+0=
x34/0x44)
root@am57xx-evm:~# [  203.019921] [<c0137548>] (warn_slowpath_fmt) from [<c=
081126c>] (hsr_get_node+0x148/0x170)
[  203.019932] [<c081126c>] (hsr_get_node) from [<c0814240>] (hsr_forward_s=
kb+0x110/0x7c0)
[  203.019942] [<c0814240>] (hsr_forward_skb) from [<c0811d64>] (hsr_dev_xm=
it+0x2c/0x34)
[  203.019954] [<c0811d64>] (hsr_dev_xmit) from [<c06c0828>] (dev_hard_star=
t_xmit+0xc4/0x3bc)
[  203.019963] [<c06c0828>] (dev_hard_start_xmit) from [<c06c13d8>] (__dev_=
queue_xmit+0x7c4/0x98c)
[  203.019974] [<c06c13d8>] (__dev_queue_xmit) from [<c0782f54>] (ip6_finis=
h_output2+0x330/0xc1c)
[  203.019983] [<c0782f54>] (ip6_finish_output2) from [<c0788f0c>] (ip6_out=
put+0x58/0x454)
[  203.019994] [<c0788f0c>] (ip6_output) from [<c07b16cc>] (mld_sendpack+0x=
420/0x744)

As this is an expected path to hsr_get_node() with frame coming from
the master interface, add a check to ensure packet is not from the
master port and then warn.

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/hsr/hsr_forward.c  | 3 +--
 net/hsr/hsr_framereg.c | 9 +++++++--
 net/hsr/hsr_framereg.h | 2 +-
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index 4ebe2aa3e7d3..04b5450c5a55 100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -324,8 +324,7 @@ static int hsr_fill_frame_info(struct hsr_frame_info *f=
rame,
 	unsigned long irqflags;
=20
 	frame->is_supervision =3D is_supervision_frame(port->hsr, skb);
-	frame->node_src =3D hsr_get_node(&port->hsr->node_db, skb,
-				       frame->is_supervision);
+	frame->node_src =3D hsr_get_node(port, skb, frame->is_supervision);
 	if (frame->node_src =3D=3D NULL)
 		return -1; /* Unknown node and !is_supervision, or no mem */
=20
diff --git a/net/hsr/hsr_framereg.c b/net/hsr/hsr_framereg.c
index 7ea925816f79..284a9b820df8 100644
--- a/net/hsr/hsr_framereg.c
+++ b/net/hsr/hsr_framereg.c
@@ -158,9 +158,10 @@ struct hsr_node *hsr_add_node(struct list_head *node_d=
b, unsigned char addr[],
=20
 /* Get the hsr_node from which 'skb' was sent.
  */
-struct hsr_node *hsr_get_node(struct list_head *node_db, struct sk_buff *s=
kb,
+struct hsr_node *hsr_get_node(struct hsr_port *port, struct sk_buff *skb,
 			      bool is_sup)
 {
+	struct list_head *node_db =3D &port->hsr->node_db;
 	struct hsr_node *node;
 	struct ethhdr *ethhdr;
 	u16 seq_out;
@@ -186,7 +187,11 @@ struct hsr_node *hsr_get_node(struct list_head *node_d=
b, struct sk_buff *skb,
 		 */
 		seq_out =3D hsr_get_skb_sequence_nr(skb) - 1;
 	} else {
-		WARN_ONCE(1, "%s: Non-HSR frame\n", __func__);
+		/* this is called also for frames from master port and
+		 * so warn only for non master ports
+		 */
+		if (port->type !=3D HSR_PT_MASTER)
+			WARN_ONCE(1, "%s: Non-HSR frame\n", __func__);
 		seq_out =3D HSR_SEQNR_START;
 	}
=20
diff --git a/net/hsr/hsr_framereg.h b/net/hsr/hsr_framereg.h
index 438b40f98f5a..4e04f0e868e9 100644
--- a/net/hsr/hsr_framereg.h
+++ b/net/hsr/hsr_framereg.h
@@ -18,7 +18,7 @@ struct hsr_node;
=20
 struct hsr_node *hsr_add_node(struct list_head *node_db, unsigned char add=
r[],
 			      u16 seq_out);
-struct hsr_node *hsr_get_node(struct list_head *node_db, struct sk_buff *s=
kb,
+struct hsr_node *hsr_get_node(struct hsr_port *port, struct sk_buff *skb,
 			      bool is_sup);
 void hsr_handle_sup_frame(struct sk_buff *skb, struct hsr_node *node_curr,
 			  struct hsr_port *port);
--=20
2.15.1
