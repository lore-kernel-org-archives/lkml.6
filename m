Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1340521-1526938433-2-6301126264516296699
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526938432; b=VmLuVuuRcwe30JTyByKPRt8BrrcMDR5HgowGCPlTHPpXXPvh5B
    +oWSLyvQql1Dmh/5/9GQn+Pa1iyoxDppyn13wB/X/46UKU5yYtHLjogEQcwDAhwQ
    9qkRNGzt3dN/F//2IxRU7boNJEU/eZJkk2OK7L0/4EMA3XMHPsOC1M7izISlCw4j
    hG5H9+78XG/Ei67V65mxgwVFPeDuXa2zWx1BDVT/DfUrXCA5W46iD2x+hrkQsrGp
    6KZrYjrNUf6Hd8PMkjwZZPFT2B1UFE8GwlRFyxUGmdYNAvv7bXpg7VI9xcnoI4S1
    qeb+A79HAqqP5phdUmBsfhwN6IoONKOornJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526938432; bh=/Wbc/P3azr7EXVEWeOoe+HNJ2CKk8z
    KgKCj4RR8L4lM=; b=GeVNNzhRvhV+LgnFZyz7naZXzK6po3z5Px1tGqrRKdAb/8
    DRqC41IS3Yx4dTEE1iMfabMVWUhpbAs1PvZdbb/0S3Y/KJTYnJwW9P1z6MTSjJgx
    DHSsS0jpCs9Ed4tFH53VHUVROGqBgCiUVJwUEap6Xb8//KvqyKWTQkT7J3a1EEQk
    COmICoQ+NX1+f6c0P8VvqpQSNPp5suVFqKM3H5ce63P1NDFxk27Nxfuoc6L9M9lF
    u/PtiS4jrulXywmKPioV3sq6eQu6mkEnBNbaZ+MMGLWJTvMJ/T4ATxdffVL5YBuI
    FXp8/QFI3dT0b5EJnkzhsTz88gyc2VY4RAhxOtrg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=tbRjm9bP x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=tbRjm9bP x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfA1A7Do9I9qGHSU4nA2u4+1HEEilZIrJ1QE4iyIL3i5WdweGzGjuGJ29dKgwyjS0ewQC6OZCy+h1QnW73LIW8qINCTgTmLdsVPLDNNtdUeGg/QyMb6Dw
    bhqlRQI+IAN7u8uJUj6dO/vQ2nK6Iqe3zQBWbgUl2iMWMjLSBm2GWXw6zpAXH9BUeqCcAQ2aT2VfCNxVwf6B2AFQBmfWWpbeB5ritCftdjtnmrx18I7wkWaG
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=ag1SF4gXAAAA:8 a=M0XPXDyK0zsVw8u4YH8A:9 a=QEXdDO2ut3YA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932512AbeEUV0K (ORCPT <rfc822;greg@kroah.com>);
        Mon, 21 May 2018 17:26:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:40942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932510AbeEUV0H (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 21 May 2018 17:26:07 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.16 091/110] x86/bugs: Make cpu_show_common() static
Date: Mon, 21 May 2018 23:12:28 +0200
Message-Id: <20180521210514.000271981@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210503.823249477@linuxfoundation.org>
References: <20180521210503.823249477@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiri Kosina <jkosina@suse.cz>

commit 7bb4d366cba992904bffa4820d24e70a3de93e76 upstream

cpu_show_common() is not used outside of arch/x86/kernel/cpu/bugs.c, so
make it static.

Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/bugs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -640,7 +640,7 @@ void x86_spec_ctrl_setup_ap(void)
 
 #ifdef CONFIG_SYSFS
 
-ssize_t cpu_show_common(struct device *dev, struct device_attribute *attr,
+static ssize_t cpu_show_common(struct device *dev, struct device_attribute *attr,
 			char *buf, unsigned int bug)
 {
 	if (!boot_cpu_has_bug(bug))
