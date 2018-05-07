Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-703107-1525689899-2-11378953683111334203
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525689899; b=bv3rHvkcQrtZ3F8EDIsoP5q7Yhq0um8JJ/NhkLai2XRYNhegiO
    MzOEhackSnzBB26zj1VgQtQIX17YkSith1forPuvhPKw5iCgiq/cn8uKlacG3brR
    0O0Br2v41+xunWfGjw6IfevonyCZ6D683xqf6+g5sTg6+mYgyURIH6jX91EI+Fft
    +6tMZ994vPRWiJOK8xUP9Z1MvAmCw2KmJqmm1/mJ9swRu527/Ya0JRzzf0ixuWEv
    aVMiNvqu9sIKr64PolFKTu5QzfFNzkNopxuRbvAG/HmdvJxvfzrt/A4w8Y/P59Vp
    s8YKPnXeRU2oV/05FpwrgO7xZAQpjsIAtpVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525689899; bh=
    vDXXDp5CguB+/rPY7XduTJBDoYQbhUEjq3vSKBJeaKI=; b=PFNlK5QFQw/LN/Sv
    eh8F0lY1nujBav5Q1OiYazy32VZud/l543hmt1C2l45ZxENTpmzdk29XQQQ3hxOE
    /6mMbRbGdE5kgsaF7XtqrQAcY7n2PRzdbP6yObiGmLIiHw6kFgIeYs2rxRkVkD+U
    qeCnzem5XDeGtOpWt60NnjJRxNErSZzlqlAB7Q3kbDer/BGOdRpjeXNTIDeNQIOP
    2SsBztMXk+dtCTvXXBDDfiULK2pee0CYROkD/JpHHLFaj7bB9RoIR5hWxB7JKaUr
    hhIYjv4TALfHj6jtoWsh7C3OFzA/lu+dEyniVv8/tiYY6KSvzoqj6vYaMQyUoaOd
    qXKaIA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=amarulasolutions.com
    header.i=@amarulasolutions.com header.b=qXV2aFfO x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=amarulasolutions.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=HEwDRpf0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=amarulasolutions.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=amarulasolutions.com
      header.i=@amarulasolutions.com header.b=qXV2aFfO x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=amarulasolutions.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=HEwDRpf0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=amarulasolutions.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfM00h93NPaGzPVJXenFW95H4k1XR10Fs7PQey8rYA59MnYS6SXKLDkN2A+4VUOSqouEVnhBlxliI67DVZoz543IyPhnF8zMfX8oeO2n3YRyjFhN/Iq44
    f+TOSuebf66eUb7M7O3WOHCjZ9IsQmQVBTgLOKiPpJpH86JMGAxL1Dp2CZqPpIhJsfx0k+PpHNORCbsOyM9FlKhcplgMRc+qhHvVcF6TO5s6mNdc8+IswDKf
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=iP-xVBlJAAAA:8
    a=VwQbUJbxAAAA:8 a=07d9gI8wAAAA:8 a=Z4Rwk6OoAAAA:8 a=cZNUurrS54-37h7PF4QA:9
    a=lHLH-nfn2y1bM_0xSXwp:22 a=AjGcO6oz07-iQ99wixmX:22 a=e2CUPOnPG4QKp8I52DXD:22
    a=HkZW87K1Qel5hWWM3VKY:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752305AbeEGKod (ORCPT <rfc822;linux@kroah.com>);
        Mon, 7 May 2018 06:44:33 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52944 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752290AbeEGKo3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 May 2018 06:44:29 -0400
X-Google-Smtp-Source: AB8JxZqa9+2KbBByN1a31dUvpiW/S/17dyB8xOpb6+Xc6qmJTbtmi49neDo7VCwVWstO80wWPY5Ydw==
From: Andrea Parri <andrea.parri@amarulasolutions.com>
To: Ingo Molnar <mingo@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        paulmck@linux.vnet.ibm.com,
        Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: [RFC PATCH v3 3/6] Documentation/features/core: Add arch support status files for 'cBPF-JIT' and 'eBPF-JIT'
Date: Mon,  7 May 2018 12:43:40 +0200
Message-Id: <1525689823-3340-4-git-send-email-andrea.parri@amarulasolutions.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525689823-3340-1-git-send-email-andrea.parri@amarulasolutions.com>
References: <1525689823-3340-1-git-send-email-andrea.parri@amarulasolutions.com>
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit 6077776b5908e split 'HAVE_BPF_JIT' into cBPF and eBPF variant.
Adds arch support status files for the new variants, and removes the
status file corresponding to 'HAVE_BPT_JIT'. The new status matrices
were auto-generated using the script 'features-refresh.sh'.

Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 .../features/core/BPF-JIT/arch-support.txt         | 33 ----------------------
 .../features/core/cBPF-JIT/arch-support.txt        | 33 ++++++++++++++++++++++
 .../features/core/eBPF-JIT/arch-support.txt        | 33 ++++++++++++++++++++++
 3 files changed, 66 insertions(+), 33 deletions(-)
 delete mode 100644 Documentation/features/core/BPF-JIT/arch-support.txt
 create mode 100644 Documentation/features/core/cBPF-JIT/arch-support.txt
 create mode 100644 Documentation/features/core/eBPF-JIT/arch-support.txt

