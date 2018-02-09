Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1427278-1518185109-2-15658992547317752886
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518185108; b=jLjWE9AXo5j+2PJd4blypCyBw6AAc36h5N2DU610lXp3iZ6
    kCX1Vdo0kRkV/ZOUkGQ0SmeL+FwxVT8SeMvrpF57apI7ptU+ULiWrEoVQ0dsO0Vq
    cQxSvTnHiv8EbXrwdw2T3vCVEuy3+hvpJcxJ3jZnh0CQBKQa3CCeHMhNDJxZWYCj
    M/tmn0ReopsPBSIun7YYnVmOu3dl6LXvL7SfANLQJCmJJuDTsWZtImcLw8U16ynH
    pjhrJ+SW86A1zmGxJ3zXoXX8d3txO5ls1YnV+7i2DuWbNbUX4nUnpHgHThpxbB6R
    Lwm8FbpzsIl9DsKB83/bDbekATuQhQlvO02UbaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518185108; bh=xEDio291/96bwrpl0Rphg3cq5S
    rmO7p9oI2ZntmpzS8=; b=XEBGsAHLNx4E24rVxCZZnu99frjYSMLUOcdq5mi56f
    35xeSvI2kxuyquDURh6IylzHfdS4VVFqNlXkeYrbq0kRg7Qdaobly71e6OkgiIEc
    HmMmCBJ9eeoqD68PGwbCJyXvKUIAqNcYOgRByFDe5nd2pW3UMIUGhcdkr5aMKxtm
    Pofn87CGEs0xYlxUpIgUCQLawfQ+OXWD0wSQwAx5Spuecy4suxY3LJ3y2JcZ4Nly
    L6AspeaxFKhUKBOVMWODfydcTIwOwZHI1O1QSY3LKCpXmpBdfObHRWInw21tEf5m
    3aD8EjkW8VwkMqbyCIhWGmvqmXJG0umpjxEdumH0upmw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752791AbeBIOEq (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 09:04:46 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:50864 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752261AbeBINne (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Feb 2018 08:43:34 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>, riel@redhat.com,
        ak@linux.intel.com, peterz@infradead.org,
        David Woodhouse <dwmw2@infradead.org>, jikos@kernel.org,
        luto@amacapital.net, dave.hansen@intel.com,
        torvalds@linux-foundation.org, keescook@google.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        tim.c.chen@linux.intel.com, pjt@google.com,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 4.9 48/92] x86/bugs: Drop one "mitigation" from dmesg
Date: Fri,  9 Feb 2018 14:39:17 +0100
Message-Id: <20180209133934.651466374@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180209133931.211869118@linuxfoundation.org>
References: <20180209133931.211869118@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Borislav Petkov <bp@suse.de>

(cherry picked from commit 55fa19d3e51f33d9cd4056d25836d93abf9438db)

Make

[    0.031118] Spectre V2 mitigation: Mitigation: Full generic retpoline

into

[    0.031118] Spectre V2: Mitigation: Full generic retpoline

to reduce the mitigation mitigations strings.

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: riel@redhat.com
Cc: ak@linux.intel.com
Cc: peterz@infradead.org
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: jikos@kernel.org
Cc: luto@amacapital.net
Cc: dave.hansen@intel.com
Cc: torvalds@linux-foundation.org
Cc: keescook@google.com
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: tim.c.chen@linux.intel.com
Cc: pjt@google.com
Link: https://lkml.kernel.org/r/20180126121139.31959-5-bp@alien8.de
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/bugs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -90,7 +90,7 @@ static const char *spectre_v2_strings[]
 };
 
 #undef pr_fmt
-#define pr_fmt(fmt)     "Spectre V2 mitigation: " fmt
+#define pr_fmt(fmt)     "Spectre V2 : " fmt
 
 static enum spectre_v2_mitigation spectre_v2_enabled = SPECTRE_V2_NONE;
 static bool spectre_v2_bad_module;
