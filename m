Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-558212-1524653188-2-16940540082325998154
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
    1524653187; b=h4PRfudEGL6qQmAyWWmPNeMvr31wAN0+7uX7J5Y3Dws7hyxM89
    lYDkwK5vUtahkWJFDgL5Iywrdt7ZgYiDaZUYFwb9V7UPxkew/zOzv745HxM0iiQb
    wL6aXeci5KE7nhkRXCp316yQbfNbDvrU1NzA5pyzepNefwJguA8BNindx8kqmnU6
    aCv0NaTRbqatQ4Va+Z3S8cThd2S1/p9TwWLOLGYMRJqqLftk2oBMgsXEfruIJDw2
    PgScFZKDfs3wMJbBq8Ge4JmVD8ZKjmbC0dnjOXITrcOo6HecT8rE9ika/vQG3I7C
    EgHqHn6Mn6RzrO1CgaXzdHLxVh0BE5B3QdUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524653187; bh=bU8908BmJEbgcTu0SIKlxrn1BECAkW
    qUu9kmXSOdFBQ=; b=jgUlp/pP5jmKDS4vV45PrZxQ/0RclkRbNQZnCpRpovO9lv
    Y62PkwqwjrQwpv5TrpGukXrCAXYxSrn54VZYJ8/TtlH6LfrBOolWgd41NQz1vg0R
    4DruC9SQVraP+pD2b09EX1JODhGPmjmEBoCbrev7C+lLZixkQ9r7R047AQoYchgF
    AtIxhLt2Tdd+0xyDSIocGyYJVrZ3+RRgqEC0VjdwTuWp8hF1FPAOEG3hLpPnmxXw
    HDDjqsj3+v0IWo8n9C7qDe5aGl8oDc5/zCXCcehv1cVMxAM+Wqbhjc7t9c/q5yg5
    aq8iD76G8yCNFXbevI+WLD/xll2I8cE98KlW5pcA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfIVLJABTFdlPTgtpSgXzXh39m1t3sNT4XTzMDq4I+EPlK9KtafrxmAT/3zvIEiSg9sVgE/ADnJ2YvPWl6fR86uZxVG9VB4qPj1+0t7334rwYZx+OSljv
    lfnRQH6lzHHCw12B0sgjClEFtOD7PAtJEmHG+5lQUP/ytosZW4aS1ncn6+e9BOFKX81dvZBv6zesDxOIVYDDPp7PCSy3DR3DSBox1lr3yle95NcjF7YsqSqN
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=QyXUC8HyAAAA:8 a=aatUQebYAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=pXeBbtYkOXvbKU-YMDkA:9 a=QEXdDO2ut3YA:10 a=7715FyvI7WU-l6oqrZBK:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752782AbeDYKqZ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 06:46:25 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53518 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754499AbeDYKpK (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 06:45:10 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Doug Smythies <dsmythies@telus.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Yu Chen <yu.c.chen@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 151/183] cpufreq: intel_pstate: Enable HWP during system resume on CPU0
Date: Wed, 25 Apr 2018 12:36:11 +0200
Message-Id: <20180425103248.606860969@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
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

From: Chen Yu <yu.c.chen@intel.com>


[ Upstream commit 70f6bf2a3b7e40c3f802b0ea837762a8bc6c1430 ]

When maxcpus=1 is in the kernel command line, the BP is responsible
for re-enabling the HWP - because currently only the APs invoke
intel_pstate_hwp_enable() during their online process - which might
put the system into unstable state after resume.

Fix this by enabling the HWP explicitly on BP during resume.

Reported-by: Doug Smythies <dsmythies@telus.net>
Suggested-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Yu Chen <yu.c.chen@intel.com>
[ rjw: Subject/changelog, minor modifications ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/cpufreq/intel_pstate.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -779,6 +779,8 @@ static int intel_pstate_hwp_save_state(s
 	return 0;
 }
 
+static void intel_pstate_hwp_enable(struct cpudata *cpudata);
+
 static int intel_pstate_resume(struct cpufreq_policy *policy)
 {
 	if (!hwp_active)
@@ -786,6 +788,9 @@ static int intel_pstate_resume(struct cp
 
 	mutex_lock(&intel_pstate_limits_lock);
 
+	if (policy->cpu == 0)
+		intel_pstate_hwp_enable(all_cpu_data[policy->cpu]);
+
 	all_cpu_data[policy->cpu]->epp_policy = 0;
 	intel_pstate_hwp_set(policy->cpu);
 
