Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD45C67863
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 02:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FCDE21476
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 02:20:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b8Dx2ekU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FCDE21476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbeJSKYU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 06:24:20 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:39387 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbeJSKYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 06:24:20 -0400
Received: by mail-io1-f68.google.com with SMTP id z16-v6so22223089iol.6;
        Thu, 18 Oct 2018 19:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YowBbCjjF46AlBIdwFCeyEd+5c983UcOdQHEldogT1s=;
        b=b8Dx2ekUxitCeeY3Aug4jkgcqY0IAbE/1JAFIzHrtEyDl1QH315ZmS3mdOzX/wjdQe
         X+3K6Jw16yRmeyqykai0yKU/w22MKSyc32HbgGBQcC87NwZkZzZHTKgsl74SRRbXHu1N
         izexBtsDBsBDl0961izVg6sPQxhGs5Xn/E/OJjdqRPD7uPX5uYqe5yX2s2cHtHBjcaYs
         jhr7zcTLTiuVkolFZdTaUSVqZgtbvO8kudpYQsUipmkx33ZAWvcCKj3BDXnZIpYWzr/v
         BMT3Pr8WEL+LWPnV43lU558mLMs86YRrI735zp0C1rYQtoivqvPv9wpTuvNNhNjMfJYr
         e0TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YowBbCjjF46AlBIdwFCeyEd+5c983UcOdQHEldogT1s=;
        b=lA6tE01yKV5DICI4vFNUj2glYRDdeojZ4McClgoKxNRSc8Gu0UMZ5imiBmu4AmJw/V
         K3I9x6l9/3kL2bVUWkM94AxV4bA/GzPZ3xZPJBK99KIJOmqqmsn7nk5xF6pu0Foty5Ii
         IK7G9OZ8/nzDckQGYEg4mEp6pNJwGcf4X2UUiWTJ/kuGcM4I0UrBjjtOIiw5QhX2wenL
         Wqh7DuxcYQkUJlcqapR1Ru97aFLRr7V7v+PKGHUWn3MlNwYZdw/sBduG0+U/2YWxAJDL
         RJJfpOAgYtHUKQKPGYgg0AMN4UMtwLJJPotKOlGNJ4JwYYll4EgpC8P6JOFwSea11vtG
         lC8A==
X-Gm-Message-State: AGRZ1gJv2VoX3zmTyBxMTQnab80FkJoo5tMeC8h4pWLUVQvWd6LBwhdF
        Xhex74uzyQWtCHMTBp2sj0iu0UycbWXkA4eInN4=
X-Google-Smtp-Source: AJdET5fAr1x5JEIj35+4Tb6voHawQE4gyNXBfPa0L7fLBi6SvsOQFXWDEukh3Ehx7tCxuWCCoWkzLlLIUnMMReeoDdw=
X-Received: by 2002:a6b:e91a:: with SMTP id u26-v6mr1773077iof.200.1539915623559;
 Thu, 18 Oct 2018 19:20:23 -0700 (PDT)
MIME-Version: 1.0
References: <20181015150305.29520.86363.stgit@localhost.localdomain>
 <20181015150926.29520.45280.stgit@localhost.localdomain> <1539886275.81977.17.camel@acm.org>
 <e870da1d-48fa-7f2e-6909-b168a06633f2@linux.intel.com> <1539893636.81977.29.camel@acm.org>
In-Reply-To: <1539893636.81977.29.camel@acm.org>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Thu, 18 Oct 2018 19:20:12 -0700
Message-ID: <CAKgT0Ucf-v3FNTA0z=3nPR-xS=0NYeqDjRfDW-KjDE5Ed-n1_g@mail.gmail.com>
Subject: Re: [driver-core PATCH v4 4/6] driver core: Probe devices
 asynchronously instead of the driver
To:     bvanassche@acm.org
Cc:     alexander.h.duyck@linux.intel.com,
        Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>, len.brown@intel.com,
        rafael@kernel.org, linux-pm@vger.kernel.org,
        jiangshanlai@gmail.com, pavel@ucw.cz, zwisler@kernel.org,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 1:15 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On Thu, 2018-10-18 at 12:38 -0700, Alexander Duyck wrote:
> > Basically if somebody loads a driver the dev->driver becomes set. If a
> > driver is removed it will clear dev->driver and set driver_data to
> > 0/NULL. That is what I am using as a mutex to track it in conjunction
> > with the device mutex. Basically if somebody attempts to attach a driver
> > before we get there we just exit and don't attempt to load this driver.
>
> I don't think that the above matches your code. __device_attach() does not
> set the dev->driver pointer before scheduling an asynchronous probe. Only
> dev->driver_data gets set before the asynchonous probe is scheduled. Since
> driver_detach() only iterates over devices that are in the per-driver klist
> it will skip all devices for which an asynchronous probe has been scheduled
> but __device_attach_async_helper() has not yet been called. My conclusion
> remains that this patch does not prevent a driver pointer to become invalid
> concurrently with __device_attach_async_helper() dereferencing the same
> driver pointer.
>
> Bart.

I see what you are talking about now. Actually I think this was an
existing issue before my patch even came into play. Basically the code
as it currently stands is device specific in terms of the attach and
release code.

I wonder if we shouldn't have the async_synchronize_full call in
__device_release_driver moved down and into driver_detach before we
even start the for loop. Assuming the driver is no longer associated
with the bus that should flush out all devices so that we can then
pull them out of the devices list at least. I may look at adding an
additional bitflag to the device struct to indicate that it has a
driver attach pending. Then for things like races between any attach
and detach calls the logic becomes pretty straight forward. Attach
will set the bit and provide driver data, detach will clear the bit
and the driver data. If a driver loads in between it should clear the
bit as well.

I'll work on it over the next couple days and hopefully have something
ready for testing/review early next week.

Thanks.

- Alex
