Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4512C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 03:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65E602086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 03:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="S3Jyv8R/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbfARD1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 22:27:07 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34912 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfARD1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 22:27:07 -0500
Received: by mail-lj1-f195.google.com with SMTP id x85-v6so10449516ljb.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 19:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LMGX1tkGVmr03HafIE9so82GR3BcFU4V5N3EJHDzG5s=;
        b=S3Jyv8R/H1CUfpYzXdm/g0k1MeJhciDN+lyc+dQitMrD5ozon35BkNQ8MTiHZp0o4p
         mIDY2C5aUcTT0jtcOhhd4YxKeCyW/mtaUJmBAKCh1F25QBsrZz5iaMA1r2o04LaxDIMZ
         Pe1kq0bCKs8hqRgjg0TvX8vdEXN69MQJ3VcX0e2g2XRAclRQYPju7K4oPZQ7mOnmnVt3
         tN7bLSVlpVsxnc8cZK4xln91nWFIFy5r0PzQ6/D1oPdkKNeCFMbze+eqPyTsAmoPJMqT
         852jo2AWSht2kHWkKhWedosKMqKplGdYOz1SUHNo8r536zlIDzRUg+qz1+Wgab7f0raH
         extA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LMGX1tkGVmr03HafIE9so82GR3BcFU4V5N3EJHDzG5s=;
        b=ZUpiFQRu83IKGbx9if2XDxv4CUcdaoY2vryMkCmO/SwX/dlPKxa1r2xhvgvAazwc/W
         MfYc19qhGaXmSEwtzku4pTkqn9YuTREBqgEO7ai5Nqh7EfKbLClZ0BNBhFDx47gq7jBg
         4uW0Fv19FLz+WkWxR4C/mRxgzo+yBILXiagCy52ktGQ0iRgwTuzxuq++WtroyHxyjZXx
         k6j3RThnuKHnwN9fcy8IzojcDnwN3BUU0lRF9x7tS64ywznNsI0/CfuqjjYkRPBthTv6
         6Q+QrNI7C3XzJPhTn2N9p0uiwV7ZoiY1pT5YUzsyKQQnqNlW77b+HC/M+l6dEIuDpI+c
         qD7Q==
X-Gm-Message-State: AJcUukcVzxxbuzknDNvjkfQOv0Ekn5SbOi28pdB21Du7N7VlU+K/JuzN
        pKA35sn5yky0OvbPCHFxglnAe8Aj//WUNjAwPWmH
X-Google-Smtp-Source: ALg8bN5C51OC6fd6FWgvAPL2C8wccOX0MyvqnnKXGTxNF3wbUXfqHFSvhrtdGfFUoUPE+RzV3KxZLoo8yIJuLcGCIFs=
X-Received: by 2002:a2e:834a:: with SMTP id l10-v6mr10760960ljh.42.1547782024026;
 Thu, 17 Jan 2019 19:27:04 -0800 (PST)
MIME-Version: 1.0
References: <cover.1544477629.git.rgb@redhat.com> <43548fafdfa98ee64ecfd0d7a69a2f5cb2c31c50.1544477629.git.rgb@redhat.com>
 <CAHC9VhSaTvVgSWVWo42Ur2k6hVNJ1XBkLwrd-J4-SUuidwXUYg@mail.gmail.com>
 <20190117103255.1f640a42@ivy-bridge> <CAHC9VhQvk+6AFjVU_ygyn8Q6FGwVy_JqXj7wWSNYYp5zSiBcuw@mail.gmail.com>
 <20190117153430.olcpsdq67mozk35e@madcap2.tricolour.ca> <CAHC9VhRBA0k9Mo2_GuscaxOGigbUhytepQ_3O1HQRvwZOwmt_A@mail.gmail.com>
 <20190117231838.im4nku57qxutjveh@madcap2.tricolour.ca>
