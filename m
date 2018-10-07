Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62272C65C30
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 09:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2AF720882
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 09:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="UOcKcFxJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2AF720882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbeJGQLi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 12:11:38 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:39611 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726402AbeJGQLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 12:11:38 -0400
Received: by mail-io1-f68.google.com with SMTP id z16-v6so13739422iol.6
        for <linux-kernel@vger.kernel.org>; Sun, 07 Oct 2018 02:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EqZXKVjgX1IjVsZV0H9lRpA40zXcF4ZMe6luud9XTXY=;
        b=UOcKcFxJqVD2/ZutFarRzMakOW+Hmxb8Mw7LbwE8ap8vtseGifO7BBf/XLQPmOISJQ
         2NCp5s1bwlenV+ZXu7h0D0gE6wvXoNMODSmX/ABZTTcowgXeZtpIkAvblhqCW/Y98TkW
         DYGn67jd8W8BTDjW+jaSP8+WWjns39MWpM0ec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EqZXKVjgX1IjVsZV0H9lRpA40zXcF4ZMe6luud9XTXY=;
        b=V7cNOk6NQtkhKuT3DJ+eZAe/VIjEY1ffAvi3G0WMhNGh0QdTWdVIbnMrGa2M869Fda
         lgZP1klubFOYwHFJo1KT9PLj+Y9q817FQ0sc3dvSQe0lwL0soZQg8SBuD5zfhaSLU6i5
         XEFVbgvOrhdt2AzigBm68ou3SSqgAff/e48+H08B+dx3kbJWZey1B+8XcJ7a/BtMySZW
         Rb9BM6KqI1UtLpPceWkE0BzNuPnEOOw43Dr4IInLtp8LXclEmvnNluY159KoEAsi2fWK
         qn+f7fFQN5Hp8HX47+igxHWDe/vs5hkm1S+DjhRJ1Ys6y1YnYhsrQnk/cWkQWH/JnuPT
         de4w==
X-Gm-Message-State: ABuFfog3xfUfs2qRa88VEHJyKqTd3nooejTq/iEdM2a7JYRKm33vwrP8
        UYJBQUYhO0OsQdj8QlFj+wN96/LeIqmbyJ7FK/2UkDYj
X-Google-Smtp-Source: ACcGV60g+bM3q5H/SAVG+Y0GrJpjqx0tJ4LeV2MYs6G7/zi8cljPBFUiN/JIS8BrtYMX40NAjtXCf9zwHO7ogl5B6z8=
X-Received: by 2002:a6b:8d88:: with SMTP id p130-v6mr13504925iod.34.1538903100270;
 Sun, 07 Oct 2018 02:05:00 -0700 (PDT)
MIME-Version: 1.0
References: <1538861738.4088.5.camel@HansenPartnership.com> <1538861799.4088.6.camel@HansenPartnership.com>
In-Reply-To: <1538861799.4088.6.camel@HansenPartnership.com>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Sun, 7 Oct 2018 11:04:48 +0200
Message-ID: <CAKMK7uGvgttqL_RoXumd0F4w8UMqwaVODaMWnOZz5weSFzDJ2A@mail.gmail.com>
Subject: Re: [Ksummit-discuss] [PATCH 1/2] code-of-conduct: Fix the ambiguity
 about collecting email addresses
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 6, 2018 at 11:36 PM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> From 4a614e9440148894207bef5bf69e74071baceb3b Mon Sep 17 00:00:00 2001
> From: James Bottomley <James.Bottomley@HansenPartnership.com>
> Date: Sat, 6 Oct 2018 14:21:56 -0700
> Subject: [PATCH 1/2] code-of-conduct: Fix the ambiguity about collecting =
email
>  addresses
>
> The current code of conduct has an ambiguity in the it considers publishi=
ng
> private information such as email addresses unacceptable behaviour.  Sinc=
e
> the Linux kernel collects and publishes email addresses as part of the pa=
tch
> process, add an exception clause for email addresses ordinarily collected=
 by
> the project to correct this ambiguity.
>
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> ---
>  Documentation/process/code-of-conduct.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/process/code-of-conduct.rst b/Documentation/pr=
ocess/code-of-conduct.rst
> index ab7c24b5478c..aa40e34e7785 100644
> --- a/Documentation/process/code-of-conduct.rst
> +++ b/Documentation/process/code-of-conduct.rst
> @@ -31,7 +31,7 @@ Examples of unacceptable behavior by participants inclu=
de:
>  * Trolling, insulting/derogatory comments, and personal or political att=
acks
>  * Public or private harassment
>  * Publishing others=E2=80=99 private information, such as a physical or =
electronic
> -  address, without explicit permission
> +  address not ordinarily collected by the project, without explicit perm=
ission
>  * Other conduct which could reasonably be considered inappropriate in a
>    professional setting

We've discussed this a bit with freedesktop.org people a while ago,
both from a CoC and privacy regulations pov, and we concluded that
attaching random people's emails in Reported-by: and similar lines,
without their consent, is indeed a problem. Bugzilla is rather
problematic in this way, since it looks like it's protecting your
email address and keeping it private, but then you can still just grab
it from the bugzilla emails without first asking for permission.
That's one of the reasons why fd.o admins want to retire Bugzilla in
favour of gitlab issues (where this is handled a lot more strictly).

What we discussed in the older thread here on ksummit-discuss is
making it clear that email addresses sent to public mailing lists are
considered public information, which I think is worth clarifying. But
what you're excempting here is anything collected without permission
in the past, which I don't think is a good wording. I've definitely
been skimping on the rules here in the past. At least in my
understanding of the legal situation, if you get a bug report through
a private channel, or at least a channel that hides private address
information (like Bugzilla does, albeit sloppily), then you do have to
ask for explicit consent to publishing that information.
-Daniel
--=20
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
