Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-380590-1524842074-2-11003342337158736496
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524842073; b=biElakq62QAdvVQml1zVIlw/irhiQXrgGej9/Vodpwp51Rq30H
    Hm8+6Fs9Am9wRja0awWVkSFJ4UtgtYnURqELlr7critYGrNtftse1roDvtsZNLFD
    eR7i07fyJaNlQG+jjRt1vugD8fXuGaBgsRknwTyJnOHLU5Oom3fioLs9I3+O7wSY
    fES/Kvim0XCvN+obzUyXdzkhudgsK01Ya+xLiA8OdDBQloxhnPpznUtyPahCdI8/
    U8f7QtDw8vSPwLMgVnf9+OG3scwWnfukY3E0fkZA/rdX87IvG9ZJlF28ptnsR36p
    PQmY2H4vmQmW4vt8JYJNOvKkQCGBMNU+qHoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524842073; bh=IR/uUjWld5nN2o/P5IFi7h8V0iGDV1
    KCFkJ4nLhDHHc=; b=ji6n7BTfJy+sLnYbgBpB7LjXJq5iAf9tcZMxbHXpCJ7BBO
    NyIDMMDQ0GOtXXXDQvfH3FIreIiJCzTPuxLHDtYWWF2RbY9wOdcTPCKMJllJ1INb
    yaNpZNsn8nnHmtl+RszzCcA2U0Wd8tsSiJKfxL6xLKcYEYv4Ut1c+H29n4I/h8+r
    0U1sj82b5mGFAvq7P2CMiIvUQCRKQx+hN1HQGcGW2+QpVz5rrojMk1vhA0W4DKkq
    D1+KwhJyKqNzaDQtwhq/JEMCnyCEnvquIiv5D3dudTfqktUYcsSoJ45GWxt/1e64
    uP5q6NTTFrXg3Q8kfTzakcP5ANElNuvF60FS1tTg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfGeujL5pdb+h7VTKFWWiC7505iltBSdCuHovgXoszEc7ALwlUJquzZ2HbikwsmQzbOOCDnkppKos5D8lfMtywddk6wDidwDz04v45hJr7i7Z8UwoJcO+
    apoosXECrW8K2I3ILZuLdp0EewEKPEE0ioS4LFFN+ry2lBhOKg+YJeYOBBWFLIrBljfFemepn7S8hH9Go7T54YjU5Ailrj5fNI6uPofsZqwiQpaoz8DeEQt+
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VnNF1IyMAAAA:8 a=ag1SF4gXAAAA:8 a=_TN53eZWIOXTJY2F9Q0A:9 a=QEXdDO2ut3YA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933587AbeD0ODv (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 10:03:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:50290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933188AbeD0ODu (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 10:03:50 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38DED2189D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4.9 32/74] s390: add optimized array_index_mask_nospec
Date: Fri, 27 Apr 2018 15:58:22 +0200
Message-Id: <20180427135711.259829079@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135709.899303463@linuxfoundation.org>
References: <20180427135709.899303463@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Schwidefsky <schwidefsky@de.ibm.com>


[ Upstream commit e2dd833389cc4069a96b57bdd24227b5f52288f5 ]

Add an optimized version of the array_index_mask_nospec function for
s390 based on a compare and a subtract with borrow.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/include/asm/barrier.h |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

--- a/arch/s390/include/asm/barrier.h
+++ b/arch/s390/include/asm/barrier.h
@@ -48,6 +48,30 @@ do {									\
 #define __smp_mb__before_atomic()	barrier()
 #define __smp_mb__after_atomic()	barrier()
 
+/**
+ * array_index_mask_nospec - generate a mask for array_idx() that is
+ * ~0UL when the bounds check succeeds and 0 otherwise
+ * @index: array element index
+ * @size: number of elements in array
+ */
+#define array_index_mask_nospec array_index_mask_nospec
+static inline unsigned long array_index_mask_nospec(unsigned long index,
+						    unsigned long size)
+{
+	unsigned long mask;
+
+	if (__builtin_constant_p(size) && size > 0) {
+		asm("	clgr	%2,%1\n"
+		    "	slbgr	%0,%0\n"
+		    :"=d" (mask) : "d" (size-1), "d" (index) :"cc");
+		return mask;
+	}
+	asm("	clgr	%1,%2\n"
+	    "	slbgr	%0,%0\n"
+	    :"=d" (mask) : "d" (size), "d" (index) :"cc");
+	return ~mask;
+}
+
 #include <asm-generic/barrier.h>
 
 #endif /* __ASM_BARRIER_H */
