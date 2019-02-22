Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 452AFC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 14:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06C65207E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 14:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UalsrtjK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbfBVOk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 09:40:26 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41063 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbfBVOk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 09:40:26 -0500
Received: by mail-qt1-f193.google.com with SMTP id v10so2673935qtp.8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 06:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3nqziSR0IfLt5LIlwX6Zr4057uYzySdWezW/DQsmFSI=;
        b=UalsrtjKComwjFFup0WYp3K0rRfg61bdNY9MjupkBWPt0Pou7OEKThgJw5YG3d/KSP
         6WFqZdtC4WxOlw75awLARgVR65bG3xrvh4U6wXL0H4ZXJWaj8ExY4NoOgXcJItoyuISu
         Z8RJQ0UhkFgasXY2p1UMPJVtTMwQrPGMr7sJRKeWQQy0aIw5HwslYOO5sEcQZIzw+Whl
         y/Ee1vV1GzFy5hJHo+PBHlWXZvMlUwSrzq1fHWStUcgmXxvcf0GKgnvpWZY71TMnnkFP
         hPiKfGwnKoT7+td8oC8R19l2D1GZ+NyozE9wIwCVj6P3ArMoo9kbVw8+dpv+ObXnLiNd
         ISQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3nqziSR0IfLt5LIlwX6Zr4057uYzySdWezW/DQsmFSI=;
        b=luscHDJY8pz2PUc0eTs1wX7tiTvTV5O63p1xiFLtjf4MOvJSRdqqukYtU5IlYhhdmD
         RYkWuU6szHk8mGkU6UiwMm6iZWjmYS5G6bx7T3eVJt/Z5D+TrMq+2lV//F8uGpJAJBLs
         gnECmjDjFEtnD+rxxikPLmoTKRbT4BB/RAwDkji0J7F7O2Y2VZMOZwjGw+QNNS4RLCD9
         yHMHzUsziddNF01m0F5mnUgZw8p1Rdndp6fvO6obyUaRfS/gE1hYGF8m0hDdHbsYG3o9
         ZUjWIfGgsrPwxrmaqXqAFXOVIJ4Ol1eJi1dsbIJj7sfXgdQ9FyIuntI8E8F7ceuc2Ds3
         sTnQ==
X-Gm-Message-State: AHQUAuZE8S+qGROen6GxZaegwxvSRiY+mJusKcxIt9P7pCoZyqib6P2Q
        itjqYGwc+fJHtRQdzs370j7GE+uw
X-Google-Smtp-Source: AHgI3IZ6nHPCuW7SAZ5WwfrHoHMh+kENxyM0fAE9pFqgHNcF0czQo62fYiQCRS1QHcAMdLd/lPI68w==
X-Received: by 2002:a0c:928a:: with SMTP id b10mr3322787qvb.89.1550846424724;
        Fri, 22 Feb 2019 06:40:24 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id s8sm1033345qtb.70.2019.02.22.06.40.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 06:40:23 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7CC664039C; Fri, 22 Feb 2019 11:39:00 -0300 (-03)
Date:   Fri, 22 Feb 2019 11:39:00 -0300
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] perf thread-stack: Improve
 thread_stack__no_call_return()
Message-ID: <20190222143900.GA13225@kernel.org>
References: <20190109091835.5570-1-adrian.hunter@intel.com>
 <20190109091835.5570-6-adrian.hunter@intel.com>
 <ef029200-4eb7-3fb5-fcb2-64f5b129a6bf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef029200-4eb7-3fb5-fcb2-64f5b129a6bf@intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Feb 22, 2019 at 11:48:51AM +0200, Adrian Hunter escreveu:
> On 9/01/19 11:18 AM, Adrian Hunter wrote:
> > Improve thread_stack__no_call_return() to better handle 'returns' that do
> > not match the stack i.e. 'no call'. See code comments for details.
> 
> This patch and patch 6 of the series do not seem to have been applied.
> Can they be applied?

I think there was some python3 oddity and I ended up letting this fell
thru the cracks, now I applied and tested it, see my results below, ints
in my perf/core branch now, will go together with your new batch in the
next pull req to Ingo,

Thanks,

- Arnaldo

