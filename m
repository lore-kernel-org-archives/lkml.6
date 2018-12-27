Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A845C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 17:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE60320866
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 17:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pFhlksWD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731221AbeL0RJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 12:09:39 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52281 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728359AbeL0RJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 12:09:39 -0500
Received: by mail-wm1-f68.google.com with SMTP id m1so17230995wml.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Dec 2018 09:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dL10Nbf5DaOn0Qr5ZWd0sebGIsPWW1EyeGiD9qCqudo=;
        b=pFhlksWDvKOj+9lOLuhkMxidFpJmWIiqW40Ndy1La9HOmtXE/hYoTgcL9R5ZmCuWUD
         NiAPRabOZdtyUjotXGyUUCsbKyXMlZO/gkIZkQHkunJq5WMJ0winWnxbdRS5lbTz54Q4
         BlKPTYGOFEhqYBTbWQfwKBjxG3xTOFv+154b2qu//7qrVRxVwKyyFOwpYS+d+1XtoW5U
         vty7t+S6AdYu0ei8k1PtWBn9CRyrIPByBKs89wRVJcddyCn3ULm3zSmTOeZoHD+OroWc
         XFG7CnQsKKDVxrU6bVPvp8Dxy1buje9JRXwoHP9RZMR2S/SI8OkOD9O3Cbz2tXMm5V72
         h9sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dL10Nbf5DaOn0Qr5ZWd0sebGIsPWW1EyeGiD9qCqudo=;
        b=Mr65ggARmPrVe03PqY5XQ0qtOFOzM9OR2AymJFrecQ4tZ+QycQXWccZoPyktmW+o0p
         TtHIImm7RwOw18NycFSCEXx2TnPJ8K9vICSZm2d/LANGYLfykgyPJQCA6h+jLdPwnGqW
         /5SAUZAnYuassCn4QecrGJ9ejHjT3AoC8MpATzCLrlPSVo7rH0fmogNejG2qIglgn37J
         7aWPseV5f+Y5k/ijTGKnHB76D8mdFzv/cw/99nubv/OtFfkaLcW9MjT0mGQ9aQgLi1b6
         7TOE1gxNiF27Ds/7qXbWPTg/UdSuCkxocXRbt/1B6r8rLa+kY+6Mt11W+iMG9RYacjBK
         JuOQ==
X-Gm-Message-State: AJcUukceBKIjQFMr7HjBRymlmQaqP2Uwz6Wf/gzeV7jP4BziPwuZZR1f
        L8oY25WABuBZqnkjShO0cQ==
X-Google-Smtp-Source: AFSGD/WNvpCiJ90ZptnSsGK4bMIyUn0rbM9ga0HzsZsnHlJNwq1qNh4VV/3HzSVVs68ceqS76rulLg==
X-Received: by 2002:a1c:934e:: with SMTP id v75mr22139107wmd.126.1545930576223;
        Thu, 27 Dec 2018 09:09:36 -0800 (PST)
Received: from localhost (host254-25-dynamic.53-79-r.retail.telecomitalia.it. [79.53.25.254])
        by smtp.gmail.com with ESMTPSA id v8sm34826871wrq.53.2018.12.27.09.09.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Dec 2018 09:09:35 -0800 (PST)
Date:   Thu, 27 Dec 2018 18:09:34 +0100
From:   Andrea Righi <righi.andrea@gmail.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Yonghong Song <yhs@fb.com>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] x86: kprobes: Show correct blaclkist in debugfs
Message-ID: <20181227170934.GA2057@xps-13>
References: <154503482486.26176.6224515860220847638.stgit@devbox>
 <20181217154713.GA1308@Dell>
 <20181218135026.6f96a89247e9b70fa45afbe9@kernel.org>
 <20181218172134.GA2902@xps-13>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218172134.GA2902@xps-13>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 06:24:35PM +0100, Andrea Righi wrote:
