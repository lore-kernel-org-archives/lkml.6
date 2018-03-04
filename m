Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2841113-1520173051-2-765649504155325766
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520173051; b=Xp9sfd95R/O5ooKhKqPZzf+e/btEcEc/Wk7AzM7epblbKUH
    HGd0oSLIgTM7Sr2Xkgb0TRUu9fnLUK/wxVzYNHsx0aRcJ481vyBZJt/HiWX76oDM
    cLidmt6jxCX0I9NR/Lms3zw2yF6ZWTpbgrsFYLC499bUOoZynJ0gPkux8zuRBD/F
    s0E8jEPjjJk4Dp1dScfRxrr7iQo++Ne7Le5nj2vTgNs/oWMl/jgilpbW4XWCxL0x
    qE73CEuYAExJkngjjSS72FLd77p608491SSJ0kUlfdHiki82Hl0AKhhLk/7iYWXx
    Dt80XUPewDXrtaj92kS7SWqJKioZiHPKa3FazTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520173051; bh=d
    53htXIhLbz49mD7znJtkY+0n2xIlyIEFtbIltvc85E=; b=drHgzO8hj6v15hzsu
    DmvOL0mzNtvyZYholjIVe1s3qK1UMK7mGSqZ1i8qUKbX3x2SeHbXG04t7llshF5Q
    xyG4R0Z6Hu5qOF8xuY2qMJpiSQeNH95jqoLhkRRxt3rrz6aLggH/EcLX8lfB0b/u
    F4k58ai/fkR5qfG4u/Hf7GhX+I40vo0ALcxNdYE0eTuR6xQiz1Nsvbd8Bq/5aou9
    v1Xp/H4mOOKbG1eOpfD3IAMvcJX+VrSzbIbgWrd61MdNOxgVetm8dl7H0RAj3ryN
    u0XnBImVW4/h51kI+SiVFcjvir+S6wFTOPnDtjd/59SxwX5DcC8eL/JL0HLADrhW
    1lEpQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=k6AC5izH x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=khXzYpFo;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=k6AC5izH x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=khXzYpFo;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELsjGFvu/pV1noqLDZq6safifIXO9188xpPrNOrSPGzvxClu8n7u0GJWo9jIgNpMtkEF+3marQ==
From: Arushi Singhal <arushisinghal19971997@gmail.com>
To: oleg.drokin@intel.com
Subject: [PATCH 1/3] staging: lustre: Replace "be be" with "be"
Date: Sun,  4 Mar 2018 19:46:06 +0530
Message-Id: <1520172968-17448-2-git-send-email-arushisinghal19971997@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520172968-17448-1-git-send-email-arushisinghal19971997@gmail.com>
References: <1520172968-17448-1-git-send-email-arushisinghal19971997@gmail.com>
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
Cc: devel@driverdev.osuosl.org,
 Arushi Singhal <arushisinghal19971997@gmail.com>, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com,
 andreas.dilger@intel.com, lustre-devel@lists.lustre.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch replace "be be" with "be".

Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
---
 drivers/staging/lustre/lnet/libcfs/debug.c             | 2 +-
 drivers/staging/lustre/lustre/include/lprocfs_status.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/lustre/lnet/libcfs/debug.c b/drivers/staging/lustre/lnet/libcfs/debug.c
index c70d2ae..1371224 100644
--- a/drivers/staging/lustre/lnet/libcfs/debug.c
+++ b/drivers/staging/lustre/lnet/libcfs/debug.c
@@ -440,7 +440,7 @@ int libcfs_debug_clear_buffer(void)
 	return 0;
 }
 
-/* Debug markers, although printed by S_LNET should not be be marked as such. */
+/* Debug markers, although printed by S_LNET should not be marked as such. */
 #undef DEBUG_SUBSYSTEM
 #define DEBUG_SUBSYSTEM S_UNDEFINED
 int libcfs_debug_mark_buffer(const char *text)
diff --git a/drivers/staging/lustre/lustre/include/lprocfs_status.h b/drivers/staging/lustre/lustre/include/lprocfs_status.h
index 835a729..426e8f3 100644
--- a/drivers/staging/lustre/lustre/include/lprocfs_status.h
+++ b/drivers/staging/lustre/lustre/include/lprocfs_status.h
@@ -114,7 +114,7 @@ struct rename_stats {
  * LPROCFS_CNTR_AVGMINMAX indicates a multi-valued counter samples,
  * (i.e. counter can be incremented by more than "1"). When specified,
  * the counter maintains min, max and sum in addition to a simple
- * invocation count. This allows averages to be be computed.
+ * invocation count. This allows averages to be computed.
  * If not specified, the counter is an increment-by-1 counter.
  * min, max, sum, etc. are not maintained.
  *
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
