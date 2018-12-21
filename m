Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B57FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 22:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 522A921927
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 22:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IqHU1uzx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392151AbeLUW3v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 17:29:51 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34027 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388822AbeLUW3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 17:29:50 -0500
Received: by mail-lj1-f193.google.com with SMTP id u89-v6so6060515lje.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 14:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d6F/ntyeS0LimzOMvDEhUtehPjr1FxHPx5RemdaDyDo=;
        b=IqHU1uzx+SCFh2O2GRUNpfW15C/DK82UXXVEnR/NXmKcX5UqBy4LAchcJB/k6UsSw8
         XnBB+ks/IZhoteINfxbXzFCG1cnYUhiE0wHKoIPB7nP2yo3aTMlA/bwrS3tbqRc/A45z
         1UEOgAFRJqxd4PUWOWcdY2mk0RYTU5Tu9RhyQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d6F/ntyeS0LimzOMvDEhUtehPjr1FxHPx5RemdaDyDo=;
        b=Vvw6nKoNA4Uy9+OvhvwD7xbo0a6H0Of4B9jx6qu7RxjgQppCA+4PODjgC9t1tiJon5
         aY9DacwZyDIZRjemVJb+U5+liX93A9jHn+PtfAbIRkAihpOZu39B1mWZcDykMrha0n6B
         Jtj6urcpyKyXiuUF+0/u37/eBNDFuTUDacHeQd9Owj0mtjLsGpBuH6HcJ6OrzwTMOOFY
         aoQk1p8INxVcExMbSevrTNEqblu7rwfUP45WM35y18yKD83OD1Cb55uV0AwOMaIf0X9T
         PWvZ9dRHVJaR01ja0L6Jm7iAuuTqah3lWIC+/B4jU5g0eBmRDY20FI1DekhksfEtP8UA
         AeTA==
X-Gm-Message-State: AJcUukdZ7keTVwcAssO+Z8RKGbjoru4TLwrJ2Iqd8Xr+f+5ey6r7R0jP
        ueR8srt240kYgxnodNGoS9+NkAjiqnY=
X-Google-Smtp-Source: ALg8bN71Au51UC45xuX+qtPKD/vz9qbXOkmZJfhq/tokONmOeQcgA07gYALr/Q38f2s6ce/FlPxPTQ==
X-Received: by 2002:a2e:6c04:: with SMTP id h4-v6mr2592965ljc.92.1545431388012;
        Fri, 21 Dec 2018 14:29:48 -0800 (PST)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id y11-v6sm4860924ljc.85.2018.12.21.14.29.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 14:29:47 -0800 (PST)
Received: by mail-lj1-f173.google.com with SMTP id g11-v6so6050119ljk.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 14:29:46 -0800 (PST)
X-Received: by 2002:a2e:95c6:: with SMTP id y6-v6mr2599069ljh.59.1545431386374;
 Fri, 21 Dec 2018 14:29:46 -0800 (PST)
MIME-Version: 1.0
References: <20181221175618.968519903@goodmis.org> <20181221175659.208858193@goodmis.org>
 <CAHk-=wg_sR-UEC1ggmkZpypOUYanL5CMX4R7ceuaV4QMf5jBtg@mail.gmail.com>
 <20181221144054.20bdeb33@gandalf.local.home> <CAHk-=wgSvRhj6KNRdn9gbK9RJVAswdtKSNjAxdf9O9vn04T5XQ@mail.gmail.com>
 <20181221153526.5e6055ca@gandalf.local.home> <077eeb8b09baebe78822819b5f15d671b738a2b2.camel@perches.com>
 <20181221155435.38a9a221@gandalf.local.home> <871s6ad2br.fsf@igel.home>
 <20181221160826.34c544e6@gandalf.local.home> <84199633fd49db573c9ba71f1992936422e907d4.camel@perches.com>
In-Reply-To: <84199633fd49db573c9ba71f1992936422e907d4.camel@perches.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 21 Dec 2018 14:29:30 -0800
X-Gmail-Original-Message-ID: <CAHk-=whLFsxr751LsJoxe-E=4LVvh=hB-3MmQTLVRA5mMLHzJA@mail.gmail.com>
Message-ID: <CAHk-=whLFsxr751LsJoxe-E=4LVvh=hB-3MmQTLVRA5mMLHzJA@mail.gmail.com>
Subject: Re: [for-next][PATCH 23/24] string.h: Add strncmp_prefix() helper macro
To:     Joe Perches <joe@perches.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 2:20 PM Joe Perches <joe@perches.com> wrote:
>
> Using
>
> static inline bool str_has_prefix(const char *str, const char prefix[])
> {
>         return !strncmp(str, prefix, strlen(prefix));
> }
>
> eliminates the strlen with gcc 4.8 (oldest I still have)

Ok, that looks like the right thing to do.

Side note: in the kernel we disable the whole "unsigned vs signed"
pointer warning entirely, exactly because of the "char *" vs "unsigned
char *" problem.

                 Linus
