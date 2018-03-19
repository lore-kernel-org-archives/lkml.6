Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3384037-1521481926-2-5169191785556669816
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
    t=1521481925; b=FX1wU14cXJC8nlXQZXfLc8gcj5NJqLgGcnEroAnqQrCrvaF
    zGgpOkyn3TjnXxxiRuq0W1Hvrb4yWlPx6S7VGb0DWY4GNT1zG+V/Pw+a1nlY4WCT
    aDDEfqmv9VYsqab3zGVSIvly2MaxwsojRtGnvIV+w7bcRT6hAJx8si69UtxRZrTG
    7gsWlFEWaMMXQWeLYeec3dKKKhOR9WbJSJrxEh2TPbjISRpXcXTLl7coHV5xrUcp
    wfOMDL/mklPyYxLydLSmDe7GS7swg3Qayn6mjrgbMTnF3bKYteTYf/r/CVSSoPrK
    1FYf00CFEAOsU0ZsQnkaEXgH0XOYW4XhHrJuWJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521481925; bh=1nvb8L
    rYm1Z4KWKutWNLZdWSMMPMrOMb5GULfXB5Ysk=; b=iH5K02uno2DgU02qJE6a+s
    LCf5HTPxcS7miY1lhp7fsfTwSGlMlcj4j+1YprxTU8eMNCR9rxsxG5cNBs81u8Fu
    strQS0eAzFyEQoPtfW3TFAW5Xr/nFb9mBYhove97YVU/AsPnOBbXaz+Gn0zpjsfz
    2VXJY1NnSu4PTu4uCHv0FYv7uyHhmVLH3hmYigSFdN1XSCzds64+p+r2Thqqxofq
    xVEvbVe274KyBobSrUH+9zqgsEgv4aUVpaEbVmsthG4M5b39NzLPxkw5W/ejbxQv
    iS80WVAJI7D9WxyG3KHpYJq7mrHyTCcJNrM8wWrfEuwQaCpWHHnrpdAQs6qJ6W9A
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=aknQ3QhT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekfeekkeenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=aknQ3QhT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekfeekkeenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965777AbeCSRu7 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:50:59 -0400
Received: from mail-co1nam03on0134.outbound.protection.outlook.com ([104.47.40.134]:7948
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965715AbeCSQE5 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:04:57 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Willem de Bruijn <willemb@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 231/281] skbuff: only inherit relevant
 tx_flags
Thread-Topic: [PATCH AUTOSEL for 4.9 231/281] skbuff: only inherit relevant
 tx_flags
Thread-Index: AQHTv5utG6sEnSI5KUuTDjPKM/wi6g==
Date: Mon, 19 Mar 2018 16:02:28 +0000
Message-ID: <20180319155742.13731-231-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0885;7:VuWxCK7VKjb3E6s53Dup+nnePZToqSGf82G6HIAJ087E3f+tpV5GTTcc/MrhBrrbqx2h98Wq8OdxgIGyVOmDyXw5A/Ig0MDmOjAwW216KzPCIi4Ow2ztM1aavc3GcxtbaZkVBuQx4uHttlzLAgHhqyMCtsnQ+M/eKZfgiF2iBIyFKjJb/rBAfoVBwDbIlk9LqT1ApSfggIdb9khkwqZYFVhWzY0r8LKE43NSZcQNqBPGAw/H8os78LhvzBqtFaeD;20:ERziNsoJ+0ogrHVKwSaWAgqCl8vl/zXaW/61gwYISBObF33qUD1FUE1W5p75odMHEC7UUMbLBoxcZ/Z5UUE4H/1pAcsBvsA+PJI8UhNaKPeA1XB5tInXv673vdKtAgiUIcdE1fedSbRLPNcHbmDI9ORmxdA4CYBJDH7ZiDXvazk=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3da00991-c096-4f1c-a28d-08d58db325d2
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0885;
x-ms-traffictypediagnostic: DM5PR2101MB0885:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08854AD2A1CE9A3D7BBE7225FBD40@DM5PR2101MB0885.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(153496737603132)(17755550239193);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0885;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0885;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(39380400002)(39860400002)(396003)(199004)(189003)(6666003)(8936002)(99286004)(3846002)(107886003)(2900100001)(68736007)(14454004)(6512007)(72206003)(81156014)(81166006)(105586002)(4326008)(25786009)(1076002)(22452003)(86362001)(110136005)(10090500001)(54906003)(53936002)(316002)(66066001)(6486002)(106356001)(6116002)(6436002)(2950100002)(3660700001)(8676002)(36756003)(97736004)(102836004)(2906002)(305945005)(5250100002)(478600001)(6506007)(7736002)(3280700002)(5660300001)(26005)(86612001)(10290500003)(76176011)(2501003)(186003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0885;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: BcDuicjbMYeKShdAeNyVF41CMYsjdZBAEO/D1sZ575pDiHYpcj/Ua9jIg5ggx7W8DEFWYkyRnhQA6CVTVZA/WlTBHKJLYyIBa82CT+RrkWRvZaoAUvzyqp0IEfIkbzWnz9QhBP8GpNa29w1leGt+CboCmKg+ze/0owONFG2LOYyxaUTZ+EVJEWmpaqI8DuGogon5smsG9AB+rbiGChiR2LW2DureNzgBQssMpqwCMjewN478y2vvEAVIcPImxk2rRXhgRrKDkTR/fBNBgwaaNyjI3CWqvOGecI+08chPm2L8xwO5sR2fvY3Y/oq/tPw5fYFmDgw/BH5TulGYP6oGGw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3da00991-c096-4f1c-a28d-08d58db325d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:02:28.0879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0885
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
index 84725214ac5f..9c8636a10463 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -2615,7 +2615,8 @@ void skb_split(struct sk_buff *skb, struct sk_buff *s=
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
@@ -3228,8 +3229,8 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
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
@@ -3881,7 +3882,8 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb,
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
