Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1431546-1518324054-2-12341602660326537372
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518324054; b=HQp1c7Y21VnGcDGcRtOifFfjNNNYkrH7V18ibKvaToSVS1j
    s5EWXGKwKVXZ7AL4MlZe9prCfU0ZeKF+m4/pjqFMDpd79G/nYNjaUmpDoeOKN665
    C24OKEx48qlhDD/q+ZIPGpr+dhVIdEaV+nooMMhMeGpCvnZccHenR3yuxuXjUWpY
    Bp6VbQoQPTdsquM28gb713aebNjzj+xraevTge6z1IiCHANswQZGthTrzQhJC4/v
    9eBPCj8I6GrzzOjV30FZ4LxNlysS7QfyqiGnd3J69aEWbsEi1vMRIVyK0i4CYoxO
    5wo5QfIjESp9mqSp16G2zT2teQhF7WKPR/8xoWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518324054; bh=ehJX/Y2qm2jTdkIQCNe
    FSK6niG8eoS9AMy5YGN9mhCQ=; b=w6OLcqnstpnkugRqwBVjmzqa76m1IShvfQY
    ruachPP7r48GOSw3tky+YP3JuIQW/z0npA9T88Ib2sIeSd+FfCJ+TW7SaH+R6bnZ
    Dm9GAvMKUnz43LLh3oTlO9xhzx8ielEJmEp3yMw7KVc1nMZICqCeV3HeKF4igH6h
    QlKWmbVSq7gCHfM52r0zsUvA+BbOi96RK05hnjOvpzn2eHV1vCEfeFfvHDv+Q+c6
    3hA6mrO1Sl4SGCT9ztfbPBXvOAVznG13rmCv+xzKtd+ZLWFSk4aIK3I/206aDSzB
    yvRCVy1iMB2PrB/rEGKwXkyBdFvGFu2Xnj6Cj2pzQNPAIhlmNKg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752995AbeBKEkw (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 23:40:52 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41672 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752945AbeBKEeI (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:34:08 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Will Deacon" <will.deacon@arm.com>,
        "Nathan Lynch" <nathan_lynch@mentor.com>,
        "Catalin Marinas" <catalin.marinas@arm.com>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.518592317@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 040/136] arm64: vdso: minor ABI fix for clock_getres
In-Reply-To: <lsq.1518323469.348919605@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.54-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Nathan Lynch <nathan_lynch@mentor.com>

commit e1b6b6ce55a0a25c8aa8af019095253b2133a41a upstream.

The vdso implementation of clock_getres currently returns 0 (success)
whenever a null timespec is provided by the caller, regardless of the
clock id supplied.

This behavior is incorrect.  It should fall back to syscall when an
unrecognized clock id is passed, even when the timespec argument is
null.  This ensures that clock_getres always returns an error for
invalid clock ids.

Signed-off-by: Nathan Lynch <nathan_lynch@mentor.com>
Acked-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/arm64/kernel/vdso/gettimeofday.S | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/arch/arm64/kernel/vdso/gettimeofday.S
+++ b/arch/arm64/kernel/vdso/gettimeofday.S
@@ -174,8 +174,6 @@ ENDPROC(__kernel_clock_gettime)
 /* int __kernel_clock_getres(clockid_t clock_id, struct timespec *res); */
 ENTRY(__kernel_clock_getres)
 	.cfi_startproc
-	cbz	w1, 3f
-
 	cmp	w0, #CLOCK_REALTIME
 	ccmp	w0, #CLOCK_MONOTONIC, #0x4, ne
 	b.ne	1f
@@ -188,6 +186,7 @@ ENTRY(__kernel_clock_getres)
 	b.ne	4f
 	ldr	x2, 6f
 2:
+	cbz	w1, 3f
 	stp	xzr, x2, [x1]
 
 3:	/* res == NULL. */
