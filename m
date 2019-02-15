Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7517EC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FB9321927
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lgO1KbLP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391781AbfBOQIa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 11:08:30 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:36489 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbfBOQIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 11:08:24 -0500
Received: by mail-vs1-f67.google.com with SMTP id t13so6101182vsk.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 08:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PIdKqV+N02CJemMPVO3OVtJ0C1MmfjoH86OjkvXP2/k=;
        b=lgO1KbLPqVSCFybo+stJ/qCwWhEev4xJafYDagvVQsYRUyraSgzjy9f025vP181vdO
         0C4BXQdZnuiHnuIjuYWB86hCCKNZI7VOIyljEVgWQNOeG2bWh3hQ9QF/A5Ac3HTDAkPl
         Ky4PM05r3MiTzPgLrT4qhs6tRBJUIwljlZSIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PIdKqV+N02CJemMPVO3OVtJ0C1MmfjoH86OjkvXP2/k=;
        b=g3pwIBfkYKD1fRkXCbQXQJ+sZ5zaJf/jIUSu00wcSq3U1ZMo1nY1pMf4f3+sYsFlvf
         BCOL9l/2cwS1ubwNazI2Y91Ghy3GNud4Y7LzMJPTyCW33IJ0mBhxG7nHJvc1r5aXVZ/F
         UyvFbQT/Sk3rZBfjCThUarBG0ieKMXG7tc20PoJzOEPyEZfCfOu21Mx52aoeOq9yo98E
         B/ARH1Js+1tn8peFO/pbKd3nY6pyXx2Xl+4PYLWEhR7FONQr44I1t48gA/knktpz3gAM
         kTdulH9SDheE/ZZU7+BH1nHUROWCjWXfnh+NocEsUzrMYUfQ7jKNoGQozBSiqHVQMQ2m
         mkEA==
X-Gm-Message-State: AHQUAuYj0brULQNwXbZ7lGOawZuF7QKR/sEb3Ifwmd41BwbiVi636jh8
        yfJxD6eGdXTwILBjSHwFBWtSqyThOzw=
X-Google-Smtp-Source: AHgI3IaO9RZX20WA21cfvBbZZFLrzEUmPw/ir0OW9xQgt1P+vXJ7vCyqyaD2N1Bc7C7hRZATwJD13w==
X-Received: by 2002:a67:ecc4:: with SMTP id i4mr5262415vsp.218.1550246902890;
        Fri, 15 Feb 2019 08:08:22 -0800 (PST)
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com. [209.85.221.170])
        by smtp.gmail.com with ESMTPSA id 32sm3945761ual.12.2019.02.15.08.08.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 08:08:21 -0800 (PST)
Received: by mail-vk1-f170.google.com with SMTP id f206so2348529vke.6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 08:08:21 -0800 (PST)
X-Received: by 2002:ac5:c387:: with SMTP id s7mr5113979vkk.92.1550246901006;
 Fri, 15 Feb 2019 08:08:21 -0800 (PST)
MIME-Version: 1.0
References: <20190215031758.GA18776@beast> <CAHk-=wg7DRUqWvbCS2dm=mpdSNJry92Fo0OHDVi67bi8BMqt4A@mail.gmail.com>
 <CAGXu5jLi+zcOoi+Ti=OyR3MfF8s_S35EEmT_DoCzYPepOcn+Ow@mail.gmail.com> <CAHk-=whBnu7TQTOoOiqSmDGpH0oxrFo9sDzJTZRFhFCv69BMrg@mail.gmail.com>
In-Reply-To: <CAHk-=whBnu7TQTOoOiqSmDGpH0oxrFo9sDzJTZRFhFCv69BMrg@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 15 Feb 2019 08:08:08 -0800
X-Gmail-Original-Message-ID: <CAGXu5j+HDB1rQFUj51UXD_PXHK+aoeZzu06BtSr=WfZY5RXVGA@mail.gmail.com>
Message-ID: <CAGXu5j+HDB1rQFUj51UXD_PXHK+aoeZzu06BtSr=WfZY5RXVGA@mail.gmail.com>
Subject: Re: [PATCH v3] exec: load_script: Do not exec truncated interpreter path
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Samuel Dionne-Riel <samuel@dionne-riel.com>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        Graham Christensen <graham@grahamc.com>,
        Michal Hocko <mhocko@suse.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 7:55 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, Feb 14, 2019 at 10:15 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > The only way we know the interpreter wasn't truncated in the
> > no-newline case is if we see whitespace after first skipping any
> > leading whitespace, and it seemed really ugly to add a special scan
> > there.
>
> No, much easier (and likely better code too), to just use 'memchr()'.
>
> What's wrong with this simple and fairly self-describing patch?
>
> And I'll rather add a few lines due to helper functions with names to
> make it more legible, rather than code in that already fairly long
> existing function.

This fails to notice truncation when there is leading whitespace.

And I'm happy to add helper functions. We just have to pick which mess
we want to have. :)

-- 
Kees Cook
