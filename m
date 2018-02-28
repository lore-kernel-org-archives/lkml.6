Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-516026-1519834935-2-6568610943335288290
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
    t=1519834934; b=CaYoTdAMYYqGW/4O1hc0g06+2iHKVVoD4I8kp3msN7/wHVv
    7mKV8/nqwhrCx4DsErva51QPy82RdwBWg0ej1Y3SxSl2sEaOk8Wc2efvXEboLwB+
    UdLi6pn2YM91zDCLLbRAX5GKsHdnQXvXGjJ0SdY/HremIqSg5auPY04AZr896R46
    7vkjBQO/xTgqzFHImyhpVX3GTe1to3yakF8tRHMRhmHiQI6rmVh8qQznEAxpQvYF
    NpHdeNY8UOb6E/xqJlvuv2q+Mt1K9MdHS1TQiLhSRa8qduWkZcE2hPldRjhdN9gz
    C8z/JgPgMU7m3HMP+JSi9TO8kZdHX7rQUWpkxTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519834934; bh=S3RSs0grV+zG9qCS7c0
    tFekP4eVBO8OEJRizJ2ihYaU=; b=S7IIorKJiIF4u+xdijb5414EvMrVUkH+hrS
    2FiwiUzDAkGvLGve/JhT4q2Im8Ar51jh5R2shUneDHuhYYsZ7OTVyCOYRgLcuha8
    LitxD9/uoIJHQonT3VmwoLw/VpdOoEK8JQFaQMCWQD1JH6AzEMBFE9O2OrkWPkLr
    s4LOvCfFpKDwBHyF1ar0fCfSysMBkAQKMQKg3KDlYOc7OIy/p1BDkRfFe0KN348F
    T9WP4Otcbm5k9TTYmpHXb9wUlxkyqAydsbvzmeZqLajxxjjG0AaBiDXCPJRsUTJ+
    a06fuCN4a9RWMoFG8hEilQV/TpYCbi3aXNutpsyDsJUKC3IAXhQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935046AbeB1QUy (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:20:54 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35396 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935224AbeB1QUw (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:20:52 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Adam Wallis" <awallis@codeaurora.org>,
        "Vinod Koul" <vinod.koul@intel.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.157345464@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 082/254] dmaengine: dmatest: warn user when dma test
 times out
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

From: Adam Wallis <awallis@codeaurora.org>

commit a9df21e34b422f79d9a9fa5c3eff8c2a53491be6 upstream.

Commit adfa543e7314 ("dmatest: don't use set_freezable_with_signal()")
introduced a bug (that is in fact documented by the patch commit text)
that leaves behind a dangling pointer. Since the done_wait structure is
allocated on the stack, future invocations to the DMATEST can produce
undesirable results (e.g., corrupted spinlocks). Ideally, this would be
cleaned up in the thread handler, but at the very least, the kernel
is left in a very precarious scenario that can lead to some long debug
sessions when the crash comes later.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=197605
Signed-off-by: Adam Wallis <awallis@codeaurora.org>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/dma/dmatest.c | 1 +
 1 file changed, 1 insertion(+)

--- a/drivers/dma/dmatest.c
+++ b/drivers/dma/dmatest.c
@@ -633,6 +633,7 @@ static int dmatest_func(void *data)
 			 * free it this time?" dancing.  For now, just
 			 * leave it dangling.
 			 */
+			WARN(1, "dmatest: Kernel stack may be corrupted!!\n");
 			dmaengine_unmap_put(um);
 			result("test timed out", total_tests, src_off, dst_off,
 			       len, 0);
