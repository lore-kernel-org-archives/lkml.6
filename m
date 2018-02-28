Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-617694-1519837650-2-17948220460279569466
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519837649; b=VJcfo/1xwvcOQIyt+rL6lymsuz46WSpDb1NAfB52Tbq7fzz
    o55bia+x5nmlK01G2OpDb4tWqTJ/VKAgTCh6xayO/BiEYfNn77x2bH6q7hw65F0v
    4NkYhFT47BHtm0AoaxEbcxUpDJiJ+Hd2gjZGfTkUIk2UUFqRZTdxNj//DwK3pD5r
    6QAEOgQBn0WrXMpyZ4OU92EKZMIWwx/GwW8fJ32etJijCEdOm3WGFRq1OteAMhlT
    n+cG2a/dXc/ccG6HAG7xGheJEOAtzrfMG7+U1QMAv2T2R+FzeOeM8LjHwfKS6eRx
    WgrfDQLEZjUeUlNZEdwyt1eFwgCcYgRT51upWPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519837649; bh=i8Hat/jn5IuaMcxGvNR
    QKe2qI4hCZ2MdJGx+/UoJXtM=; b=q7DGKUKs5VxXBQhP3fDWzv/4fsbE+2rGVdz
    CRbdUf6lRXWDjCLVj3hdqMOx1SwGPlligdZ1KdCFf5wRALFpUJE/KN5B4xvz2a/g
    gjkZKLZDVK5UwVKvoAkd4e0JBhNvkHx8h3ao84yhDQzlPqiUWubGcgyohqscjuM6
    Ez+uS77AEK5HDnXaf7jEGNjVynULXdfhiSDNCzG9bYil71ckUXkgwaRzRIQRhURD
    jyYOlriY/eUr2V0yl10/juHjzuAEWtwuNr50oJN2dRBN8XYNok+kFzsFLGS8MhZy
    g08btv2L+XpzBwuOGvtcVs4UxmNY3lXmDOEfG+ipH8PzXSxDafA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752894AbeB1PuR (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:50:17 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34313 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752793AbeB1PuQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:50:16 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Xin Long" <lucien.xin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Marcelo Ricardo Leitner" <marcelo.leitner@gmail.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.448229823@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 030/254] sctp: force the params with right types for
 sctp csum apis
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Long <lucien.xin@gmail.com>

commit af2697a0273f7665429c47d71ab26f2412af924e upstream.

Now sctp_csum_xxx doesn't really match the param types of these common
csum apis. As sctp_csum_xxx is defined in sctp/checksum.h, many sparse
errors occur when make C=2 not only with M=net/sctp but also with other
modules that include this header file.

This patch is to force them fit in csum apis with the right types.

Fixes: e6d8b64b34aa ("net: sctp: fix and consolidate SCTP checksumming code")
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 include/net/sctp/checksum.h | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

--- a/include/net/sctp/checksum.h
+++ b/include/net/sctp/checksum.h
@@ -48,31 +48,32 @@ static inline __wsum sctp_csum_update(co
 	/* This uses the crypto implementation of crc32c, which is either
 	 * implemented w/ hardware support or resolves to __crc32c_le().
 	 */
-	return crc32c(sum, buff, len);
+	return (__force __wsum)crc32c((__force __u32)sum, buff, len);
 }
 
 static inline __wsum sctp_csum_combine(__wsum csum, __wsum csum2,
 				       int offset, int len)
 {
-	return __crc32c_le_combine(csum, csum2, len);
+	return (__force __wsum)__crc32c_le_combine((__force __u32)csum,
+						   (__force __u32)csum2, len);
 }
 
 static inline __le32 sctp_compute_cksum(const struct sk_buff *skb,
 					unsigned int offset)
 {
 	struct sctphdr *sh = sctp_hdr(skb);
-        __le32 ret, old = sh->checksum;
 	const struct skb_checksum_ops ops = {
 		.update  = sctp_csum_update,
 		.combine = sctp_csum_combine,
 	};
+	__le32 old = sh->checksum;
+	__wsum new;
 
 	sh->checksum = 0;
-	ret = cpu_to_le32(~__skb_checksum(skb, offset, skb->len - offset,
-					  ~(__u32)0, &ops));
+	new = ~__skb_checksum(skb, offset, skb->len - offset, ~(__wsum)0, &ops);
 	sh->checksum = old;
 
-	return ret;
+	return cpu_to_le32((__force __u32)new);
 }
 
 #endif /* __sctp_checksum_h__ */
