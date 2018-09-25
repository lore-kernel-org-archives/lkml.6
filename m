Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02278C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACDCE206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JGLZJll+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACDCE206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729553AbeIYVZ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 17:25:27 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:55018 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729421AbeIYVZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 17:25:27 -0400
Received: by mail-it1-f193.google.com with SMTP id f14-v6so15885496ita.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 08:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8UUVAD38hGnTglp3buGNXoMwy7QMXgBYYcNuRYSqpRg=;
        b=JGLZJll+czTPgaBaV87eg6dLFY14RU2lwP08uYgPpYq1pBJUaKBVSPiawJ1jgZZPrk
         3fRprBefZVHu6XpWSnM19MPk8iCWdoenXNepI9dQP6epgiJozZuCOqEaT45puuldP/Go
         c4Wr12jCGGvN13I3glgmTutHgJ6Nr+3YnZ1pYE2eujDJM/5JVWMbCBYc5m17yc7gn3Ih
         Eln1bHdTAajvNWAOLG2REAUxM+YNYQd1p31rKwzSrmIT3xNlu1383fGNJCq0LlrKRWhx
         ASyPEDZWpZGBsedy6qxfMkgFmKJhlfzVmcMtASR1l88p+P6R/vZkbSkPibLPredNO+6K
         lWZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8UUVAD38hGnTglp3buGNXoMwy7QMXgBYYcNuRYSqpRg=;
        b=Gb05afzjUoyYcn7Tx1849e8UiYd5Qn98FXoUgeugJP6fRLs3oqYUjB805gWvamq/v6
         K7+kZLxfQBu0s6sbTMUgUotD3WmQzO/5kh9Fakmu9uuAo4ml3Qr2HFTdI08qTCM/BFnu
         TnYYWqd0Q/d/cTMnQI9d4/SkV/dw24oWcZyuO7rOzEZRr5pCpbjGkDDyBVgSjV/bfBYb
         7P/N/aU8eh53HQzNEBi/RmMM3vee/KKOBq/tUGKZoA+cCZuzNVqCv4QqnMMg3CAhZ6zg
         qIc1/YnJCExgVnjFueU4w1ha77iXrb0ChcSKovazW2q0tuPNtqI59dV6cL4yYVd4Ua+J
         8WZA==
X-Gm-Message-State: ABuFfoji6d5stX84i/V2PcA8jPFHV2UHkweqCWQZYcYCFkVBGgKVA6ui
        jX1eUbGcrN6oXwlE2r3vIkJ/4QZg9F3JWZobylmJsw==
X-Google-Smtp-Source: ACcGV62aWNXHkLlUurzO/qf93x5LeJXjTofVaDOzuJm2V+hJfjSRBamBjD0hFZPxUnYWnaXY5BCSiR3zLtXopiju9Qs=
X-Received: by 2002:a24:be8f:: with SMTP id i137-v6mr1186222itf.113.1537888649681;
 Tue, 25 Sep 2018 08:17:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:3d47:0:0:0:0:0 with HTTP; Tue, 25 Sep 2018 08:17:29
 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.44L0.1809251110170.1517-100000@iolanthe.rowland.org>
References: <13984886.16016319.1537887354102.JavaMail.zimbra@redhat.com> <Pine.LNX.4.44L0.1809251110170.1517-100000@iolanthe.rowland.org>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 25 Sep 2018 17:17:29 +0200
Message-ID: <CAAeHK+weYa=d=dSgCJ0o6dZBAxBakeAy2hodHhuPSeTr3iesuA@mail.gmail.com>
Subject: Re: [PATCH] usb: usbfs: fix crash in check_ctrlrecip()->usb_find_alt_setting()
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Vladis Dronov <vdronov@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver Neukum <oneukum@suse.com>,
        Hans de Goede <hdegoede@redhat.com>,
        syzkaller <syzkaller@googlegroups.com>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 5:15 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Tue, 25 Sep 2018, Vladis Dronov wrote:
>
>> > What reason is there for having two different fixes for the same bug?
>> > This one isn't going to get into any mainline trees that don't already
>> > have c9a4cb204e9e.
>>
>> I believe this is the right thing to do, so usb_find_alt_setting()
>> is not called with a known-bad argument.
>>
>> Honestly, I would change "if (!config)" in usb_find_alt_setting() to
>> "BUG_ON(!config)" so we know when its callers do smth wrong and go
>
> (You'll be lucky if Linus doesn't see that.  He yells at anybody who
> suggests adding BUG_ON for anything that doesn't completely crash the
> kernel.  The basic problem is that "BUG_ON" is not a good name: That
> routine doesn't really report bugs; instead it brings everything to a
> halt in situations where the kernel is unable to proceed.  In practice
> this tends to make actual debugging more difficult.)

What about adding a WARN_ON()? It doesn't crash the kernel and it will
be detected and reported by syzbot.
