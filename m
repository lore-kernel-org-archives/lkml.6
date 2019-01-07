Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A959BC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 22:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 767FC2147C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 22:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C6zk2l22"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbfAGWlk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 17:41:40 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37030 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfAGWlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 17:41:40 -0500
Received: by mail-oi1-f193.google.com with SMTP id y23so1764560oia.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 14:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I6QD3wLcW1YmZ/cdQnhEAcvJ1nWOL/rceIugyNTL+2E=;
        b=C6zk2l22goz0ViBty0cM/rWBGX3hC3F6mev8zriX3VCaoVqBaXLE0G5y1IzYj4C7g0
         xYD0ioCnWTYhZzMME+NEdSe5jIcL5onViRa969mcfF/N7BcKqEV/sdCdoN6Y3DwsdnWv
         eeUQmAuB557KTaLSjIBDtCwCh/AnQTzGQ1Zd2H1Pia5ll1rajT0PjYKovvih5navFq4J
         cY2kwk+rSvkQLSE+W3g5XAvq+Doy5y3KqqIa2ZGSa1/Jdw1OZb8MtzXqKYHPYDAakxyA
         llLi6iXVnp1pQrIFnFoyYUqWazXV83VC5dzKMkczkifd5WuGDTJEA3yFsIOTSxsdA+2O
         Xq6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I6QD3wLcW1YmZ/cdQnhEAcvJ1nWOL/rceIugyNTL+2E=;
        b=dI6ZdLH3+ckyQJG9z2HLdUlb6ivdAv6T9TPeO9M/zuk1X5AWq6mp+nlijaV0WGW4SC
         7fv2pkqDTwyxZJRU6yi+/eswsvywJdfVOyT+Vogampz5kzc8L+TB1fbyu782c+jp0MUT
         EYIIIq4RkBxsSCGwqbDq98//nSAHAwEoSdI2TAPlC5fmJ4UnV+sezxlafrIjaDVuhUB7
         l564QcTEAsBKkZFtvFbZJe+Ar8RJWrNBS34Rca9Tf6KrtXM8iFifzfSxuqx3389E+lq3
         Z+SFIlSG1rRL9FARffG0P3aMkGWedh9ZDa3naL0fAsupSy9cNMMjDhlD1UHaI8cDfM6g
         axuA==
X-Gm-Message-State: AJcUukcqF5QND4QuiEAxHinggKZdxvx2De3ESaWKJu1qWM9LV5gfW/m5
        IRpMyqcJGlLi8Y9SWGhyY7PoZehVZ50glVBOqYzh+w==
X-Google-Smtp-Source: ALg8bN65dHCIndLjClRO8uVbpK0GPRgwawg1TDOpADKKU/5Awjepo4pI8dMWRGbCDhv7kqFSiapjZsCWch3DOOcBLAM=
X-Received: by 2002:aca:6952:: with SMTP id e79mr9690831oic.117.1546900899006;
 Mon, 07 Jan 2019 14:41:39 -0800 (PST)
MIME-Version: 1.0
References: <1546873978-27797-1-git-send-email-longman@redhat.com> <20190107223214.GZ6311@dastard>
In-Reply-To: <20190107223214.GZ6311@dastard>
From:   Daniel Colascione <dancol@google.com>
Date:   Mon, 7 Jan 2019 17:41:28 -0500
Message-ID: <CAKOZueuHGg=F8se1AQqswZWCEco=ScmudWq5X5s1qS4+LCtgWw@mail.gmail.com>
Subject: Re: [PATCH 0/2] /proc/stat: Reduce irqs counting performance overhead
To:     Dave Chinner <david@fromorbit.com>
Cc:     Waiman Long <longman@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 7, 2019 at 5:32 PM Dave Chinner <david@fromorbit.com> wrote:
>
> On Mon, Jan 07, 2019 at 10:12:56AM -0500, Waiman Long wrote:
> > As newer systems have more and more IRQs and CPUs available in their
> > system, the performance of reading /proc/stat frequently is getting
> > worse and worse.
>
> Because the "roll-your-own" per-cpu counter implementaiton has been
> optimised for low possible addition overhead on the premise that
> summing the counters is rare and isn't a performance issue. This
> patchset is a direct indication that this "summing is rare and can
> be slow" premise is now invalid.

Focusing on counter performance is, IMHO, missing the mark. Even if
interrupt count collection were made fast, there's *something* in any
particular /proc file that a particular reader doesn't need and that,
by being uselessly collected, needlessly slows that reader. There
should be a general-purpose way for /proc file readers to tell the
kernel which bits of information interest them on a particular read
syscall sequence or particular open(2) or something. Creating a new
proc file for every useful combination of attributes doesn't scale
either.