> On Tue, Dec 18, 2018 at 01:50:26PM +0900, Masami Hiramatsu wrote:
> ...
> > > Side question: there are certain symbols in arch/x86/xen that should be
> > > blacklisted explicitly, because they're non-attachable.
> > > 
> > > More exactly, all functions defined in arch/x86/xen/spinlock.c,
> > > arch/x86/xen/time.c and arch/x86/xen/irq.c.
> > > 
> > > The reason is that these files are compiled without -pg to allow the
> > > usage of ftrace within a Xen domain apparently (from
> > > arch/x86/xen/Makefile):
> > > 
> > >  ifdef CONFIG_FUNCTION_TRACER
> > >  # Do not profile debug and lowlevel utilities
> > >  CFLAGS_REMOVE_spinlock.o = -pg
> > >  CFLAGS_REMOVE_time.o = -pg
> > >  CFLAGS_REMOVE_irq.o = -pg
> > >  endif
> > 
> > 
> > Actually, the reason why you can not probe those functions via
> > tracing/kprobe_events is just a side effect. You can probe it if you
> > write a kprobe module. Since the kprobe_events depends on some ftrace
> > tracing functions, it sometimes cause a recursive call problem. To avoid
> > this issue, I have introduced a CONFIG_KPROBE_EVENTS_ON_NOTRACE, see
> > commit 45408c4f9250 ("tracing: kprobes: Prohibit probing on notrace function").
> > 
> > If you set CONFIG_KPROBE_EVENTS_ON_NOTRACE=n, you can continue putting probes
> > on Xen spinlock functions too.
> 
> OK.
> 
> > 
> > > Do you see a nice and clean way to blacklist all these functions
> > > (something like arch_populate_kprobe_blacklist()), or should we just
> > > flag all of them explicitly with NOKPROBE_SYMBOL()?
> > 
> > As I pointed, you can probe it via your own kprobe module. Like systemtap,
> > you still can probe it. The blacklist is for "kprobes", not for "kprobe_events".
> > (Those are used to same, but since the above commit, those are different now)
> > 
> > I think the most sane solution is, identifying which (combination of) functions
> > in ftrace (kernel/trace/*) causes a problem, marking those NOKPROBE_SYMBOL() and
> > removing CONFIG_KPROBE_EVENTS_ON_NOTRACE.

I'm planning to spend a little bit more time on this and see if I can
identify the problematic ftrace functions and eventually drop
CONFIG_KPROBE_EVENTS_ON_NOTRACE, following the sane solution.

However, in the meantime, with the following patch I've been able to get
a more reliable kprobes blacklist and show also the notrace functions in
debugfs when CONFIG_KPROBE_EVENTS_ON_NOTRACE is off.

It's probably ugly and inefficient, because it's iterating over all
symbols in x86's arch_populate_kprobe_blacklist(), but it seems to work
for my specific use case, so I thought it shouldn't be bad to share it,
just in case (maybe someone else is also interested).

Thanks,

From: Andrea Righi <righi.andrea@gmail.com>
Subject: [PATCH] x86: kprobes: automatically blacklist all non-traceable functions

Iterate over all symbols to detect those that are non-traceable and
blacklist them.

Signed-off-by: Andrea Righi <righi.andrea@gmail.com>
---
 arch/x86/kernel/kprobes/core.c | 11 +++++++++--
 kernel/kprobes.c               | 22 ++++++++++++++++++++--
 2 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 4ba75afba527..8cc7191ba3f9 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -1026,10 +1026,17 @@ int kprobe_fault_handler(struct pt_regs *regs, int trapnr)
 }
 NOKPROBE_SYMBOL(kprobe_fault_handler);
 
+static int do_kprobes_arch_blacklist(void *data, const char *name,
+				     struct module *mod, unsigned long addr)
+{
+	if (arch_within_kprobe_blacklist(addr))
+		kprobe_add_ksym_blacklist(addr);
+	return 0;
+}
+
 int __init arch_populate_kprobe_blacklist(void)
 {
-	return kprobe_add_area_blacklist((unsigned long)__entry_text_start,
-					 (unsigned long)__entry_text_end);
+	return kallsyms_on_each_symbol(do_kprobes_arch_blacklist, NULL);
 }
 
 int __init arch_init_kprobes(void)
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index f4ddfdd2d07e..2e824cd536ba 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1389,11 +1389,29 @@ static int register_aggr_kprobe(struct kprobe *orig_p, struct kprobe *p)
 	return ret;
 }
 
+#if defined(CONFIG_KPROBES_ON_FTRACE) && \
+	!defined(CONFIG_KPROBE_EVENTS_ON_NOTRACE)
+static bool within_notrace(unsigned long addr)
+{
+	unsigned long offset, size;
+
+	if (!kallsyms_lookup_size_offset(addr, &size, &offset))
+		return true;
+	return !ftrace_location_range(addr - offset, addr - offset + size);
+}
+#else
+static bool within_notrace(unsigned long addr)
+{
+	return false;
+}
+#endif
+
 bool __weak arch_within_kprobe_blacklist(unsigned long addr)
 {
 	/* The __kprobes marked functions and entry code must not be probed */
-	return addr >= (unsigned long)__kprobes_text_start &&
-	       addr < (unsigned long)__kprobes_text_end;
+	return (addr >= (unsigned long)__kprobes_text_start &&
+	       addr < (unsigned long)__kprobes_text_end) ||
+	       within_notrace(addr);
 }
 
 bool within_kprobe_blacklist(unsigned long addr)
-- 
2.17.1