diff --git a/Documentation/features/core/BPF-JIT/arch-support.txt b/Documentation/features/core/BPF-JIT/arch-support.txt
deleted file mode 100644
index d277f971ccd6b..0000000000000
--- a/Documentation/features/core/BPF-JIT/arch-support.txt
+++ /dev/null
@@ -1,33 +0,0 @@
-#
-# Feature name:          BPF-JIT
-#         Kconfig:       HAVE_BPF_JIT
-#         description:   arch supports BPF JIT optimizations
-#
-    -----------------------
-    |         arch |status|
-    -----------------------
-    |       alpha: | TODO |
-    |         arc: | TODO |
-    |         arm: |  ok  |
-    |       arm64: |  ok  |
-    |         c6x: | TODO |
-    |       h8300: | TODO |
-    |     hexagon: | TODO |
-    |        ia64: | TODO |
-    |        m68k: | TODO |
-    |  microblaze: | TODO |
-    |        mips: |  ok  |
-    |       nds32: | TODO |
-    |       nios2: | TODO |
-    |    openrisc: | TODO |
-    |      parisc: | TODO |
-    |     powerpc: |  ok  |
-    |       riscv: | TODO |
-    |        s390: |  ok  |
-    |          sh: | TODO |
-    |       sparc: |  ok  |
-    |          um: | TODO |
-    |   unicore32: | TODO |
-    |         x86: |  ok  |
-    |      xtensa: | TODO |
-    -----------------------
diff --git a/Documentation/features/core/cBPF-JIT/arch-support.txt b/Documentation/features/core/cBPF-JIT/arch-support.txt
new file mode 100644
index 0000000000000..90459cdde3143
--- /dev/null
+++ b/Documentation/features/core/cBPF-JIT/arch-support.txt
@@ -0,0 +1,33 @@
+#
+# Feature name:          cBPF-JIT
+#         Kconfig:       HAVE_CBPF_JIT
+#         description:   arch supports cBPF JIT optimizations
+#
+    -----------------------
+    |         arch |status|
+    -----------------------
+    |       alpha: | TODO |
+    |         arc: | TODO |
+    |         arm: | TODO |
+    |       arm64: | TODO |
+    |         c6x: | TODO |
+    |       h8300: | TODO |
+    |     hexagon: | TODO |
+    |        ia64: | TODO |
+    |        m68k: | TODO |
+    |  microblaze: | TODO |
+    |        mips: |  ok  |
+    |       nds32: | TODO |
+    |       nios2: | TODO |
+    |    openrisc: | TODO |
+    |      parisc: | TODO |
+    |     powerpc: |  ok  |
+    |       riscv: | TODO |
+    |        s390: | TODO |
+    |          sh: | TODO |
+    |       sparc: |  ok  |
+    |          um: | TODO |
+    |   unicore32: | TODO |
+    |         x86: | TODO |
+    |      xtensa: | TODO |
+    -----------------------
diff --git a/Documentation/features/core/eBPF-JIT/arch-support.txt b/Documentation/features/core/eBPF-JIT/arch-support.txt
new file mode 100644
index 0000000000000..c90a0382fe667
--- /dev/null
+++ b/Documentation/features/core/eBPF-JIT/arch-support.txt
@@ -0,0 +1,33 @@
+#
+# Feature name:          eBPF-JIT
+#         Kconfig:       HAVE_EBPF_JIT
+#         description:   arch supports eBPF JIT optimizations
+#
+    -----------------------
+    |         arch |status|
+    -----------------------
+    |       alpha: | TODO |
+    |         arc: | TODO |
+    |         arm: |  ok  |
+    |       arm64: |  ok  |
+    |         c6x: | TODO |
+    |       h8300: | TODO |
+    |     hexagon: | TODO |
+    |        ia64: | TODO |
+    |        m68k: | TODO |
+    |  microblaze: | TODO |
+    |        mips: |  ok  |
+    |       nds32: | TODO |
+    |       nios2: | TODO |
+    |    openrisc: | TODO |
+    |      parisc: | TODO |
+    |     powerpc: |  ok  |
+    |       riscv: | TODO |
+    |        s390: |  ok  |
+    |          sh: | TODO |
+    |       sparc: |  ok  |
+    |          um: | TODO |
+    |   unicore32: | TODO |
+    |         x86: |  ok  |
+    |      xtensa: | TODO |
+    -----------------------
-- 
2.7.4
