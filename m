Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C5CC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 06:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B15292081B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 06:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BEeV9MXR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfBEGhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 01:37:21 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44430 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbfBEGhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 01:37:21 -0500
Received: by mail-lj1-f194.google.com with SMTP id k19-v6so1894599lji.11
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 22:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tFMjeg/6i9VVdxeWN9F6+orywrkeXAgbNh3qyfZ5lBg=;
        b=BEeV9MXRd+ZqbZJr7v+KNXEOVfqjxbDsuRSfGrtiTNNe2jJF4orKEuNnO+X7WuLvev
         HnfUXT1Zp6rR2iYI3mwEM0SB06LmHMgS78QQwnqUYqjcSSJ9Xpp0ZHHF2KuQZuBj5iFn
         OklwTifZoviDirraz8Ix3IoZgPuyggFbfubaI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tFMjeg/6i9VVdxeWN9F6+orywrkeXAgbNh3qyfZ5lBg=;
        b=Xxs4gZvt1Z9Tll+ruszfcKWDu2WD1h8uGO+fMtWEAdFSozWhqjxQiEDYfMbPfLZlCP
         4/jYoVEJUWmNjmK8bhUwSrYRv6kb1Zfde+jKpbyVp4tPv1UJ/weio5RUDpOUWmwK7N6P
         yGNmIIWMdPDo2kXYhie3S+FR9BI3F3beYB0H6wJmY4APh+UO2eyLd+SQNYfRUO4utuN/
         /f/PE1lCp0DxBzwTkixvaSWBsi7108Fvcp6qaLBVEswJpIvPKDANO2bLCAG45+egY8vk
         UiLMrpLpqmpWR7Vb8AgRaf8QxXEQROe47TNV6mB+I7DI/cYtYEE5p18WmQFnxpYz5uPL
         FyJg==
X-Gm-Message-State: AHQUAuZ4NLV7lZz3wxBYkfhbFi02YxvarRL8krzK5PX7JqVqYrHF+Ao7
        DWlDEvMNZpsXjZbtKOyzgwgnuRiq7im1Qg==
X-Google-Smtp-Source: AHgI3Ia+WGMG9mUwsySj+Eu9072raC/JEVvNdJRiFfd9zIbK37RLrlOAC/ln5VrC3Ez80Q10MmWafQ==
X-Received: by 2002:a2e:2e1a:: with SMTP id u26-v6mr1937057lju.8.1549348638325;
        Mon, 04 Feb 2019 22:37:18 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id f1sm3578088lfm.22.2019.02.04.22.37.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 22:37:16 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id l10so1762650lfh.9
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 22:37:16 -0800 (PST)
X-Received: by 2002:a19:9bc2:: with SMTP id d185mr1989032lfe.21.1549348636205;
 Mon, 04 Feb 2019 22:37:16 -0800 (PST)
MIME-Version: 1.0
References: <20190203074939.7261-1-jackoalan@gmail.com> <20190203083933.ee4a6j4mdecesbn2@brauner.io>
 <CAGXu5jLGgCChpxt3ee8kSi2pTKPd9baHt_uZvTG6qqi8oFK2UQ@mail.gmail.com> <87r2cn7y9g.fsf@xmission.com>
In-Reply-To: <87r2cn7y9g.fsf@xmission.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 5 Feb 2019 06:37:00 +0000
X-Gmail-Original-Message-ID: <CAHk-=wjFUCjvFzTGNt2hNO-Q5TaQHYSD_5NDDiS+zxwf3qQPwQ@mail.gmail.com>
Message-ID: <CAHk-=wjFUCjvFzTGNt2hNO-Q5TaQHYSD_5NDDiS+zxwf3qQPwQ@mail.gmail.com>
Subject: Re: [PATCH] signal: always allocate siginfo for SI_TKILL
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian@brauner.io>,
        Jack Andersen <jackoalan@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 5, 2019 at 2:41 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> I think the simpler change to just do:

Ack. Changelog and sign-off?

              Linus
