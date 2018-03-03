Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1254417-1520121339-2-17224851597544695496
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enrosk.us-ascii, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520121338; b=INiSbsooBeSDflu6jEoEsI9TK2nrqr0qA+5eMzInbo0yfdY
    45Yi024ZV2KozURCnd3pIRYUWWc2wGNnfpu5Qo1dQjVAZU6F75n4ggXhnuNys46a
    NDNjpZ37+/0/kBMz3oZk8AANY4Syx2PfJvDCuxcuybNgUjoXRGzRPt+A7Y7Oyznl
    xcqXzifvf3vodyR6aCCZkqyCQMLzKDhm6qs1ulReu4tTFXJxhWPt/NvjpukXLQu2
    Z9v1QmE+5Qb5t5OvHEoD/MsAHn2KuZmkd//Y+0U5RaokYD12w/72w91NNpr672lH
    9xFC/XrKRrSvhnqFB7kywcK0nVcymBUK5RHCbAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520121338; bh=ofqXQD
    YOEyzMu6QMi4SHTEfwDScFi8ynvGvYB1s1NW4=; b=VXkh0S20Usmlr/IbS/Lalx
    X6YG5kdv51KNPRJOJNJwKJBmb93/nT/rulSRk5mBWviqtFzZPw4AmP+IvWZ6rW2f
    S2LlYLdQRAsj/kvkNEd7cYLKFXFoQm/PuDdIv3FJltkK/GTG4a8XtY3qxE0sKOh9
    Hy+6fEpfG8GlZNd8Aj0hX2qzIhTeZEOP2wdbw9eTkoyokbLk9qSRx4675WFNYtHP
    xxnydCYYEAUM7BAkxTeuq18TpQaAd24DHE5DIQpgoAPE5JopRmErC1nsYu4+DftN
    z0m15dCRPcS7/jV/6LDH7pIU2UlF1X7VXWR9Os0mK6Pm/5ooqxPcIq0B7F4DqE0g
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ARxyamXB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ARxyamXB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933912AbeCCWc4 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:32:56 -0500
Received: from mail-cys01nam02on0126.outbound.protection.outlook.com ([104.47.37.126]:47215
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932419AbeCCWcv (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:32:51 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Davide Caratti <dcaratti@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 061/219] sched: act_csum: don't mangle TCP and
 UDP GSO packets
Thread-Topic: [PATCH AUTOSEL for 4.9 061/219] sched: act_csum: don't mangle
 TCP and UDP GSO packets
Thread-Index: AQHTsz71A1IZ9HcaVEuLjKGcrKkRVg==
Date: Sat, 3 Mar 2018 22:28:31 +0000
Message-ID: <20180303222716.26640-61-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1098;6:1OO32LjOmM3q4cTA4+0YcvKUUW+TFh95E/BBhvoMCLPYijGAl9tZ7isD+A51K727z+kqrggSoFZTaJLSktBujP7/vH9QBCxrZ7jssgckkMtOnNu7XLZHyqwLsGBNSSKi6q3Fr3zzWfGXVUm9i9SppY3+10DeJqQqk42tlSTfedQB/OshY9V105FyQHIUmiY53mk1grFvwXd9Y++eW11o9Ust+be8fbVgj8FWbQSp/tgjQqcCIarKAE/HPhuKM6zZjVXpMcqURBej9gEg8DB/CBR1mgblcL290jn6lVOyJD3Nbt3fdmMIlL6z9j5A2lGiIuCjWfaRgZmF9v0QIytdX1+SDusPJpARHJOlyv1gGqZMkn6U+uBC8YbL8NurQj92;5:pLtR3JYf5pnAp+6tPGv/Ys3a3Di5movunn0cbqtHJ4QslB5oCv08eohVBW7ipKNUX3X/vTovg2MAB/ZAwMcYi9cG93hRorwgQuLT/IQURobUpV6/HyFx+Fy7ObKbhL7XWGXRqhW/cQZ3QQ+a0e6RQ/0zu4SRx4xgt6llvdaQCLs=;24:uKR5vwQGZ4/andKhvBZbGFv7Xi1qPXadSgx2+05RaKF00WCIHUK/C1YGKSPX8/6YhOo6/6xXhLo/imBvjHeo27uQzHpND4ktWq+jg9pbVgA=;7:Fl1Lv1RhhdRhtKtO7Ide1hVb1sLer9ZuRKcBHMl0Y8BTPCgqcWo0h6yngKsQ8iF+x5BjTyKihAs522iCLGtdVR9W5maqozqmBD8QZFMtss/ygUGNUw/D0jMQVZh8vEbYcFcqvZnMHY1N9iVnbAZ6W/qNgQ29ggQw443a9BBjjdbWxqlH1+4Z+S1yTvN7hNMaojZRXC5yJGR2QkN3YmHxQ3IoSJpmiH/bdkatMq0r+xWUUjns8jnOlicoB65KsEac
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d357e49a-82a5-43fc-570a-08d58156b1d8
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1098;
x-ms-traffictypediagnostic: MW2PR2101MB1098:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB109826EC043CCE8B4678309EFBC40@MW2PR2101MB1098.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3231220)(944501244)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1098;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1098;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(39860400002)(376002)(39380400002)(366004)(396003)(346002)(199004)(189003)(2906002)(8936002)(36756003)(6512007)(81156014)(10290500003)(81166006)(99286004)(6436002)(68736007)(478600001)(3846002)(22452003)(53936002)(8676002)(110136005)(54906003)(4326008)(316002)(76176011)(6116002)(7736002)(105586002)(305945005)(3660700001)(1076002)(14454004)(97736004)(575784001)(25786009)(186003)(72206003)(26005)(102836004)(86362001)(6666003)(2501003)(3280700002)(6506007)(5660300001)(10090500001)(59450400001)(66066001)(106356001)(5250100002)(2900100001)(2950100002)(86612001)(6486002)(107886003)(22906009)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1098;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: jSKhJb8mzcmiLD1bqjb2JGh416fx+/YqS0TXlkCrO49/Lf1IGvBNuXMlAGf4hj39yEiSKzcZjEnghzm5mKvO6PKO2pWLupn8f9EUVpI+QzHxgVIFDVwgMMPSiqcAItNZ5qA8tpujnvPR2IuGOuLz/euoC+DRCbDF3VyyBexbDkQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d357e49a-82a5-43fc-570a-08d58156b1d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:31.6663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1098
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Davide Caratti <dcaratti@redhat.com>

