Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-617694-1519837111-2-1600799745152414473
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
    t=1519837110; b=FKdj8DlRzAfExBSsJOhQjND4C+MmEuerOmbApHDYiCQTqIv
    IqonZpeAgnrWIMH6VrwKGOlVohPv82d7NvUx5M9L4QDj3Rw0oa87dFPmkEYp6SqR
    6GTtsS0YTC7RzGN2XiXYo6St5eqC+MaSc0JOFh20xDdrhM4W+FOZ6MXKkOV3M9CK
    ff74w1i5NhXXUUXjPGU56PijW2fZIGv8xUf2XasoGqxCWyxmNrZZ3+jl1u6gE5+K
    3W6vrCxlPvOQzk4GIzkvDHBDSqD3Su/WS9UZ/BJMNgQ6P34K6QMBrv+oOVdCroQN
    qHAbl+3kVf+KL/Vj4KvDaAfX7qZcmN8RP278izA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519837110; bh=pNtD+TSb4GKt8+PHCVp
    JmK4U0jcIzVwVw4Gdwl99QBU=; b=Q2TUB6ghWdwwsqeNsgllOG9jUQHYBsSdOWu
    ivqKjXiGqvjCjIm4XNJv1K+zKNIn4K7V0mZ7ex0cT8olq/7t7szbosVY1qkJxQSn
    oBdjNNfuFeDGGZFc1e7W8veD6qyl5wMj4dNQq02oaLMjfDyW7Te27Iw8agtZ0uFk
    KTQzKdo01nW5NZCZJAiF8/PU2eW7ukPdu5exEX3NtknokYlZzqGB5tw6QbTobk7h
    4Ml9XSVjt4D/xOFTUGDnXZh3ppN9PuxHQ8SlKqwbgYuHumpNwcz186LkRb8B3ZBq
    uYylE6/vx6SOT9MD+K8p4hnPycnph1fdX7J5lndJv2yzGdKAcvg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933910AbeB1Pwv (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:52:51 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34416 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932426AbeB1Pwt (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:52:49 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Tony Luck" <tony.luck@intel.com>,
        "Jia Zhang" <qianyue.zj@alibaba-inc.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Borislav Petkov" <bp@suse.de>, "x86-ml" <x86@kernel.org>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.361447019@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 179/254] x86/microcode/intel: Extend BDW late-loading
 with a revision check
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

From: Jia Zhang <qianyue.zj@alibaba-inc.com>

commit b94b7373317164402ff7728d10f7023127a02b60 upstream.

Instead of blacklisting all model 79 CPUs when attempting a late
microcode loading, limit that only to CPUs with microcode revisions <
0x0b000021 because only on those late loading may cause a system hang.

For such processors either:

a) a BIOS update which might contain a newer microcode revision

or

b) the early microcode loading method

should be considered.

Processors with revisions 0x0b000021 or higher will not experience such
hangs.

For more details, see erratum BDF90 in document #334165 (Intel Xeon
Processor E7-8800/4800 v4 Product Family Specification Update) from
September 2017.

[ bp: Heavily massage commit message and pr_* statements. ]

Fixes: 723f2828a98c ("x86/microcode/intel: Disable late loading on model 79")
Signed-off-by: Jia Zhang <qianyue.zj@alibaba-inc.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Tony Luck <tony.luck@intel.com>
Cc: x86-ml <x86@kernel.org>
Link: http://lkml.kernel.org/r/1514772287-92959-1-git-send-email-qianyue.zj@alibaba-inc.com
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/kernel/cpu/microcode/intel.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -271,8 +271,17 @@ static bool is_blacklisted(unsigned int
 {
 	struct cpuinfo_x86 *c = &cpu_data(cpu);
 
-	if (c->x86 == 6 && c->x86_model == 0x4F) {
-		pr_err_once("late loading on model 79 is disabled.\n");
+	/*
+	 * Late loading on model 79 with microcode revision less than 0x0b000021
+	 * may result in a system hang. This behavior is documented in item
+	 * BDF90, #334165 (Intel Xeon Processor E7-8800/4800 v4 Product Family).
+	 */
+	if (c->x86 == 6 &&
+	    c->x86_model == 0x4F &&
+	    c->x86_mask == 0x01 &&
+	    c->microcode < 0x0b000021) {
+		pr_err_once("Erratum BDF90: late loading with revision < 0x0b000021 (0x%x) disabled.\n", c->microcode);
+		pr_err_once("Please consider either early loading through initrd/built-in or a potential BIOS update.\n");
 		return true;
 	}
 
