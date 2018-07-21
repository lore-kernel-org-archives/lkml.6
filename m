Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABDCCECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 13:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DA5A20854
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 13:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T0zstGi/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DA5A20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbeGUOYV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 10:24:21 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38254 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbeGUOYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 10:24:21 -0400
Received: by mail-wr1-f67.google.com with SMTP id v14-v6so13675700wro.5
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 06:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YvWasVjL0A8+LzZ9WKRyRHh64HaG4/RhzHJZkoK/URI=;
        b=T0zstGi/JO+jyhFTj5DyoN6O1d/76djgnfQxFM03bDHOzCe/GtabukaPHohHccS8i0
         o9TXZuBgQjHq9CQjg7QGKtuzFlJAyymz2c6iilxHLHRM6WFMmKNeXwwYOXIWcPuII48q
         OL7A00irO+NWpN9GHLKCRAdIy3UeBBVewFiB+DrjZ9u2s5xKxOKtSRwbLY6hRmK5vJ0Z
         cLzXV3AG+o2DulydFWSM1igsibwB93yk0pspsHgcBmQud6yg5iKuog/z8Gdwo5yMqSgB
         0i/dRlXl7aUA3dyEju+878OfKLVvxgNDelJqoM078GPZ07ayVtsW0yUqcyP7dz/3fYgl
         MH5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YvWasVjL0A8+LzZ9WKRyRHh64HaG4/RhzHJZkoK/URI=;
        b=SKV1UB3b/L/DkyNG+lPCqTGKen+5OCUvcuZwgvZ1ZR+xxc56giagDFx9izbXRYjuQR
         gfXp+lVJFYjkLaA89shwmMhjtLjFG+kqiLmx/08DK5/irvAUUh5HJN+jyGFC/DLl0GvJ
         wHYFLoNhySBe7dGznrUsnhhVe7JBrVcdyHrGU2KGXWVTS/8FglzvXIuJIm/+ot6DTel3
         bwJsXcexYvuaCgdFUxwbYJdOCWuCjM6ohGWPummSA/lbUdxELVLaKrhJzAOMu8CjnESO
         Cdor/1J3v277oZk8kb8CzXKCsS6GWWQInB5bNi2YngVjkilWpOOsomuYM7OzNWKSkHfy
         kEWg==
X-Gm-Message-State: AOUpUlFsXoK4dmjeuEBiNWFcvM4zNkd7mc7xmcd+xQ2mjRn5wfntkZ3w
        a2QoyIy0VStZw6qZDt1bXhzjxVvmGRv23CAAIYS6pQ==
X-Google-Smtp-Source: AAOMgpdDxxjMxBtz0VXNmUXArr+0qE7cq6x6SsARSBBNFRmTrHKjHSw8ho2taz09TVpnggUHIwdVfo3gjRw4lNs3EkY=
X-Received: by 2002:adf:f188:: with SMTP id h8-v6mr4218837wro.214.1532179893307;
 Sat, 21 Jul 2018 06:31:33 -0700 (PDT)
MIME-Version: 1.0
References: <20180721125713.88501-1-toddpoynor@gmail.com> <20180721131720.GA4290@kroah.com>
 <CAAW3YpbJADPRYcwZFcHMPcbOWqQmdqiXbvPrJwBxC0=uCo0aFw@mail.gmail.com>
In-Reply-To: <CAAW3YpbJADPRYcwZFcHMPcbOWqQmdqiXbvPrJwBxC0=uCo0aFw@mail.gmail.com>
From:   Todd Poynor <toddpoynor@google.com>
Date:   Sat, 21 Jul 2018 06:31:21 -0700
Message-ID: <CAAW3YpZhn949sfMpHChwG7xX6yzwmQRK4RL5Zw20sYwaoSpU-w@mail.gmail.com>
Subject: Re: [PATCH 00/14] staging: gasket: assorted cleanups
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "toddpoynor@gmail.com" <toddpoynor@gmail.com>,
        Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>, benchan@chromium.org,
        devel@driverdev.osuosl.org, frankhu@chromium.org,
        LKML <linux-kernel@vger.kernel.org>, groeck@chromium.org,
        Dmitry Torokhov <dtor@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 21, 2018 at 6:30 AM Todd Poynor <toddpoynor@google.com> wrote:
>
> On Sat, Jul 21, 2018 at 6:17 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Sat, Jul 21, 2018 at 05:56:39AM -0700, Todd Poynor wrote:
> > > From: Todd Poynor <toddpoynor@google.com>
> > >
> > > Various fixups arising from the chromium review of the gasket and apex
> > > drivers.
> >
> > Didn't I just apply this whole series?  Why resend it?
>
> This is another round of cleanups from the chromium review, I can
> update the subject to make that more clear.

Oh, something went wrong, will fix up my end.

>
> >
> > confused,
> >
> > greg k-h
