Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78493C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 22:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 152762145D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 22:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="c9YIJRtx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 152762145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbeK3JHT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 04:07:19 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35880 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbeK3JHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 04:07:19 -0500
Received: by mail-ot1-f68.google.com with SMTP id k98so3288117otk.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 14:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A4yEFiJ8olDhvQpbipodU07cuIia8QuhLtCquYajzyY=;
        b=c9YIJRtxWZkzRPRb0MOPslQ8GjftUhVNmdLLCaGHCK7yc4VkvYoBOghIwGj8dO0+qN
         snUkP1qjPkPmQgxBe65Vwz6rVrLITs1FhR+xCJg3tVkPrJkSkDex/iSlE7QRMovhUfSA
         xUnMnR0BT1Irmgs7OYP7sJu7pQPc3T2ZjgMDeT/r3V0QIZtoFMaGrg9VrW8+joMgWLJt
         +corkP6kybd9+St9MmajNUqUjwcCikD0/Xlb5oV+IluNzmLH+pMVoZygO2YX3qc45vOq
         0XBiseq4L5U3QyN5Sa4ysaTOIvDgHCAu2i5PU1ogpWJxFfTiLN0NocfLn07DyoQasLmz
         ufKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A4yEFiJ8olDhvQpbipodU07cuIia8QuhLtCquYajzyY=;
        b=aktggLm5+Tq9GcN5XC/BBHWgB6jBp8wGDOGDRDwdUM37mgBWx3hAWllJ1q12cwuWF8
         bM4rBwo+fYwf/gsCsGzHmkEHvUdfmr4EC1YBsckRxBfYBvgAyBqvlYJLWvJ/yCLUhcrE
         GGl5u39BajKfTkCwj5yxi3hIhjFtrqDcgziM8/yMZG+U/3WGCJtm1nFUswYtRRC/NVGi
         0F+qafgHtswq2mYchDuL3ur/U3cYdWw6wUVYkdsgSKdU+glyjIJe0yT/yOCBTJ3G5T8b
         FbVhNgT52CLXYqiocOUa1wRTe3F459G4N79UTTAWh7EeOIZ9CdL2SmeocKj4I6LSy5ey
         HAPg==
X-Gm-Message-State: AA+aEWYBP32KSlS3me/B+RrWoOLx6A5WShL1LIUsUDzxKye7hlDF1wl6
        jkiIVrGM3RdAhpdMnFtvrVsUbnSt85Li+4vBZDWSew==
X-Google-Smtp-Source: AFSGD/VDyr+eSGJ+3A68oeHv7VI5duBsavnxraNSP1uUU3b3lhtwvYBClteyujGal5Q5aPNQZkXEqhzx52WppubzdMA=
X-Received: by 2002:a9d:5cc2:: with SMTP id r2mr2043400oti.367.1543528824531;
 Thu, 29 Nov 2018 14:00:24 -0800 (PST)
MIME-Version: 1.0
References: <154345118835.18040.17186161872550839244.stgit@ahduyck-desk1.amr.corp.intel.com>
 <154345153672.18040.3771035148218843351.stgit@ahduyck-desk1.amr.corp.intel.com>
 <CAPcyv4gMswOJ3VTaY6P7f=iG_jNBKZyynn22CLrEBB13Fq-8vQ@mail.gmail.com>
 <a5b33ae899fc4131abf0f26af33a6c6b7f462431.camel@linux.intel.com>
 <CAPcyv4j2w6ygzuP-vEKPk6NGLCEB6FcKTVFQkUqr3HC471xJsg@mail.gmail.com> <53173cf971f5fbd33d744a1734dda87cb66c4206.camel@linux.intel.com>
In-Reply-To: <53173cf971f5fbd33d744a1734dda87cb66c4206.camel@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 29 Nov 2018 14:00:12 -0800
Message-ID: <CAPcyv4gJvjB-tWwW65q5uXW7xABZ0WmfSNVHG5C437MgoEC+QQ@mail.gmail.com>
Subject: Re: [driver-core PATCH v7 2/9] driver core: Establish clear order of
 operations for deferred probe and remove
To:     alexander.h.duyck@linux.intel.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        jiangshanlai@gmail.com, "Rafael J. Wysocki" <rafael@kernel.org>,
        "Brown, Len" <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        zwisler@kernel.org, Dave Jiang <dave.jiang@intel.com>,
        bvanassche@acm.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 1:54 PM Alexander Duyck
<alexander.h.duyck@linux.intel.com> wrote:
>
> On Thu, 2018-11-29 at 10:55 -0800, Dan Williams wrote:
> > On Thu, Nov 29, 2018 at 10:07 AM Alexander Duyck
> > <alexander.h.duyck@linux.intel.com> wrote:
> > >
> > > On Wed, 2018-11-28 at 17:57 -0800, Dan Williams wrote:
> >
> > [..]
> > > > I think the flag should be named "cancel" and set it in the
> > > > device_del() path. Otherwise this is encoding code flow state in the
> > > > struct rather than device-state that the code needs to comprehend.
> > >
> > > Instead of "cancel" what would you think of "dead"? In my mind once we
> > > call device_del we are essentially working with a dead device object so
> > > that might make more sense in terms of a state rather than "cancel"
> > > which doesn't really tell us what should be canceled.
> >
> > That sounds good to me.
> >
> > > Looking over the code I could probably set it before we start calling
> > > the notifiers for BUS_NOTIFY_DEL_DEVICE. The only thing I am not sure
> > > about is if we would need to add any sort of synchronization primitives
> > > around it.
> > >
> >
> > I think it needs to be something like a barrier:
> >
> >     dev->dead;
> >     device_lock();
> >     device_unlock();
> >
> > ...where you can be sure that anyone after that device_unlock() has
> > acted on dev->dead, or will see dev->dead.
>
> Actually what I think I will do is set dev->dead to true with the
> device lock held at the start of device_del. So something like:
>         device_lock();
>         dev->dead = true;
>         device_unlock();

Yeah, the lock is needed anyway since it's a bitfield.

> It seems like that would probably make the most sense and be consistent
> with the handling of other bits such as dev->offline. It means adding
> one more call to device_lock/unlock but it guarantees that the update
> behavior is consistent with the other bitfields near it and that we
> cannot have an asynchronous probe routine trying to run while we are
> tearing out the bus/class/sysfs from underneath the device.

I think that last statement

"guarantee that the update behavior is consistent with the other
bitfields near it and that we cannot have an asynchronous probe
routine trying to run while we are tearing out the bus/class/sysfs
from underneath the device."

...would be good to include as a comment when setting 'dead' to true.
