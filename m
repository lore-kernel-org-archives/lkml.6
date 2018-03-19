Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3827995-1521495158-2-15815097656674085114
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521495157; b=cI144CP+bKYDD+O7AjitnnnDmhdMi9lKa8ri/A0A4E2kOXA
    eTgyiw05c50FsIDNqj8lIbmtdTr4brIDlUkJfZbP05TjiFBppa8HDNQR8NxCIdWr
    o5nMgwUC0Jxn5FItg9f0Y8AlCwvn/eMk2g0/rPkDaYS/N4uk4MoOoUtD4J1sJn+T
    mSM1sQUwL3Bl7foX/cV/4kuX09D+EkY/inoDY2UtmV5P2F0hSAycPZzA7pA3GXUV
    bf+IVYndJ+i8CHqD0yTAY0+Eunww05qy9Pg8jrpllrNgbNMv2HMyGsEToVQnSUgw
    2CdmAuF8UG8myS0epnUZtkqbbD+0ZhiDtKBxzIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521495157; bh=gIyV7j
    cgi2jErqN+/VeX7CbMkce00EMnaT9hhlMgv/8=; b=IOt/+Z9sNjPERM5QqboFe0
    3hhzdiJwbDWe5loZXOeBigtSGFdjkxVk0oS6quufFV21ccV2jQ0l0jf+28JL6+Uk
    Ng3DvyZDA8QYVTeUWDsIPloCr4cncPaFy2SU0l2pt6FZ4eQLhMb9UVauAV++hzfD
    s+IZ4t3FNP6BGOfKDrJI80bm7HPIExjyOqG0j3osNIIX4oA2eK9PWzrKMEZLX7Q4
    nWSQsWFbEXkPz4IBTraHXwgB2wXW7gs8jNXbZDdDQg6DsN8FpstyiSQ3oSCriU5P
    IU7I/Eky1Bn/3BRHK26sjeX9Ab+3Bh3hKn4L47a18BHlM9Su3ei5Ah7KSCerVH3Q
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CHo8qHEu x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpedutddvtddunecuvehluhhsthgvrhfuihiivgepieel;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CHo8qHEu x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpedutddvtddunecuvehluhhsthgvrhfuihiivgepieel;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970658AbeCSVcI (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:32:08 -0400
Received: from mail-by2nam01on0128.outbound.protection.outlook.com ([104.47.34.128]:43648
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965087AbeCSQAA (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:00:00 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Ihar Hrachyshka <ihrachys@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 063/281] neighbour: update neigh timestamps
 iff update is effective
Thread-Topic: [PATCH AUTOSEL for 4.9 063/281] neighbour: update neigh
 timestamps iff update is effective
Thread-Index: AQHTv5szqk5Lt3ThD0C7KM5dofQ3gw==
Date: Mon, 19 Mar 2018 15:59:03 +0000
Message-ID: <20180319155742.13731-63-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0965;7:I5TP+a8owJYn974n7EslpDD/8mtWhyYSm1eEPA5iyLwDbhCbwrVaLmh2ZT9RtnrcmWxXGJF60yjQwRRUYuYpjO5hEfsl9vrIlSpZOdvI4wkq9YhHwEvQuXDKflQ7dKXZ92qn02t5ZTyUYqSRDLySZryGVu8TUJDYPcq4BQnmVhL3oUuf4MsRw2ZFL1sR4pmUJhkD246pnY1g1aB7mYcuddDVtDuaI11l4YL/O+1Eo1cKTZXDN8e5gi4cE4Dtjtkn;20:EDvGGFCIXobGy8gLCD1+0O7FNPnjkofwN2zHaeWQsvkLux1tVfb2tv5hXIrYOv7+ua6Imm415u9v+uUbHvZScWuUwXfrSLz8i2XqndM+DYCGhloVMRhB8PcN92zlRxdSenn3T5wyhtPcoZlJI0sowrFmcDgdxFuOMAuUJJ/MXW4=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3704a8db-fdbf-40bd-55a0-08d58db2753d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0965;
x-ms-traffictypediagnostic: DM5PR2101MB0965:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09657B7D906FC249EC3F4BF9FBD40@DM5PR2101MB0965.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(17755550239193);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0965;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0965;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(39860400002)(376002)(39380400002)(189003)(199004)(25786009)(7736002)(6506007)(86362001)(15650500001)(86612001)(10090500001)(478600001)(53936002)(6666003)(6512007)(36756003)(2950100002)(8936002)(110136005)(54906003)(105586002)(14454004)(107886003)(72206003)(10290500003)(316002)(102836004)(2501003)(59450400001)(5250100002)(99286004)(22452003)(305945005)(6436002)(6486002)(1076002)(76176011)(26005)(4326008)(186003)(97736004)(106356001)(3660700001)(3846002)(6116002)(5660300001)(68736007)(2900100001)(8676002)(81166006)(81156014)(3280700002)(2906002)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0965;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: C+tL54Av7VwBh9q/VEWzX0NHKSBLJKnZz0XcNT4R/iO38kIBnTWj0fprJbJvg+4SlfptfO0PiGuN1KDm2wO3Mtt5o1BjmbyeRuiU8xJLvkBs9T6+1ga2DTJ887jeqqwBMRknA+5XqCaRSIlIivw/zlJj9CjVCapih2MjDOebqlTOe7IqVmMtHjBJPLdT/RyP24/9V+d9iFadjSk3ETiPEOygWZIrTTuRNIkVQmdRHxqqs9LZuYsRIWKEx7QOG7OX0PXvQ9xkb4gsN045KHmQ5lHvB1mJaoynuzO38ZlXvh8ol17W0YoQj9l1/t5hgUIqRAK7OkNRBIjfEi6hAGGUFA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3704a8db-fdbf-40bd-55a0-08d58db2753d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:59:03.8199
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0965
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Ihar Hrachyshka <ihrachys@redhat.com>

[ Upstream commit 77d7123342dcf6442341b67816321d71da8b2b16 ]

It's a common practice to send gratuitous ARPs after moving an
IP address to another device to speed up healing of a service. To
fulfill service availability constraints, the timing of network peers
updating their caches to point to a new location of an IP address can be
particularly important.

Sometimes neigh_update calls won't touch neither lladdr nor state, for
example if an update arrives in locktime interval. The neigh->updated
value is tested by the protocol specific neigh code, which in turn
will influence whether NEIGH_UPDATE_F_OVERRIDE gets set in the
call to neigh_update() or not. As a result, we may effectively ignore
the update request, bailing out of touching the neigh entry, except that
we still bump its timestamps inside neigh_update.

This may be a problem for updates arriving in quick succession. For
example, consider the following scenario:

A service is moved to another device with its IP address. The new device
sends three gratuitous ARP requests into the network with ~1 seconds
interval between them. Just before the first request arrives to one of
network peer nodes, its neigh entry for the IP address transitions from
STALE to DELAY.  This transition, among other things, updates
neigh->updated. Once the kernel receives the first gratuitous ARP, it
ignores it because its arrival time is inside the locktime interval. The
kernel still bumps neigh->updated. Then the second gratuitous ARP
request arrives, and it's also ignored because it's still in the (new)
locktime interval. Same happens for the third request. The node
eventually heals itself (after delay_first_probe_time seconds since the
initial transition to DELAY state), but it just wasted some time and
require a new ARP request/reply round trip. This unfortunate behaviour
both puts more load on the network, as well as reduces service
availability.

This patch changes neigh_update so that it bumps neigh->updated (as well
as neigh->confirmed) only once we are sure that either lladdr or entry
state will change). In the scenario described above, it means that the
second gratuitous ARP request will actually update the entry lladdr.

Ideally, we would update the neigh entry on the very first gratuitous
ARP request. The locktime mechanism is designed to ignore ARP updates in
a short timeframe after a previous ARP update was honoured by the kernel
layer. This would require tracking timestamps for state transitions
separately from timestamps when actual updates are received. This would
probably involve changes in neighbour struct. Therefore, the patch
doesn't tackle the issue of the first gratuitous APR ignored, leaving
it for a follow-up.

Signed-off-by: Ihar Hrachyshka <ihrachys@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/core/neighbour.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 7b315663f840..a426790b0688 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -1130,10 +1130,6 @@ int neigh_update(struct neighbour *neigh, const u8 *=
lladdr, u8 new,
 		lladdr =3D neigh->ha;
 	}
=20
-	if (new & NUD_CONNECTED)
-		neigh->confirmed =3D jiffies;
-	neigh->updated =3D jiffies;
-
 	/* If entry was valid and address is not changed,
 	   do not change entry state, if new one is STALE.
 	 */
@@ -1155,6 +1151,16 @@ int neigh_update(struct neighbour *neigh, const u8 *=
lladdr, u8 new,
 		}
 	}
=20
+	/* Update timestamps only once we know we will make a change to the
+	 * neighbour entry. Otherwise we risk to move the locktime window with
+	 * noop updates and ignore relevant ARP updates.
+	 */
+	if (new !=3D old || lladdr !=3D neigh->ha) {
+		if (new & NUD_CONNECTED)
+			neigh->confirmed =3D jiffies;
+		neigh->updated =3D jiffies;
+	}
+
 	if (new !=3D old) {
 		neigh_del_timer(neigh);
 		if (new & NUD_PROBE)
--=20
2.14.1
