Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1143910-1525285322-2-9634642665367936081
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525285321; b=PW96yv1epd2VWFRtK7YSQLsPDhE2nIxn8mxnL746tQLAnhsxfX
    scnRkpcKPCUMMNoytJ5llOxQUEAXr7uzAU5WJX2vxQRONE7rVrTilzrb/+EQYYsF
    VuQl/psw4G5/EO4ML4Xsv0UhkEwT2U8yj0K3CK+uugqUtS/L4GrNtoy0WCGMUjSB
    YKlMCXdnzAKwqMl6URpPUh+5le45BENGuktwlDL5wbYJ7mrJP3/F7yTz1ByiTIqz
    bBzsL5BJyQBzBtC2cemTkCLTTj5gSwUXGIlShLBo3FqcpUUFHBP7SCQaUb79XDqP
    +ftg7uRDYxhDTUucvwajKd1vmPtoyTapC+Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525285321; bh=0Jw6r
    CMlGoWli8d0tktdHoIKGRgLu0fwQ8yd7mnLBMI=; b=bQiiYBlP/MCNz0oxB8oFf
    bTltdrVZSXnvVq56Mm8qidAqKy92te/25oD/fQCPEOqPm/qIX4CafWRbGKriawLM
    0SJqsZyVp/A26Y+sy8UFLzmdGMEIQWqefswrjihHzY6u9O3nx3QaqXU0U5aJxcqJ
    57nMkFJqQjAyqjkcw5CIcK45O5sArv0WAk/OBCfYFV41vq2+wyNzOKzKXqG2aqFz
    auf+EJz/8Glj9B840pYPccdjdHpCtCyKdw2LLHz3KB+7dFLoS4P56GFf/wJBtqcQ
    OKgfSCkMmMgJoTPm7EEzv4xTdatwwR4/4n0cBTgnU4Do5ooJ7Ja+wD80E/myke/d
    g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=infradead.org header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=infradead.org header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJZp54VSeDJNP0ktyyiHRX9E8AvMy8zprXfo+HTb54wHxdANn7N6m/BpOxSO8dAVi7yO+k1lKo5YGZM/hlsCyWBbstcOtvD1eK/ehn5WflUWv/rjxo+F
    dR7mPBEdPznSoO82CDULdd615OzaBuHq48JzEvXN4ZLWO6b64a9po1aouOWKip5Vf5ba+tzx+A2cUIBCImHF51OTTPggXw2f4UBVqk+AT0Xlikuso/iT4Ek8
    AbzelqfL6yIdgOMaBGGVlw==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=QyXUC8HyAAAA:8 a=ySfo2T4IAAAA:8
    a=kBl-OI3rAAAA:8 a=JfrnYn6hAAAA:8 a=DDOyTI_5AAAA:8 a=hRnDSNM6WB-EmQT4h0oA:9
    a=CjuIK1q_8ugA:10 a=ZUkhVnNHqyo2at-WnAgH:22 a=pLxN2xGgR0OPbCgNAGn6:22
    a=1CNFftbPRP8L7MoqJWF3:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: James Simmons <jsimmons@infradead.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devel@driverdev.osuosl.org, Andreas Dilger <andreas.dilger@intel.com>,
 Oleg Drokin <oleg.drokin@intel.com>, Lai Siyao <lai.siyao@intel.com>,
 Jinshan Xiong <jinshan.xiong@intel.com>, NeilBrown <neilb@suse.com>
Subject: [PATCH 3/4] staging: lustre: obdclass: guarantee all keys filled
Date: Wed,  2 May 2018 14:21:47 -0400
Message-Id: <1525285308-15347-4-git-send-email-jsimmons@infradead.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1525285308-15347-1-git-send-email-jsimmons@infradead.org>
References: <1525285308-15347-1-git-send-email-jsimmons@infradead.org>
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: Hongchao Zhang <hongchao.zhang@intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lustre Development List <lustre-devel@lists.lustre.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Hongchao Zhang <hongchao.zhang@intel.com>

In keys_fill, the key_set_version could be changed after
the keys are filled, then the keys in this context won't
be refilled by the following lu_context_refill for its
version is equal to the current key_set_version.

In lu_context_refill, the key_set_version should be protected
before comparing it to version stored in the lu_context.