commit 4ad79244f4899815a904f6e6adb71d24216b9b1d
Author: Adrian Hunter <adrian.hunter@intel.com>
Date:   Wed Jan 9 11:18:34 2019 +0200

    perf thread-stack: Improve thread_stack__no_call_return()
    
    Improve thread_stack__no_call_return() to better handle 'returns' that
    do not match the stack i.e. 'no call'. See code comments for details.
    The example below shows how retpolines are affected:
    
    Example:
    
      $ cat simple-retpoline.c
      __attribute__((noinline)) int bar(void)
      {
              return -1;
      }
    
      int foo(void)
      {
              return bar() + 1;
      }
    
      __attribute__((indirect_branch("thunk"))) int main()
      {
              int (*volatile fn)(void) = foo;
    
              fn();
              return fn();
      }
      $ gcc -ggdb3 -Wall -Wextra -O2 -o simple-retpoline simple-retpoline.c
      $ objdump -d simple-retpoline
      <SNIP>
      0000000000001040 <main>:
          1040:       48 83 ec 18             sub    $0x18,%rsp
          1044:       48 8d 05 25 01 00 00    lea    0x125(%rip),%rax        # 1170 <foo>
          104b:       48 89 44 24 08          mov    %rax,0x8(%rsp)
          1050:       48 8b 44 24 08          mov    0x8(%rsp),%rax
          1055:       e8 1f 01 00 00          callq  1179 <__x86_indirect_thunk_rax>
          105a:       48 8b 44 24 08          mov    0x8(%rsp),%rax
          105f:       48 83 c4 18             add    $0x18,%rsp
          1063:       e9 11 01 00 00          jmpq   1179 <__x86_indirect_thunk_rax>
      <SNIP>
      0000000000001160 <bar>:
          1160:       b8 ff ff ff ff          mov    $0xffffffff,%eax
          1165:       c3                      retq
      <SNIP>
      0000000000001170 <foo>:
          1170:       e8 eb ff ff ff          callq  1160 <bar>
          1175:       83 c0 01                add    $0x1,%eax
          1178:       c3                      retq
      0000000000001179 <__x86_indirect_thunk_rax>:
          1179:       e8 07 00 00 00          callq  1185 <__x86_indirect_thunk_rax+0xc>
          117e:       f3 90                   pause
          1180:       0f ae e8                lfence
          1183:       eb f9                   jmp    117e <__x86_indirect_thunk_rax+0x5>
          1185:       48 89 04 24             mov    %rax,(%rsp)
          1189:       c3                      retq
      <SNIP>
      $ perf record -o simple-retpoline.perf.data -e intel_pt/cyc/u ./simple-retpoline
      [ perf record: Woken up 1 times to write data ]
      [ perf record: Captured and wrote 0,017 MB simple-retpoline.perf.data ]
      $ perf script -i simple-retpoline.perf.data --itrace=be -s ~/libexec/perf-core/scripts/python/export-to-sqlite.py simple-retpoline.db branches calls
      2019-01-08 14:03:37.851655 Creating database...
      2019-01-08 14:03:37.863256 Writing records...
      2019-01-08 14:03:38.069750 Adding indexes
      2019-01-08 14:03:38.078799 Done
      $ ~/libexec/perf-core/scripts/python/exported-sql-viewer.py simple-retpoline.db
    
    Before:
    
        main
            -> __x86_indirect_thunk_rax
                -> __x86_indirect_thunk_rax
                    -> __x86_indirect_thunk_rax
                        -> bar
    
    After:
    
        main
            -> __x86_indirect_thunk_rax
                -> __x86_indirect_thunk_rax
                    -> foo
                        -> bar
    
    Committer testing:
    
    Chose "Reports", Then "Context-Sensitive Call Graph" and then go on
    expanding:
    
    Before:
    
    simple-retpolin
       PID:PID
          _start
             _start
                __libc_start_main
                   main
                       __x86_indirect_thunk_rax
                          __x86_indirect_thunk_rax
                          bar
    
    After:
    
    Remove the "simple.retpoline.db" file, run again the 'perf script' line
    to regenerate the .db file and run the exported-sql-viewer.py again to
    get the same all the way to 'main', then, from there, including 'main':
    
                   main
                       __x86_indirect_thunk_rax
                           __x86_indirect_thunk_rax
                               foo
                                   bar
    
    Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
    Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
    Cc: Jiri Olsa <jolsa@redhat.com>
    Link: http://lkml.kernel.org/r/20190109091835.5570-6-adrian.hunter@intel.com
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
index f52c0f90915d..632c07a125ab 100644
--- a/tools/perf/util/thread-stack.c
+++ b/tools/perf/util/thread-stack.c
@@ -638,14 +638,57 @@ static int thread_stack__no_call_return(struct thread *thread,
 	else
 		parent = root;
 
-	/* This 'return' had no 'call', so push and pop top of stack */
-	cp = call_path__findnew(cpr, parent, fsym, ip, ks);
+	if (parent->sym == from_al->sym) {
+		/*
+		 * At the bottom of the stack, assume the missing 'call' was
+		 * before the trace started. So, pop the current symbol and push
+		 * the 'to' symbol.
+		 */
+		if (ts->cnt == 1) {
+			err = thread_stack__call_return(thread, ts, --ts->cnt,
+							tm, ref, false);
+			if (err)
+				return err;
+		}
+
+		if (!ts->cnt) {
+			cp = call_path__findnew(cpr, root, tsym, addr, ks);
+
+			return thread_stack__push_cp(ts, addr, tm, ref, cp,
+						     true, false);
+		}
+
+		/*
+		 * Otherwise assume the 'return' is being used as a jump (e.g.
+		 * retpoline) and just push the 'to' symbol.
+		 */
+		cp = call_path__findnew(cpr, parent, tsym, addr, ks);
+
+		err = thread_stack__push_cp(ts, 0, tm, ref, cp, true, false);
+		if (!err)
+			ts->stack[ts->cnt - 1].non_call = true;
+
+		return err;
+	}
+
+	/*
+	 * Assume 'parent' has not yet returned, so push 'to', and then push and
+	 * pop 'from'.
+	 */
+
+	cp = call_path__findnew(cpr, parent, tsym, addr, ks);
 
 	err = thread_stack__push_cp(ts, addr, tm, ref, cp, true, false);
 	if (err)
 		return err;
 
-	return thread_stack__pop_cp(thread, ts, addr, tm, ref, tsym);
+	cp = call_path__findnew(cpr, cp, fsym, ip, ks);
+
+	err = thread_stack__push_cp(ts, ip, tm, ref, cp, true, false);
+	if (err)
+		return err;
+
+	return thread_stack__call_return(thread, ts, --ts->cnt, tm, ref, false);
 }
 
 static int thread_stack__trace_begin(struct thread *thread,
