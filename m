Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3374234-1523481363-2-9346187866617134711
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523481362; b=Lx+rzSfknVnuzGLFwny3UOtfirBdAjvO66KxstW11WOzRysYWj
    FR30fK80f/VhCguG7N9vxLL9N5JvaYH57f9AFWCz0Luf8F8qIydiMzWUOxWO/zD2
    wZy65/20ZfRmzwSrPDUAFUFOENhctInNHvZYAVrFMBBpqq6RlrNts4KPes3Am7OP
    QlYeZ3FM3zrjqiTX33ru9Tgg4ZFJxlrPKVG8Z5E8RJ9p7DYDJ+oDQCBReGAPiUha
    YJpLiFHEqLOMpzzkvxpCXHHm/ej6Hu4nGncG2vgTu3lBGzH8waABfeyOUW+QAfW8
    AI/FkcGqsX9o0p9t6iHk4D1YNjWsuqScBSlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523481362; bh=nGLte+++dkz6SUl/KzA2NFMJeJHpr/
    FMT9UQNIEdEC4=; b=H9p8ET7I/4NbsLlZJSl8ZHhWSi6+6zw9NMkESiXJ7G1CI+
    hFsMZHt8A2yUsJOQDzwChoAKQ2pVFRUwKmhhNVvgqAqXTsmTIPZUJoy9E6bzlqjr
    49K4pbxb1Zxd0+F2RyGNyPVsGr+5SSJflLXN5ShDKYBRHu6hZ0Y1N/ZOTPRPFyPI
    qT0E9yvzcwo20VSFGYy/LWPVs1dIuW+29AkwBcHaVyY6UFfidx7goI5s8exrwrox
    +Z7O1a7nPjngoXupLHIe2H5COUDa+p0OqxcCPXnHDjIIZCe2YjLi3egDzsg9Dq71
    rEzjmNywVbDOJIXNcI3S4lLAQOQ6xwXYb8V6WKzA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIhCeNEDh0h4b2Hdh+SOCvuQ8D4t5C05AsMYK49UnOZVob2GZNGGFwxrbl7iFlto5XMpiG1kAugXxNli5KbzCXCMfKpdsVIbl1KHiCqHu1kadU/SjUPK
    NjEvOqjQjWYv9KGg1M5UQzQQb4UqBB5A8PUUfRsc15jjePTwHxjw9IvbAOtnrZRPCM2prUsB8VP4OqLwyIIoQ1jSLs9vcm2pT8SBGTJfLK79N/hz08Gzbn/O
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=UGG5zPGqAAAA:8 a=7ZN4cI0QAAAA:8 a=FNyBlpCuAAAA:8 a=J1Y8HTJGAAAA:8
    a=20KFwNOVAAAA:8 a=AeCkNC4mAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=W2qOomZxW66Eo3tqgE0A:9 a=zj_0yZE5lZr3CtCD:21 a=wjn9YYyDJH2rjWWc:21
    a=QEXdDO2ut3YA:10 a=17ibUXfGiVyGqR_YBevW:22 a=Dl0WHwQvj8hGZljrFLtM:22
    a=RlW-AWeGUCXs_Nkyno-6:22 a=y1Q9-5lHfBjTkpIzbSAN:22 a=3H0rhiSm_XezoJcgKFaR:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754718AbeDKSku (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:40:50 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56574 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754698AbeDKSkq (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:40:46 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        David Howells <dhowells@redhat.com>,
        Sabrina Dubroca <sd@queasysnail.net>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 067/121] skbuff: return -EMSGSIZE in skb_to_sgvec to prevent overflow
Date: Wed, 11 Apr 2018 20:36:10 +0200
Message-Id: <20180411183500.258857453@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183456.195010921@linuxfoundation.org>
References: <20180411183456.195010921@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/skbuff.h |    8 +++---
 net/core/skbuff.c      |   65 +++++++++++++++++++++++++++++++------------------
 2 files changed, 46 insertions(+), 27 deletions(-)

--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -845,10 +845,10 @@ struct sk_buff *skb_realloc_headroom(str
 				     unsigned int headroom);
 struct sk_buff *skb_copy_expand(const struct sk_buff *skb, int newheadroom,
 				int newtailroom, gfp_t priority);
-int skb_to_sgvec_nomark(struct sk_buff *skb, struct scatterlist *sg,
-			int offset, int len);
-int skb_to_sgvec(struct sk_buff *skb, struct scatterlist *sg, int offset,
-		 int len);
+int __must_check skb_to_sgvec_nomark(struct sk_buff *skb, struct scatterlist *sg,
+				     int offset, int len);
+int __must_check skb_to_sgvec(struct sk_buff *skb, struct scatterlist *sg,
+			      int offset, int len);
 int skb_cow_data(struct sk_buff *skb, int tailbits, struct sk_buff **trailer);
 int skb_pad(struct sk_buff *skb, int pad);
 #define dev_kfree_skb(a)	consume_skb(a)
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3285,24 +3285,18 @@ void __init skb_init(void)
 						NULL);
 }
 
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
-__skb_to_sgvec(struct sk_buff *skb, struct scatterlist *sg, int offset, int len)
+__skb_to_sgvec(struct sk_buff *skb, struct scatterlist *sg, int offset, int len,
+	       unsigned int recursion_level)
 {
 	int start = skb_headlen(skb);
 	int i, copy = start - offset;
 	struct sk_buff *frag_iter;
 	int elt = 0;
 
+	if (unlikely(recursion_level >= 24))
+		return -EMSGSIZE;
+
 	if (copy > 0) {
 		if (copy > len)
 			copy = len;
@@ -3321,6 +3315,8 @@ __skb_to_sgvec(struct sk_buff *skb, stru
 		end = start + skb_frag_size(&skb_shinfo(skb)->frags[i]);
 		if ((copy = end - offset) > 0) {
 			skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
+			if (unlikely(elt && sg_is_last(&sg[elt - 1])))
+				return -EMSGSIZE;
 
 			if (copy > len)
 				copy = len;
@@ -3335,16 +3331,22 @@ __skb_to_sgvec(struct sk_buff *skb, stru
 	}
 
 	skb_walk_frags(skb, frag_iter) {
-		int end;
+		int end, ret;
 
 		WARN_ON(start > offset + len);
 
 		end = start + frag_iter->len;
 		if ((copy = end - offset) > 0) {
+			if (unlikely(elt && sg_is_last(&sg[elt - 1])))
+				return -EMSGSIZE;
+
 			if (copy > len)
 				copy = len;
-			elt += __skb_to_sgvec(frag_iter, sg+elt, offset - start,
-					      copy);
+			ret = __skb_to_sgvec(frag_iter, sg+elt, offset - start,
+					      copy, recursion_level + 1);
+			if (unlikely(ret < 0))
+				return ret;
+			elt += ret;
 			if ((len -= copy) == 0)
 				return elt;
 			offset += copy;
@@ -3355,6 +3357,31 @@ __skb_to_sgvec(struct sk_buff *skb, stru
 	return elt;
 }
 
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
+int skb_to_sgvec(struct sk_buff *skb, struct scatterlist *sg, int offset, int len)
+{
+	int nsg = __skb_to_sgvec(skb, sg, offset, len, 0);
+
+	if (nsg <= 0)
+		return nsg;
+
+	sg_mark_end(&sg[nsg - 1]);
+
+	return nsg;
+}
+EXPORT_SYMBOL_GPL(skb_to_sgvec);
+
 /* As compared with skb_to_sgvec, skb_to_sgvec_nomark only map skb to given
  * sglist without mark the sg which contain last skb data as the end.
  * So the caller can mannipulate sg list as will when padding new data after
@@ -3377,19 +3404,11 @@ __skb_to_sgvec(struct sk_buff *skb, stru
 int skb_to_sgvec_nomark(struct sk_buff *skb, struct scatterlist *sg,
 			int offset, int len)
 {
-	return __skb_to_sgvec(skb, sg, offset, len);
+	return __skb_to_sgvec(skb, sg, offset, len, 0);
 }
 EXPORT_SYMBOL_GPL(skb_to_sgvec_nomark);
 
-int skb_to_sgvec(struct sk_buff *skb, struct scatterlist *sg, int offset, int len)
-{
-	int nsg = __skb_to_sgvec(skb, sg, offset, len);
 
-	sg_mark_end(&sg[nsg - 1]);
-
-	return nsg;
-}
-EXPORT_SYMBOL_GPL(skb_to_sgvec);
 
 /**
  *	skb_cow_data - Check that a socket buffer's data buffers are writable
