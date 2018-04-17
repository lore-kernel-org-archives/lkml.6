Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2220351-1523981308-2-16712297960650129134
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
    1523981308; b=KLk9Mgsj7nTQ1Pf70IMKusm8apbp1VJzC/pR5uuGNp7ogqbUEY
    YT/IZzMa9reCYXSSV12zA5fXFGJ6pzzGMlGtXEHSdWiIeJaE6rU/jQgtFVOCcVUf
    DfGxjJkLKGlMxFte48X3bpytC89IMDSEBhafaJJDtY64yY8I/YHxfsAdmQAYnM17
    5ffAKIYTkejhEPdMSIHp7i18vWOdRm6ovmH/n1hBuOgkJHJrJ2DirrTmtZqLu+1p
    IB5B756nv2/1QmR2RH36/l3ksoAMxyf510350VY9BgOJ3BOTt2EUE3COfmB04CNj
    elVOMhKHKMtlkKGGjDO02uFfmo2AFF8Q7n3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523981308; bh=VmYK7I/sW6epTUOOanYxNK5UpAiAK4
    Kh9veI24oAQtY=; b=ZLRm/z3O1HP08SnRi5RyqJk9qjKMeyiz5aJnzJ3tg2Q90B
    YXZSPltHpdJ0ZySWrbUWbPk+YoIwIM7qUKF457EO2PuIRjmFBEc2OPRNDpriXwdS
    7rIjRzeJHeoM4bm9sEGGyC0bJvIC7xGVj366NurH8pUgSNGus8nt53a/Z/Jjgn8/
    9B2rs6hdiUUcfC1K2s48B0qZCJJnxHnk2Jm0xZAj/LIQ4MXGZTr0b+Bz6u3fJdIc
    SaWqs7DO6vXooOcBOTFLOe9qhyWmznKk+hshWICYm27Ku8IcvSUeaCDHdRlNt2IB
    r2BmWRuQvEUekaXFYbgjGi8PnL4zjPZvnTMXXgRQ==
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
X-CM-Envelope: MS4wfHiKZmkrvlQbQiCUAWYP8S9W/dbDMN1ooPDYGcCgldOq/OOUoIFuGJDKDQKt9gVbu7YeWDIxBOFiycIJlaY9U5EmsEO4rxymtnyaVG1tSUeAGlHhAp43
    +1Zl4yDfEh9K+sUa9bSenHCGS+fQSAgNZeVuv7YY0bKQLcRQJoGuBPhNF0QqpSsY2bV8z3J3asnFwEvD6BVIK2lMQRKp9WC9ps9h3VtGwUBWR9XLIP9Hc/4w
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=7CQSdrXTAAAA:8 a=1XWaLZrsAAAA:8 a=ag1SF4gXAAAA:8 a=L81Mo6SC5OE7cpdV_4MA:9
    a=QEXdDO2ut3YA:10 a=a-qgeE7W1pNrGK8U0ZQC:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755114AbeDQQIZ (ORCPT <rfc822;greg@kroah.com>);
        Tue, 17 Apr 2018 12:08:25 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35478 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755405AbeDQQIX (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 17 Apr 2018 12:08:23 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Hackmann <ghackmann@google.com>
Subject: [PATCH 4.9 16/66] arm64: uaccess: Prevent speculative use of the current addr_limit
Date: Tue, 17 Apr 2018 17:58:49 +0200
Message-Id: <20180417155646.551501269@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155645.868055442@linuxfoundation.org>
References: <20180417155645.868055442@linuxfoundation.org>
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

From: Mark Rutland <mark.rutland@arm.com>


From: Will Deacon <will.deacon@arm.com>

commit c2f0ad4fc089cff81cef6a13d04b399980ecbfcc upstream.

A mispredicted conditional call to set_fs could result in the wrong
addr_limit being forwarded under speculation to a subsequent access_ok
check, potentially forming part of a spectre-v1 attack using uaccess
routines.

This patch prevents this forwarding from taking place, but putting heavy
barriers in set_fs after writing the addr_limit.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Mark Rutland <mark.rutland@arm.com> [v4.9 backport]
Tested-by: Greg Hackmann <ghackmann@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/uaccess.h |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -68,6 +68,13 @@ static inline void set_fs(mm_segment_t f
 	current_thread_info()->addr_limit = fs;
 
 	/*
+	 * Prevent a mispredicted conditional call to set_fs from forwarding
+	 * the wrong address limit to access_ok under speculation.
+	 */
+	dsb(nsh);
+	isb();
+
+	/*
 	 * Enable/disable UAO so that copy_to_user() etc can access
 	 * kernel memory with the unprivileged instructions.
 	 */
