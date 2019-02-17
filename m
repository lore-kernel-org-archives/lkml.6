Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63155C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 16:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 376792190C
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 16:34:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbfBQQeu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 11:34:50 -0500
Received: from mail.grenz-bonn.de ([178.33.37.38]:35374 "EHLO
        mail.grenz-bonn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbfBQQeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 11:34:50 -0500
Received: from [192.168.1.100] (212-51-139-180.fiber7.init7.net [212.51.139.180])
        by ks357529.kimsufi.com (Postfix) with ESMTPSA id 9F7FE7928D;
        Sun, 17 Feb 2019 17:34:47 +0100 (CET)
Subject: [PATCH] ptrace.2: Improve clarity for multi-threaded tracers
From:   =?UTF-8?Q?Niklas_Hamb=c3=bcchen?= <mail@nh2.me>
To:     mtk.manpages@gmail.com
Cc:     linux-kernel@vger.kernel.org, cleverca22@gmail.com,
        linux-man@vger.kernel.org
References: <48bb7c89-abb9-1e88-fee3-fb42d4032d12@nh2.me>
Openpgp: preference=signencrypt
Autocrypt: addr=mail@nh2.me; keydata=
 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
Message-ID: <bfa474c6-5b13-652d-2fd8-16b2be7efb62@nh2.me>
Date:   Sun, 17 Feb 2019 17:34:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <48bb7c89-abb9-1e88-fee3-fb42d4032d12@nh2.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Until now, the man page said:

    Attachment and subsequent commands are per thread:
    in a multi‐ threaded process, every thread can be individually attached to a
    (potentially different) tracer, or left not attached and thus not debugged.
    Therefore, "tracee" always means "(one) thread", never "a (possibly
    multithreaded) process".

While the first sentence "Attachment ... [is] per thread" might be interpreted
as holding for both tracer and tracee, the rest talks only about the
multi-threadedness of the *tracee*, leaving some uncertainty in the reader on
whether the tracer may issue `ptrace()` from different threads.

This patch adds more explicitness, removing any doubt.

Relevant resources:

* LKML thread https://marc.info/?l=linux-kernel&m=155036848808748&w=2
  "ptrace() with multithreaded tracer"
  where I asked about this behaviour, in case anybody disagrees with my
  understanding
* https://stackoverflow.com/questions/18737866/can-a-thread-trace-a-process/
  where the previous ambiguity of the man page confused some users, and where
  and example program is given that confirms the behaviour I mention in this
  patch
* A program of mine, in which I have independently confirmed that using
  `ptrace()` from a thread that's not the tracer thread (a sibling thread in
  the process is the tracer instead) results in `ESRCH`
* https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/ptrace.c?id=96d4f267e40f9509e8a66e2b39e8b95655617693#n207
  where the comment on `ptrace_check_attach()` talks about `%current`, which
  is a thread

Signed-off-by: Niklas Hambüchen <mail@nh2.me>
---
 man2/ptrace.2 | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/man2/ptrace.2 b/man2/ptrace.2
index 3b6b6ea84..4058abe94 100644
--- a/man2/ptrace.2
+++ b/man2/ptrace.2
@@ -122,12 +122,18 @@ It is primarily used to implement breakpoint debugging and system
 call tracing.
 .PP
 A tracee first needs to be attached to the tracer.
-Attachment and subsequent commands are per thread:
-in a multithreaded process,
+Attachment and subsequent commands are per thread,
+on both the tracer and tracee side.
+Issuing a tracing command from a thread that is not the tracer of the given
+.I pid
+will result in an
+.B ESRCH
+error.
+In a multithreaded process to be traced,
 every thread can be individually attached to a
 (potentially different) tracer,
 or left not attached and thus not debugged.
-Therefore, "tracee" always means "(one) thread",
+Therefore, "tracer" or "tracee" always mean "(one) thread",
 never "a (possibly multithreaded) process".
 Ptrace commands are always sent to
 a specific tracee using a call of the form
@@ -2259,7 +2265,7 @@ or (on kernels before 2.6.26) be
 .TP
 .B ESRCH
 The specified process does not exist, or is not currently being traced
-by the caller, or is not stopped
+by the calling thread, or is not stopped
 (for requests that require a stopped tracee).
 .SH CONFORMING TO
 SVr4, 4.3BSD.
--
2.17.1
