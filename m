Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52BEAC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24C4C208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ON8SiR4N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730326AbfAJRbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 12:31:52 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36711 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729799AbfAJRbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 12:31:51 -0500
Received: by mail-lj1-f195.google.com with SMTP id g11-v6so10458179ljk.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 09:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nH5aONxUScUHVmaCDAij2sf2edxD9ysnfGrexA2u1PM=;
        b=ON8SiR4NMMp+UeHHVT31z0qsBGUFss7huwy/1N+NYGJwWNQ7eNJBxrDPMe7WNWOqD/
         QAFfDMnXzEf8CW0/rWlmTzaUD82u4BAlHIE8KRGEkkHoIkIRH26am8FbOPNq2IUmS2oT
         Q4zH7D2kNvrVnxEF3rKj1LrCoJcOKxAkax5rI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nH5aONxUScUHVmaCDAij2sf2edxD9ysnfGrexA2u1PM=;
        b=g0awKF0PYIaf9qzSwCRso/z6pL64/wFjKTgxww2J2/74Wx7xsXzCBmpYfPFsuplsNu
         SItAN2Z9f5XyIdZonljFXsMpyWm+VNfpd0HMnDTOFOUqxas6nS1tahzRhMlHOqM7etPa
         v8O4Hj8iVnOYVKakVakV7xwEE/IGj+rfF1tgEBY6s6llXWSt6+fX+6trIysuBXw1eLlT
         vsUoRD2hXgLyFDn8Rg992fMc/bZ/qPoDC4YxE+dJdRNoCVpvc3MPIOmvidKZedkz2jPf
         M/NkMIj9rXSmvgqpqH6BOQWFij85FYhRUS6dr7YIFRVU/q21Bv3LFtfSbDLeZ041X3B+
         mS8A==
X-Gm-Message-State: AJcUukdCmW8A+oTJsyRJRFxZ4hG3N8PwVSM1Nr6hncj449yr8sEPQcVs
        0GZ/ttSNmzo9mX/GVbciMKuOpVzKBUzJvg==
X-Google-Smtp-Source: ALg8bN6aqOAH6WAAM0H6tdfM3Hy8IJVoLJgEH3FqDelgHLkvEOwshDlpGuLneVbe04WbiVOX2N6RYQ==
X-Received: by 2002:a2e:9017:: with SMTP id h23-v6mr5638774ljg.71.1547141509230;
        Thu, 10 Jan 2019 09:31:49 -0800 (PST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id c22sm14257514lfd.88.2019.01.10.09.31.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 09:31:46 -0800 (PST)
Received: by mail-lj1-f176.google.com with SMTP id k19-v6so10416802lji.11
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 09:31:46 -0800 (PST)
X-Received: by 2002:a2e:9c7:: with SMTP id 190-v6mr5757495ljj.120.1547141505693;
 Thu, 10 Jan 2019 09:31:45 -0800 (PST)
MIME-Version: 1.0
References: <cover.1547073843.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1547073843.git.jpoimboe@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 10 Jan 2019 09:31:29 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiP4Z5r6tdkuD2DYocxG0zx=Kh+Z2k_LQ4QFvehe1+9uw@mail.gmail.com>
Message-ID: <CAHk-=wiP4Z5r6tdkuD2DYocxG0zx=Kh+Z2k_LQ4QFvehe1+9uw@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Static calls
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Nadav Amit <namit@vmware.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 9, 2019 at 2:59 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> NOTE: At least experimentally, the call destination writes seem to be
> atomic with respect to instruction fetching.  On Nehalem I can easily
> trigger crashes when writing a call destination across cachelines while
> reading the instruction on other CPU; but I get no such crashes when
> respecting cacheline boundaries.

I still doubt ifetch is atomic on a cacheline boundary for the simple
reason that the bus between the IU and the L1 I$ is narrower in older
CPU's.

Also, the fill of the L1 I$ from the (cache coherent L2) may not be a
cacheline at a time either.

That said, the fetch may be sufficiently ordered that it works in
practice. It _would_ be absolutely lovely to be able to do things like
this.

I do agree with Nadav that if there's some way to avoid this, it would
be good. I'm not in general a huge fan of compiler plugins (compiler
instability is just about my worst fear, and I feel plugins tend to
open up that area a lot), but it does feel like this might be
something where compiler tweaking would possibly be the cleanest
approach.

             Linus
