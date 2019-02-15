Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A59A2C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72A9221924
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:01:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jw8OEcX8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388701AbfBORBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 12:01:42 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:37524 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbfBORBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 12:01:41 -0500
Received: by mail-ua1-f68.google.com with SMTP id v26so3446513uap.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 09:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sr3yxeh7Dr24+qO0FXdr1WWMdIYIhlwBgr588YCelb0=;
        b=jw8OEcX8x8QxSpnZkb9EDrBoycN4nu18WUPN8a17RTguDO5QDe30ev8xW5d1RgVN/u
         4gyBy8f/ZemHgetQGLo5Nz9Srlw5ll9+RdIAvZSnH6faKAnAED699vJIGfPqzgxJaFPm
         hI0dcBFCoLXFrj9RX0njPb2UnPF1b+5DWpXAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sr3yxeh7Dr24+qO0FXdr1WWMdIYIhlwBgr588YCelb0=;
        b=JU4hmwLYMhhgzMtWX0eX7odMeGNPeXBEXqznSt3oy6CC2X09XIwgoufLzVPmxdAcZw
         6o8ztMVjnWTirxhTQFCx89QxfvpI/7s3aS6F/kox8jvKr8+8+YGo4dftI7s+atxhiiA9
         IcHrFtDDIaOZrnPYk98B4N4wf/XPfQU/JdyoeAM0Kl+I3i03qpau92OZu7F68LiVG5x9
         ra7tde9qdhjfUtRa4KJ4oPIac+57nealqHMcHNAhoCxh23FuU8HcmBssBKUgGQC0CHqX
         BdjxBKl8IaWQbZPoLIV8IgSYmL6edFrIr83UfHZBoxGUCInAuh3Z9BeKhUQuplPTQcLk
         QORw==
X-Gm-Message-State: AHQUAubVWQ/8JQqF9km9U5gNUra2L+mh0VvStGADBm7AfqzDMzaRDcmW
        eHvw5AI//7w436JIrGvvcpbPtRL/MQc=
X-Google-Smtp-Source: AHgI3IaZlGRCqtTVr+oRE9yrGHitOOG0b4pHzGFm6x9OrsaCb1x/bbzNvIVNqkVN6HEoqrSz5oYk0g==
X-Received: by 2002:ab0:670b:: with SMTP id q11mr4851003uam.54.1550250099548;
        Fri, 15 Feb 2019 09:01:39 -0800 (PST)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id a3sm32831vkb.29.2019.02.15.09.01.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 09:01:38 -0800 (PST)
Received: by mail-vs1-f47.google.com with SMTP id n10so6177295vso.13
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 09:01:38 -0800 (PST)
X-Received: by 2002:a67:eb4a:: with SMTP id x10mr5457859vso.172.1550250097940;
 Fri, 15 Feb 2019 09:01:37 -0800 (PST)
MIME-Version: 1.0
References: <20190215031758.GA18776@beast> <CAHk-=wg7DRUqWvbCS2dm=mpdSNJry92Fo0OHDVi67bi8BMqt4A@mail.gmail.com>
 <CAGXu5jLi+zcOoi+Ti=OyR3MfF8s_S35EEmT_DoCzYPepOcn+Ow@mail.gmail.com>
 <CAGXu5jJXFP-1rEeYtMfqrSUz2oz8TWcjr89zL6-MPsNS7rwywg@mail.gmail.com>
 <20190215161851.GA8804@redhat.com> <CAHk-=wjk29MeO9PuyirONZMr75-H6LtfNe6WghOXT7n+f5-RTA@mail.gmail.com>
In-Reply-To: <CAHk-=wjk29MeO9PuyirONZMr75-H6LtfNe6WghOXT7n+f5-RTA@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 15 Feb 2019 09:01:26 -0800
X-Gmail-Original-Message-ID: <CAGXu5jKGyZhPMdMCrPY00-XXW0MhRoPuGFJbouFBfi7VoURdSQ@mail.gmail.com>
Message-ID: <CAGXu5jKGyZhPMdMCrPY00-XXW0MhRoPuGFJbouFBfi7VoURdSQ@mail.gmail.com>
Subject: Re: [PATCH v3] exec: load_script: Do not exec truncated interpreter path
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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

On Fri, Feb 15, 2019 at 8:39 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, Feb 15, 2019 at 8:18 AM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > Not sure. Consider a script file which has a single line
> >
> >         #!/path/to/interpreter
> >
> > WITHOUT '\n' at the end.
>
> Heh. I'm not sure how valid that is, but it's an interesting case for sure.
>
> But it's actually fairly easy to fix with the franken-approach I did
> that combines mine and Kees' patches.
>
> Does this work?

+static inline bool no_tab_or_space(const char *first, const char *last)
+{
+        // Skip leading space
+        for (;tabspc(*first) ; first++)
+            if (!*first || first == last)
+                return false; // only space

The !*first will never hit here (since it's been checked to be either
' ' or '\t', and if first == last it's whitespace all the way, so we
could just return true here to bail out early (there's no interpreter
at all, so we want to -ENOEXEC still).

I'll get a version written and tested...

-Kees

-- 
Kees Cook