In-Reply-To: <20190117231838.im4nku57qxutjveh@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 17 Jan 2019 22:26:52 -0500
Message-ID: <CAHC9VhTEDJUa7hWuZ28cwcZt1ZCSUSBf_EXo9DxrRnhuWmqL=A@mail.gmail.com>
Subject: Re: [PATCH ghak59 V3 2/4] audit: add syscall information to
 CONFIG_CHANGE records
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Steve Grubb <sgrubb@redhat.com>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 6:19 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2019-01-17 12:58, Paul Moore wrote:
> > On Thu, Jan 17, 2019 at 10:34 AM Richard Guy Briggs <rgb@redhat.com> wrote:
> > >
> > > On 2019-01-17 08:21, Paul Moore wrote:
> > > > On Thu, Jan 17, 2019 at 4:33 AM Steve Grubb <sgrubb@redhat.com> wrote:
> > > > > On Mon, 14 Jan 2019 17:58:58 -0500 Paul Moore <paul@paul-moore.com> wrote:
> > > > > > On Mon, Dec 10, 2018 at 5:18 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > > > > > > Tie syscall information to all CONFIG_CHANGE calls since they are
> > > > > > > all a result of user actions.
> > > > >
> > > > > Please don't tie syscall information to this. The syscall will be
> > > > > sendto. We don't need that information, its implicit. Also, doing this
> > > > > will possibly wreck things in libauparse. Please test the events with
> > > > > ausearch --format csv and --format text. IFF the event looks better or
> > > > > the same should we do this. If stuff disappears, the patch is
> > > > > breaking things
> > > >
> > > > We've discussed this quite a bit already; connecting associated
> > > > records into a single event is something that should happen, needs to
> > > > happen, and will happen.  Conceptually it makes no sense to record the
> > > > syscall (and any other associated records) which triggers the audit
> > > > configuration change, and the configuration change record itself as
> > > > two distinct events - they are the same event.  We've also heard from
> > > > a prominent user that associating records in this way is desirable.
> > > >
> > > > If the ausearch csv and text audit log transformations can't handle
> > > > this particular change, I would consider that a shortcoming of that
> > > > code.  We have multi-record events now, and this is only going to
> > > > increase in the future.
> > > >
> > > > Richard, if you can't make the requested changes to this patch and
> > > > resubmit by ... let's say the middle of next week? that should be
> > > > enough time, yes? ... please let me know and I'll make the changes and
> > > > get this merged.
> > >
> > > I would do the change, which should be very trivial, but I'm dense
> > > enough that I still don't know what you want.  In the last 6 months I've
> > > asked a number of direct questions that have not been directly
> > > addressed.  Perhaps I should be able to figure it out from the more
> > > general or fundamental principles replies I've gotten (which have been
> > > helpful, but perhaps incomplete), but I'm still having some trouble.
> > > Perhaps I'm exposing my limitations.
> >
> > Since code is unambiguous, let me just cut and paste what I was
> > thinking (be warned, this is a cut-n-paste, so the whitespace is
> > probably mangled):
>
> Thank you.  Very clear.  I don't see the point of
> audit_log_user_recv_msg() for reasons already stated but that's ok.

That's a fair comment.  I think there is some value in having the
function dedicated for the user messages since they are fairly unique
in that we don't ever want to associate them with the current task,
but it does result in a single use function (which I generally
dislike).  Who knows, maybe at some future point in time we'll get rid
of audit_log_user_recv_msg(), but let's stick with it for now.

> Since we're looking at these, here are the various field formats of the
> AUDIT_CONFIG_CHANGE records.
>
> Steve and Paul, are they worth attempting to normalize?

Right now, my vote is "no".  Although I'm voting that way pretty much
just because I want to get this patch in during this development cycle
and I'm fairly certain that trying to reach any consensus around
normalization is going to drag this out.  I would strongly encourage
you to just tweak this patch as we've just talked about and leave it
at that for the time being.

-- 
paul moore
www.paul-moore.com
