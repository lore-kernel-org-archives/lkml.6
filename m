Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2898263-1519909635-2-17420976134355295138
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519909634; b=AEQ6e513Brlj6YKAJAAz8GKb1Izr9DcTXADwgaTb1BBjLhz
    eb3pUMr0ZSxBpnpvq/QH3SwpylLGjCPD0ApN42O/JVwSNyv/FKk0/3AtdUkUDKHQ
    xwUCt+JLk9PP2TIGiIT/rN07VnqiIEbGvt7i4NtdNaVZ9f6Hxr7UHdDEKiJBMatN
    /hRF/CNCL5QqGHxmwF+CWUVF5VtcTrXXlAUGvrIIa5zpmev5R9VccpPCCdE9np93
    kk7zrsdxYPAMoMbdK+fwf1npP3WNWW2ePG1bbrWYW7PwhGTSPqvtkRvKX9svEVjH
    mbMfavsxZythqEANO1punwDKrq1p03QUmqcd13A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519909634;
    bh=B9j5UF0uESTYsHgGAtUITtbvy9Mt1eVCWXup4v2dg9E=; b=dLsanohHQ8dd
    aLLawzEwHh0zJxhGp1aIe74NACYfPcPgbG6h252mC+GQxHv9Ep5VS6CV9EJH7LVo
    BB8kyCXWv6/Jy7GnNJxamWzIJIEckRqUm/RdnTuJus/BsOdFsKt7wGMJs8U2vFAd
    4fKEwxoi23Sm/fozvX9W4bxT2e9A0K88R71w7Q5eI51sWqdlgN8F1VDeQr8gvKyt
    6C0BRJlwaoVQ0HitMxKuPJWnE5LS21JCfGG2w9ItKVcSpgFpJwiaW3buNe25woNS
    Nlt7KUNgYlSYwUPteM4gKwvhCipBrjoggQ0vekOFFsXFYxe4+7uPG6X8o67rl4JA
    MOY2KWlAcA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=L/9E5Ltp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=c24NByrq;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=L/9E5Ltp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=c24NByrq;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030600AbeCAM45 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 07:56:57 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:37411 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030576AbeCAM4z (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Mar 2018 07:56:55 -0500
X-Google-Smtp-Source: AG47ELvCpEunRQHWeOqLoDTvu+swGgZUBdPEg3zyzzVel6A0znw3pOXx7vuihGz9xKQb/258cC5GKg==
From: Alex Shi <alex.shi@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: Alex Shi <alex.shi@linaro.org>
Subject: [PATCH 13/45] arm64: uaccess: Prevent speculative use of the current addr_limit
Date: Thu,  1 Mar 2018 20:53:50 +0800
Message-Id: <1519908862-11425-14-git-send-email-alex.shi@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
References: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Will Deacon <will.deacon@arm.com>

commit c2f0ad4fc089 upstream.

A mispredicted conditional call to set_fs could result in the wrong
addr_limit being forwarded under speculation to a subsequent access_ok
check, potentially forming part of a spectre-v1 attack using uaccess
routines.

This patch prevents this forwarding from taking place, but putting heavy
barriers in set_fs after writing the addr_limit.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>
---
 arch/arm64/include/asm/uaccess.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index 3531fec..00025c5 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -71,6 +71,13 @@ static inline void set_fs(mm_segment_t fs)
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
-- 
2.7.4
