Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D481EC04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 20:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 978BB208B3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 20:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PWKG5jVZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 978BB208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbeJPEUl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 00:20:41 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38564 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbeJPEUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 00:20:41 -0400
Received: by mail-wm1-f66.google.com with SMTP id 193-v6so20918859wme.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 13:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kRilpkKxdy6EsiloWAQteo136yREEzdz1jb351bL4GM=;
        b=PWKG5jVZb6O/MHoCeGdv9ebrr8lq6gMoa4V3ugTgKuUb8ZGsZ2dh6R3l9XzM/eE10J
         1A6pbjfjNX8roJqhEPZBPMER+kuBrBhQg84R+2p0iEMNieYWfOq5PLJCmh68+cFFf1V3
         PY/zBJuFFPo21V0Jd2z1aEO/L3j8XfIe423DWjck+9t3cieqWmhu85lknRpeDKEUTgvQ
         0ZIumKzZNCQkpA7qlcOhx6sAVEd7QE5X8VjjI6rRySZi9U55Zs+/IMB34axuaUzxuQIU
         G/4Qy8GuEZCKxF2G9os8n5+642SAHdRvMo6oiEYJ1fcgCyiCV/2yCESgC1FeZTuwhrcu
         yOJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kRilpkKxdy6EsiloWAQteo136yREEzdz1jb351bL4GM=;
        b=AVa1rkkpDEpNoKMYwVloa7YQI1Fr2e2lopmYQS2X0LMpkGouHCsMqtTH0s9hznNSz0
         tzc5PqyldEHhqTxPIRvH6kJis9wwoO7uNbPnIA5PoloTRzQukKdrmOpjngJpXo1vAd8g
         k4SSWlz8yhDBGBZ9BjNWp8bTUnsApzxHLbVMlgmodZx+JLod0zs08OOBNtm6tTduzWNp
         zzuvqxYPLtOQa/E5bKUbDDjz+mu20DB9TjL4+wm/bgkZqK8MIeT47XDGLscrnXusDVh+
         LC86vvHr+u6C79VFk3S5Mki/3oz0P//0FBq7JFuXev7IFsNa2MitdpC7orHMvdm1o7LU
         0YSA==
X-Gm-Message-State: ABuFfohvsvgI7UZIg6O3L7HvVHsLal7/xFG8R3Ii+XV2EGSwrZR2w9Tz
        htNL/ouJPxmztYRuUVTuNUBz0aVoCJg6qjlUze8CMQ==
X-Google-Smtp-Source: ACcGV63nuq/m8D+DClvBkEIQEydVhDfw5HvkfNcvBtpcCrofeOlc9pTNLPuRxQinPppJRGVSWOIMBfHFc054desU5Bg=
X-Received: by 2002:a1c:58f:: with SMTP id 137-v6mr14732077wmf.37.1539635628175;
 Mon, 15 Oct 2018 13:33:48 -0700 (PDT)
MIME-Version: 1.0
References: <20181015045927.156790-1-toddpoynor@gmail.com> <20181015045927.156790-2-toddpoynor@gmail.com>
 <20181015073436.GC14476@kroah.com>
In-Reply-To: <20181015073436.GC14476@kroah.com>
From:   Todd Poynor <toddpoynor@google.com>
Date:   Mon, 15 Oct 2018 13:33:35 -0700
Message-ID: <CAAW3YpYHo=PZk_AHVD8O6E+D+Ky=LSQpWQ6gBPYCt5rRGEMXXQ@mail.gmail.com>
Subject: Re: [PATCH 01/11] staging: gasket: core: debug log updates
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "toddpoynor@gmail.com" <toddpoynor@gmail.com>,
        Rob Springer <rspringer@google.com>, benchan@chromium.org,
        devel@driverdev.osuosl.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 12:34 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sun, Oct 14, 2018 at 09:59:17PM -0700, Todd Poynor wrote:
> > From: Todd Poynor <toddpoynor@google.com>
> >
> > Add debug logs for device enable/disable events,
>
> Why?
>
> What is going to need this?

As one of the few people actually developing for Apex chips (but this
may be more soon), I ran into a situation where I cared about this.
But I usually cobble together custom debugging for development
situations, and generally don't get debug logs for
released-in-the-wild drivers, so I'm fine not including these or any
other debug logs.

It sounds like debug logs face a pretty high bar for acceptance.  I'm
happy to send a patch removing all of 'em from gasket/apex if that's
preferred.

> > remove logs for
> > callbacks (the called functions can generate their own logs if needed).
>
> That's a different thing than "adding" them, so shouldn't this really be
> 2 patches?  If it was, I could have accepted this patch already, and
> ignored the "add new logs" one :)

Sure, the callbacks most frequently occur during disable/enable events
and were linked in my brain, but will send a new patch to just remove
the useless callback logs.

>
> thanks,
>
> greg k-h
