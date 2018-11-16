Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A515C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 19:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B36822087A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 19:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="avPbxxyd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B36822087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbeKQFde (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 00:33:34 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39385 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725729AbeKQFde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 00:33:34 -0500
Received: by mail-lf1-f67.google.com with SMTP id n18so17281555lfh.6
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 11:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y+QNAKzRVZzkUxgv7m2oQiWE6mLm1revQ2idJw927UA=;
        b=avPbxxydL0KKclEOhHtxujVisM9/BsJwWqPLiy4kplwmCP1Lu54P0+gbHT0Yed/qa4
         qh1VALzUJ2JoMbilaKD3E7r42GxXbyWNm+Kol20Hx97P7+5OsmpKv318gxtrXPjgFj5B
         DWEAD9Xp0ICNrB437cBlw2JwJccI+vy6S16NtSq2CZO0x0dvYFAqLvTj04rLCJlmeseZ
         DuGce1XT0dMOqg3hKAl3/cOY9NUMxr1GqgESu2qpg29U9uqE/i+DEJypXBGtoikYpd3e
         azBQW+SetvA7r24nQBsyIOkOoxyHJbjoxBnbSfRM6s+doYqESMSo7JoFCMQBiE1ADQM4
         UzNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y+QNAKzRVZzkUxgv7m2oQiWE6mLm1revQ2idJw927UA=;
        b=kYEfq2MEUrVcfJrc2l4EmBJbzWzb/MYqaeeTvFsyoorIapVneLDbLW/B3+l6MaVoDD
         FHLtozf2gzLrqYeJnkmsJNxpd+8tKSLsoos5rSeSJDef2zGh9WifvXV6zAV6ZRdincfu
         iKNfq19aPhV2sMh71iF9hLaJPhuoE9ekR6CD8GT/+SBzwuNdNeLlhylXIVSJCzWVzXf2
         4GHrDOuL+LPJeHS5kxhL0SSycdDK4X5S3cgOPdfhyZE4nIRbkcjmaky8F4gBsPEDxjJg
         e+iHY2JAGLhOY/h3ba0JykIPeFKjRHBLEvVitD20QWBg2WO3qitvk3PZu7jp8HYv+oi+
         XH8w==
X-Gm-Message-State: AGRZ1gJ3jz4fOlOajpUf8o9HrfuTSUZw8FDsiCeeVE3MkIAxopZ0VkAx
        BzF0uFYVA6X2MghxP4mWkt/Bm5hZxMLrHAXgPQtksw==
X-Google-Smtp-Source: AJdET5fdSegG9ltAYsg0kzedfDCPFTOn+qE+LL7kk/GutneIBkrFHRXJtWjmwQd9mJvROaavqVp9yE+ABi9XjNtsbnA=
X-Received: by 2002:a19:978c:: with SMTP id z134mr6723158lfd.109.1542395993921;
 Fri, 16 Nov 2018 11:19:53 -0800 (PST)
MIME-Version: 1.0
References: <5FBCBE569E134E4CA167B91C0A77FD610198F8FA41@EXMBX-SZMAIL022.tencent.com>
 <20181115143349.44e1942213b61a4818bcbf02@linux-foundation.org> <20181115225427.GA25874@kroah.com>
In-Reply-To: <20181115225427.GA25874@kroah.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Fri, 16 Nov 2018 11:19:41 -0800
Message-ID: <CAHRSSEw26XZMAgR=9HXVzBEDanwJABcJAYzYgA32HtaC0TR+7A@mail.gmail.com>
Subject: Re: [PATCH V4] binder: ipc namespace support for android binder
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     akpm@linux-foundation.org, chouryzhou@tencent.com,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>, dave@stgolabs.net,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>, christian@brauner.io
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 2:54 PM gregkh@linuxfoundation.org
<gregkh@linuxfoundation.org> wrote:
...
>
> A number of us have talked about this in the plumbers Android track, and
> a different proposal for how to solve this has been made that should be
> much more resiliant.  So I will drop this patch from my queue and wait
> for the patches based on the discussions we had there.
>
> I think there's some notes/slides on the discussion online somewhere,
> but it hasn't been published as the conference is still happening,
> otherwise I would link to it here...

Here is a link to the session where you can look at the slides [1].
There was consensus that "binderfs" (slide 5) was the most promising
-- but would be behind a config option to provide backwards
compatibility for non-container use-cases.

The etherpad notes are at [2] (look at "Dynamically Allocated Binder
Devices" section)

Christian Brauner will be sending out more details.

-Todd

[1] https://linuxplumbersconf.org/event/2/contributions/222/
[2] https://etherpad.openstack.org/p/Android

>
> thanks,
>
> greg k-h
