Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1874556-1527162920-2-11747060736035639402
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527162919; b=kYF/3y4UvM+kNxL91OiH7FnciBAwKWpbVztNvWwKwYQkUsgZlL
    DJcL13P++EYVWbATUa7Ctjw3cn80B3jcdFbv/G8g+DnG7sQgU3C+9oDx/LztyQTy
    ufY4xdyVsfMmvC4OrRcP7igLk/QN3AazhAqq+3WV5ehyZjFt77fVf+sUjf2JPf7f
    vdUKv0zfsiWMgoGJaJHbXGfHnPcr9OvcSEipU03JaHobR49fQIHpkNoayR4Xgz1Z
    DlhhWJTeZGO0pVSWncjF2RltpaJodN7vL5DWBKtIqfzQ5G/zFtbDtKp26U1QRqFL
    06f28wtJeT+uor97OJj7Cdp9um74hAoeGhiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527162919; bh=gFsTtcJ5uvbsIQ9XE3L5c1HgVf27F2
    AVT9hP1JOM4lg=; b=U3WXfURpiV58xTAmHqju7F1QPEBEcY8D+xUAaOtDV77SQf
    SQCz5/EgItQbrZQ1xMcucKJ5vPU9wWxnDCagkGK5TbTzz59XGJuZtPkcJ7KR4GjI
    Nr/pTiDHZcE/5XA5suQBYZ6Tv5af3/osXRmoBBf0a3pUdKf/d6rIYwIbq/ySu0en
    vitVBrLYymT1+1KW+T3OeuzsSjlajeGiCQ2ugE5HwvwoMT+fG0OMURrCn2+bJxID
    6z6QMmDf4HLXm05i2rlFbJJPUVvAeI67x2UjapXi5vPXrtXZ+E/NAh1xquHOdx4j
    Q3GgqTI44fHDzplCWSsVvNmjcu3g9d3EkYr1ZubQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=FdObbt/j x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=FdObbt/j x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfMQxhXKfmY8M9KGgWNsqH7SAj6pF4SRH8uOpfMYwzzZn6okCtm0zSuYEw1ix2fMydF5JctQx5zOE7nHDt+doYeGyk/N2V/iXhUd1IJFseEV3auT+9qU6
    v/UVxqsZa5gKZuy+qpf9MfzxJWvzKb3FaTwSVoiEdUU0Wapm56q0Xu3H5UxgUcoQE6iqibrznYGm+ekJZXmj40O0a+eMCfV5jFjA3x9r/OPTrYQb/pfpDVpZ
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=wMNdZWldAAAA:8 a=ag1SF4gXAAAA:8 a=e6q0WhvrSwsW8V3Ope4A:9 a=QEXdDO2ut3YA:10
    a=FUarYpL4UH3yWsho8X8J:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966943AbeEXLzD (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 07:55:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:57282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966877AbeEXJqH (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:46:07 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Suchanek <msuchanek@suse.de>
Subject: [PATCH 4.4 46/92] powerpc: Dont preempt_disable() in show_cpuinfo()
Date: Thu, 24 May 2018 11:38:23 +0200
Message-Id: <20180524093203.791914291@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093159.286472249@linuxfoundation.org>
References: <20180524093159.286472249@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

commit 349524bc0da698ec77f2057cf4a4948eb6349265 upstream.

This causes warnings from cpufreq mutex code. This is also rather
unnecessary and ineffective. If we really want to prevent concurrent
unplug, we could take the unplug read lock but I don't see this being
critical.

Fixes: cd77b5ce208c ("powerpc/powernv/cpufreq: Fix the frequency read by /proc/cpuinfo")
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Acked-by: Michal Suchanek <msuchanek@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/kernel/setup-common.c |   11 -----------
 1 file changed, 11 deletions(-)

--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -217,14 +217,6 @@ static int show_cpuinfo(struct seq_file
 	unsigned short maj;
 	unsigned short min;
 
-	/* We only show online cpus: disable preempt (overzealous, I
-	 * knew) to prevent cpu going down. */
-	preempt_disable();
-	if (!cpu_online(cpu_id)) {
-		preempt_enable();
-		return 0;
-	}
-
 #ifdef CONFIG_SMP
 	pvr = per_cpu(cpu_pvr, cpu_id);
 #else
@@ -329,9 +321,6 @@ static int show_cpuinfo(struct seq_file
 #ifdef CONFIG_SMP
 	seq_printf(m, "\n");
 #endif
-
-	preempt_enable();
-
 	/* If this is the last cpu, print the summary */
 	if (cpumask_next(cpu_id, cpu_online_mask) >= nr_cpu_ids)
 		show_cpuinfo_summary(m);
