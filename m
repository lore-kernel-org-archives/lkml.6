Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22505C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 10:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9C992081C
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 10:25:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9C992081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbeK2VaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 16:30:18 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46721 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbeK2VaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 16:30:17 -0500
Received: by mail-qt1-f195.google.com with SMTP id y20so1303480qtm.13
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 02:25:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+0GdSe67bskA+Gl1Qzc2d7U1CLwOD7SMS8W7R/YIAc8=;
        b=QXg99X3bRf2N+SE0WReAVpu2LF2Ml0OfN6QLH8U5gi7ZBSRAtjSbhCRc5aS5MGKucg
         pyjg47EodWLfpINT88lDuiqLVk8KBWsphwKBAK/rDPFC87J5BfEUO2qi6ICTY2csyfeR
         owRqCZsz52v+ZqyZLZwibG7BnJhEG3XG9JIK23SwFKlcQQjg7PTLIf7Q+wbftmNbDFM/
         Lr7nXECZ2RTEIBri7Co2cpH7aohsSBLPK64MZww9fj+UrdBNZQHDVryOfPYQa7FXlxMH
         BaMkhoxkClbuO4I/uorPBWGmQWM/p3q4kvcVVUs2ZwGK+zUNPbJsaFg4gPritn0QpHHW
         6KWg==
X-Gm-Message-State: AA+aEWa4n/Y3Nu+x7v8VtL2bmllgWnjq5kNzF2izK0LYp3n13SvwhZqZ
        C511/GFnUjx6IeJaWAlBqkE1nU3w5kPIsvm85fdNnZoFMTI=
X-Google-Smtp-Source: AFSGD/UFCJgGStljPgJiuVxu5ol03J9m0S0k6x2arGpe0Pb5oklamqZYnqSeFRfkEUSFz6JTMUVFrdVCdBH8Qu5rIAI=
X-Received: by 2002:ac8:2f98:: with SMTP id l24mr706975qta.83.1543487125025;
 Thu, 29 Nov 2018 02:25:25 -0800 (PST)
MIME-Version: 1.0
References: <20181122063409.15816-1-peter.hutterer@who-t.net>
 <CA+jURcuGGRtyeRXfLK0Or=hDG6KJ1z9eAS8DAuH12-QTNpgs0w@mail.gmail.com> <20181129042722.GA5872@jelly>
In-Reply-To: <20181129042722.GA5872@jelly>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Thu, 29 Nov 2018 11:25:12 +0100
Message-ID: <CAO-hwJ+eFJduSuORm8GavKjtsfV4tqkEGC5-cao0_yhkVbKfwg@mail.gmail.com>
Subject: Re: [PATCH 0/8] HID: MS and Logitech high-resolution scroll wheel support
To:     Peter Hutterer <peter.hutterer@who-t.net>
Cc:     hcutts@chromium.org,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 5:27 AM Peter Hutterer <peter.hutterer@who-t.net> wrote:
>
> On Wed, Nov 28, 2018 at 03:22:14PM -0800, Harry Cutts wrote:
> > On Wed, 21 Nov 2018 at 22:34, Peter Hutterer <peter.hutterer@who-t.net> wrote:
> > > [snip]
> > > Devices tested:
> > > - Microsoft Comfort Optical Mouse 3000
> > > - Microsoft Sculpt Ergonomic Mouse
> > > - Microsoft Surface mouse
> > > - Logitech MX Anywhere 2S
> > >
> > > The following devices were tested for the HID feature and didn't have it:
> > > - Logitech G500s, G303
> > > - Roccat Kone XTD
> > > - all the cheap Lenovo, HP, Dell, Logitech USB mice that come with a
> > >   workstation that I could find in the local office
> > > - Etekcity something something
> > > - Razer Imperator
> > > - Microsoft Classic IntelliMouse
> > > - Microsoft Surface Mobile Mouse
> >
> > I just tested the patches with the Microsoft Comfort Optical Mouse
> > 3000. I also tested with the Microsoft Surface Precision mouse [0],
> > and like the Surface Mobile mouse it didn't seem to report the HID
> > feature (at least, it was only reporting REL_WHEEL_HI_RES changes of
> > 120 in evtest).
>
> IIRC that's the same mouse benjamin has and it does have the HID feature, it
> just ends up reporting the same number of clicks anyway so there's no
> visible effect. Which in itself is a good sign for the patch series, I
> guess ;)
>
> > For the series:
> > Acked-by: Harry Cutts <hcutts@chromium.org>
> > Verified-by: Harry Cutts <hcutts@chromium.org>
>
> thanks, much appreciated.

Thanks everyone.

Just a small note that there is a mess up in Peter's series that he is
already aware of: patch 6/8 depends on 8/8 so there is either a small
refactoring to do or change the order of the patches.

I also have asked Peter to look for regression tests in hid-tools[0]
before I can merge this. FWIW, I am putting together a CI system that
will run this test suite for every submitted patch (plus a few other
tests). But the test suite simply lacks basic wheel testing, so it's
hard to see regressions :)

I should be able to apply the series in the next following days or
next week I think.

Cheers,
Benjamin

[0] https://gitlab.freedesktop.org/libevdev/hid-tools/
