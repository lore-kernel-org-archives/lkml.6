Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5984DC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B4E12070B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EDV5jOZX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729429AbfAHSRA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 13:17:00 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41136 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbfAHSQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 13:16:59 -0500
Received: by mail-lj1-f196.google.com with SMTP id k15-v6so4211365ljc.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 10:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AF45K0R5HnMz1K8AiYWGG5zEHo927DsrwNAY1IrlLWI=;
        b=EDV5jOZXM+Ujj85ZlQyHQYoFlOfeSfByfc+7VzM8xhzvT/33+o8M/Ax9uwlDPnHR6N
         1FiZ9RThr+Dd3kbNuCLKsd5sGl9mnAQPC7n0O8dftHo1vfC5wpKWl3ly89+uYMaSubxL
         3aL/o8JwzuNPfYwJTt/v8jI/63Q/B4NCptFoU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AF45K0R5HnMz1K8AiYWGG5zEHo927DsrwNAY1IrlLWI=;
        b=RcmrlibDk937e0LiGvnnSkAIEpZgw/6IVHC7i9N3dquDqvVJoShOVCAOWkvkdBP1o7
         hy6QP5Py0JqDNs7MVhh0nQd4BgUnuZ8fQQeBzBf/bf1KO7AsNBw38L+iVrc1axBHs7C+
         vOngVzWki7OQfnWQXzY+pr7MjWi6DGM+DElShQCJJyPFKFuatFz2D+G+Q+SQGKVG+IHQ
         kYLTV2Jcybdm+qodxrVQtJYy3OazpvaqYoCMkjEE2HYVoe3QJkq0mWBsH9a5rIQ/fUcb
         R/V1nRY9fECSQ/v5AMMWronr7ze6EdClNHDRHrGteo91d3oUroML1a7A1I9WWkTeaAex
         XkLQ==
X-Gm-Message-State: AJcUukctX/wCO9AUF0/NmkKjhtGu3Lk2chSxf87YYWHW6TM79iZLlJ6P
        EdMvgf5U33EMHNjmj0hGudT1EYcHLo4=
X-Google-Smtp-Source: ALg8bN6IYBjVrQH33ChDf3Ae86QbgnC6LH71ghM7LQza6ZFH+SCFKiY3DSX5xv12TDUF7N1PM4r8WQ==
X-Received: by 2002:a2e:917:: with SMTP id 23-v6mr1593709ljj.1.1546971416885;
        Tue, 08 Jan 2019 10:16:56 -0800 (PST)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id 65sm13441353lfp.55.2019.01.08.10.16.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 10:16:55 -0800 (PST)
Received: by mail-lj1-f173.google.com with SMTP id u89-v6so4247234lje.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 10:16:55 -0800 (PST)
X-Received: by 2002:a2e:9983:: with SMTP id w3-v6mr1800313lji.133.1546971415249;
 Tue, 08 Jan 2019 10:16:55 -0800 (PST)
MIME-Version: 1.0
References: <20190108131516.27903-1-shorne@gmail.com> <CAHk-=whR9UX8wG0CKp87sNQkNdtMPVmAmi-gjGRwWTYYAJ9v_w@mail.gmail.com>
In-Reply-To: <CAHk-=whR9UX8wG0CKp87sNQkNdtMPVmAmi-gjGRwWTYYAJ9v_w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 8 Jan 2019 10:16:39 -0800
X-Gmail-Original-Message-ID: <CAHk-=wic8HES0M_KgB3Tfaufb36r42ZKw4a0t96Xq_efCoR02Q@mail.gmail.com>
Message-ID: <CAHk-=wic8HES0M_KgB3Tfaufb36r42ZKw4a0t96Xq_efCoR02Q@mail.gmail.com>
Subject: Re: [PATCH] arch/openrisc: Fix issues with access_ok()
To:     Stafford Horne <shorne@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        openrisc@lists.librecores.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 8, 2019 at 10:10 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, Jan 8, 2019 at 5:15 AM Stafford Horne <shorne@gmail.com> wrote:
> >
> > The commit 594cc251fdd0 ("make 'user_access_begin()' do 'access_ok()'")
> > exposed incorrect implementations of access_ok() macro in several
> > architectures.  This change fixes 2 issues found in OpenRISC.
>
> Looks good to me. Should I apply this directly, or expect a pull
> request with it later?

Oh, and replying to myself with a quick note: it might also be a good
idea to just make it an inline function.

The only reason I did alpha and SH as those macros with a statement
expression was that because I don't have a cross-build environment,
continuing to do it as a macro was the safest thing from a build
standpoint.

One big difference between a macro and an inline function is that the
inline function requires everything to be declared at the point of the
function definition, while the macro can use things that get declared
only later (like "get_fs()"). So a macro can use functions and other
macros that aren't declared yet, but will be declared by the time the
macro is actually _used_.

So when changing the macro "blind", it was simply safer to just keep
it a macro and just make it a bit more complex. But since you can
build-test your changes, making (for example) __range_ok() be an
inline function might have been the cleaner solution to the "use
twice" issue.

But your existing patch looks fine to me too, so don't worry too much
about it. I just wanted to point out that the reason I did alpha and
SH the way I did was not some "macros are better", but rather "Linus
is weak and lazy".

               Linus
