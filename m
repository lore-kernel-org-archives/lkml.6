Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3444635-1521482542-2-10924152187257433557
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
    t=1521482542; b=jqkFxOzv9V7zLNj0H/Kv5sYCcv3AbFypQ0dbDJjivIHHEQQ
    fHqfLhTRyn0UFiTExl084QAnsa/0+eIGqnjZoqRwMHqG1LpC4zUUYipUYI+XjgMF
    ne4RD40whZSbsQZVTMssFtVqGawW9g++21SXdzyPqWGkhIUrU8Zb2H3mt4hKThJo
    MX+XstrEwIkMOTFzit6t+RgVJoZTkJxPw/Js++AXL2W5AFXlrOfWMYT16LSy2pas
    1VRn1cfdUY7B3Fv2zKwasdI89DvEvods91b1jLtRW0wRHKsrf5bayaKPBPRRO7Yd
    ZvLOAmUMCbwTKWiWIuNYWlQvLawqWixEi2DlrqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521482542; bh=MM6DKT
    TxqcqY9KKN+ta4lfPAQ+VMpb+zNjvxU7pjUoo=; b=g6ewYeIN+dHwmNgpQJocHa
    l4k5wRJFYsED73MhK5WxnwHnI3z3NU3zZtQ0gKoUebts/dBY46TOpD71DqqjdDhC
    3DtnMTe8B3V6a3/0epo6o3f9EIs++3wyW94DGpw6K6RoUP5syh/cfp7WJlC/yWP6
    JXOmh3exzClW9hxfp9QUBn0u8tWxbXwDskoOfVZNblMLY0vkjvXQyB22Gx91S900
    KgmsT6kVW+o69omS/XCfGNF3oHSsVCUscpdJ23+Mlc6NPxoHwA9QL7nXpUOBhMuX
    QLQWk46aoWeZr2wKe/oXXkaLJbdX1pmfNPuGgQ1S3IBcTAZzaLigu+yjWAI1Ox2g
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OisKQ2XI x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdekucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejgeejieenucevlhhushhtvghrufhiiigvpeefhe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OisKQ2XI x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdekucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejgeejieenucevlhhushhtvghrufhiiigvpeefhe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932923AbeCSSBd (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 14:01:33 -0400
Received: from mail-bl2nam02on0137.outbound.protection.outlook.com ([104.47.38.137]:29088
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965637AbeCSQEC (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:04:02 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Sabrina Dubroca <sd@queasysnail.net>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 196/281] macsec: check return value of
 skb_to_sgvec always
Thread-Topic: [PATCH AUTOSEL for 4.9 196/281] macsec: check return value of
 skb_to_sgvec always
Thread-Index: AQHTv5uU0nIzS+yhE0KBni90ef3hrw==
Date: Mon, 19 Mar 2018 16:01:45 +0000
Message-ID: <20180319155742.13731-196-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0727;7:O336Je4dx5iENW6+9PqTdm7qkBvwSHstUZUfFyFFSXuv0f9NPACFGPPbvuBh6Jw9T6lrC40barsgYnSlpeBxqM+SyQyuQRU9Ho7EqXS9jGJbERC/+IW2zUsBl+Zgs6DGoGKzAwdqKMkcsHZlamjeJyebkbZURfCDaceU7eNz/yzWEmJgr7ojz38xV18rqj9g70NYMFIveMSHkZKmMrO/vAW/5PZ3okIooJbNidXerP+3oNlLpfdjRZXw6xaDYAVI;20:CntwfjPvJO42r/aW3DVR5jhedDxlEeSSYFVv3B98FOwI79t1F6Iu3LMYN2jnX4AagdNHtcb6ch5uF6lD+qmFYTRjCDTD91LTlHKGZn7gIojUI91n40AB+S1bJlMUmZVgscPlWhZpR9VplcdY09kiX3xG+H1co3zSlPKYkkXvRyY=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 81359877-5002-4675-9aa8-08d58db3047c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0727;
x-ms-traffictypediagnostic: DM5PR2101MB0727:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0727E2C83206A5C0FB018C5CFBD40@DM5PR2101MB0727.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0727;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0727;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39380400002)(366004)(346002)(39860400002)(189003)(199004)(4326008)(53936002)(6512007)(81156014)(305945005)(81166006)(14454004)(6486002)(106356001)(76176011)(2900100001)(6436002)(6506007)(68736007)(22452003)(66066001)(3280700002)(6116002)(110136005)(8676002)(54906003)(10090500001)(3846002)(316002)(2950100002)(26005)(575784001)(86362001)(105586002)(6666003)(99286004)(36756003)(478600001)(2501003)(186003)(5250100002)(86612001)(97736004)(107886003)(7736002)(1076002)(102836004)(72206003)(5660300001)(25786009)(10290500003)(2906002)(3660700001)(8936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0727;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: WBnesETAKyZyiFdz1w1paw+cWsKbTKVCOPumS1I4F7R49E5twSl9wnzOdwnvjmE1HcshKDRC6y15b9BduihQToF6xVDlEcPs3BrNITIPv3X1j7lwq5w4TpVkg0naSi0WIosS/Jtm4e4NrGvDsPSqUkp3b2SPbDvxHtK1LWurnd7u6SiV7iukaHo6di/+xLf6yaeLo0rAUZ7yZYc3AYIlXuH3+qtmFwbvayVGZerTiuAkV9kZ/aJWCLneB9b4u5FFIJaECdcIB1SfQzltDZCJCZW7uBOWsEM+5ZYWx4iO9O7BvvsfYefuITOIswbNu+BUrCEnrDbrxFa/XIurELsrOg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81359877-5002-4675-9aa8-08d58db3047c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:01:45.4533
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0727
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "Jason A. Donenfeld" <Jason@zx2c4.com>

[ Upstream commit cda7ea6903502af34015000e16be290a79f07638 ]

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/macsec.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 2caac0c37059..365a48cfcbbf 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -742,7 +742,12 @@ static struct sk_buff *macsec_encrypt(struct sk_buff *=
skb,
 	macsec_fill_iv(iv, secy->sci, pn);
=20
 	sg_init_table(sg, ret);
-	skb_to_sgvec(skb, sg, 0, skb->len);
+	ret =3D skb_to_sgvec(skb, sg, 0, skb->len);
+	if (unlikely(ret < 0)) {
+		macsec_txsa_put(tx_sa);
+		kfree_skb(skb);
+		return ERR_PTR(ret);
+	}
=20
 	if (tx_sc->encrypt) {
 		int len =3D skb->len - macsec_hdr_len(sci_present) -
@@ -949,7 +954,11 @@ static struct sk_buff *macsec_decrypt(struct sk_buff *=
skb,
 	macsec_fill_iv(iv, sci, ntohl(hdr->packet_number));
=20
 	sg_init_table(sg, ret);
-	skb_to_sgvec(skb, sg, 0, skb->len);
+	ret =3D skb_to_sgvec(skb, sg, 0, skb->len);
+	if (unlikely(ret < 0)) {
+		kfree_skb(skb);
+		return ERR_PTR(ret);
+	}
=20
 	if (hdr->tci_an & MACSEC_TCI_E) {
 		/* confidentiality: ethernet + macsec header
--=20
2.14.1