[ Upstream commit add641e7dee31b36aee83412c29e39dd1f5e0c9c ]

after act_csum computes the checksum on skbs carrying GSO TCP/UDP packets,
subsequent segmentation fails because skb_needs_check(skb, true) returns
true. Because of that, skb_warn_bad_offload() is invoked and the following
message is displayed:

WARNING: CPU: 3 PID: 28 at net/core/dev.c:2553 skb_warn_bad_offload+0xf0/0x=
fd
<...>

  [<ffffffff8171f486>] skb_warn_bad_offload+0xf0/0xfd
  [<ffffffff8161304c>] __skb_gso_segment+0xec/0x110
  [<ffffffff8161340d>] validate_xmit_skb+0x12d/0x2b0
  [<ffffffff816135d2>] validate_xmit_skb_list+0x42/0x70
  [<ffffffff8163c560>] sch_direct_xmit+0xd0/0x1b0
  [<ffffffff8163c760>] __qdisc_run+0x120/0x270
  [<ffffffff81613b3d>] __dev_queue_xmit+0x23d/0x690
  [<ffffffff81613fa0>] dev_queue_xmit+0x10/0x20

Since GSO is able to compute checksum on individual segments of such skbs,
we can simply skip mangling the packet.

Signed-off-by: Davide Caratti <dcaratti@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/sched/act_csum.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/sched/act_csum.c b/net/sched/act_csum.c
index e0defcef376d..24a0c66394a0 100644
--- a/net/sched/act_csum.c
+++ b/net/sched/act_csum.c
@@ -180,6 +180,9 @@ static int tcf_csum_ipv4_tcp(struct sk_buff *skb, unsig=
ned int ihl,
 	struct tcphdr *tcph;
 	const struct iphdr *iph;
=20
+	if (skb_is_gso(skb) && skb_shinfo(skb)->gso_type & SKB_GSO_TCPV4)
+		return 1;
+
 	tcph =3D tcf_csum_skb_nextlayer(skb, ihl, ipl, sizeof(*tcph));
 	if (tcph =3D=3D NULL)
 		return 0;
@@ -201,6 +204,9 @@ static int tcf_csum_ipv6_tcp(struct sk_buff *skb, unsig=
ned int ihl,
 	struct tcphdr *tcph;
 	const struct ipv6hdr *ip6h;
=20
+	if (skb_is_gso(skb) && skb_shinfo(skb)->gso_type & SKB_GSO_TCPV6)
+		return 1;
+
 	tcph =3D tcf_csum_skb_nextlayer(skb, ihl, ipl, sizeof(*tcph));
 	if (tcph =3D=3D NULL)
 		return 0;
@@ -224,6 +230,9 @@ static int tcf_csum_ipv4_udp(struct sk_buff *skb, unsig=
ned int ihl,
 	const struct iphdr *iph;
 	u16 ul;
=20
+	if (skb_is_gso(skb) && skb_shinfo(skb)->gso_type & SKB_GSO_UDP)
+		return 1;
+
 	/*
 	 * Support both UDP and UDPLITE checksum algorithms, Don't use
 	 * udph->len to get the real length without any protocol check,
@@ -277,6 +286,9 @@ static int tcf_csum_ipv6_udp(struct sk_buff *skb, unsig=
ned int ihl,
 	const struct ipv6hdr *ip6h;
 	u16 ul;
=20
+	if (skb_is_gso(skb) && skb_shinfo(skb)->gso_type & SKB_GSO_UDP)
+		return 1;
+
 	/*
 	 * Support both UDP and UDPLITE checksum algorithms, Don't use
 	 * udph->len to get the real length without any protocol check,
--=20
2.14.1
