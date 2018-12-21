Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E51AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48FE621927
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZYb4o5aJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404502AbeLUSvu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 13:51:50 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46393 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730799AbeLUSvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 13:51:49 -0500
Received: by mail-lj1-f194.google.com with SMTP id v15-v6so5597360ljh.13
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 10:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0zApp6IS+WoZWhc5M0SkUqLBNZjji60b0VHaYT0YWxs=;
        b=ZYb4o5aJncBjQAfYc+C05uVka9XxdOGnQnhvKj/OqagU7c2LE9ScYcylYovOPQiX6y
         rEXD5IjuJLRQanfcTS1h5+EOyGlj6yZIvgzq+bsBwauuYvi2H3DRqCw4F7KAbEXCCRZc
         Xgjo+vtWY7ItLDGNn9WfF6RpqHvrZZs4gskv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0zApp6IS+WoZWhc5M0SkUqLBNZjji60b0VHaYT0YWxs=;
        b=TdfZVwQtWMbGRZik6+qCmg0LR+af2mKJZizo+HDSF+XT71YNGBoYDRLR5PiTbmNTdj
         4leXmVE1LejbjR66vPs0RDgWGCnz/7pn6Tk9+jjaTgGoiRBmzB1jjyue/T2KQnhF54gQ
         t8SgVZJFvvVwvVDlkJ4cZOG6qm/FKDOdBSy9bn5NEHSUpL2oNGNbxLX3LMDNJuCO+cdR
         VTPkdvM6g9oW1rLg49ezbTiGf+btpSia/Hfr0Rh7NxlqtF9OTZKPDjwD5N8ia2KvWRFK
         Kfte3GXKXZcws2vWapgpFZjMjYVrnstnWkuLnk52j7PIN8HoQIZQpXjmUTibMVZX8cOa
         AKFQ==
X-Gm-Message-State: AJcUukfZ0lfsjBOhwv+W7e0QPBil7jMYJUMahqOdqw/Jr+n0/KeF6wmx
        d7mm7sr1z3u7WUQ6pi8K0qkAZHO4UWk=
X-Google-Smtp-Source: AFSGD/Xi2AmnzylqFZcr2LJo5kZfgw3+zgc7lAtp7zMemXTykKVpFzUV3HA8nshzwCSd/rrFXEKYrA==
X-Received: by 2002:a2e:908b:: with SMTP id l11-v6mr2356488ljg.150.1545418306387;
        Fri, 21 Dec 2018 10:51:46 -0800 (PST)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id d190sm5726055lfe.9.2018.12.21.10.51.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 10:51:45 -0800 (PST)
Received: by mail-lj1-f182.google.com with SMTP id t18-v6so5609709ljd.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 10:51:45 -0800 (PST)
X-Received: by 2002:a2e:310a:: with SMTP id x10-v6mr2534379ljx.6.1545418304974;
 Fri, 21 Dec 2018 10:51:44 -0800 (PST)
MIME-Version: 1.0
References: <20181221175618.968519903@goodmis.org> <20181221175659.208858193@goodmis.org>
In-Reply-To: <20181221175659.208858193@goodmis.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 21 Dec 2018 10:51:29 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg_sR-UEC1ggmkZpypOUYanL5CMX4R7ceuaV4QMf5jBtg@mail.gmail.com>
Message-ID: <CAHk-=wg_sR-UEC1ggmkZpypOUYanL5CMX4R7ceuaV4QMf5jBtg@mail.gmail.com>
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

On Fri, Dec 21, 2018 at 9:57 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> I figured the best thing to do is to create a helper macro and place it
> into include/linux/string.h. And go around and fix all the open coded
> versions of it later.
>
> I plan on only applying this patch and updating the tracing hooks for
> this merge window. And perhaps use it to fix some of the bugs that were
> found.

I like the helper function concept, but as they say about CS: "There
is only one hard problem in computer science: naming and off-by-one
errors".

And this one has that problem. The name makes absolutely no sense.

Calling it "strncmp_prefix()" when there is no "n" there makes no sense.

So drop the "n" from the name.

And honestly, maybe it would be better to use a different naming
pattern entirely, and avoid the crazy non-boolean "str*cmp()" model.
That thing is useful for search comparisons (where "before/after"
matters), but it's horrible for the actual "is this true or not",
where the code ends up being

        if (!strcmp_prefix(a, "prefix")) {
                // This is the "Yes, prefix matched" case, despite the
"if !" syntax

which is just confusing.

So I'd really prefer more of a

        #define has_prefix(str, prefix) ...

model that actually returns a boolean (true if it has a prefix, false
if it doesn't), rather than use the "str*cmp" naming and return
values.

(But I agree that *if* you use the "strcmp" naming, then you do need
to hold to the traditional strcmp return value semantics).

Hmm?

Finally, I also suspect that your helper might be slightly fragile.
Doing sizeof() seems broken. I could see somebody using some prefix
define for arrays with constant sizes, and doing

   #define PFX1 "cpp\0"
   #define PFX2 "c\0\0\0"
   #define PFX3 "h\0\0\0"

or similar. Also, is there a reason you use "&prefix" for the constant
test? I don't see that pattern anywhere else. Plus it looks entirely
wrong without the parenthesis (ie "&(prefix)" to make sure we group
things right).

So a lot of small problems, but the naming one is big.

                  Linus
