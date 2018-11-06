Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB0AC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 08:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A09082081D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 08:09:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A09082081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729790AbeKFRd1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 12:33:27 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41704 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729021AbeKFRd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 12:33:27 -0500
Received: by mail-oi1-f195.google.com with SMTP id g188-v6so3998380oif.8
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 00:09:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l7N9Ev3h0AJec1XM+HYht3KAlXtD7sfrjwhPCmBs2qU=;
        b=BGtnKKa+1gUc8ilh5X+MN5+k6X7adUF8V4vBjY3f2qE15UQEa1tFc9a/9GUN3VxB2V
         EACUvH+hHOqN/IAQdO8QybCxITybPSv9G+5LFhWW5rTiIOUoNw0IS6ek7mVD71aLUHQs
         d9PBGn+Q6kwTLAR0+8fQNDjF7YqdCD9UvVRjKhaTHXieSjJrDXCav2As87/UmS9cjj6Z
         tQWx8sLJ4SPlNupaTQVAOmSbRwnr/k7S0QQ0F7hg/1m8NXjFD6Fl3bNOHVPAbSL3Cyn7
         k5qiLSTXac47InQagrP2oFMXPkVwk/D3cL7ANyZM0J/oHwt9DCzj3uHigvLDM9wsaOT3
         yd5g==
X-Gm-Message-State: AGRZ1gJVJd6oePCI/0rH9cnVOrkd6HPeqfyIsRnHaQI5BsLyg1hRWpB3
        ijRg3Ddn/0eaNHhkokRauXCrvRv2ijBWQ+ewIRo=
X-Google-Smtp-Source: AJdET5ejFfzhkWS0td7+N0FSCA582pKFLyhbdTof1N0+N0KQJ+jH5MxFGAl2DJtDDaEZwrWOazCRSZmnuIfwWYX7d1U=
X-Received: by 2002:aca:f3d4:: with SMTP id r203-v6mr13481736oih.95.1541491766520;
 Tue, 06 Nov 2018 00:09:26 -0800 (PST)
MIME-Version: 1.0
References: <1541472103-6212-1-git-send-email-tsu.yubo@gmail.com>
 <CAJZ5v0gzM+_a+HJa_kjpgaj96iiH3f_x1ZXjK3HE8=E5FvuAPA@mail.gmail.com> <932e46a701ebe9b3b33a110d187880eda14c23fb.camel@perches.com>
In-Reply-To: <932e46a701ebe9b3b33a110d187880eda14c23fb.camel@perches.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 6 Nov 2018 09:09:15 +0100
Message-ID: <CAJZ5v0ha=+g2bCr+0Xf47bh-fr66woJfhubd7guc-Dr-xC9x1g@mail.gmail.com>
Subject: Re: [PATCH v2] kobject: to use pr_warn replace KERN_WARNING
To:     Joe Perches <joe@perches.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, tsu.yubo@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 6, 2018 at 8:58 AM Joe Perches <joe@perches.com> wrote:
>
> On Tue, 2018-11-06 at 08:49 +0100, Rafael J. Wysocki wrote:
> > On Tue, Nov 6, 2018 at 3:42 AM Bo YU <tsu.yubo@gmail.com> wrote:
> > > Fix warning form checkpatch, use pr_warn replace KERN_WARNING
> > >
> > > Signed-off-by: Bo YU <tsu.yubo@gmail.com>
> >
> > First off, IMO, you should not change the existing code just in order
> > to make checkpatch happy about it.  That alone is not a good enough
> > reason for modifying it.
> >
> > If the checkpatch warning indicates an issue like broken white space
> > (and I mean really broken and not lines longer than 80 chars etc),
> > then that may be a reason to modify the existing code, depending.
>
> Existing code is slightly broken.
> There is currently a missing terminating newline in the
> non-switch case match, when msg == NULL;

OK, so this should be explained in the patch changelog.

Saying "I do this to make checkpatch happy" in the changelog is just
not enough IMO (if not outright misleading).
