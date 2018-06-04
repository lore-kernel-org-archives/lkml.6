Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti33d1t02-1799621-1528128108-2-9888175257843553433
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1528128097; b=ZG6ZZvJrWH+TKO0Nv5U0DLJ0j3fHXREmYuQ995C+EdSII0r1Qh
    MC163kQUM79s5B4rf1fX49M59QRRnlEYHLpBHu3jwXd8elCPA9qUWyrWF0BaOjYn
    Mc3EvMYnAOfSkxuLGY8eyo6Nc5j0npGPJpQcEhfXF3I5G47jHc+41ANxtJipU79q
    4lahp+EuGtePbpBWSbpH7Q5BQfSGaQIy++5vcCyO4vrB7OhFlQdr93cFdOXkUwdJ
    DGlO2QihqCqhIYSkunXmZ5aUqpn8MpxnuJoQDByy68DYkfYgf3KSla1Tca45lh7+
    gX71ZObY0qKIfCgYpK93OXqIde4koKW4spCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1528128097;
    bh=TflKrYz08DQH93TRSwQc7PLVReSyaP0bbv9II3yX6Ck=; b=HdMeWQy71wns
    TM2lZPnBge+rNLXmTl7MXBjVnAsqzTnPvrDbIIegijIgsdU7kragoH0Dq/Li2pFh
    puvhRkFSq71uTuOtPeifvgMWOUjNRwq6GFu5vgYQbxHDRTgBO4nC7mXBbcjDr5ie
    uGJGwe5t2mPhTeMrcrL5qxLrOHmgHrcTt05u/NKDR6F/VGlIAfMSJEO8gPYHI6pr
    YxyYAIKl1z0Z4kr4K3Op9bOkIcKWbyU6M3OPAhV3GMFKHBf0k5aLAZRMlQP+6EcC
    75QYlM/JBZupxnppw5vo8NKnn+JiHELr27tNEMpMluADG9iVzH1JweZIshgGV9jw
    XdsQ8HIeyw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=MJMJIUD0 header.a=rsa-sha256
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
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=MJMJIUD0 header.a=rsa-sha256
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
X-CM-Envelope: MS4wfO9xsXdEc8HxjX4HcmFHUZVBv/3L7SHMYFNIvJP9yas1UPi8RY2fXgzMNlAbOVDrt7A6lJER9TY2W+ou+qp7pGuHZxA+UlNJu/5AgOVlnX0pGpWRHhKS
    REDD9hOQuqNKEoQi9cpLk8rdpCxO0oIyEsNNUQ+kE6La6/tIG/HKP8ewQG2JaW23H01GUaIdB/SV1VcwTAnHa1tmtD+I4hVJ4G36HCttV+qjr/165KA4R/yt
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=7mUfYlMuFuIA:10
    a=VwQbUJbxAAAA:8 a=07d9gI8wAAAA:8 a=gCol6u2zAc9TF8PHovMA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=e2CUPOnPG4QKp8I52DXD:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751449AbeFDQBe (ORCPT <rfc822;linux@kroah.com>);
        Mon, 4 Jun 2018 12:01:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:60350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751013AbeFDQBd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 4 Jun 2018 12:01:33 -0400
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
Subject: [RFC PATCH -tip v5 26/27] Documentation: kprobes: Add how to change the execution path
Date: Tue,  5 Jun 2018 01:01:09 +0900
Message-Id: <152812806959.10068.3756867273565043166.stgit@devbox>
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

Add a section that explaining how to change the execution
path with kprobes and warnings for some arch.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/kprobes.txt |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/kprobes.txt b/Documentation/kprobes.txt
index 3e9e99ea751b..8a98eed1521b 100644
--- a/Documentation/kprobes.txt
+++ b/Documentation/kprobes.txt
@@ -80,6 +80,26 @@ After the instruction is single-stepped, Kprobes executes the
 "post_handler," if any, that is associated with the kprobe.
 Execution then continues with the instruction following the probepoint.
 
+Changing Execution Path
+-----------------------
+
+Since the kprobes can probe into a running kernel code, it can change
+the register set, including instruction pointer. This operation
+requires maximum attention, such as keeping the stack frame, recovering
+execution path etc. Since it is operated on running kernel and need deep
+knowladge of the archtecture and concurrent computing, you can easily
+shot your foot.
+
+If you change the instruction pointer (and set up other related
+registers) in pre_handler, you must return !0 so that the kprobes
+stops single stepping and just returns to given address.
+This also means post_handler should not be called anymore.
+
+Note that this operation may be harder on some architectures which
+use TOC (Table of Contents) for function call, since you have to
+setup new TOC for your function in your module, and recover old
+one after back from it.
+
 Return Probes
 -------------
 
