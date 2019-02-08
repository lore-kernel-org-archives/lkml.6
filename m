Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D85C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 19:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6819217D8
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 19:53:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMW3w0SQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbfBHTxx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 14:53:53 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:35429 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbfBHTxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 14:53:53 -0500
Received: by mail-ua1-f65.google.com with SMTP id d2so1532720ual.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 11:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=or39wF3ojKTigI7tp9JxJqT+f6MF7PN9oX6LrzVzOjo=;
        b=UMW3w0SQpXNyBSFMQj7raqD/mJllAaESSOaZ3J7k18vvtdj6hTJIuAOLfS3ZkgROnR
         RjQ65ASnd98Mfx7cYg/+8WyOi4PNqUHtxSUGKCB1IOsSVoLM9IGITKAJd88VyzwdEU6t
         PmQ1SHNx0NWYUxxYNq1dgtcQvi4KpaLnAr/YuTpsrwe0RYXbNEM36+vAWMan7Dp5Z5oY
         xolfNSORyw+BuLGHT5cl7cZmQRbh0X+tGawv5FaSu/B34fPCbj/tk6vuNHJ5iyhSJgRy
         M7bMEoC6JGlIw3Q5v3zb/ykmXbfN+mBg/V3RYFhoTJwLEK8diKXlxfzKPnYmEe3btBYr
         Nc5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=or39wF3ojKTigI7tp9JxJqT+f6MF7PN9oX6LrzVzOjo=;
        b=eJf2GiztZOYGSQT7Wrn7c724uNjHdNx0Zls8HXvKD6XAyv4JWXL75EugvmdYswrwgd
         B3ci/0s6t7zle7XRFnOr+fw0Q6QulkXL1s6MGUGcmpev/tK4nJ3h9RAcv+Qw1jrq3li8
         jjqG2M2OZLfY+PMKwg4whgRvxYz/nuhInICoLac6iC+t0pviI3qZ12unx99BU7elVYO1
         QwXFHtcSG7sSv352imsZk0CX8mp1Vp7ir+mvoxAw7G1VYoVLYF/ZCWy/sw1LhRByn5/m
         mS20Z634Ta7Ax8VTA6bRMNSFKmSW8UQirnB0Wdrx2rzECZh1+km5Ik1ZVJ4DbNSMHgDg
         UWwQ==
X-Gm-Message-State: AHQUAuZydtBQx82KKTY6j+nDZGpcuR+LF8MnohseH5vr/BLqar05FD7c
        OHdnCYAUa6jp08fgLtBlJY5WGxalDSFQdLrbeHrLhg==
X-Google-Smtp-Source: AHgI3IYZlDvu3bBq0Le0cqrCtzegWS7X5I//60ewWEWjf+dwDVks3XfJjAuAnrFTQ8SvMAvPeeTolftckjj0wIz+Lik=
X-Received: by 2002:ab0:4e23:: with SMTP id g35mr9162032uah.8.1549655631870;
 Fri, 08 Feb 2019 11:53:51 -0800 (PST)
MIME-Version: 1.0
References: <20190204203254.4026-1-oded.gabbay@gmail.com> <20190204203254.4026-6-oded.gabbay@gmail.com>
 <20190208120639.GA23483@kroah.com>
In-Reply-To: <20190208120639.GA23483@kroah.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Fri, 8 Feb 2019 21:53:27 +0200
Message-ID: <CAFCwf13hn+qEqv_CcR+O8fynUrz9Mma7mKzQr6COv48kTMoO=Q@mail.gmail.com>
Subject: Re: [PATCH v3 05/15] habanalabs: add command buffer module
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Mike Rapoport <rppt@linux.ibm.com>, ogabbay@habana.ai,
        Arnd Bergmann <arnd@arndb.de>, Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 8, 2019 at 2:06 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Feb 04, 2019 at 10:32:44PM +0200, Oded Gabbay wrote:
> > +int hl_cb_ioctl(struct hl_fpriv *hpriv, void *data)
> > +{
> > +     union hl_cb_args *args = data;
> > +     struct hl_device *hdev = hpriv->hdev;
> > +     u64 handle;
> > +     int rc;
> > +
> > +     switch (args->in.op) {
> > +     case HL_CB_OP_CREATE:
> > +             rc = hl_cb_create(hdev, &hpriv->cb_mgr, args->in.cb_size,
> > +                                     &handle, hpriv->ctx->asid);
>
> so cb_size comes from userspace, ok, you check for the value to be too
> small, but not too big.  That means someone can try to allocate too much
> memory, possibly crashing things, not good :(
Yes, correct, but even if I limit a single allocation to, let's say,
1MB, what's stopping a userspace process from allocating multiple CBs
and draining the system memory ? I'm counting on the oom module to
kill that process if it mis-behaves.
And, btw, I assumed there is hard limit of 4MB on a single
dma_alloc_coherent. i.e. I was never able to allocate more then 4MB
through that API. So I never thought I need to check for max size
because of that hard limit.
Am I missing something here ?

>
>
> > +             memset(args, 0, sizeof(*args));
> > +             args->out.cb_handle = handle;
> > +             break;
> > +     case HL_CB_OP_DESTROY:
> > +             rc = hl_cb_destroy(hdev, &hpriv->cb_mgr,
> > +                                     args->in.cb_handle);
> > +             memset(args, 0, sizeof(*args));
>
> Why zero this if it's not copied back to userspace?
Fixed
>
>
>
> > +             break;
> > +     default:
> > +             rc = -EINVAL;
>
> -ENOTTY is normally the "invalid ioctl value", right?
Fixed
>
> > +             break;
> > +     }
> > +
> > +     return rc;
> > +}
>
> thanks,
>
> greg k-h
