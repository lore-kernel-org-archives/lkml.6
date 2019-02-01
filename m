Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4870C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 17:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9382A2086C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 17:01:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oYnCYR/I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730649AbfBARBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 12:01:03 -0500
Received: from mail-it1-f174.google.com ([209.85.166.174]:38752 "EHLO
        mail-it1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728770AbfBARBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 12:01:03 -0500
Received: by mail-it1-f174.google.com with SMTP id z20so10755693itc.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 09:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MYRYTmO2UKtncXFMnEATIgRImHRBJ+EzhMAFeOQJz9Y=;
        b=oYnCYR/ItAR0ZqLzgMaSZ1x9ZDRu5sii9v7bSfxsUtNxQ+2TPV545rwr+8xA9UMpdi
         FcX7gVY4V2u7zXHNyROv8AMsY79gbkaSEtx+D4lKC/l6bW5k64rv7o16rBIF4vgzIzK5
         b5oabX//1hGpY8CoaxHkUTeSN8ptQqYbXUeIQ9eYjjnIzCcLep3ulITSxx+hzvC6avQD
         +Au8BYEE49v92zhP4ASPKlLLpdbKdnp4EerLyPtRGV+lv07qw9eLkC16s07OedoM0TTz
         RtTSEv5e+pZiFFQbNz2Aw9s/NDG87EqWcXW7H04jp25vNWO59Hd9WN7dRC8QDONtwFA/
         zdSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MYRYTmO2UKtncXFMnEATIgRImHRBJ+EzhMAFeOQJz9Y=;
        b=n+WoJghlXuZQLYcmcmVVs0DeK+rILDqT3U6XY5SV/Im8Dgd5XfM3YTsd83iZiPWbH+
         7WreOPxrJoRbo12ta0OlRgVk0XXYNdkFSXhaGVDbHEiBj0chDGMl27JMMiWn4xe+GRin
         DQeqCKb4neXwiKF2fPWE3TfwLQ5Pcf1rSiamIBzR46zzqjo991YXEG8pzmlz4jWkJcfp
         YU3H88HEGiqnKs6w1/k0wVsr1pc809DJzTWQxZ6+8WLqHMIaQJ+OVAAtjlKHdqVCRitL
         0ADQaVzhA+WD9QzhqVIHFTCA/e6ozi4SvWVwu4z2paW664GTz9E1RHPwcdc2EfYOIOUU
         Cz6w==
X-Gm-Message-State: AJcUukesIe/kh3juh3YohBxIXHhyAeDLbR0NEyiv+K0YP6pAbS2XiuOM
        Agblut6KfzyKjumcaWnE0X/A5qYy08jzZ23ibrzqZQ==
X-Google-Smtp-Source: ALg8bN6Cd/Ye+HIYmoOdyagHpo4+M0JdZS0qhta2aPnvq+IwWvq4efm1OsWre07u+6vawYdlzbEMcB6EFQWJNuO/iVk=
X-Received: by 2002:a02:8ca8:: with SMTP id f37mr26504109jak.80.1549040461749;
 Fri, 01 Feb 2019 09:01:01 -0800 (PST)
MIME-Version: 1.0
References: <20190131192533.34130-1-thgarnie@chromium.org> <20190131192533.34130-16-thgarnie@chromium.org>
 <20190201071259.GB14343@kadam>
In-Reply-To: <20190201071259.GB14343@kadam>
From:   Thomas Garnier <thgarnie@google.com>
Date:   Fri, 1 Feb 2019 09:00:50 -0800
Message-ID: <CAJcbSZEhcKVBn0vOE0rkdwkf3vRmmZ=ttoJNfN4+20QTRTuSng@mail.gmail.com>
Subject: Re: [PATCH v6 15/27] compiler: Option to default to hidden symbols
To:     Dan Carpenter <dan.carpenter@oracle.com>
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
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Sparse Mailing-list <linux-sparse@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 11:13 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Thu, Jan 31, 2019 at 11:24:22AM -0800, Thomas Garnier wrote:
> > Provide an option to default visibility to hidden except for key
> > symbols.
>
> It took me a while to figure out the verb in this sentence...  :P

I agree, I should rewrite this description.

>
> It's weird that we're annotating things to be default.  What visibility
> are they we leave off the annotation?

The word "default" is confusing but that's how it is called by gcc.
Symbols not marked default are hidden.

>
> regards,
> dan carpenter
>


-- 
Thomas
