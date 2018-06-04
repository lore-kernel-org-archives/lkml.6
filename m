Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti33d1t02-1780358-1528127367-2-2238008029082921433
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1528127367; b=AhcrPDBTtxoZ3p8hvs1vPhzZsLbd2qVjbZbHz8llnpVOuaarqK
    VkFs8uNCrOscwTvJYt5dynxsJcYUm4PSRdLKafcESgWncmD+ANTirsx+kqkCwUP0
    t1Z82LolsiNhwBafL6X//Vse1lJSn4+ft0nYiEHuaogcX+vUZespf2FaRWFy6wFS
    9RP34+htP26KH8LZwjIcQkVz/OMprsjSe58soNlBpKeEaFnDRnYk++Nsa7eeMV7m
    cDDhnbAWqZzSZEWKnYLDocEdORfnubgPRV0NOn2DoZD7YRjMJWdyVRCMmpnyuO+P
    fRu5Jl8XXoD7MfqEoaamtoKfrnCRZCSYV0CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1528127367;
    bh=G4T0Sp8q9I9Tmpvi+y7yiDEoKH6retzybGrCbuMB+Ws=; b=UNKs13aidPDx
    +ghj+BT7GHHeEMV0xAzBKA34yNRiARqaR4NpepwlG3ULIWR8bliXbJSyL0D7qxsJ
    5v90KgDAvFS5jPlAvRk9Y5g7i8We5oRDQE6ouubrwzoaMieE0JpLl+/pgIh9ezcn
    5TwSVreXc1MbUZGnV3h2FeRyPR6W5NUG4IyUlWmpRPn+wjvUGRlulHIv9/DhcLrS
    ID5NIPUpvz8hvxhg2UrurnmZKnwLdeOj/Mo9Oo7yyIvtNhjIXhO5CpyMANILmgCV
    v3nxlffUZN6CMmEbFW6OIdiRnRQPe1ksverlGoYTLBK8UFPsNhQdy4LdTFwyRDy6
    UdTRHNpYgA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=dclULVu1 header.a=rsa-sha256
    header.s=default x-bits=1024;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=dclULVu1 header.a=rsa-sha256
      header.s=default x-bits=1024;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJRSEYVdyTo31avwiUpeuP048ho3G2P72pUb4lEXiazdSG06zsqlRkFDe+0qJmtkKOmNpeP52yMVEYgZCkAHEKdo4BddNzh/6fcv4KgNMBLEKlCf+TWE
    14CbSflfDJAS/mSkjoAAHruWPeMLHReLLowRT1TWtAd40Djv5yQjjso++X9YWZlVRji5PLpfTZOVaViPDT2mfQQwjCewA5Wm+BvK3fAAV7iFi41urNc0t2wP
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=7mUfYlMuFuIA:10
    a=VwQbUJbxAAAA:8 a=07d9gI8wAAAA:8 a=LtRq_sKPvbM-v-v2jesA:9
    a=RWDg8Kwhj7xMSMno:21 a=xO6M827N-GYgeY25:21 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=e2CUPOnPG4QKp8I52DXD:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751085AbeFDPtY (ORCPT <rfc822;linux@kroah.com>);
        Mon, 4 Jun 2018 11:49:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:55578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751266AbeFDPtY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 4 Jun 2018 11:49:24 -0400
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-arch@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: [RFC PATCH -tip v5 01/27] Documentation/kprobes: Fix to remove remaining jprobe
Date: Tue,  5 Jun 2018 00:49:00 +0900
Message-Id: <152812733994.10068.11973626561310254470.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <152812730943.10068.5166429445118734697.stgit@devbox>
References: <152812730943.10068.5166429445118734697.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Remove jps from the document, since jprobe is removed.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/kprobes.txt |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/kprobes.txt b/Documentation/kprobes.txt
index 22208bf2386d..5ae80baf3921 100644
--- a/Documentation/kprobes.txt
+++ b/Documentation/kprobes.txt
@@ -474,7 +474,7 @@ error occurs during registration, all probes in the array, up to
 the bad probe, are safely unregistered before the register_*probes
 function returns.
 
-- kps/rps/jps: an array of pointers to ``*probe`` data structures
+- kps/rps: an array of pointers to ``*probe`` data structures
 - num: the number of the array entries.
 
 .. note::
