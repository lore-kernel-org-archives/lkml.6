Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti33d1t02-1780358-1528127977-2-6083214847814161188
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1528127976; b=WYrUyw+1z5NpY+NHV5kO/VAM+TgwIIWoNwj8DDQvJSOSpRW0Hd
    IT1hGxohEb987QQuyScHcWImlo1/56YetiGwAR8gutwGbxkeDBSP4Nq1Tp4N9XUb
    HR6HhtjIry4+hfLVf7pJAqWxh+to4aC3FWeO4VrgzEfFm6J2nXV2/I/NJWh92KHz
    NuhZl1JI/zjncG0NSQfA9IUttCdbNyKtGvzEThddpaTmcS41PzOQjs8gjGzD8FcQ
    akPWokZnFRXSlueJwNOg7Ps6Bb/wOTfa4/TrjJFuvZkPbf0e8OQvdgr98527oz44
    R2R00Kx0EvMaXWeynS6wcjsTGbIrNeyg/DoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1528127976;
    bh=an3zK+CyP+NSK9c5nhlJhxfQ4qwnMQcSEeidDTFuI0w=; b=idK3y8shH79v
    lEFATviZp6VR28TfBB8Krl55XYzB0R8DdI/IZypVmqOfG7fVctfgU4kxvjX/qjKq
    6neHyg+YA8p3/GAa8DnipAkgaVSLAlp9ZFGoRoZmZ8JxxFjVKneN6Y5rFEMuWetz
    O9is0y11aBlI7+Rrk2caSTbTrhpjEGmLErvV9TwrsWPKgtmvyf+4I0kOQCUt7W+0
    tpgzjw1DHPLEXBQxs1oopQ9ihSGxActdL6CCjnlW3I7OiI1KpRd9MTF79itbWVXv
    MNivZvYdciBdFYRHvpeJD3R5SCxJ/htzz0QHrhAlKWedMdu0Gh6zV8daW9DRfmtf
    PMgehGh8zw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=CdMSFb/1 header.a=rsa-sha256
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
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=CdMSFb/1 header.a=rsa-sha256
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
X-CM-Envelope: MS4wfEExefCwwAXdXymrUXCrBEHb3cnzP+aTdtD6iRiGmCeSHF6OnFkMV7BjH1+wzHSjL/eQ0ibWJnud9J2HJ3ZBzvXg3Zr+Smf0kNpp1+6+B9Co6p+3PKt5
    kUCVGchyipH6Gb9CD+OM46EcykGnvkh0PUFFRceF6rXFcKEGWqV7LOwpPdJ1wYP/jlrbuWFkZbwwipSq77NzOiyLOxY22ECzQEy9bNap+GGizjsnxcNvxl0o
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=7mUfYlMuFuIA:10
    a=VwQbUJbxAAAA:8 a=hAG5_4vcAAAA:8 a=fsWX9E5i64TX0yKf0BUA:9
    a=rNVHbXP7peIwkvRK:21 a=EfhzlqB7MrMs71fi:21 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=8Bh8Pg2EFav9IBZ9i9Tn:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751213AbeFDP7f (ORCPT <rfc822;linux@kroah.com>);
        Mon, 4 Jun 2018 11:59:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:59342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750985AbeFDP7e (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 4 Jun 2018 11:59:34 -0400
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-arch@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Subject: [RFC PATCH -tip v5 22/27] sh: kprobes: Don't call the ->break_handler() in SH kprobes code
Date: Tue,  5 Jun 2018 00:59:10 +0900
Message-Id: <152812795011.10068.14489215679738766582.stgit@devbox>
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

Don't call the ->break_handler() from the SH kprobes code,
because it was only used by jprobes which got removed.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org
---
 arch/sh/kernel/kprobes.c |   14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/arch/sh/kernel/kprobes.c b/arch/sh/kernel/kprobes.c
index 2b5e58873b96..4fafe0cd12c6 100644
--- a/arch/sh/kernel/kprobes.c
+++ b/arch/sh/kernel/kprobes.c
@@ -248,11 +248,6 @@ static int __kprobes kprobe_handler(struct pt_regs *regs)
 			prepare_singlestep(p, regs);
 			kcb->kprobe_status = KPROBE_REENTER;
 			return 1;
-		} else {
-			p = __this_cpu_read(current_kprobe);
-			if (p->break_handler && p->break_handler(p, regs)) {
-				goto ss_probe;
-			}
 		}
 		goto no_kprobe;
 	}
@@ -281,7 +276,6 @@ static int __kprobes kprobe_handler(struct pt_regs *regs)
 		/* handler has already set things up, so skip ss setup */
 		return 1;
 
-ss_probe:
 	prepare_singlestep(p, regs);
 	kcb->kprobe_status = KPROBE_HIT_SS;
 	return 1;
@@ -508,14 +502,8 @@ int __kprobes kprobe_exceptions_notify(struct notifier_block *self,
 				if (post_kprobe_handler(args->regs))
 					ret = NOTIFY_STOP;
 			} else {
-				if (kprobe_handler(args->regs)) {
+				if (kprobe_handler(args->regs))
 					ret = NOTIFY_STOP;
-				} else {
-					p = __this_cpu_read(current_kprobe);
-					if (p->break_handler &&
-					    p->break_handler(p, args->regs))
-						ret = NOTIFY_STOP;
-				}
 			}
 		}
 	}
