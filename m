Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1340521-1526937499-2-524043415929093601
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526937498; b=fYlIYd/NjLRFYIiQMZEpxEd2FTv+ZUqeZyvlvNXGxGcYTo++rz
    S2FxBUcA923TXHoIiueSJjW+U9uL+4GXjryY0LpxIzY1YBqPtetkj4pUj5Tq0t3s
    oNb8Wjsbbu+qv2Qut6ZWPdh6uBiyIGuLeKOuBSoW3lcBUVFrL2yHBHn1d/fiZ3MG
    llDtXG0xp96AmQcluYfeRduNVwxYkMxtm4KFnM+vNvl/JMgH8wOk1hGTvN3HG5vE
    BQ2RGR/WX8uKD3ItKti+ZcgUZ36Echv9K0L+Nsd0hROtT5hRn+OrjPS3k/CqXyFW
    OXZddMtZRF858lDMjxk7HE530sspk9JejzSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526937498; bh=hhDRoV4Cej+buYoPbcOBeGGADlzQp/
    C9jJnCK7Un2vc=; b=Qj2PHgOKeZLcWcwc0TnabOIL9Ez1EM5wkPwQqCyyyic6T+
    z7jVr27DfY6ao+rLIz2fi8GYjoXU97cJEndhajpMR/00OQPRkMgwWRi3v6xvk1Vw
    b31pmAoZ4yF2/6RZ8HaYPD2X2XGbjsYX6xktlg+QalEtnRTahCfgZgy1nLRpdBCF
    Fy31/drbaLMW5LvkwD1IYAH+S5mfIgLYkRqPLCBIBi11Pk9e7aXbZuOgXI23ti84
    GI+QfqHjnlpGKX3BMjOXrsWkG1uHnY34zGcGRCFXnG6Xjey1d2BBezuyAbRPOeGJ
    DhFaPFImJgRblzveYtIeWAFWtL+1taOO3F+HS0kQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=InTM7EJs x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=InTM7EJs x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfOR2ESgYsLUTQ0sSCj03iI8EdVJKMG587ek/HPEHi7VxPovz4DXt4n6SHOVIfvAhIREyC39BqlNVwBDeXkrQea11xi07suSxWhFAYONtcVwnTWGhvnGW
    DQerZauXAXs0eJdLsn62DpHiTTx12LIuu8hvEqFxqs2LmQNJ6qdUg7pavMUS1szYiOFuFLEeWj2g28ia432pM/Gu1UT9DArUDtgDEOOsnyhrLeOEKwkYE7tj
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=wMNdZWldAAAA:8 a=ag1SF4gXAAAA:8 a=e6q0WhvrSwsW8V3Ope4A:9 a=QEXdDO2ut3YA:10
    a=FUarYpL4UH3yWsho8X8J:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751056AbeEUVSO (ORCPT <rfc822;greg@kroah.com>);
        Mon, 21 May 2018 17:18:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:33330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753409AbeEUVSL (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 21 May 2018 17:18:11 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Suchanek <msuchanek@suse.de>
Subject: [PATCH 4.14 14/95] powerpc: Dont preempt_disable() in show_cpuinfo()
Date: Mon, 21 May 2018 23:11:04 +0200
Message-Id: <20180521210450.526230128@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210447.219380974@linuxfoundation.org>
References: <20180521210447.219380974@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -242,14 +242,6 @@ static int show_cpuinfo(struct seq_file
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
@@ -358,9 +350,6 @@ static int show_cpuinfo(struct seq_file
 #ifdef CONFIG_SMP
 	seq_printf(m, "\n");
 #endif
-
-	preempt_enable();
-
 	/* If this is the last cpu, print the summary */
 	if (cpumask_next(cpu_id, cpu_online_mask) >= nr_cpu_ids)
 		show_cpuinfo_summary(m);
