Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E114C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 22:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20BAE2081B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 22:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hb8Wql21"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20BAE2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbeKBHtk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 03:49:40 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:53063 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727645AbeKBHtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 03:49:40 -0400
Received: by mail-it1-f195.google.com with SMTP id r5-v6so808966ith.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 15:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C86infv4Nu9WWba+HJ9Xwkr8kCyH2cmtkPC1zUdk5ns=;
        b=hb8Wql21P5nSR/BUTIEQIzPuYfPRVNzsHVB1jFodVDEtf3pzczi5wF5zBZoUn2quv2
         EowFeTpeyTT9Z9jHllTmI9sS2QQBVydch+/3T/MiOhOLbmjLsczwMcnoNGTOzHnZMMtq
         JEQlr0zWUDyCAnK6b5duh4pWxMn4XdOF5T34E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C86infv4Nu9WWba+HJ9Xwkr8kCyH2cmtkPC1zUdk5ns=;
        b=W9nYsr+1i1vsXKvL73c1hIWtbWwFxRe/3pbKrfL6tO91UoYeZvwzaF6HnQAQ0i3Jlk
         9a463+Z8gYWR+uCUkmXFtjzMd6F5OST69w3iigZrVRDGinnxF5jFd9kd9FFE1JmilfvE
         d0xUtxkjVsRJTN9v6uA9ivTQj36vBuGcn78yAvC40dGxX7QL8BLyidI0pimXPkfPWl6j
         vFs5thb9vfyqYdnv4+fSX27pWchUyOrQtcYNGOixKdNFEcNjanUz7q7FgvY6VSxDl4NG
         +4Q/TbY/c1qHbl14FjdJNFhAMtPIDFPR8+H3jNw5XGHS+ltUb7HFiMpda7T1TqSUCcD4
         h7iw==
X-Gm-Message-State: AGRZ1gK2UqosmTefJnM1lM4W7S4Ya7KDtX8qX0Yb+AXRE1DxZzwcKec4
        b3lGUTpyYgUF3tX1DdWgqok+lzMq54JATYZNcoJw6A==
X-Google-Smtp-Source: AJdET5caSfH+8sB5FdCX/Ice5v22q7VrooJ0qhfXkwUgIuM+jNStOZXdVk699I8xpuF2U2G6o/qYVASxH3V6LTgCT9U=
X-Received: by 2002:a24:d602:: with SMTP id o2-v6mr7983548itg.71.1541112282305;
 Thu, 01 Nov 2018 15:44:42 -0700 (PDT)
MIME-Version: 1.0
References: <20181030230624.61834-1-evgreen@chromium.org> <1540943443.196084.131.camel@acm.org>
 <CAE=gft4xwXuJ=aHbF08SxFxtSRX_6KBzPHxCCMbA6F7RnGQ8jA@mail.gmail.com>
In-Reply-To: <CAE=gft4xwXuJ=aHbF08SxFxtSRX_6KBzPHxCCMbA6F7RnGQ8jA@mail.gmail.com>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Thu, 1 Nov 2018 15:44:31 -0700
Message-ID: <CAPUE2uuhfk7kstwO2kp_Rs=9QQPgGQGY+QqR76zpZpTkKp5Mig@mail.gmail.com>
Subject: Re: [PATCH 0/2] loop: Better discard for block devices
To:     evgreen@chromium.org
Cc:     bvanassche@acm.org, axboe@kernel.dk, asavery@chromium.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 1, 2018 at 11:15 AM Evan Green <evgreen@chromium.org> wrote:
>
> On Tue, Oct 30, 2018 at 4:50 PM Bart Van Assche <bvanassche@acm.org> wrote:
> >
> > On Tue, 2018-10-30 at 16:06 -0700, Evan Green wrote:
> > > This series addresses some errors seen when using the loop
> > > device directly backed by a block device. The first change plumbs
> > > out the correct error message, and the second change prevents the
> > > error from occurring in many cases.
> >
> > Hi Evan,
> >
> > Can you provide some information about the use case? Why do you think that
> > it would be useful to support backing a loop device by a block device? Why
> > to use the loop driver instead of dm-linear for this use case?
> >
>
> Hi Bart,
> In our case, the Chrome OS installer uses the loop device to map
> slices of the disk that will ultimately represent partitions [1]. I
> believe it has been doing install this way for a very long time, and
> has been working well. It actually continues to work, but on block
> devices that don't support discard operations, things are a tiny bit
> bumpy. This series is meant to smooth out those bumps. As far as I
> knew this was a supported scenario.
>
> -Evan
> [1] https://chromium.googlesource.com/chromiumos/platform/installer/+/master/chromeos-install

The code has moved to
https://chromium.googlesource.com/chromiumos/platform2/+/master/installer/chromeos-install
but the idea is the same. We create a loop device to abstract the
persistent destination. The destination can be a block device or a
file. The later case is used for creating master images to be flashed
on memory chip before soldering on the production line.
It is handy when the final device is 4K block aligned but the builder
is using 512b block aligned device, we can mount a device over a file
that will behave like the real device we will flash the image on.

Gwendal.
