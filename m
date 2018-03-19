Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3293580-1521479224-2-9390374033537525428
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521479223; b=g0068Ok+ni6tJDHBBQ1XScPIsRh69zgPy2SvCNVDZQirHyr
    uwtPh0mCVVOltAkuMkqYc0DdzCyQWjHMBz29RsrtKfHIvpA9Ka3bug8dih7jXQnO
    YfvPytKixXkT5YZ2kPxs8hnY1yCyvKbQF4096nV1BVZNwr2/hfeP/hMIL+3IVPXh
    H3iuQebV0xf2gY858pdWx1/0jIbwOmv6UA3+ziCynQXBG8hSJTKR3NQqtUM47OAF
    veCR1XgaILVa/ykiM95Rht0QlB+xjFZaHUzWwLUDx18EVlC6qxPPyuzVd0IdFiAX
    Ss8geGTSF+CMzbuutSCgG7cbXSSp+fs9zlfRbfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521479223; bh=Ag0Btm
    I1lwEq3lIxgPPlvzDgZpvddwduTdkMWW430C8=; b=JOreH2Ek/VFsnLRszQ5edZ
    22uYD79muV/a2qvz7SeevkX+A59YRymCeaoFX1jlHa0pXnlJboOaH17ek7mMvvnG
    l6d2m75HrvEVmnKCOyg+TtfWF493SmvWDyEOMbSazvOA800cmdNq9l1UnCZLqhUc
    0Ejhq/FJa/KC34m6grGktkEzpAWIU73y1zzbQZJpaqYwgwgP5HvP1qrvt6DYkHFd
    IoAuMbgFTv/17ONvBU+cHOjSep9dTwma23uqUgt6hyT4FeLCT6pftHmPDYw/1lcy
    0pkaz1Olgtb4G4XZEaLDyDD775I44XUvhqV0KPFcl9DNnEuTqtpWs2T28rU8iRiA
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=QXxsiR15 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdeljeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkeefleeknecuvehluhhsthgvrhfuihiivgepgeef;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=QXxsiR15 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdeljeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkeefleeknecuvehluhhsthgvrhfuihiivgepgeef;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935640AbeCSRGu (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:06:50 -0400
Received: from mail-bn3nam01on0108.outbound.protection.outlook.com ([104.47.33.108]:5984
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966438AbeCSQKy (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:10:54 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Willem de Bruijn <willemb@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 141/167] skbuff: only inherit relevant
 tx_flags
Thread-Topic: [PATCH AUTOSEL for 4.4 141/167] skbuff: only inherit relevant
 tx_flags
Thread-Index: AQHTv5x/RojlwOv5vUGrGmqifSGUQA==
Date: Mon, 19 Mar 2018 16:08:19 +0000
Message-ID: <20180319160513.16384-141-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1095;7:mGf0vFgpnsX0tXSySNVqIA6ZfSWwbGm4rtvFKqUSKzcnTqgzy0NT42v7ffl6jhvdFC1iTyl18Ftj7RuNvduYU26WbWt16XZ0Sxg6q9EKdWalCUFCtz8k3GutYp5i8F6sTX6Pvy09jj/kds1sCzQ4wHBy9wS6QCkXh56SZkTk2fFb8LBPNjQEJAV8lgogq6YFojy6FLCbB6tVQrLIfjN0/mO82FIoX6ChrXFBZD/xctXbhUuivD0LVfFfhMyMTSdC;20:H9+If1Aw3dc4mRZOrHvrZi75ljkglGcZHnLegyUFxRrxgTz4AtrabDPTRJKq/Z/gMZOkzV7Fwyr/V1lZBb0kloGu2u6+f13/9jUv38MDEcb2oT0ZIdNvQ8zP4VvjwwNs0iumS+Hy4KwNlqhtBWtonrC7HhmfwzANWAgLNYhmwLg=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f557cb4b-ecb3-4bdf-9beb-08d58db3f8eb
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1095;
x-ms-traffictypediagnostic: DM5PR2101MB1095:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10958A5610705DA760F61171FBD40@DM5PR2101MB1095.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(153496737603132)(17755550239193);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1095;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1095;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(39860400002)(396003)(39380400002)(189003)(199004)(305945005)(316002)(1076002)(7736002)(14454004)(86612001)(25786009)(8936002)(2950100002)(110136005)(66066001)(186003)(10090500001)(6666003)(5250100002)(2501003)(99286004)(76176011)(86362001)(575784001)(4326008)(68736007)(3660700001)(105586002)(8676002)(81166006)(81156014)(106356001)(3280700002)(72206003)(10290500003)(478600001)(2900100001)(97736004)(54906003)(6512007)(53936002)(6506007)(102836004)(6436002)(5660300001)(6486002)(107886003)(26005)(2906002)(22452003)(6116002)(3846002)(36756003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1095;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: qwnN5RispdaroHSQka+mF64sGy+LTtj1s4YnmewGmfB04d+KH8LLipkm9luPTbMfO6fg/0O6P9Ia3xlc7bhJe7kQHcI35s3v4eTuL2m4g+YIEA9rk9Yr3lvn/Dt5IPdUW6R8ml94pLSc7X608JEJqjkSK9SeCCS4SRiUJ9FKxVKxavHi/zpOq5fzwns2aSS7QTl+g7UhfvEW527wvdOpYSUb95DAyxsRkikFwvh45QDPj+KfWnuVDGBYpXjqdAk1SDOnycxuy0IRcigfwLJQ8Bwo7Kqt75tlbbAzcFrMTJLlb+/HVnT55FgUeseCVBOh1UBxy7nHM7JzC6nqM3havg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f557cb4b-ecb3-4bdf-9beb-08d58db3f8eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:08:19.9603
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1095
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Willem de Bruijn <willemb@google.com>

[ Upstream commit fff88030b3ff930ca7a3d74acfee0472f33887ea ]

When inheriting tx_flags from one skbuff to another, always apply a
mask to avoid overwriting unrelated other bits in the field.

The two SKBTX_SHARED_FRAG cases clears all other bits. In practice,
tx_flags are zero at this point now. But this is fragile. Timestamp
flags are set, for instance, if in tcp_gso_segment, after this clear
in skb_segment.

The SKBTX_ANY_TSTAMP mask in __skb_tstamp_tx ensures that new
skbs do not accidentally inherit flags such as SKBTX_SHARED_FRAG.

Signed-off-by: Willem de Bruijn <willemb@google.com>
Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
Acked-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/core/skbuff.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 02f0a705ee96..620dc871f7de 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -2551,7 +2551,8 @@ void skb_split(struct sk_buff *skb, struct sk_buff *s=
kb1, const u32 len)
 {
 	int pos =3D skb_headlen(skb);
=20
-	skb_shinfo(skb1)->tx_flags =3D skb_shinfo(skb)->tx_flags & SKBTX_SHARED_F=
RAG;
+	skb_shinfo(skb1)->tx_flags |=3D skb_shinfo(skb)->tx_flags &
+				      SKBTX_SHARED_FRAG;
 	if (len < pos)	/* Split line is inside header. */
 		skb_split_inside_header(skb, skb1, len, pos);
 	else		/* Second chunk has no header, nothing to copy. */
@@ -3115,8 +3116,8 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 		skb_copy_from_linear_data_offset(head_skb, offset,
 						 skb_put(nskb, hsize), hsize);
=20
-		skb_shinfo(nskb)->tx_flags =3D skb_shinfo(head_skb)->tx_flags &
-			SKBTX_SHARED_FRAG;
+		skb_shinfo(nskb)->tx_flags |=3D skb_shinfo(head_skb)->tx_flags &
+					      SKBTX_SHARED_FRAG;
=20
 		while (pos < offset + len) {
 			if (i >=3D nfrags) {
@@ -3734,7 +3735,8 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb,
 		return;
=20
 	if (tsonly) {
-		skb_shinfo(skb)->tx_flags =3D skb_shinfo(orig_skb)->tx_flags;
+		skb_shinfo(skb)->tx_flags |=3D skb_shinfo(orig_skb)->tx_flags &
+					     SKBTX_ANY_TSTAMP;
 		skb_shinfo(skb)->tskey =3D skb_shinfo(orig_skb)->tskey;
 	}
=20
--=20
2.14.1
