Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B181EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 22:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 795BC21928
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 22:08:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NVAFjWfA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392128AbeLUWIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 17:08:32 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33063 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732390AbeLUWIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 17:08:32 -0500
Received: by mail-lj1-f194.google.com with SMTP id v1-v6so6031205ljd.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 14:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=umSUn5Ci9dA3t2XruE1eAp2L46+qSHbncfbdX3L7+rI=;
        b=NVAFjWfAqGqJLkCbCLkU6eZzsVvyLLlrwBhT6kUhFW2MOQ+OaiWc6WatxrkUdGlm3Q
         /6dn6UruSIADY+CkTUS2vI/uFvJtot8NCO1mGdZOm776aUN9jF0Qi9QxYtc9bM5iYQEK
         O9O7X6KmbnB1VjNFNS1fPfVvi9Ghozu2rPdXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=umSUn5Ci9dA3t2XruE1eAp2L46+qSHbncfbdX3L7+rI=;
        b=ALfrGIStZWKOh9k0VzLoV2zeaA+5QT524UuddMZkvJkI0sn/de+fx8pxCdjwNIq75w
         wXlqUdgx4Z4Yw82/5ZWb2WSM5X2nydsZEFolCsVdzHCgDRktNWzRZxMsXe8pV/XcyJFf
         2E92Ej9bFdXQ6JJQSBeXEo+m75YCyXO6CsIT7CHzIGgwtrLy/yRnEtTJFosQMfsD/2Fp
         8oxcUwA1Mzfb08kPrbe71ByZyukk/ytyIKQVSk8e5qKA/EpbX5OElXqCtlbNMCuMRaOd
         9gsG6nenuQu4Ev/TpsGPd7C5ydKWNZkDNeYnNckHVp3q8hMorvCc37XGFEz60r9owaIY
         /mFQ==
X-Gm-Message-State: AJcUukcy3TyqLcAyqmXpkjGaDuMet94no2gMZK2qSnUMGPMZlghI+JMg
        QPdrPLaMeJCwr3H6cB+JJMfNb1BkPMo=
X-Google-Smtp-Source: AFSGD/VOKhATJiZLRTL105ihUXpT1jifINVEeXJ13ZdDXNhhnvWLYDxhP6s0iKMs9UQASAj2m43qPA==
X-Received: by 2002:a2e:2c02:: with SMTP id s2-v6mr2708191ljs.118.1545430109749;
        Fri, 21 Dec 2018 14:08:29 -0800 (PST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id k11-v6sm4968221ljk.40.2018.12.21.14.08.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 14:08:28 -0800 (PST)
Received: by mail-lj1-f178.google.com with SMTP id v15-v6so5995389ljh.13
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 14:08:28 -0800 (PST)
X-Received: by 2002:a2e:95c6:: with SMTP id y6-v6mr2571097ljh.59.1545430108025;
 Fri, 21 Dec 2018 14:08:28 -0800 (PST)
MIME-Version: 1.0
References: <20181221175618.968519903@goodmis.org> <20181221175659.208858193@goodmis.org>
 <CAHk-=wg_sR-UEC1ggmkZpypOUYanL5CMX4R7ceuaV4QMf5jBtg@mail.gmail.com>
 <20181221144054.20bdeb33@gandalf.local.home> <CAHk-=wgSvRhj6KNRdn9gbK9RJVAswdtKSNjAxdf9O9vn04T5XQ@mail.gmail.com>
 <20181221153526.5e6055ca@gandalf.local.home> <CAHk-=wjtkvFUuRNZU67KccuUKYHw=pYoDMQJ_9OVDFxOwmK9zQ@mail.gmail.com>
 <20181221155513.11450ca6@gandalf.local.home>
In-Reply-To: <20181221155513.11450ca6@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 21 Dec 2018 14:08:11 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjaNWzXSW9XT-Z=9OF=5+2ft6UqjoUgaWeEWx8PUmS9xg@mail.gmail.com>
Message-ID: <CAHk-=wjaNWzXSW9XT-Z=9OF=5+2ft6UqjoUgaWeEWx8PUmS9xg@mail.gmail.com>
Subject: Re: [for-next][PATCH 23/24] string.h: Add strncmp_prefix() helper macro
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Joe Perches <joe@perches.com>,
        Tom Zanussi <zanussi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 12:55 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Fri, 21 Dec 2018 12:41:17 -0800
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
> > Parentheses....
>
> ?

Your patch actually had them, but in the body of your email you did

> #define have_prefix(str, prefix) ({ \
>       const char *__pfx = (const char *)prefix; \

which is just completely wrong.

Considering your _old_ patch had the exact same bug, I really think
you need to start internalizing the whole "macro arguments *have* to
be properly protected" thing.

And I agree with Joe that using a million underscores just makes code
less legible. Two underscores at the beginning is the standard
namespace protection. Underscores at the end do nothing. And using
*more* than two is just crazy.

Finally, I think the cast is actually bogus and wrong. Why would the
prefix ever be anything but "const char *"? Adding the cast only makes
it more possible that somebody uses a truly wrong type ("unsigned long
*" ?), and then the cast just silently hides it.

If somebody uses "unsigned char *" for this, they'd get the exact same
warning if they were using strncmp and do this by hand.

So why would that helper function act any differently? Particularly
when it then has the huge downside that it will also accept absolute
garbage?

Anyway, that was a long and winding NAK for your patch.

             Linus
