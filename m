Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3175828-1521475379-5-10252747221425783573
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
    t=1521475379; b=fi5AH28O2xloJisxk3XyEaNoq/Bb0YIkqWLsfwLoqupY8Ix
    sU5hH0lsPTbQ9CW0FpV3ghmlmgIdP4tHUt1xkbVQHBIV2PTKQD7E2CFKBlTHCnD+
    ugUDK4fsT7km8TN8XJzlLwz4fgml3eY+qaGDyInNa5nsxK6fRRstrNNCK7olvnh9
    Ubvf5VlB5MIXnegiw8SSNP9Jus3SLEvkwakJQlA1CsSG7d0AyBh6p9269aWtqIce
    GIYEvuzlO4vD0SCcCI6qFmWEpdPQ/spZeVrwPUMKuXaxh61tZ/Hi4hbRLpseg5kG
    /4KtBY2f8hKodc8WgZCIn/CTqpf4M8sUZyMeBLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521475379; bh=uP+3hm
    xriXDtfnCsiVPaTPXb8cdW5YSCRcUiPOyh0gA=; b=kjoZIeQCzXc+3vVLtTaGUA
    xpnytdV8Ug6HiAZHQCX4LdqzY7lZt1mqngMD4y314QnWKr1VLlrnqkj2Xw0ADWEB
    I+z5paJZuSP6S7IdRiH2sNtcMXDhyD6IqjDdbH0ZQK5t1hY+eXL3yTzWTGEmctWK
    Bap8xqGQLSLjRvn0MvriyX2UaA7uQvs71ieOqwZMg0lI9SDtMVtW6QrSIvsaKLgx
    RvRvSq4C/253jDmmCXuIVVcl9yl/+sXbSKTW1afaaALHazWUyOHdm7JDbmdz2p7u
    1arRMVsksakE0zaDXyvGftK3AmOTzI5eGo1z1uL7gVB+g1uRcGxoNenA8bSLcDdw
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=k84AnNKe x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekfeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepleeftddunecuvehluhhsthgvrhfuihiivgepudefud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=k84AnNKe x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekfeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepleeftddunecuvehluhhsthgvrhfuihiivgepudefud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965020AbeCSQCs (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:02:48 -0400
Received: from mail-dm3nam03on0119.outbound.protection.outlook.com ([104.47.41.119]:22560
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934836AbeCSQCk (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:02:40 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 154/281] netfilter: conntrack: don't call iter
 for non-confirmed conntracks
Thread-Topic: [PATCH AUTOSEL for 4.9 154/281] netfilter: conntrack: don't call
 iter for non-confirmed conntracks
Thread-Index: AQHTv5t39JhYyY6A+kW59RAF2WPzuA==
Date: Mon, 19 Mar 2018 16:00:56 +0000
Message-ID: <20180319155742.13731-154-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1062;7:9dOj2afrEjAFF8LpbrIiHONI4m6zRUH92EJqkB9vl35pL+sIJOFE/zo+zWjhxV0lzK6u/sLgaySlwTmYbHrGJlSfrKiAcoPeQNmFtt8iIl+IL4GU1MGDvSR3+31BPPWvNUUD0qAaEOaNaomANjqGCVTvxtfzhAAkhgKUgEWsXD+xzR0/uafnNmKmCDsxHvmmuvQNHMPgfTPaQ/nYPEu0gSYtlc6loCTpG1caH8piFyYitoFRVcaMrkhJaGkWFGcm;20:9f3t+aq+8Az0rVhlIjkRJGrWy9Ip7GNAtCa/aMfHQozH7rDx8vJNvup5MdYgFzTw2UGKVFkWLUGNtujDO3wA5Ofd/5g3//Q+2XScE6ujbJZWfNF+wKtP5MG+9ZPHpuc7IZzKTC6Ag8ea1kbX49R2gDRjjOh/Efe58HXrtgivlzc=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fda53e34-e0de-453d-394b-08d58db2d5a7
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1062;
x-ms-traffictypediagnostic: DM5PR2101MB1062:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1062FC30626BD24042B20BC9FBD40@DM5PR2101MB1062.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1062;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1062;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(346002)(366004)(396003)(39380400002)(199004)(189003)(106356001)(10290500003)(478600001)(110136005)(22452003)(3280700002)(6666003)(54906003)(2906002)(2900100001)(2950100002)(186003)(10090500001)(97736004)(26005)(5660300001)(72206003)(66066001)(53936002)(107886003)(102836004)(59450400001)(6512007)(6506007)(316002)(7736002)(305945005)(1076002)(6436002)(36756003)(3846002)(6116002)(6486002)(105586002)(8936002)(86612001)(68736007)(3660700001)(86362001)(575784001)(81166006)(81156014)(8676002)(25786009)(2501003)(4326008)(76176011)(5250100002)(14454004)(99286004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1062;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: EuS1hsVMJVsFwKyeeXmauoSLAElOk3dDbrxRzeFCL38WJo7k6iBd2bwbztTUYesgwkDVka348+ULT9plYC60AhjdUo47j7aYWrLtSp5d5EAUY3CMU0Y0dXqUnFBXTkh7lkpH2450f3bcFrmYFFDbLlw/RkMEQAiEhv9++KmsVNtoTPM5uQFES3PxwIjcKxPDkyQqj8moihSt0R1vWJhiuc73lV4/bdRGov8oRYanBCTtHdYJW4rw2IqkIWe4hye1qbT+4cOcCMN4MZiDC8a4FnsmoKpArXSTv3190mC22UNTeBg7nLhaJqpLg8Q6GMLZdM52uukg9d5lIifco0623g==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fda53e34-e0de-453d-394b-08d58db2d5a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:00:56.2900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1062
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Florian Westphal <fw@strlen.de>

[ Upstream commit b0feacaad13a0aa9657c37ed80991575981e2e3b ]

nf_ct_iterate_cleanup_net currently calls iter() callback also for
conntracks on the unconfirmed list, but this is unsafe.

Acesses to nf_conn are fine, but some users access the extension area
in the iter() callback, but that does only work reliably for confirmed
conntracks (ct->ext can be reallocated at any time for unconfirmed
conntrack).

The seond issue is that there is a short window where a conntrack entry
is neither on the list nor in the table: To confirm an entry, it is first
removed from the unconfirmed list, then insert into the table.

Fix this by iterating the unconfirmed list first and marking all entries
as dying, then wait for rcu grace period.

This makes sure all entries that were about to be confirmed either are
in the main table, or will be dropped soon.

Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/netfilter/nf_conntrack_core.c | 39 +++++++++++++++++++++++++++++------=
----
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/net/netfilter/nf_conntrack_core.c b/net/netfilter/nf_conntrack=
_core.c
index 750b8bf13e60..2039fd7daf4e 100644
--- a/net/netfilter/nf_conntrack_core.c
+++ b/net/netfilter/nf_conntrack_core.c
@@ -1542,7 +1542,6 @@ get_next_corpse(struct net *net, int (*iter)(struct n=
f_conn *i, void *data),
 	struct nf_conntrack_tuple_hash *h;
 	struct nf_conn *ct;
 	struct hlist_nulls_node *n;
-	int cpu;
 	spinlock_t *lockp;
=20
 	for (; *bucket < nf_conntrack_htable_size; (*bucket)++) {
@@ -1564,24 +1563,40 @@ get_next_corpse(struct net *net, int (*iter)(struct=
 nf_conn *i, void *data),
 		cond_resched();
 	}
=20
+	return NULL;
+found:
+	atomic_inc(&ct->ct_general.use);
+	spin_unlock(lockp);
+	local_bh_enable();
+	return ct;
+}
+
+static void
+__nf_ct_unconfirmed_destroy(struct net *net)
+{
+	int cpu;
+
 	for_each_possible_cpu(cpu) {
-		struct ct_pcpu *pcpu =3D per_cpu_ptr(net->ct.pcpu_lists, cpu);
+		struct nf_conntrack_tuple_hash *h;
+		struct hlist_nulls_node *n;
+		struct ct_pcpu *pcpu;
+
+		pcpu =3D per_cpu_ptr(net->ct.pcpu_lists, cpu);
=20
 		spin_lock_bh(&pcpu->lock);
 		hlist_nulls_for_each_entry(h, n, &pcpu->unconfirmed, hnnode) {
+			struct nf_conn *ct;
+
 			ct =3D nf_ct_tuplehash_to_ctrack(h);
-			if (iter(ct, data))
-				set_bit(IPS_DYING_BIT, &ct->status);
+
+			/* we cannot call iter() on unconfirmed list, the
+			 * owning cpu can reallocate ct->ext at any time.
+			 */
+			set_bit(IPS_DYING_BIT, &ct->status);
 		}
 		spin_unlock_bh(&pcpu->lock);
 		cond_resched();
 	}
-	return NULL;
-found:
-	atomic_inc(&ct->ct_general.use);
-	spin_unlock(lockp);
-	local_bh_enable();
-	return ct;
 }
=20
 void nf_ct_iterate_cleanup(struct net *net,
@@ -1596,6 +1611,10 @@ void nf_ct_iterate_cleanup(struct net *net,
 	if (atomic_read(&net->ct.count) =3D=3D 0)
 		return;
=20
+	__nf_ct_unconfirmed_destroy(net);
+
+	synchronize_net();
+
 	while ((ct =3D get_next_corpse(net, iter, data, &bucket)) !=3D NULL) {
 		/* Time to push up daises... */
=20
--=20
2.14.1
