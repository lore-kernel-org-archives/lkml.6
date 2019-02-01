Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA81C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D10B020869
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uhWp5yKx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728602AbfBAJFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 04:05:44 -0500
Received: from mail-io1-f49.google.com ([209.85.166.49]:36432 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbfBAJFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 04:05:43 -0500
Received: by mail-io1-f49.google.com with SMTP id m19so5104735ioh.3;
        Fri, 01 Feb 2019 01:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SMSVya3sF3C7n2pqq1mkXvOHNxY7eiciFrScDthbYaY=;
        b=uhWp5yKxCnARTs13Xjsm9/AkmnMJosCy7ULDNK/UeliJX1PVyIoobkd9wjkMeHMqBk
         d6YFEh7ff4pTF3y6LQwXxBU5Jyg44W7GITVwX3WO4AWCkNnMCS5/VuYwtChm8EAt7hI+
         ULM953A3Tv3mlZxPQX3tSS4G3cryTPPeIjrZyPlxBrHsJ3d0tv3NMI3Z4rlMZuoylrQp
         scHZW2NM1D3I2+lMotkXDGGvp5IYfMrlwHKo5cp8ame/Q2sfoWWgdIi5eBtJ+baW0yFS
         kXyctrDYP2svJUiALaoVZKpT+IMHAKh2hX/xi9F6wJ0GoJjEA4VGUzsN8vR3WPtQU9Qo
         SmoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SMSVya3sF3C7n2pqq1mkXvOHNxY7eiciFrScDthbYaY=;
        b=NUE5x56bn4NRtS9SuS7eDeyma/Ci3ix8OL8gfIzhUTomcwWLW/vZEeuO6azpHyDi5X
         aXErtE/eyAETVAiGNCwXhtPS13jvyJAzvg6ywZYr4do8PIpQUf4P0lxEi+8vdix+VjtP
         3kbWXgdYPeAUCd0dy0ZCEGxOhkQePXFC2ZK0lFKW15yPBpiF8rZjguyvl5VmWU+ZRUEm
         6iFB8FtX/QhyQVj5ZXeY3soyx6tdyHXyKKfxj8JiXjlgWSomcSHFMWb9OEjZAi9Q4W0o
         I8p6IJzYlkXVSnwSob093otC5/IgSGoWN9q1TnpSQYY/UW/hO/uJ2peFd8huCtH58pjE
         +2lA==
X-Gm-Message-State: AHQUAuZiA6LcMyGJ/ybmRH6xxFaxesKyzleJSqCVKecYxVlpeRhSP79L
        Shr2a6RcJEUyl4JgnMFczTr2FElKbLvPPfLXeD6sww==
X-Google-Smtp-Source: AHgI3IYHeEEAYn5D+1hzdwb0+WEHRKgo3LsjI9QsoNoRy23Jn6e/fQXGTucyhUdM77YdajXouBrnvLYaSzny4Gmh+zY=
X-Received: by 2002:a6b:ca04:: with SMTP id a4mr9990456iog.254.1549011942762;
 Fri, 01 Feb 2019 01:05:42 -0800 (PST)
MIME-Version: 1.0
References: <CAOPCCyKnS6Eab6QD8Qd6-pyYTXP4VDMsjTfzzv8R+ijTDCVf4w@mail.gmail.com>
 <20190201090002.GA4166@kroah.com>
In-Reply-To: <20190201090002.GA4166@kroah.com>
From:   Michael Umansky <mishka99@gmail.com>
Date:   Fri, 1 Feb 2019 01:05:17 -0800
Message-ID: <CAOPCCyLCaStbRjPLY6TYYf0pncO8e13cROXdnRcJQtJ9rtT7Cw@mail.gmail.com>
Subject: Re: latest RT patches for the latest 4.20.6 release
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oops, very sorry, I forgot to add -rt to stable email :)
Michael

On Fri, Feb 1, 2019 at 1:00 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Fri, Feb 01, 2019 at 12:04:40AM -0800, Michael Umansky wrote:
> > Hello,
> >
> > I found linux-stable-rt-4.20.2.tar.gz but the latest official patches
> > are for 4.19.15 (in the rt directory).
> >
> > While I can run the diffs against the regular 4.20.2 tree I'm curious
> > if there will be official patches released against that version, or
> > better yet, against current 4.20.6 stable version?
>
> I recommend asking the -rt developers, as they know the most about this
> and their plans for releases of that patchset.
>
> good luck!
>
> greg k-h
