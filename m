Return-Path: <SRS0=gsCl=F4=gmail.com=htejun@kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-870783-1520357698-2-6375552187354472271
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='198.145.29.99', Host='mail.kernel.org', Country='US', FromHeader='org',
  MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: SRS0=gsCl=F4=gmail.com=htejun@kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520357697; b=SRhih1Hgo4X4/s+0qBUoC6i8AXtuF46mH0rF6Lu/C3VkUgd
    G25uzsqRwuYe79PgLH9JxftrE5F7lTKH5kp8GIXtw/5tmLg4p6sTl/Du+wvHKbWZ
    d8MpqqC6kynAtXRJC1+SJJ2EJ3G+WVEwaqW+BEbCn7L8I44mUSETaDA3YvuXgYQ7
    7yFoEc1hxtc/uXPbAnaCRI9SPpb4/Pzbh9wST+q5QJ+cSA5rjJDiFvL2QYrs49bm
    8QziVjRibsYZ2p5+zEHKcdAnsSsjzv2TEIwOzMsyd1bTftDllhK+FWtfQcPbPIEg
    Y0SjMOB3h+ayS7IfZujhnGgrST9iYIIpiAHEGYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=sender:from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding; s=arctest; t=1520357697; bh=lAjkTExh
    1HfSgBZdVgEHbW+e+LSzXfCWNw76ETiMxVw=; b=Py930wXILeZelxL0ZRCZinhp
    ghVz4tykun5NZCWU4I/rRuDJqWKKnmKpGkIUtfEpV0V38T2JT5nahuF4ozDjD5Yd
    lLCgqkUReZUHHgzve1ew4R+AJynfPHh/dEMNAsoqYCiosJo0nH6WUo1bNt95zjah
    jCLYzFuYpXMIoAovYUIs/aYMQseLxhoXnNUStYNrOsD4m0vZCGJKDtluJ0aRbVEj
    AE8MQtHopTzNuAQ6Ms1v6TMA71H8R5BdBF2976L1OOgMKhRtmLGzkZoRvZlBYE7b
    9hnEakcIFL/z9lalXZAdlmCy7zMwcNZa6I6bmECI9DovuUA+swzoe1CDo22g2Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=A852Sl24 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom=SRS0=gsCl=F4=gmail.com=htejun@kernel.org smtp.helo=mail.kernel.org;
    x-aligned-from=domain_pass;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=VZzN0yST;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=A852Sl24 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom=SRS0=gsCl=F4=gmail.com=htejun@kernel.org smtp.helo=mail.kernel.org;
    x-aligned-from=domain_pass;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=VZzN0yST;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: security@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8996620856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=htejun@gmail.com
X-Google-Smtp-Source: AG47ELsNuPcwf585x8uj5p8d3aSOEg5tWPd4D034XJRM2ILdK4sh4Eo3mcf6rr4YewHQe6KwDM/lzQ==
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
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	linux-mm@kvack.org
Subject: [PATCH 4/7] HMM: Remove superflous RCU protection around radix tree lookup
Date: Tue,  6 Mar 2018 09:33:13 -0800
Message-Id: <20180306173316.3088458-4-tj@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180306173316.3088458-1-tj@kernel.org>
References: <20180306172657.3060270-1-tj@kernel.org>
 <20180306173316.3088458-1-tj@kernel.org>
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
Cc: Jérôme Glisse <jglisse@redhat.com>
Cc: linux-mm@kvack.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
Hello, Jérôme.

This came up while auditing percpu_ref users for missing explicit RCU
grace periods.  HMM doesn't seem to depend on RCU protection at all,
so I thought it'd be better to remove it for now.  It's only compile
tested.

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
