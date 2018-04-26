Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2209064-1524730164-2-14557381617110521153
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524730164; b=cHYnhW9EqLSOO/rx7B5eG8s9iCXq8sHz+0hMtXlOGjPS5ZNyiA
    iUoQIUTSYKa+fkGn7P+WqG+6uxTs1aJzLwGK0lxN/6xP9E9+DiCLAULAAZrhLxYQ
    3odvM3rmP+51wX1wF7zz18ZAcuoeQkOS2sc8/5AVbCu1UrAE6H7KnS29Y3NkLBHL
    ADA+q1HrqTIZ61Hrz/stXhiPfOmyR37WfkRGO1IBvjieamIHBAYvMzu2H/H4gIC6
    e4WyC1+oI/GO0BJiCJ61gKNaFO+saC6l0MR+9DpWgdY9h1+0x5DBm2yhkKAB+zYO
    ZB0mZmSA9E1hco2Jac4stLLb8P2s1BX5Mh4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524730164;
    bh=UijtCYrCdF0HMb4QTnkFRVJ3OtUaCMIXWJqE4cTr5Uo=; b=ZMYaSPbnkBYm
    B7Q5c2TTuPDLrUabN2grJjRGuGVDBnx9cQBZspmR6wPqGm1AcLgnesMfNc7Jn3OA
    Xr6hGtFWvTmw64b6pkaOZe2jKNuUwbXTCGZcmxCeEuwQqTDEhQ9vxX4Q7jROPBGy
    SYbA4Y42r7slLBFdDT5oqCZDtQ7LAQQ7Sj+0rEWHHf928UeAZJogo0iy24SA1Tqw
    GxTt+hP2WGRhiYNWUvSExGE2TGA/Xh+3M7ff/mdrt6+apoxQn6qOAn6EX15fWPOu
    ur4+tn+1Vp1734zee7hi0FhWG7Pw1guyAYrOO+HmSBxUuBrSMSrotfe8MkjERKE/
    Ir9E9dYDIg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFK52Ky0537UQxl3h7xturcIkoLTmXXp09tYj9bgtjJlbyDxPD9B6GiJjQ63CEiGQ+tCF/CYG8YboicQdRhScFq/GVEh51THNu12YjvBvv8/7ZO5TCM5
    x73ZZnsvjkLEMmvmXtzm9GcTVvDMdvkk5PIBu1YaGMpzzmbzHOXTJn2bP83bzHWgnB7QWhhdkrjzMiS7b0vA9f7m0aVpRXfv+xEP4QvysQcO6MobGALvyJzm
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=Ke8Jehkl8E0rIBd1d0QA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753951AbeDZII7 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 26 Apr 2018 04:08:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:34734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752419AbeDZII5 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 26 Apr 2018 04:08:57 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B939521781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
From: Masami Hiramatsu <mhiramat@kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jon Medhurst <tixy@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "Tobin C . Harding" <me@tobin.cc>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        akpm@linux-foundation.org, acme@kernel.org, rostedt@goodmis.org,
        brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        stable@vger.kernel.org
Subject: [PATCH -tip v2 1/7] kprobes: Make blacklist root user read only
Date: Thu, 26 Apr 2018 17:08:31 +0900
Message-Id: <152473011152.8819.5654087016485747842.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <152473007907.8819.10449983839199591406.stgit@devbox>
References: <152473007907.8819.10449983839199591406.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Since the blacklist file indicates a sensitive address
information to reader, it should be restricted to the
root user.

Suggested-by: Thomas Richter <tmricht@linux.ibm.com>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/kprobes.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 102160ff5c66..314cec85a8b2 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2621,7 +2621,7 @@ static int __init debugfs_kprobe_init(void)
 	if (!file)
 		goto error;
 
-	file = debugfs_create_file("blacklist", 0444, dir, NULL,
+	file = debugfs_create_file("blacklist", 0400, dir, NULL,
 				&debugfs_kprobe_blacklist_ops);
 	if (!file)
 		goto error;
