Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3384037-1521481456-2-17068673056302790916
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
    t=1521481455; b=tiYlrCDZtjXDfFz0spZpRNz1KopkNfuxQmcVDwaHUO4PRLS
    Z0C++HSJ+woTpq2y+HDeUt/JEwLOAhQ93xWQBRsGFmz1cqreC411eiiQp7rKh3Vg
    Omg1+0q/JsBTLJ0NnGlCdMFun94LFUYPzMsIJweyaBjxBSiq2JZFo6KjjW5A4GbX
    3VkhwH88EiZknsOUmYSi7M8W6LwfG8SHw/KAKOmLo5CJdx6ytbDjXz4yGNljVPtR
    epyiT/Hoxc1xh9c8+KBwKUr8knEkrRZ1JSh+I3CGVsbJrNE4C2hFDbDnHZI7j6DB
    5KPiv8a9PLIBkTaRhCXSPa96tHcMjwqe5ouTWhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521481455; bh=5LJffp
    U1aa7H/GcACgIcKlwNiMXwD8IbKhdjXc6eFpg=; b=CRzkUvC4/dw8CiZQgbw3oW
    Dp9xyIBfx6s8qZO3eQkJE/RQ/VOHbapi6ZzBsOiFMEIPZm04Fr++dpKej6RU9QP2
    Z1OSGKM9NZkzK0iWYjkJ9EPBH68DlJqBavgYLC30NVtED0811FSKBS10KlmpbZbu
    bu8FfWw9gFeDfGnJC8m2UYabtyv7txZYS5LbVVt40wulO6aM8qP6DUWK0aKy7drZ
    bQwXESDC8lH7XTwt8ly63KXIwzw8nH1SOWsRl8vfqWigo79xEjdhlruc9TroAY3R
    cfQHv1DtYywpkh7QVNK0UQYPzae/rtDjtDgamEIk2RNZwgJt960ilZHoxrYkgMNg
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ah73lQHA x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpedutdehudelnecuvehluhhsthgvrhfuihiivgepjeei;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ah73lQHA x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpedutdehudelnecuvehluhhsthgvrhfuihiivgepjeei;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965826AbeCSRnq (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:43:46 -0400
Received: from mail-dm3nam03on0092.outbound.protection.outlook.com ([104.47.41.92]:19136
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965763AbeCSQFn (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:05:43 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "Karicheri, Muralidharan" <m-karicheri2@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 259/281] hsr: fix incorrect warning
Thread-Topic: [PATCH AUTOSEL for 4.9 259/281] hsr: fix incorrect warning
Thread-Index: AQHTv5vBmRXubJBfwkyrsvUocYRWmA==
Date: Mon, 19 Mar 2018 16:03:01 +0000
Message-ID: <20180319155742.13731-259-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1015;7:cMO9DtlaHaFk5yEj8JmIWC4C7jbExG4WBQHna5OPIjeNb5/qnEW/IRq6dTMCrSUWEHpiouY05nUCd6tsdMiFPTQMRnyj9LTIDxkWC/caZIh418nDDdkwHCwePrDQ3tQcZZvkjaD+MsO/wmj/89k+qkafeASb5hZmTqZ0KCaDJf4Oc5I8iYoKy3KaCx6jI8ffNf97NV07yXDueRFJkQvoDTalIzHYpIqalsxo/CEgAT52aL3OMMnens+RtvlG7ESf;20:+ybFilzvX8oD2ZbsCcMvhV1K1G/PKV1eMqKokC++23shFRJemOFnPy7wXRQiior3bGF8bR/adwVYL4JBGxiNlx/OvpH8MkLwDaEspFif6GQ2dwyFbifTuF9yRI3xNlkk+AzlMhdWnlfJRMzSBN/HLcd0j/lHzNxR46mbDEQz2qs=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8400fd79-236a-4d04-4937-08d58db34103
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
x-ms-traffictypediagnostic: DM5PR2101MB1015:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1015A70853428F4C24364611FBD40@DM5PR2101MB1015.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(31051911155226)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(366004)(39380400002)(376002)(39860400002)(396003)(346002)(199004)(189003)(6506007)(106356001)(107886003)(2950100002)(6666003)(22452003)(316002)(10090500001)(59450400001)(76176011)(8676002)(81156014)(105586002)(81166006)(3280700002)(3660700001)(305945005)(7736002)(2501003)(6436002)(68736007)(6486002)(5250100002)(8936002)(6116002)(3846002)(2906002)(1076002)(186003)(36756003)(25786009)(10290500003)(4326008)(97736004)(72206003)(2900100001)(99286004)(53936002)(5660300001)(6512007)(14454004)(478600001)(102836004)(66066001)(86612001)(86362001)(26005)(54906003)(110136005)(575784001)(22906009)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: BKGAhuGAWTnFjGifCj51sgAj6g2aqSD8NRs7IkL62ymGyN7exqRBYYeXhh9u0ito+g1i60AMUcM+rPddxtgSqVJshv/wqf0x9Jbu0gooc7j1U9BXV/uLGmFLPNQW+8AZDo4dO5wTyaOgEb4+jrYjtmCYZNzAagiK0S4fIVYnw8jdiZJyBlYSCmJK7eGBVrz2EckjV1marIejKc4Spla5XBZH3D5qd5F3m9EKAWeW0ng+SJ1SjixOqnHbMRIrF0ET5o0YkVbXvupgz/4K/kul7JzkoZLrh0ltTnbKnnj8EBslo6PWBO0G/A2O8te78bceIRa2XjBb+7+08vdOn35JGg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8400fd79-236a-4d04-4937-08d58db34103
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:03:01.2127
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
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
2.14.1
