Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3357373-1521479551-2-6929469383553911701
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
    t=1521479550; b=oJaZtimZ8N4Xl2gjQ4f49FVhwXpYYdIpev1qVVrBWqqz1QM
    80omYE0jZ5Ax4iLTL8JJMfR1TxPVK6Zmtk0NYlp3gnb1brCOiKauV1DSfni0ZhVK
    ob0OqhW60cM0wmtYbJzeelj3nV4WqW5zzXfr8PiX76zarFd4uwKx5iBXWKH4rz1X
    sq0V2KLhQ27d1TFr2+IzhU2COFfbgkU15Rjwsc3krRlQieja8U4OHYGlgmUSenQ+
    V0eWLVedFKIRVrEvk9VD0YKi/jmqJ5xMBsW/o/+yr+OIigtIjaG2Lw2M3fILqVfs
    q2cRvjpAxdVnqorN+AqRh90UBE3X2YXS9+hdJeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521479550; bh=1O0BNp
    6d6TqsPyruCSHEcXQq99WsGMltaG5ijaENWM4=; b=YuNHEsqwqxRUDQO1/z09WT
    zAYp1dDCXMHCcgOXNpZooQlYU8xeVqbWeuFqRN4Q76eMV1ESx17mqM0M//CMx8BN
    3LtDn9IywfnEILG8tSQ0feRqYPAIWoxWr0qgqpv/oDxEGr03JxebaYKKw5eBci76
    jfJFSzmjh7ehRz5aLEJWQEDWowzy8QgLnnch5Y8rbtmuGVDStlI9a90a0fKUBhgd
    wj4E5l7wDTx4n6nmNLZvgxd/VETACfd5SzMbfXUpp7bT0qwdYJxMSOpYCMFU9+WH
    7i3UfWs25JFcvs42AVHjHEM7ln34ezTx+48HCipwIfTBpyf9F0y91riDXQBovaGw
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=T6cUP3/G x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelkeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepudefgedukeenucevlhhushhtvghrufhiiigvpeehie;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=T6cUP3/G x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelkeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepudefgedukeenucevlhhushhtvghrufhiiigvpeehie;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967564AbeCSRMO (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:12:14 -0400
Received: from mail-bn3nam01on0125.outbound.protection.outlook.com ([104.47.33.125]:62326
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966255AbeCSQKg (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:10:36 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        David Howells <dhowells@redhat.com>,
        Sabrina Dubroca <sd@queasysnail.net>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 121/167] skbuff: return -EMSGSIZE in
 skb_to_sgvec to prevent overflow
Thread-Topic: [PATCH AUTOSEL for 4.4 121/167] skbuff: return -EMSGSIZE in
 skb_to_sgvec to prevent overflow
Thread-Index: AQHTv5xwvtKs8cK1nEqevVHrbU0ZYA==
Date: Mon, 19 Mar 2018 16:07:54 +0000
Message-ID: <20180319160513.16384-121-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1045;7:qgEHI6uT3G6Deb9XkDX+KsIMwaWQ/JMC9AhpShFShS5VZJRRI5NNOm9WEpz+jAESLw+Sztanp2HGLPf5XmHrKs9d25TTu2ABflKwtcI/mCKSOyMPv8hVdcP9dECoH2x4KR9bDtEVEH3lQqfOATcreVSv+STpjx7i3+/xOy2B25Boa9XBMEuUI7/JGipTlQeXTPTrM6UCgVXvC3jIFbFUSqu7/aLajkCsjJdjHzBvJhbhNbzL/R2299PaQZH4SJ6J;20:66+/pE9Qe5hw/Kdj+WwY8/vHgGvL5THTzNomnSethZ8gopQoGbzwFNoU6QGkvVL4ZqgENKT9MffaALb7NFTUs2jU9khJ2kY4V/gz4E27+mRNDqqh8uuNEp1+kj0M6utXHX/58ornhs9Hxrkjde/kG7YKvdDR6XW1ZU3FNjAf3S4=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2fc801f1-6156-4591-3948-08d58db3f1e6
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1045;
x-ms-traffictypediagnostic: DM5PR2101MB1045:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1045713C20E076FE68A7DB9EFBD40@DM5PR2101MB1045.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1045;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1045;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(39380400002)(39860400002)(396003)(199004)(189003)(86612001)(66066001)(6436002)(76176011)(5890100001)(10290500003)(6666003)(2950100002)(305945005)(8676002)(97736004)(6486002)(86362001)(25786009)(26005)(575784001)(102836004)(8936002)(6512007)(7736002)(3280700002)(106356001)(107886003)(110136005)(68736007)(81156014)(22452003)(6506007)(186003)(54906003)(10090500001)(2900100001)(4326008)(2906002)(14454004)(81166006)(316002)(105586002)(6116002)(3846002)(5660300001)(36756003)(72206003)(1076002)(59450400001)(53936002)(7416002)(3660700001)(99286004)(2501003)(5250100002)(478600001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1045;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: urX0wXq49G66dOw5ikHjlAt7KavbRMTVX8Jv+Nv+b4gdbVUvrutfKCJsAFdCyOZjqG30OTTdPy4K5vDLNZBmCjC6pKUPpmBdUmwxxjiD8M5xpMz1a1+AGEcGV7ugVRxOi6eHF4zq9H6uMpSwWJtaMCFoeT731t3pnIlqGeUDhXw9Am1ZtFjdw4JAiMokVfzRsn1SLNOwJEH8y23zvPoqOiGKW9aI3KPBn7RwPfx66Tg5Ii+mPl6rmSKdKL0DLWbfjcwidCYMT4NgwTD2fr2/gaoMkuMeQ92sAFf9809XwxTnNG5/RH0NKtnLFji45gDl9O1tgUBRHSUvARWi1/Jyhw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fc801f1-6156-4591-3948-08d58db3f1e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:07:54.3371
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1045
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "Jason A. Donenfeld" <Jason@zx2c4.com>

[ Upstream commit 48a1df65334b74bd7531f932cca5928932abf769 ]

This is a defense-in-depth measure in response to bugs like
4d6fa57b4dab ("macsec: avoid heap overflow in skb_to_sgvec"). There's
not only a potential overflow of sglist items, but also a stack overflow
potential, so we fix this by limiting the amount of recursion this function
is allowed to do. Not actually providing a bounded base case is a future
disaster that we can easily avoid here.

As a small matter of house keeping, we take this opportunity to move the
documentation comment over the actual function the documentation is for.

While this could be implemented by using an explicit stack of skbuffs,
when implementing this, the function complexity increased considerably,
and I don't think such complexity and bloat is actually worth it. So,
instead I built this and tested it on x86, x86_64, ARM, ARM64, and MIPS,
and measured the stack usage there. I also reverted the recent MIPS
changes that give it a separate IRQ stack, so that I could experience
some worst-case situations. I found that limiting it to 24 layers deep
yielded a good stack usage with room for safety, as well as being much
deeper than any driver actually ever creates.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: David Howells <dhowells@redhat.com>
Cc: Sabrina Dubroca <sd@queasysnail.net>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 include/linux/skbuff.h |  8 +++----
 net/core/skbuff.c      | 65 ++++++++++++++++++++++++++++++++--------------=
----
 2 files changed, 46 insertions(+), 27 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index b5421f6f155a..a6da214d0584 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -879,10 +879,10 @@ struct sk_buff *skb_realloc_headroom(struct sk_buff *=
skb,
 				     unsigned int headroom);
 struct sk_buff *skb_copy_expand(const struct sk_buff *skb, int newheadroom=
,
 				int newtailroom, gfp_t priority);
-int skb_to_sgvec_nomark(struct sk_buff *skb, struct scatterlist *sg,
-			int offset, int len);
-int skb_to_sgvec(struct sk_buff *skb, struct scatterlist *sg, int offset,
-		 int len);
+int __must_check skb_to_sgvec_nomark(struct sk_buff *skb, struct scatterli=
st *sg,
+				     int offset, int len);
+int __must_check skb_to_sgvec(struct sk_buff *skb, struct scatterlist *sg,
+			      int offset, int len);
 int skb_cow_data(struct sk_buff *skb, int tailbits, struct sk_buff **trail=
er);
 int skb_pad(struct sk_buff *skb, int pad);
 #define dev_kfree_skb(a)	consume_skb(a)
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 86b619501350..02f0a705ee96 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3329,24 +3329,18 @@ void __init skb_init(void)
 						NULL);
 }
=20
-/**
- *	skb_to_sgvec - Fill a scatter-gather list from a socket buffer
- *	@skb: Socket buffer containing the buffers to be mapped
- *	@sg: The scatter-gather list to map into
- *	@offset: The offset into the buffer's contents to start mapping
- *	@len: Length of buffer space to be mapped
- *
- *	Fill the specified scatter-gather list with mappings/pointers into a
- *	region of the buffer space attached to a socket buffer.
- */
 static int
-__skb_to_sgvec(struct sk_buff *skb, struct scatterlist *sg, int offset, in=
t len)
+__skb_to_sgvec(struct sk_buff *skb, struct scatterlist *sg, int offset, in=
t len,
+	       unsigned int recursion_level)
 {
 	int start =3D skb_headlen(skb);
 	int i, copy =3D start - offset;
 	struct sk_buff *frag_iter;
 	int elt =3D 0;
=20
+	if (unlikely(recursion_level >=3D 24))
+		return -EMSGSIZE;
+
 	if (copy > 0) {
 		if (copy > len)
 			copy =3D len;
@@ -3365,6 +3359,8 @@ __skb_to_sgvec(struct sk_buff *skb, struct scatterlis=
t *sg, int offset, int len)
 		end =3D start + skb_frag_size(&skb_shinfo(skb)->frags[i]);
 		if ((copy =3D end - offset) > 0) {
 			skb_frag_t *frag =3D &skb_shinfo(skb)->frags[i];
+			if (unlikely(elt && sg_is_last(&sg[elt - 1])))
+				return -EMSGSIZE;
=20
 			if (copy > len)
 				copy =3D len;
@@ -3379,16 +3375,22 @@ __skb_to_sgvec(struct sk_buff *skb, struct scatterl=
ist *sg, int offset, int len)
 	}
=20
 	skb_walk_frags(skb, frag_iter) {
-		int end;
+		int end, ret;
=20
 		WARN_ON(start > offset + len);
=20
 		end =3D start + frag_iter->len;
 		if ((copy =3D end - offset) > 0) {
+			if (unlikely(elt && sg_is_last(&sg[elt - 1])))
+				return -EMSGSIZE;
+
 			if (copy > len)
 				copy =3D len;
-			elt +=3D __skb_to_sgvec(frag_iter, sg+elt, offset - start,
-					      copy);
+			ret =3D __skb_to_sgvec(frag_iter, sg+elt, offset - start,
+					      copy, recursion_level + 1);
+			if (unlikely(ret < 0))
+				return ret;
+			elt +=3D ret;
 			if ((len -=3D copy) =3D=3D 0)
 				return elt;
 			offset +=3D copy;
@@ -3399,6 +3401,31 @@ __skb_to_sgvec(struct sk_buff *skb, struct scatterli=
st *sg, int offset, int len)
 	return elt;
 }
=20
+/**
+ *	skb_to_sgvec - Fill a scatter-gather list from a socket buffer
+ *	@skb: Socket buffer containing the buffers to be mapped
+ *	@sg: The scatter-gather list to map into
+ *	@offset: The offset into the buffer's contents to start mapping
+ *	@len: Length of buffer space to be mapped
+ *
+ *	Fill the specified scatter-gather list with mappings/pointers into a
+ *	region of the buffer space attached to a socket buffer. Returns either
+ *	the number of scatterlist items used, or -EMSGSIZE if the contents
+ *	could not fit.
+ */
+int skb_to_sgvec(struct sk_buff *skb, struct scatterlist *sg, int offset, =
int len)
+{
+	int nsg =3D __skb_to_sgvec(skb, sg, offset, len, 0);
+
+	if (nsg <=3D 0)
+		return nsg;
+
+	sg_mark_end(&sg[nsg - 1]);
+
+	return nsg;
+}
+EXPORT_SYMBOL_GPL(skb_to_sgvec);
+
 /* As compared with skb_to_sgvec, skb_to_sgvec_nomark only map skb to give=
n
  * sglist without mark the sg which contain last skb data as the end.
  * So the caller can mannipulate sg list as will when padding new data aft=
er
@@ -3421,19 +3448,11 @@ __skb_to_sgvec(struct sk_buff *skb, struct scatterl=
ist *sg, int offset, int len)
 int skb_to_sgvec_nomark(struct sk_buff *skb, struct scatterlist *sg,
 			int offset, int len)
 {
-	return __skb_to_sgvec(skb, sg, offset, len);
+	return __skb_to_sgvec(skb, sg, offset, len, 0);
 }
 EXPORT_SYMBOL_GPL(skb_to_sgvec_nomark);
=20
-int skb_to_sgvec(struct sk_buff *skb, struct scatterlist *sg, int offset, =
int len)
-{
-	int nsg =3D __skb_to_sgvec(skb, sg, offset, len);
=20
-	sg_mark_end(&sg[nsg - 1]);
-
-	return nsg;
-}
-EXPORT_SYMBOL_GPL(skb_to_sgvec);
=20
 /**
  *	skb_cow_data - Check that a socket buffer's data buffers are writable
--=20
2.14.1
