Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-99051-1527490810-2-14335006254978596278
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527490810; b=Q2y6X5N7adfEmLsfnHYC9GOOk9FyqCbUoYmoNwyOTh1tqcIMTW
    fvMDjCSg6DEcRQNJHe6VK0IX4syDbdPYAWyAqzdypiQzIrnC+puABH6vcA+JxiVX
    prJ2lE9C38IWLJ+IODdQKPIhDUq6JzXhCgqd2mr7aQCWdNEj1/5nb1aoYgSsQkQL
    rOzaqDdTmr5rUiS0IafdSt7Gym2E8UWSzYK3liz5Uz4PDgVkGoJo0NJlaNCZgz4Y
    efpezfZ86EsJN5zq9N+HvkSstQkXnEo4GAGRNOzDmd1xSd1IyuPXbyIXSsiobXA4
    UxGC+54DhCwyxc94UNsZqg33xmMwczTito3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1527490810;
    bh=sY11y1EGcvwGGkN9/MKS+0N2BVfsCd/E//UhY2zBVno=; b=Fk5ZSj7oi+Lp
    +XvXZEjI/Rhtwnmg9e+dHWJIVi4fesJ5zJx+Ym4lUb4bwwsZosn7rKUtchNQKQH2
    0+ek30Qe9k7ZS10yeBSNwWNu1cxDiGFC3vdNr+P+srcxwDMRCV1jfGUFTQXxE1oi
    lPN3O6GllRHksooDD9gczIcxUexl2rDhHnfyCw4jaHjjUoBuX+ARk0qGhfJgzsq/
    SoN7RKqihdA5LbpUi4GGPKZNtucz52Ji4fD6Wafdje76L8oeu2Dm16F8/8EP1eWJ
    XWD9JRLMRe3WJHElzV0rhuMnVazc4ixa9RlD5fQq2jKsGfhEmtdHdP6rf/lBsk6J
    tVtY6zRlpQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=xl+RsdDG header.a=rsa-sha256
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
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=xl+RsdDG header.a=rsa-sha256
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
X-CM-Envelope: MS4wfGDDQB0micxxWROkVYXYzQlU8AgylmSjOym/s+orXBOSVNaQlx3TQdKwLI959PFJLTVn47i4QMy+4rSBF4E7+2aWmlIux4RaX/oiaLHnAGeuaZqsCl8i
    z27RKrCcJINFz00buH06abnCun0ckkI9QM8DGh4d9q3Bvzjojle3+HBErC9T3ARziy16ZIqGVsOLl/goyaIET3Q51nPyNgnlvoL1syHjAkiwDR+daaBZ7MsC
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=LtRq_sKPvbM-v-v2jesA:9 a=q9jhxGrhH7tRGKNj:21
    a=PLQ7UrGdhCz-RsMG:21 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753552AbeE1HAJ (ORCPT <rfc822;linux@kroah.com>);
        Mon, 28 May 2018 03:00:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:35492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753570AbeE1HAI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 28 May 2018 03:00:08 -0400
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc: x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Laura Abbott <labbott@redhat.com>, Josef Bacik <jbacik@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S . Miller" <davem@davemloft.net>,
        linux-arch@vger.kernel.org
Subject: [PATCH -tip v4 01/27] Documentation/kprobes: Fix to remove remaining jprobe
Date: Mon, 28 May 2018 15:59:42 +0900
Message-Id: <152749078217.15132.3840614080309577218.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <152749074878.15132.16693721906742461289.stgit@devbox>
References: <152749074878.15132.16693721906742461289.stgit@devbox>
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
