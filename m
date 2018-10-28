Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C58FECDE44
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 04:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB3DF2064C
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 04:13:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rwzs6m7q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB3DF2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729166AbeJ1M5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 08:57:08 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:36431 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729139AbeJ1M5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 08:57:08 -0400
Received: by mail-yb1-f193.google.com with SMTP id w16-v6so2104793ybp.3;
        Sat, 27 Oct 2018 21:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E+GNb2D0Xr4UPoDRdzzdgkTZ2b1Cr93Gxymr9JZWU2w=;
        b=Rwzs6m7qEA/pbgjj9sIvcF/Pws6HKm+jH/o+GP370Ij9OTN+tL4IvI3HPjAHT8G+df
         UwuZE3UVRRufY7NvBATLl81vmf9z2yGfLqvAFoRxYZYpgAf4xfMf167rVsCog0hwVSf9
         iDkYq/AhvouGOWqM6hfHzXyoWn8TyG0fuMAB+HIFnS7ZmyjP8pKopk4LDWujMlabDr1f
         p1YTYTP7xwSHX3eGSU3Yk2BgNcg4fxLpUjI7yoHLpahNT3RjUYWFWoMvmTmsZ2rp98xX
         VqOp+iFq5JkZsGzEeTR7gKMjklChXmn9F584di+wrulBPbq1onZgbMgmxoDo6P2TUweb
         LSYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E+GNb2D0Xr4UPoDRdzzdgkTZ2b1Cr93Gxymr9JZWU2w=;
        b=rMPUSbQYokHN0g5NXfy6o/fIBLAlUCTI9bvAqUaGhxEwSogJelPK2rEkAAuumA0mPl
         KPqOJKcumQUmC9/xkuQ2f1Xd7l2lK7MgSD/AXGxz8AUHvFBXIyROEsnFRG1LSqHkEiD9
         iSI/uqXMa+3pCzNF5TaTSEnkk8PUg7WUMmHL1pF5rsrfWT0vyHpSWub0JsENhBNsAeC7
         S84ReTV4AuomeKsX0Z12dmrYDjomopeWm6mvs7XVVJLnM9It1M41MHVOfDyNIesaGo8N
         ZHU9utGfULQu4PjQ9hJ7M7jcDw8xWR3ZWfeAIy9aOubN0I3khJmS+YcZg0zXRq3r6hmf
         3saw==
X-Gm-Message-State: AGRZ1gLNNyDvRnFYvJ/XRjg7lAK0n94kZDP2SvhSYw45M07yc4G+6CEr
        c6FJSNsO3Z6v6G7UL3A18zOA+mpYb2xC1sXJU98=
X-Google-Smtp-Source: AJdET5c0n3DmkKBRc5gDrKQTh9Vjq/esfAm9rjkm23y7S7fNFldG+uJyJNV2gef+i9QhLezh8RvrKUw4QmbdhrcldkU=
X-Received: by 2002:a25:acc2:: with SMTP id x2-v6mr9054783ybd.37.1540700027122;
 Sat, 27 Oct 2018 21:13:47 -0700 (PDT)
MIME-Version: 1.0
References: <20181026134516.1234-1-diego.viola@gmail.com> <3d9dd60b-7bfe-bc1c-b971-0935a84dcf45@kernel.dk>
 <CA+ToGPHR7s4kTKdSh3rpjvxPQN+Y+Qfv=vT2icJ1Gh55X3-mTg@mail.gmail.com>
In-Reply-To: <CA+ToGPHR7s4kTKdSh3rpjvxPQN+Y+Qfv=vT2icJ1Gh55X3-mTg@mail.gmail.com>
From:   Diego Viola <diego.viola@gmail.com>
Date:   Sun, 28 Oct 2018 01:13:35 -0300
Message-ID: <CA+ToGPFMgT2co9c+QWN=7etS9w0OaRfUz69hduOn5rRvMwdsbg@mail.gmail.com>
Subject: Re: [PATCH v3] libata: Apply NOLPM quirk for SAMSUNG MZ7TD256HAFV-000L9
To:     axboe@kernel.dk
Cc:     hdegoede@redhat.com, tj@kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 5:36 PM Diego Viola <diego.viola@gmail.com> wrote:
>
> On Fri, Oct 26, 2018 at 11:21 AM Jens Axboe <axboe@kernel.dk> wrote:
> >
> > On 10/26/18 7:45 AM, Diego Viola wrote:
> > > med_power_with_dipm causes my T450 to freeze with a SAMSUNG
> > > MZ7TD256HAFV-000L9 SSD (firmware DXT02L5Q).
> > >
> > > Switching the LPM to max_performance fixes this issue.
> >
> > Applied, thanks.
> >
> > --
> > Jens Axboe
> >
>
> Jens, Hans,
>
> Thank you.
>
> Diego

Hi Hans and Jens,

I just wanted to give you guys an update about this problem.

I've managed to update my SSD firmware to the latest version[1].

For running the update, I've had to install Windows 10, ran the
firmware update, remove Windows and reinstall Arch Linux.

The latest version of the firmware is DXT04L5Q, and it looks like
there hasn't been a new update since 2015.

I'll be running with med_power_with_dipm and hope this firmware update
fixes the problem, if it doesn't and I get another freeze, I'll send
another patch blacklisting the drive completely. Is that OK?

1. https://support.lenovo.com/br/en/downloads/ds038904

Thanks and Best Regards,
Diego
