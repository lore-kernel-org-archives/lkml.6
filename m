Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3242FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E905E20870
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:28:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xcwy3LzZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E905E20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730043AbeKTCwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:52:06 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:33057 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729879AbeKTCwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:52:06 -0500
Received: by mail-ua1-f65.google.com with SMTP id t8so3201500uap.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 08:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rjT56Y3Hb0xyMumXvOFYWzCrqANEbDFkwo4obTq7yfk=;
        b=Xcwy3LzZQAQptpw75ewDX0jCn/iH+12JD/wHMlzH0HE4lfy6sp/acdgVgcirIsLU5M
         HNLFmXCEig3Tj+ZHco3Rsj0epRg+KkIJQwgMfIJO5EGTXDATjvtGPa+C7YhjJVtRgGtj
         pEGyTmij6v3T/msenqK26G1CKqgvsqMpu0sOrr6g33SCKvGiezICRmazN6GoMYA7z4jx
         /ZAm/MpKIv2dl6eWu6X+HA8L4/rHJXaQt63yB1V3d24kHvpftquzS03HfbcWs9bZYTX0
         uf6zBQqtdlNo1bxTIJJsbglfEOloNhg5vVsOeZayYhHp2JDjy4hQlvy/K6Dv2b5YEVSr
         +xzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rjT56Y3Hb0xyMumXvOFYWzCrqANEbDFkwo4obTq7yfk=;
        b=JwssZcPmjgmS0spdxtGAqTPsLNNkVpkAxP6F5jWU0jILlBZ+9jdwRpHeb7+2tywQDQ
         JJtfHSNlLSi5eccZlcc0L1R2SeAde46YJYNxyrcwDVS7Cv8dxsLCdRcgmXFgOeeVxmQz
         mQGZ9C2cuVizsEUQC4KNUs3IPDoJUKrcjUZZSpwQc3OUcU6dyfWjuHYkL9tuor+QfYRp
         dQgQlNbUjtiadvoxfrDWkgEcOPMp5jePmW836i7Fvc/pvAlME1vaO8iyRFuUmfKecPKk
         Ib8qb74BU6pi/0XqpHF1/QOx4kJDUxLWamDZuSLD2FOATL0p2iQjOqXIMqzYe2VrfZ/k
         cfqA==
X-Gm-Message-State: AGRZ1gILjQYmZOknVUM+7tzjqnHDTXXKPKJm4Kl4C/bJrJFI5cGmYWXr
        +IhKxBQWDMRS19nH96FPpLJ2lu10bg/chYqW1ow/Cg==
X-Google-Smtp-Source: AJdET5d8sj04KqWO/Bc6BrEIzxH8RxctnzNqGT+0m8sWlDo+WGd5x4/G4DHZ0oNzB7k9h7szWk5itA50FkiFrGA6WsM=
X-Received: by 2002:a9f:2b44:: with SMTP id q4mr7066521uaj.126.1542644878352;
 Mon, 19 Nov 2018 08:27:58 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a67:f48d:0:0:0:0:0 with HTTP; Mon, 19 Nov 2018 08:27:57
 -0800 (PST)
In-Reply-To: <CAJwJo6aXQUtciO7kPSENoajV6JUqUGJxCh_0yPf5D8GfbLegzA@mail.gmail.com>
References: <20181118111751.6142-1-christian@brauner.io> <CAKOZuet3s0WxxPgrtrNkq8YiOWhYAiK6yEio6PKVV9J_H4_TSA@mail.gmail.com>
 <CALCETrUd2Y2MmO8Qx8aUvQDOTNiyj35Y7bctPBZe0p2i1EUiLw@mail.gmail.com>
 <CAKOZuev1JUGFWuwsKqS6rXcFMqpCHT1VAG2kwB4O=FHo6DAFiQ@mail.gmail.com>
 <CALCETrVLP_mudJTW6EQpRr5GZ7kfuGci+QCT1uPrOVDTWcod-A@mail.gmail.com>
 <a7f50692-667c-4efe-a2d0-fa324eebb90b@infradead.org> <CAKOZueutLc8d0Fe+7dNWiZKnALhTSST8+kCnOrL+OmB6coUmtA@mail.gmail.com>
 <CALCETrVg71XBv-gMOtL-m0Dd0HNz8_oXOUDSWin5LeViAL0UYA@mail.gmail.com>
 <CAKOZuesCKo4GH9fdum2EUFLrtTWam3aizcDQUn3-vCYg4T1P8w@mail.gmail.com>
 <CALCETrUeNZPfrSYa9vH5Ukrk1Y+Kb9GkZOh6LkqG6Z9NpK5P0w@mail.gmail.com>
 <CAKOZuevVk_aH_2TuiNcmxgMa+gHXMBXz6Uu5a6TDjoxjhaE36g@mail.gmail.com>
 <CALCETrVscRwQG55-j1SKc2TmSb1-=5861804ojUuviNzdyDOrA@mail.gmail.com> <CAJwJo6aXQUtciO7kPSENoajV6JUqUGJxCh_0yPf5D8GfbLegzA@mail.gmail.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Mon, 19 Nov 2018 08:27:57 -0800
Message-ID: <CAKOZueu78Urbc-Vt--ZntGAG_i-LrNsPjGmRi7F8zuTUQ=iHug@mail.gmail.com>
Subject: Re: [PATCH] proc: allow killing processes via file descriptors
To:     Dmitry Safonov <0x7f454c46@gmail.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Christian Brauner <christian@brauner.io>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        open list <linux-kernel@vger.kernel.org>,
        Serge Hallyn <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Kees Cook <keescook@chromium.org>,
        Jan Engelhardt <jengelh@inai.de>,
        Andrei Vagin <avagin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 8:13 AM, Dmitry Safonov <0x7f454c46@gmail.com> wrote:
> I wonder how fast it would be holding a pid with another open()ed fd.
> And then you need to read comm (or how you filter whom to kill).
> It seems to me that procfs will be even slower with this safe-way.
> But I might misunderstand the idea, excuses.
>
> So, I just wanted to gently remind about procfs with netlink socket[1].

We discussed netlink was extensively on the thread about
/proc/pid/kill. For numerous reasons, it's not suitable for
fundamental process management. We really need an FD-based interface
to processes, just like we have FD-based interfaces to other resource
types. We need something consistent and reliable, not an abuse of a
monitoring interface.

> Probably, if it's time to add a new API for procfs, netlink may be more
> desirable.

Definitely not.
