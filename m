Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5598AC43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 17:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1044320658
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 17:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UCuKlGIH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1044320658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbeIBWMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 18:12:07 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:42085 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbeIBWMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 18:12:06 -0400
Received: by mail-io0-f171.google.com with SMTP id n18-v6so14211503ioa.9;
        Sun, 02 Sep 2018 10:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nyhWyYVLeXxsm5jta3Rs0eGxTrHuILH40AqO8R7l5G8=;
        b=UCuKlGIHQJBOsOH6kzcP85bWXlCKGBk7RJRdrBefQ1Iy/cezySZhXw58+qrQRAynUM
         iO4w7QLt2+OUUClvFAZZ9/3mFOOlLQp1mb/oCdK+h+v90TWguGn1Q15TaqWbqBLlkvv0
         YanOOTWttuSvSlKG+sWR5+34XKYTeQfWmhLNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nyhWyYVLeXxsm5jta3Rs0eGxTrHuILH40AqO8R7l5G8=;
        b=ZmLK0fDjFD7J+K2iO/+uMTZkcPLSNZdok19aGY4mxMXIuZ3AZsuXSqs87pOgzDqd1r
         0LuAEq/QyuYVN5geC9tUSjnWWHIL7pz1Tzrcw2RxxUuUFm7A4UwNM/gjlqjBSfZvVClI
         mA/fye+ezA6f3gd6+XEEFl+tWtAtgyni7uyWtSzFWow3Hr69yJen+nzqpR8p0BhwAizI
         V28TuHT/9IKGriEXPZCpN1RgySHJi0bDh85DxIiZ3kHRHSRhNNzcd5lpYknC8YoRgt+i
         8a0glyR+8TBGZ6nJlcXO9NCJ/ZCD8E7M7TcWYfFCZGEmRaq3Fj1L2s+hMSi/RlzYkZpO
         CQrg==
X-Gm-Message-State: APzg51AuUYSO01on6oda4BVkL8oiaOM929T81OC5gbNWw/Ga29vrj2lv
        4HK7rmAQ0Lhyy7bAZo7tXEaYCoz4EbHDSmt1Quw=
X-Google-Smtp-Source: ANB0VdbqWP3fze1KywF4onC0F+2xxQbPEn6EjuoyxMV02vqw9X115gDO4Hb3yfcHdigLthA7YzN/xeG8qj/UJWX5AKY=
X-Received: by 2002:a6b:7a49:: with SMTP id k9-v6mr18245282iop.238.1535910932112;
 Sun, 02 Sep 2018 10:55:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAOuWhkaGjX8Q_xghkFVTqzZkDrUv-sdH=VbS7hvnqFWrT+3eOQ@mail.gmail.com>
 <CAFLxGvxX8QW4wUJKommXVMpGBj7G_H3=SOwQGjGuyPZZrhCzKw@mail.gmail.com>
In-Reply-To: <CAFLxGvxX8QW4wUJKommXVMpGBj7G_H3=SOwQGjGuyPZZrhCzKw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 2 Sep 2018 10:55:21 -0700
Message-ID: <CA+55aFyLC8PhjZ+iV7MucSZ1aGKMT=S9=EkEAQ6T1=ZRqD-xLA@mail.gmail.com>
Subject: Re: Recent removal of bsg read/write support
To:     richard -rw- weinberger <richard.weinberger@gmail.com>
Cc:     drorl@infinidat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 2, 2018 at 4:44 AM Richard Weinberger
<richard.weinberger@gmail.com> wrote:
>
> CC'ing relevant people. Otherwise your mail might get lost.

Indeed.

> On Sun, Sep 2, 2018 at 1:37 PM Dror Levin <drorl@infinidat.com> wrote:
> >
> > We have an internal tool that uses the bsg read/write interface to
> > issue SCSI commands as part of a test suite for a storage device.
> >
> > After recently reading on LWN that this interface is to be removed we
> > tried porting our code to use sg instead. However, that raises new
> > issues - mainly getting ENOMEM over iSCSI for unknown reasons.

Is there any chance that you can make more data available?

I'd rather fix the sg interface (which while also broken garbage, we
can't get rid of) than re-surrect the bsg interface.

That said, the removed bsg code looks a hell of a lot prettier than
the nasty sg interface code does, although it also lacks ansolutely
_any_ kind of security checking.

> > Because of this we would like to continue using the bsg interface,
> > even if some changes are required to meet security concerns.

I wonder if we could at least try to unify the bsg/sg code - possibly
by making sg use the prettier bsg code (but definitely have to add all
the security measures).

And dammit, the SCSI people need to get their heads out of their
arses. This whole "stream random commands over read/write" needs to go
the f*ck away.

Could we perhaps extend the SG_IO interace to have an async mode?
Instead of "read/write", have "SG_IOSUBMIT" and "SG_IORECEIVE" and
have the SG_IO ioctl just be a shorthand of "both".

And have a model that actually checks that "yeah, this command is ok
for a normal user", so that it's actually useful for things like CD
burning etc, without making it a huge gaping security hole that is
only useful for crazy special cases?

Maybe that - otherwise reasonably pretty - block/bsg.c code could be
joined with the SG_IO code that actually understands security issues?

                 Linus
