Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD63AC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 19:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83B5921019
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 19:50:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Y/rCiTnY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbeLaTuj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 14:50:39 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35816 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbeLaTuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 14:50:39 -0500
Received: by mail-lf1-f65.google.com with SMTP id e26so18772471lfc.2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Dec 2018 11:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BoA3cVIc+I6J2F5LhJJNZX2C914W6cM25IWSHPLOBCA=;
        b=Y/rCiTnYaZSaXTEGr6AMhdmR3XsKZvX0bZA6b3M2rDwQo2cszmwDFIWjyourUHw95L
         4uiRlhJNKCjb4eov8V2NYJe2/IQxVGKDKXiHNODPhudCSx17K4LdQ6aF3GAePd/e8Cwf
         47Ewd/vX9r44KqT4ETXkYY4lFJUj1T9TjW79c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BoA3cVIc+I6J2F5LhJJNZX2C914W6cM25IWSHPLOBCA=;
        b=fZ0fqaAr6qebr0NHJfFwcOXEE8uiDh6yRSEeWojPYxVMZOf6AApMnGIsfqzO4fYHxD
         XS35i07RehNqpYNephWoH49CfMofmQp7xhSWBM/CkWHdP4EbjbjV36F3QRJKTcvhDA7a
         CHXo/q12Yf7tts2mQr8RfyapXpTyyH0TjRbQRFJvrdNQfHMOF/BLoocViAw09eixW2DR
         zmg4VEbZrHcxEGH4NSMhf6O7+BgWOojpLYaOMPWPtsWNzpO5Nx8/CY814OPBmjjpaWhg
         xwRV3/1UEjP4VGMTWwm8k15PiOBgvt9EJZM95kJeNkiO8pr60AFBUh+VPybMgDdpmHmu
         V6lw==
X-Gm-Message-State: AA+aEWaN0nW5Isn04dj31Xjsp+NE0QE7fOE1ytwVoMu2XQP6jJiL8xvK
        PNQ8BY6rtCmo4mUtCHWy0m0cMWZ04Qk=
X-Google-Smtp-Source: AFSGD/Vme2ieTz9zZwY4L7ka1h284OZBKsJB3M5UK2+AAL/FpbfOAVQ91rap7k3HEC7NP8dkRqKrAw==
X-Received: by 2002:a19:789:: with SMTP id 131mr20269408lfh.11.1546285836346;
        Mon, 31 Dec 2018 11:50:36 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id p23sm9379881lfh.47.2018.12.31.11.50.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Dec 2018 11:50:35 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id v5so18734370lfe.7
        for <linux-kernel@vger.kernel.org>; Mon, 31 Dec 2018 11:50:34 -0800 (PST)
X-Received: by 2002:a19:6e0b:: with SMTP id j11mr20497362lfc.124.1546285834603;
 Mon, 31 Dec 2018 11:50:34 -0800 (PST)
MIME-Version: 1.0
References: <20181228182813.01ae131a@gandalf.local.home> <CAHk-=wh9rpBhJ9r_AH=RuvaD8u1V1VKpY8diqZtpqdToYRdCwA@mail.gmail.com>
 <20181231143300.51310ce3@gandalf.local.home>
In-Reply-To: <20181231143300.51310ce3@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 31 Dec 2018 11:50:18 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi49df9EuxeW1949H=KiqTUEVYnsV33j-8ffr9P-ouU+g@mail.gmail.com>
Message-ID: <CAHk-=wi49df9EuxeW1949H=KiqTUEVYnsV33j-8ffr9P-ouU+g@mail.gmail.com>
Subject: Re: [GIT PULL] tracing: Update for 4.21
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Joe Perches <joe@perches.com>,
        Andreas Schwab <schwab@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 31, 2018 at 11:33 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > Forgot to push out?
>
> Yeah, I did. I just pushed it out.

Thanks, I see it.

> > Btw, please don't include the whole diff in the same email when it's
> > ~seven thousand lines and over 200k in size. Yeah, I'm on a fast
> > connection, but that isn't *always* true. Did lkml even take this
> > email?
>
> OK, I'll modify my script not to make that diff.

For small "fixes" pulls, the diffs are nice, and you actually see the
details of the fixes. But for big things, the full diff is usually
only a distraction.

I think the x86 maintainers have a script where it adds the diff if
it's less than a hundred lines or something like that..

                     Linus
