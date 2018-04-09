Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4102378-1523245869-2-17437044754059749164
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
    1523245868; b=wSLv6T3tKr+/U/oqLyKeZ4deDNBW8M5IeJyvcwMr0TKqC3kiHk
    HblUwNdJzJ9Q0AgtuvaYty6i13BWEYS9AY0YT+NBmM7SUcUa+QzOWX6sMkjhoeE3
    CyKKABDyThrspDThT5aFOMa3QxJP/g2m9HheSpVxBaHdOWuktmdKU/dT3UAGsoXh
    Oo3pEEqXGK0LiOJVUj/JkBmJAw3ZrAiqnVfP9IyKZ6Ob1DgVORIFW2KMAPdHoPgk
    1Bod4aeYvKScvt3r5OT4VeG4hFFTTlYEQjp+IX2yQQGRBgZgrZQLMV5ZAvhK+JMC
    YRUWyYQ60oSSVfwyzVWz24lQ6BetMPdVm8XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523245868; bh=ynQjRCtn02
    SgZ6Y4sKpMZbj9uyTwC2zSxCFbk0h37vk=; b=HF3nKhEvQD+Cvv7YfCPcm1wXbc
    0yVZXngiW5/IoUw+uCZsKIglsS+z78LpIlaYQI74o3kgiBsjf44gEyMoRmDuktR2
    iXx6fkam8eAhkJBYm0KxVIaK6YepYeVovd9CU60QV8sww5qFrlwSGBK+Z6vUJDFx
    Jk4oP5Bfa1Xeydzj8LPOc5KzQ+T9yjUbpRJrxzUIUrIZTqgUqKV+CTZ8gV6mHMxX
    pPJrcSBCC+Nw5UeGaAXKyo3H2SgnIxcQKxVe11t/tzzUjbQ2jv1pFzktS86eGc6X
    JHTTlnYcMmAr7RRtg8kKgoRK72IxNwfWFu0IdIsrEix4NlvLCuLsaKTpdMug==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=JvSCoUZG x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=JvSCoUZG x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJwIrJyeOQwdfz8imlXoqcKvaTZ6xBWbOQsKPKId2xefyoi2kiiVkr3G7K58jHRdyLXhk46Hlfow9YUqahjYKFfp6g5El5scLeb5VN/04oI7ysTCSZu5
    U0WGHeCAm2lT0xs70HOUh6oNyOD58qCTIHXAutP2XWX8BSldChxeyAKiXY2tphMh1+3i8Fvio0qQnhJQ0rp2nM/rT7RS+2kxhdWJ6k0ZDQ2G4Rayr6PxT8Ai
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=9isDrUItAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8
    a=CLeWWt8dGckd-uDcp54A:9 a=RfgONM9Q38_H_8yf:21 a=CC5GkahYXGZ71kRb:21
    a=wPNLvfGTeEIA:10 a=01Cuw3xjDqt1ySEFOcFQ:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754055AbeDIDuh (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:50:37 -0400
Received: from mail-by2nam03on0122.outbound.protection.outlook.com ([104.47.42.122]:11088
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754057AbeDIAT3 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:19:29 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Andy Spencer <aspencer@spacex.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 107/189] gianfar: prevent integer wrapping in
 the rx handler
Thread-Topic: [PATCH AUTOSEL for 4.15 107/189] gianfar: prevent integer
 wrapping in the rx handler
Thread-Index: AQHTz5g96A+9eAIDV0Sr+epalbYDjw==
Date: Mon, 9 Apr 2018 00:18:10 +0000
Message-ID: <20180409001637.162453-107-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1063;7:05w1PrN2NKZsKff+WEADUBs1vfOonZyUdmPC7sZ6kt6oJAeAtbDQM1YyBjtHiv9glM6NNiSmIe4U48nHTaHmcywLsx5YTLIu4S5YkfctQO6S/i0/4yNtE03oJSqXSxlSVQ61ffqpwbbAJl3UmQfxIqIkOkTZsMvjcQhCIjuVXCJywn2exhW8qq56+IUO4U/KauZqbVxrwghp+zvu9iYp7v2YLjP/k+tUN5TaFm66GDgAT0ir/o0CAWYjyoj5UdOr;20:eCA/9Zh3ZpYv4OFuDfoZME1ylUrD14frlfJGcpQgLe6ez5pPQaq/DxYrhSd72fE6eUGmgCeZ1xn3aI1Z3MvuQ3TQ7U7di69A5O8tugIQAq+8xoz+/aC6UAolLnyFARh3oKtmiWOad35X+Tb7QN9de1S5sNh/q5iKl0bhrMCIv1s=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6861b55f-a983-4d98-514b-08d59daf8bfd
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1063;
x-ms-traffictypediagnostic: DM5PR2101MB1063:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB106308EDE752B746D1EA16F1FBBF0@DM5PR2101MB1063.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1063;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1063;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(39860400002)(376002)(396003)(366004)(189003)(199004)(2900100001)(6436002)(7736002)(10090500001)(102836004)(3660700001)(6506007)(76176011)(305945005)(4326008)(5250100002)(97736004)(26005)(25786009)(6512007)(2906002)(81166006)(106356001)(107886003)(68736007)(14454004)(86612001)(66066001)(10290500003)(6666003)(5660300001)(81156014)(478600001)(476003)(486006)(6486002)(72206003)(3280700002)(99286004)(105586002)(36756003)(1076002)(2616005)(11346002)(53936002)(446003)(8676002)(186003)(3846002)(54906003)(6116002)(2501003)(8936002)(316002)(110136005)(575784001)(86362001)(22452003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1063;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: EtLrxx3QekQK7qgr1L0lSadtHPHPsyYAnbA2QH985/SeoU+DgU/+Nr5TdkO69484562OU6kat/83I1OBEj/SWi8KnjAw2wjnF+ibtypMjB6Jsh5AWNSNPvuMXRnMUc30zk4ng+NySI7RU1nH0PdRea7F7BzfynM/9AA6lrhmYMzXhG/57dH4G28vG4O1WLqG/42kSUloWP96vEujpM2WMjIfo2SSGa4AuBMIjGpuNEPC39jO2tE2wFGEgcNPcIVObGSIY+CCet9pWSOVLLpf3E5kXr1YTSO3y2gxoXXYIacZcSit0fTbD/1CxrreC8F4vHhaFOsysiK6rNGpzpclR2Z6lSJAL1wVrwwc2Mo1nGFMba9IyWvVzdev7frHtoO9qN2YczrtDYEeTa/S5DqQCzcHwl7DczCycj/OaeWaEvM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6861b55f-a983-4d98-514b-08d59daf8bfd
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:18:10.3812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1063
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Andy Spencer <aspencer@spacex.com>

[ Upstream commit 202a0a70e445caee1d0ec7aae814e64b1189fa4d ]

When the frame check sequence (FCS) is split across the last two frames
of a fragmented packet, part of the FCS gets counted twice, once when
subtracting the FCS, and again when subtracting the previously received
data.

For example, if 1602 bytes are received, and the first fragment contains
the first 1600 bytes (including the first two bytes of the FCS), and the
second fragment contains the last two bytes of the FCS:

  'skb->len =3D=3D 1600' from the first fragment

  size  =3D lstatus & BD_LENGTH_MASK; # 1602
  size -=3D ETH_FCS_LEN;              # 1598
  size -=3D skb->len;                 # -2

Since the size is unsigned, it wraps around and causes a BUG later in
the packet handling, as shown below:

  kernel BUG at ./include/linux/skbuff.h:2068!
  Oops: Exception in kernel mode, sig: 5 [#1]
  ...
  NIP [c021ec60] skb_pull+0x24/0x44
  LR [c01e2fbc] gfar_clean_rx_ring+0x498/0x690
  Call Trace:
  [df7edeb0] [c01e2c1c] gfar_clean_rx_ring+0xf8/0x690 (unreliable)
  [df7edf20] [c01e33a8] gfar_poll_rx_sq+0x3c/0x9c
  [df7edf40] [c023352c] net_rx_action+0x21c/0x274
  [df7edf90] [c0329000] __do_softirq+0xd8/0x240
  [df7edff0] [c000c108] call_do_irq+0x24/0x3c
  [c0597e90] [c00041dc] do_IRQ+0x64/0xc4
  [c0597eb0] [c000d920] ret_from_except+0x0/0x18
  --- interrupt: 501 at arch_cpu_idle+0x24/0x5c

Change the size to a signed integer and then trim off any part of the
FCS that was received prior to the last fragment.

Fixes: 6c389fc931bc ("gianfar: fix size of scatter-gathered frames")
Signed-off-by: Andy Spencer <aspencer@spacex.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/freescale/gianfar.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/etherne=
t/freescale/gianfar.c
index 7f837006bb6a..3bdeb295514b 100644
--- a/drivers/net/ethernet/freescale/gianfar.c
+++ b/drivers/net/ethernet/freescale/gianfar.c
@@ -2932,7 +2932,7 @@ static irqreturn_t gfar_transmit(int irq, void *grp_i=
d)
 static bool gfar_add_rx_frag(struct gfar_rx_buff *rxb, u32 lstatus,
 			     struct sk_buff *skb, bool first)
 {
-	unsigned int size =3D lstatus & BD_LENGTH_MASK;
+	int size =3D lstatus & BD_LENGTH_MASK;
 	struct page *page =3D rxb->page;
 	bool last =3D !!(lstatus & BD_LFLAG(RXBD_LAST));
=20
@@ -2947,11 +2947,16 @@ static bool gfar_add_rx_frag(struct gfar_rx_buff *r=
xb, u32 lstatus,
 		if (last)
 			size -=3D skb->len;
=20
-		/* in case the last fragment consisted only of the FCS */
+		/* Add the last fragment if it contains something other than
+		 * the FCS, otherwise drop it and trim off any part of the FCS
+		 * that was already received.
+		 */
 		if (size > 0)
 			skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, page,
 					rxb->page_offset + RXBUF_ALIGNMENT,
 					size, GFAR_RXB_TRUESIZE);
+		else if (size < 0)
+			pskb_trim(skb, skb->len + size);
 	}
=20
 	/* try reuse page */
--=20
2.15.1
