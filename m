Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D5BBC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 13:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0041D20652
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 13:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="gmXczKPN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbfAQNVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 08:21:54 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39661 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727363AbfAQNVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 08:21:53 -0500
Received: by mail-lj1-f196.google.com with SMTP id t9-v6so8553731ljh.6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 05:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ryVcTEl5q/cbIxyudwCNKkjBsjaLwkUWRsmdGQumEmw=;
        b=gmXczKPNRKZaPtcfGbS9bxRl+axZM0sJSTx/XCGpOSbEoEnb23ZwbiG6cWm+WtzfAA
         p55BIwXZ2YsphVpAuhNsVi/wkIz639Xu19VhxCtg5Avnxm4NawpH8h1DrGdh9UwTWHar
         D4JIEOvSuope+1zOAyHlxxxMFh+3hsyLfgprSbUnS/V4bbEMw7/gYblYSlhodA1ptui9
         3OsLyXLAkDrK2zJmuTrM0L7yaPWpd5hzbRAHxRm0SjKRj/AApScxkvAW1Kt44qR/rqaT
         UT2Pyk8EYnCtxOiG87dqAMYZWa2dPq8v6CWuxG9WhRbUnGqafoB03Z1ztwop7OM1+2fW
         koZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ryVcTEl5q/cbIxyudwCNKkjBsjaLwkUWRsmdGQumEmw=;
        b=AvAg0TSk6qwCjo9ZrweHWRhoRQXT/udS71zyn4wmK9FB/OP9OydGFsG22hrDWQGK35
         3jfuGodzVcoN58c3NLLF5wJXhWD5cIt7bM7kVJauXOE1F/jP7KjvgO7VHEZ8laRm0o+E
         EA/DF5KSsYZ37bAwlv5hfF2cKJr7fdyaOJDoASuM9MFlHgaIGnHsdXOEQJltuDvKRIQB
         yF84ZKlm4CCeFJKeYcgQWqPK/5ysf9fSFp2dtEzBbeBs7245GFsFiF0Dqwe2nlrDoZwD
         kM5rtnaVWg7Vs7RKRinIbXWJzEWRjAbOQUai/8XDU7GmuX2+K5dM8P8GsJlFEzQwruMR
         l5KA==
X-Gm-Message-State: AJcUukcLYnKStPbFpiFhmX8Eu4ZErHfKdETUIv835WHU0aut7r+ryOUM
        GvqmNuI0cYCKHs85d+hVHqFTFdimBUA1X570iPoN
X-Google-Smtp-Source: ALg8bN58X8MYRiCrPvVQKNuzhka0CQteVlngLpn3c6FKVF36Eyjk5LG5tvRpYVDMzueK3dLrsCT+yM/WJTTK3kS/Qro=
X-Received: by 2002:a2e:880a:: with SMTP id x10-v6mr10369552ljh.174.1547731311223;
 Thu, 17 Jan 2019 05:21:51 -0800 (PST)
MIME-Version: 1.0
References: <cover.1544477629.git.rgb@redhat.com> <43548fafdfa98ee64ecfd0d7a69a2f5cb2c31c50.1544477629.git.rgb@redhat.com>
 <CAHC9VhSaTvVgSWVWo42Ur2k6hVNJ1XBkLwrd-J4-SUuidwXUYg@mail.gmail.com> <20190117103255.1f640a42@ivy-bridge>
In-Reply-To: <20190117103255.1f640a42@ivy-bridge>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 17 Jan 2019 08:21:40 -0500
Message-ID: <CAHC9VhQvk+6AFjVU_ygyn8Q6FGwVy_JqXj7wWSNYYp5zSiBcuw@mail.gmail.com>
Subject: Re: [PATCH ghak59 V3 2/4] audit: add syscall information to
 CONFIG_CHANGE records
To:     Steve Grubb <sgrubb@redhat.com>,
        Richard Guy Briggs <rgb@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        Eric Paris <eparis@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 4:33 AM Steve Grubb <sgrubb@redhat.com> wrote:
> On Mon, 14 Jan 2019 17:58:58 -0500
> Paul Moore <paul@paul-moore.com> wrote:
>
> > On Mon, Dec 10, 2018 at 5:18 PM Richard Guy Briggs <rgb@redhat.com>
> > wrote:
> > >
> > > Tie syscall information to all CONFIG_CHANGE calls since they are
> > > all a result of user actions.
>
> Please don't tie syscall information to this. The syscall will be
> sendto. We don't need that information, its implicit. Also, doing this
> will possibly wreck things in libauparse. Please test the events with
> ausearch --format csv and --format text. IFF the event looks better or
> the same should we do this. If stuff disappears, the patch is
> breaking things

We've discussed this quite a bit already; connecting associated
records into a single event is something that should happen, needs to
happen, and will happen.  Conceptually it makes no sense to record the
syscall (and any other associated records) which triggers the audit
configuration change, and the configuration change record itself as
two distinct events - they are the same event.  We've also heard from
a prominent user that associating records in this way is desirable.

If the ausearch csv and text audit log transformations can't handle
this particular change, I would consider that a shortcoming of that
code.  We have multi-record events now, and this is only going to
increase in the future.

Richard, if you can't make the requested changes to this patch and
resubmit by ... let's say the middle of next week? that should be
enough time, yes? ... please let me know and I'll make the changes and
get this merged.

-- 
paul moore
www.paul-moore.com
