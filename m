Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3293580-1521478028-2-14661334445704328336
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
    t=1521478027; b=KUckm7MjVtUjjTG/tBC4/KftaKHBc45NikTh/reeAUgWAA2
    96EfxNi6ilWn59aW+Su51Dsuw6yJ8YYZAgK+JYnbawgxRuZOcpv4t2xTXm+Mc2WZ
    aSTW4frX/VXGFSL0XSQ4lt42CddnNgxkrMlOmqoddAgYYWmhLN6DzTQILoHBBmve
    mLAdD95ATrxIp/1XEvjddmch86IC1ZCLxogGbB6LjX+sxyq4aEwB2q76zt0uaGCr
    BCP4uJDd4AZwOsxieL90krr5+XaFCiqnMhm1quvlYJDYjjEHryyC+64XaQCXdfuF
    qejjN9Ai4Hg3PrAyXDvzGibmq91GppSZnRSk/1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521478027; bh=E/JiuT
    vVpJ34ajKCA+KZy9OVbEi5cBPkRuQKinTNesI=; b=tjUnWfpHlWXOpByt76To9w
    U+ad5sGF4FRIUmPzn5gTv3eg5b9DDYjBPmEI+gmrgaNZViXASHVoK6s2n8yAoKrd
    TGVIO7WXFszslHqsFd1ooAGFWCC194U/iBbiF1aJiKoOIPHxe0e9XUg3waSSkmun
    UfQgx8h+X9aRvQ42DkXjtc8rGoQ1dbINU/gjJ4fka1BowbCEDJwy7zKx5jDoKXoB
    xz7HYZbD3pRxYbuhw1SJEzzUxaU0qPPXp+VpGyVMp4wBCkZT+xm+TWz45goC029Z
    FocJC1wpqEISap0G0aOsR+b1cUYI5GJbxZaXDgyDYI+Rz/iVbJb02ewbMDAdsXIA
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CS3eX+WU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelfeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepuddtvddtjeenucevlhhushhtvghrufhiiigvpeelge;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CS3eX+WU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelfeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepuddtvddtjeenucevlhhushhtvghrufhiiigvpeelge;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967283AbeCSQp4 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:45:56 -0400
Received: from mail-by2nam03on0114.outbound.protection.outlook.com ([104.47.42.114]:59520
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935139AbeCSQMQ (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:12:16 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Ihar Hrachyshka <ihrachys@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 028/102] neighbour: update neigh timestamps
 iff update is effective
Thread-Topic: [PATCH AUTOSEL for 3.18 028/102] neighbour: update neigh
 timestamps iff update is effective
Thread-Index: AQHTv50E2DxcGW7RIES9n0zkKc9ZdA==
Date: Mon, 19 Mar 2018 16:12:02 +0000
Message-ID: <20180319161117.17833-28-alexander.levin@microsoft.com>
References: <20180319161117.17833-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319161117.17833-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0920;7:RFnvR6DpbZMg5tCek/lBrKStg+uNT3usfQ6/fxFNo0KrE3mnbCNyNO+Yx1Dkqvuj0sZVSeEXCAzRjVPpooACApDqyxDoq0RRstbdMD4eEXo2jwoa5W5gVjS9SyynJwOcGGunK2LZXL8hYiGt8ewbJklG9CQvDoSkKRQ67hiosAREvKDRsstr/iZqD2SdmBi3bUNFD8gJICOmT2yvVLPjtQkwOM7uL+LIUhE7uC51+rxsf/MDRT+5eehpSrrB6PWK;20:Zo0Iw+a2dXZ46iHRPH/cM+xOjzK2VHt93J8BIQc1DyUQwQld7MMIOOowlnLLqxdjwToPP4F8giZHdJhXLb8YgEDETEh3MvC8FWIiDPi3TPeMuANcglhsVEfxOuj6P2fmWTiiEcQXDPvxOyqcxfc6/DroG1400lr6vi0AT4nLJP0=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b1a7e294-a6b8-4a0b-37e9-08d58db429f3
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0920;
x-ms-traffictypediagnostic: DM5PR2101MB0920:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09202EF932A62FB33B590724FBD40@DM5PR2101MB0920.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(17755550239193);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0920;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0920;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(396003)(376002)(39860400002)(366004)(189003)(199004)(6512007)(14454004)(2906002)(2900100001)(8936002)(186003)(86362001)(5250100002)(316002)(97736004)(2501003)(6116002)(1076002)(3846002)(81166006)(6436002)(6506007)(59450400001)(6486002)(26005)(72206003)(81156014)(53936002)(102836004)(478600001)(10290500003)(8676002)(107886003)(6666003)(4326008)(3660700001)(66066001)(25786009)(2950100002)(86612001)(36756003)(15650500001)(54906003)(110136005)(3280700002)(7736002)(305945005)(5660300001)(76176011)(68736007)(22452003)(10090500001)(105586002)(106356001)(99286004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0920;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: nTsSm2VeJlAL/KmaL6AoUyFNTU+gA09PD7w+wA8O4yAq+ywjdyryPrhHQtyODHGwk9IcU6RELrtobPb3siEny62EBDQODhk17AkDkGJBp3nzSDnABHXSfBw4OoHXTawD4iVVqLhyHhbkB57U0rUHDvHuzkuNKJ9ndq2iWqtT4dxnftow8nFZN1YhCjsLQPsB6N1ugTdE3FUZb0mNsPa01Q9n8i5invCgWcfO6Gz3likFAD2gCE+8PhskuAelaB04Xp/b7jzapezEjAhwZiNC00K4f8ADjAHMQ9SmmM8keVH/Fs8audLoMk0eLFJSO4I7aEEafaSGDvaIiralDSG+Ow==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1a7e294-a6b8-4a0b-37e9-08d58db429f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:12:02.4438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0920
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
index 11dc427320bd..73018d173223 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -1147,10 +1147,6 @@ int neigh_update(struct neighbour *neigh, const u8 *=
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
@@ -1174,6 +1170,16 @@ int neigh_update(struct neighbour *neigh, const u8 *=
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
 		if (new & NUD_IN_TIMER)
--=20
2.14.1
