Return-Path: <SRS0=5xW2=GE=gmail.com=htejun@kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2426127-1521056742-2-10066821156183393222
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='198.145.29.99', Host='mail.kernel.org', Country='US', FromHeader='org',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: SRS0=5xW2=GE=gmail.com=htejun@kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521056742; b=lsfE4YF5XUKZHqdCk9fziMFRNGabTjA8anUgXtl0j2r3by7
    0w0aasi5qNyQDT/vSg/h+xiT0RagyIbHS8eS3OqbXSdY0mskuoFwr/bsmS1O0vVN
    gG9sw7Cw4O8vn7sq1NMD52ip9AwgNI/w47pArUSGizGAOZheNXK7CL5w11zXN1Nk
    bijZQwZWnK09L1XIosfQu81P/pmziFkxO4fMDUetCGCsdSYEFYBiwNSqPScRkVBC
    MyLQLdB/nZnDqDOrEjzEAe+BSTdMnxLchACtN1tSt4CAPHWMZq1Hx6Detfd+uRi8
    MEfgbvdU72VstewcJcIkE1btA9gty6IzW2sTLPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=sender:from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding; s=arctest; t=1521056742; bh=H2dPffxI
    d0/mpW4kkiOVKDPkETwdBaQs++EKyblVulA=; b=boFBsZJM3llwVM5oqHWt36ME
    pA9w1pR5wLXu65XRMUDynN2ndcCy2Jab4sgf5Y58YdJHl+hI3DFn5M3kcjv8gdJK
    8e6uKFW+4TojtACQayZckkiCeANzxojl5GKMPnC90KziVo1V9yinBp9JRVgpfQnR
    hgjXj7LcKXSuYu/BFA6Naoo6k2skWbKOlzIlY7yw4wnIJQykRsL3lmC7i4pbKhq2
    0ARBUBWCIMGuvMAxxHAnfbW2r6Fp1TXeHoUdeiVWOU4EuoS2gzOes83tvF4Gu4LI
    SG81rs1qohiZ8CDfg+DCcAn7D+VNkhTt248945QQ8g1Jw0t4Sr9yuw1oqryTGg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=FhWGkPA1 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom=SRS0=5xW2=GE=gmail.com=htejun@kernel.org smtp.helo=mail.kernel.org;
    x-aligned-from=domain_pass;
    x-category=clean score=0 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=fHPThlNe;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=FhWGkPA1 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom=SRS0=5xW2=GE=gmail.com=htejun@kernel.org smtp.helo=mail.kernel.org;
    x-aligned-from=domain_pass;
    x-category=clean score=0 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=fHPThlNe;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: security@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D40032077A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=htejun@gmail.com
X-Google-Smtp-Source: AG47ELvjG0LbvJbGzQ4cLkGF+uneTrUUzyxGFpOi8BYB5VN4Loki/Tiz4hjwMNJ5F1IirvKhuspskA==
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: torvalds@linux-foundation.org,
	jannh@google.com,
	paulmck@linux.vnet.ibm.com,
	bcrl@kvack.org,
	viro@zeniv.linux.org.uk,
	kent.overstreet@gmail.com
Cc: security@kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@fb.com,
	Tejun Heo <tj@kernel.org>,
	linux-mm@kvack.org
Subject: [PATCH 4/8] HMM: Remove superflous RCU protection around radix tree lookup
Date: Wed, 14 Mar 2018 12:45:11 -0700
Message-Id: <20180314194515.1661824-4-tj@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180314194515.1661824-1-tj@kernel.org>
References: <20180314194205.1651587-1-tj@kernel.org>
 <20180314194515.1661824-1-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

hmm_devmem_find() requires rcu_read_lock_held() but there's nothing
which actually uses the RCU protection.  The only caller is
hmm_devmem_pages_create() which already grabs the mutex and does
superflous rcu_read_lock/unlock() around the function.

This doesn't add anything and just adds to confusion.  Remove the RCU
protection and open-code the radix tree lookup.  If this needs to
become more sophisticated in the future, let's add them back when
necessary.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Jérôme Glisse <jglisse@redhat.com>
Cc: linux-mm@kvack.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
Hello,

Jérôme, how do you want to route this patch?  If you prefer, I can
route it together with other patches.

Thanks.

 mm/hmm.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index 320545b98..d4627c5 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -845,13 +845,6 @@ static void hmm_devmem_release(struct device *dev, void *data)
 	hmm_devmem_radix_release(resource);
 }
 
-static struct hmm_devmem *hmm_devmem_find(resource_size_t phys)
-{
-	WARN_ON_ONCE(!rcu_read_lock_held());
-
-	return radix_tree_lookup(&hmm_devmem_radix, phys >> PA_SECTION_SHIFT);
-}
-
 static int hmm_devmem_pages_create(struct hmm_devmem *devmem)
 {
 	resource_size_t key, align_start, align_size, align_end;
@@ -892,9 +885,8 @@ static int hmm_devmem_pages_create(struct hmm_devmem *devmem)
 	for (key = align_start; key <= align_end; key += PA_SECTION_SIZE) {
 		struct hmm_devmem *dup;
 
-		rcu_read_lock();
-		dup = hmm_devmem_find(key);
-		rcu_read_unlock();
+		dup = radix_tree_lookup(&hmm_devmem_radix,
+					key >> PA_SECTION_SHIFT);
 		if (dup) {
 			dev_err(device, "%s: collides with mapping for %s\n",
 				__func__, dev_name(dup->device));
-- 
2.9.5
