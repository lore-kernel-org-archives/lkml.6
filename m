Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF7EC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 17:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7125B218FD
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 17:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tcWS9f0H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731313AbfBARfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 12:35:13 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:39960 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbfBARfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 12:35:12 -0500
Received: by mail-io1-f66.google.com with SMTP id k2so6318995iog.7
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 09:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qCwvscVM/TJkSwOBFqx5kqPZega2w9fbnmQXRgn5dC0=;
        b=tcWS9f0HyHRYaZ9CcuPKZGz5zPI3m+RXHd21+71t5tN8PdWfnxz/FXQD0usfQyYHke
         J+tI+K4Z+35OnMZ6f4r5U9+BYu0g+g5yF2umVVJ3leirmIHMeNIdEVefj3quH43rGQUR
         W4veGVbhtGb87nT29p0Nm9s8R7uj/eDQXzGfUOiiaCCkke1bJkCuu7u5n8xsPWEj9vwr
         rFDMPjJMeEW59RU6pRQASdN2uFZYGLX2/I9txjLcJgzT+Bg5jJ+u5YqkR/9UZieA9NUu
         nrpfDk/VvsiMTzHCBsG/zL9kLKVgUnkxp3HlBNWzmz+ZrZpHUGxgsFgKHuLpdSHHc/l0
         OtIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qCwvscVM/TJkSwOBFqx5kqPZega2w9fbnmQXRgn5dC0=;
        b=j4QkxY1BAHuLlx+O2ZTN4UVRgbzC1d57BxWfrvBjertH1bhc0b0fR0m3YAjN06o+2I
         obYqk1YWpwwNR0MysVeQRro3uSdlDOyrJWiW+CRJPyPRk44lGDdJVHXEFZxbE/V8O+3C
         WOq0ivx3hcqthj+tH1P9Kn/2wEtAbAJPVjyose2XJa/JmLw3r4o84iZyamiFOurq1gJq
         JS30kTK5NXRZkMKcNBDBnfwcgNrdSD0a07fEkPXMgu16ge7GAgh5JttRGmODbfr+Z9xn
         XaXr5yNHzGtjQep0OTs1qPs7A5jRDs0o4EPAUZkz0yvbCo8I/qIqRe/3Vi57F2/jW+sY
         Xmiw==
X-Gm-Message-State: AHQUAubXHhXYUE6llEDOSG/LdxZtLSzhS+c+bOzqyCwT+c777cV7YxA6
        v5jDV4YLlRYdXCIgdjIDymMEbEt7dPqpKSXD9QIj8w==
X-Google-Smtp-Source: AHgI3Ia3FDaCAZ70M41ZT4WczmN6PjrKaogADa+FHC7gV7JWPy5uhqlo2dkX8F2bWp5FNP0JCzQp9DnmE6tmQVcs5rQ=
X-Received: by 2002:a5e:8f06:: with SMTP id c6mr408845iok.140.1549042511411;
 Fri, 01 Feb 2019 09:35:11 -0800 (PST)
MIME-Version: 1.0
References: <20190131192533.34130-1-thgarnie@chromium.org> <20190131192533.34130-16-thgarnie@chromium.org>
 <3a2bdc07-e8c4-c340-dde7-516ab0de66f2@intel.com>
In-Reply-To: <3a2bdc07-e8c4-c340-dde7-516ab0de66f2@intel.com>
From:   Thomas Garnier <thgarnie@google.com>
Date:   Fri, 1 Feb 2019 09:35:00 -0800
Message-ID: <CAJcbSZEkc2Rc7uemA0Qw2uJhvNciLRxPrMVSQV_-O_N8zozZ_Q@mail.gmail.com>
Subject: Re: [PATCH v6 15/27] compiler: Option to default to hidden symbols
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Thomas Garnier <thgarnie@chromium.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        kristen@linux.intel.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jason Baron <jbaron@akamai.com>,
        Jordan Borgner <mail@jordan-borgner.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jan Beulich <JBeulich@suse.com>,
        Song Liu <songliubraving@fb.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Sparse Mailing-list <linux-sparse@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 1, 2019 at 12:24 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 31/01/19 9:24 PM, Thomas Garnier wrote:
> > Provide an option to default visibility to hidden except for key
> > symbols. This option is disabled by default and will be used by x86_64
> > PIE support to remove errors between compilation units.
> >
> > The default visibility is also enabled for external symbols that are
> > compared as they maybe equals (start/end of sections). In this case,
> > older versions of GCC will remove the comparison if the symbols are
> > hidden. This issue exists at least on gcc 4.9 and before.
>
> What does this mean, if anything, for what/how symbols appear in /proc/kallsyms?

No, they will still appear in kallsyms. Some symbols are not absolute
anymore or moved sections but still present.

-- 
Thomas
