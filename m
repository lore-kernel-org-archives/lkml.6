Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1681C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 17:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1F0F218A3
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 17:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jidC26qx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbeLRRYj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 12:24:39 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45872 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbeLRRYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 12:24:39 -0500
Received: by mail-wr1-f65.google.com with SMTP id t6so16561440wrr.12
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 09:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BQW99PsZ63VINy2Tlfuvx1EViNHJWklQFsAihrja4w4=;
        b=jidC26qxonJMPGCp6H3rwhcXgWDLAOUI5vCDLT5iXq2JGyxoMHSwGpD2SAWJlNSXag
         pLIS8FGdKd/NVQzg9HLt/+AxnKY/gMjWvKSnf2oxgy/9prqc1pwbLe8UD8OAYmN11Ara
         8B5+kly/F6VocBhVHR+Q/n8oRnlv11cEg3u3X8174glB4gneAYmn2P0ESPviEioFVmu1
         5zF3WYASVnEkr15fbUoVpcFwE8Y5t1gz7g3+vM8u/70yThd90RNqU2kyCY7fN88kTQcA
         gZInZU/xk5QwJHRFJD3WQptwlNc8IZxaO+6AoZ6t5M8EsSdGWeLz+1L11d06BOhUpE1y
         vRig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BQW99PsZ63VINy2Tlfuvx1EViNHJWklQFsAihrja4w4=;
        b=hWng23p8lJDNZcVbuyyOI2xgVYfY2g2q4JdRhIcpjP7zOQnV45yh/b8XLui1LJCtcT
         zRNMYSD0K9KeKf9de/DmyoPx5/lSaxNGV+R2T+nhyTz+793WhT9OMtdAgW2O23e/mgas
         slpNk6Vf8kf10loLZ0siWmI4VtGidB0ifae+31VWTpv/3d0jO1MWSXMspkk/7hf+sTPB
         P8x7n0ThzKGc61Sby6mVzNlZtvkRrBE74NmrrmbMYxnFXs2Q1iS12R+aX128jZh0DQHV
         GjhxR+O7SzDoT1CnqAAY7OF/zJrAFLVIfH/PSTkiDP7OBImvIUqPTlt7KjB6Z3gapnUy
         p2cQ==
X-Gm-Message-State: AA+aEWbNdJMulmUPSgZXgRjhYIhFAoWgJbve9+TI0FNObb8uIxnBKSg6
        mTvrKWtKDW8upIQst+WqRg==
X-Google-Smtp-Source: AFSGD/XA5Cfsjt+kVnZUbGHaNE03HqcCKQRxfG2uoD7M6zrqMZ/KojjbmE8DqejebwI760o5CshAZQ==
X-Received: by 2002:adf:94e4:: with SMTP id 91mr16473465wrr.322.1545153876954;
        Tue, 18 Dec 2018 09:24:36 -0800 (PST)
Received: from localhost (host171-129-dynamic.1-87-r.retail.telecomitalia.it. [87.1.129.171])
        by smtp.gmail.com with ESMTPSA id o9sm1903233wmh.3.2018.12.18.09.24.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Dec 2018 09:24:36 -0800 (PST)
Date:   Tue, 18 Dec 2018 18:24:35 +0100
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
Message-ID: <20181218172134.GA2902@xps-13>
References: <154503482486.26176.6224515860220847638.stgit@devbox>
 <20181217154713.GA1308@Dell>
 <20181218135026.6f96a89247e9b70fa45afbe9@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218135026.6f96a89247e9b70fa45afbe9@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 01:50:26PM +0900, Masami Hiramatsu wrote:
...
> > Side question: there are certain symbols in arch/x86/xen that should be
> > blacklisted explicitly, because they're non-attachable.
> > 
> > More exactly, all functions defined in arch/x86/xen/spinlock.c,
> > arch/x86/xen/time.c and arch/x86/xen/irq.c.
> > 
> > The reason is that these files are compiled without -pg to allow the
> > usage of ftrace within a Xen domain apparently (from
> > arch/x86/xen/Makefile):
> > 
> >  ifdef CONFIG_FUNCTION_TRACER
> >  # Do not profile debug and lowlevel utilities
> >  CFLAGS_REMOVE_spinlock.o = -pg
> >  CFLAGS_REMOVE_time.o = -pg
> >  CFLAGS_REMOVE_irq.o = -pg
> >  endif
> 
> 
> Actually, the reason why you can not probe those functions via
> tracing/kprobe_events is just a side effect. You can probe it if you
> write a kprobe module. Since the kprobe_events depends on some ftrace
> tracing functions, it sometimes cause a recursive call problem. To avoid
> this issue, I have introduced a CONFIG_KPROBE_EVENTS_ON_NOTRACE, see
> commit 45408c4f9250 ("tracing: kprobes: Prohibit probing on notrace function").
> 
> If you set CONFIG_KPROBE_EVENTS_ON_NOTRACE=n, you can continue putting probes
> on Xen spinlock functions too.

OK.

> 
> > Do you see a nice and clean way to blacklist all these functions
> > (something like arch_populate_kprobe_blacklist()), or should we just
> > flag all of them explicitly with NOKPROBE_SYMBOL()?
> 
> As I pointed, you can probe it via your own kprobe module. Like systemtap,
> you still can probe it. The blacklist is for "kprobes", not for "kprobe_events".
> (Those are used to same, but since the above commit, those are different now)
> 
> I think the most sane solution is, identifying which (combination of) functions
> in ftrace (kernel/trace/*) causes a problem, marking those NOKPROBE_SYMBOL() and
> removing CONFIG_KPROBE_EVENTS_ON_NOTRACE.

OK. Thanks for the clarification!

-Andrea
