Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85CBFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 18:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 509A220836
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 18:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JAKviBbK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406481AbfBNSKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 13:10:40 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:45140 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732633AbfBNSKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 13:10:40 -0500
Received: by mail-ua1-f68.google.com with SMTP id e16so2318169uam.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 10:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BONKBdzaZ4k0ujEhXsRKef+NzCUqIyiSBvdJaagY29w=;
        b=JAKviBbKS6sPBkmCrBQPODekxAs2kMliYChggXVVEHqkCmxUAQ7TdS9a3XHhKJueaS
         Zhx0Uo6yz16Qcdx2yoNqSiBOsMuJhZ7lNTrEZcVO2MuiuZnmBUUubxhrLfhql2wzeHok
         j/KmoWUdRHN/AHMJFc/DLwOhX4KU1OEIGEiSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BONKBdzaZ4k0ujEhXsRKef+NzCUqIyiSBvdJaagY29w=;
        b=G5cikhyxuMwEj7gtsumdnDFyHy67u/2bdwC4/duv8ONpOyoO1NKZ536qlZX9FLFP8A
         o4zX6/0eC26/bErY6kIfYS/pYFM4AnjcnxzFUhV4BJrZG08Qydqgh81UfdZEHiEJXAcs
         Kk+ndsc1ugqf+a5ykQMUbZFYII8ZMGYtddC+XC/p0nXAKpzGifnk6oIJ32L3rzXdFteI
         8QVLQTsl+3qG3lIamS7fAl/a7sHgUTLItIvY03sLFIKaLkWGtFdY7oRjYfl/HOujuNK9
         qcLvh0GfCCYwD5EvsWtv/xjeWZhx85oEcucsS15iQgMn52snJYYsf3QP6n5sLRH8Hr61
         y+Ag==
X-Gm-Message-State: AHQUAuYDJCkTw61c7XMm+xBy2cgf9IxaIXszc3dPl6C7BJe6tnpIFMZT
        n6UEsRLVLebGlqRlZgf/rzrSiH/Cbxg=
X-Google-Smtp-Source: AHgI3IYd295rRD7H9r5sOAEqe4sgfbHSZVIoEG7DW6EA6Jay8Ches5QSlorSri4RLgMP+LK5ynCd9A==
X-Received: by 2002:ab0:21ce:: with SMTP id u14mr2411935uan.50.1550167839352;
        Thu, 14 Feb 2019 10:10:39 -0800 (PST)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id l197sm2882508vke.18.2019.02.14.10.10.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 10:10:38 -0800 (PST)
Received: by mail-ua1-f46.google.com with SMTP id z24so2320365ual.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 10:10:37 -0800 (PST)
X-Received: by 2002:ab0:74cb:: with SMTP id f11mr2467901uaq.14.1550167837417;
 Thu, 14 Feb 2019 10:10:37 -0800 (PST)
MIME-Version: 1.0
References: <20190214164331.GA33450@beast> <CAHk-=wg+Bc1Qmp0VBqPQq=_4=SgbN6jRvPtrme8-ieobpM16iw@mail.gmail.com>
In-Reply-To: <CAHk-=wg+Bc1Qmp0VBqPQq=_4=SgbN6jRvPtrme8-ieobpM16iw@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 14 Feb 2019 10:10:25 -0800
X-Gmail-Original-Message-ID: <CAGXu5jLYJyz+afGrMp_KbvL2xiwg3h6Cz_q6fQjXL9gpbej7QA@mail.gmail.com>
Message-ID: <CAGXu5jLYJyz+afGrMp_KbvL2xiwg3h6Cz_q6fQjXL9gpbej7QA@mail.gmail.com>
Subject: Re: [PATCH v2] exec: load_script: Allow interpreter argument truncation
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Samuel Dionne-Riel <samuel@dionne-riel.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        Graham Christensen <graham@grahamc.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 9:59 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, Feb 14, 2019 at 8:43 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > This documents the parsing steps, and will fail to exec if the string was
> > truncated with neither an end-of-line nor any trailing whitespace.
>
> Is there any reason why we don't just revert 8099b047ecc4 ("exec:
> load_script: don't blindly truncate shebang string").
>
> That revert patch would seem to be much simpler than this rather
> complicated thing.

We certainly can, but we'll still need to fix the "don't exec a
truncated interpreter path" problem (which this fixes).

I'm happy to do it as two steps instead: revert, then a separate fix
to land in the merge window?

-- 
Kees Cook