Signed-off-by: Hongchao Zhang <hongchao.zhang@intel.com>
Intel-bug-id: https://jira.hpdd.intel.com/browse/LU-8346
Reviewed-on: https://review.whamcloud.com/26099
Reviewed-on: https://review.whamcloud.com/27448
Reviewed-on: https://review.whamcloud.com/27994
Reviewed-by: Patrick Farrell <paf@cray.com>
Reviewed-by: Jinshan Xiong <jinshan.xiong@intel.com>
Reviewed-by: Mike Pershin <mike.pershin@intel.com>
Reviewed-by: Fan Yong <fan.yong@intel.com>
Reviewed-by: Oleg Drokin <oleg.drokin@intel.com>
Signed-off-by: James Simmons <jsimmons@infradead.org>
---
 drivers/staging/lustre/lustre/obdclass/lu_object.c | 29 +++++++++++++++++++---
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/lustre/lustre/obdclass/lu_object.c b/drivers/staging/lustre/lustre/obdclass/lu_object.c
index 4e4dd58..8b507f1 100644
--- a/drivers/staging/lustre/lustre/obdclass/lu_object.c
+++ b/drivers/staging/lustre/lustre/obdclass/lu_object.c
@@ -1386,8 +1386,8 @@ void lu_context_key_degister(struct lu_context_key *key)
 
 	lu_context_key_quiesce(key);
 
-	++key_set_version;
 	write_lock(&lu_keys_guard);
+	++key_set_version;
 	key_fini(&lu_shrink_env.le_ctx, key->lct_index);
 
 	/**
@@ -1546,15 +1546,18 @@ void lu_context_key_quiesce(struct lu_context_key *key)
 
 		list_for_each_entry(ctx, &lu_context_remembered, lc_remember)
 			key_fini(ctx, key->lct_index);
-		write_unlock(&lu_keys_guard);
+
 		++key_set_version;
+		write_unlock(&lu_keys_guard);
 	}
 }
 
 void lu_context_key_revive(struct lu_context_key *key)
 {
+	write_lock(&lu_keys_guard);
 	key->lct_tags &= ~LCT_QUIESCENT;
 	++key_set_version;
+	write_unlock(&lu_keys_guard);
 }
 
 static void keys_fini(struct lu_context *ctx)
@@ -1573,6 +1576,7 @@ static void keys_fini(struct lu_context *ctx)
 
 static int keys_fill(struct lu_context *ctx)
 {
+	unsigned int pre_version;
 	unsigned int i;
 
 	/*
@@ -1586,8 +1590,10 @@ static int keys_fill(struct lu_context *ctx)
 	 */
 	read_lock(&lu_keys_guard);
 	atomic_inc(&lu_key_initing_cnt);
+	pre_version = key_set_version;
 	read_unlock(&lu_keys_guard);
 
+refill:
 	LINVRNT(ctx->lc_value);
 	for (i = 0; i < ARRAY_SIZE(lu_keys); ++i) {
 		struct lu_context_key *key;
@@ -1628,9 +1634,17 @@ static int keys_fill(struct lu_context *ctx)
 			if (key->lct_exit)
 				ctx->lc_tags |= LCT_HAS_EXIT;
 		}
-		ctx->lc_version = key_set_version;
 	}
+
+	read_lock(&lu_keys_guard);
+	if (pre_version != key_set_version) {
+		pre_version = key_set_version;
+		read_unlock(&lu_keys_guard);
+		goto refill;
+	}
+	ctx->lc_version = key_set_version;
 	atomic_dec(&lu_key_initing_cnt);
+	read_unlock(&lu_keys_guard);
 	return 0;
 }
 
@@ -1739,7 +1753,14 @@ void lu_context_exit(struct lu_context *ctx)
  */
 int lu_context_refill(struct lu_context *ctx)
 {
-	return likely(ctx->lc_version == key_set_version) ? 0 : keys_fill(ctx);
+	read_lock(&lu_keys_guard);
+	if (likely(ctx->lc_version == key_set_version)) {
+		read_unlock(&lu_keys_guard);
+		return 0;
+	}
+
+	read_unlock(&lu_keys_guard);
+	return keys_fill(ctx);
 }
 
 /**
-- 
1.8.3.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
