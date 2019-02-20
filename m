Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE1F1C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 06:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B47BA21773
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 06:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tL/u/Og9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbfBTGfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 01:35:07 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43974 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726660AbfBTGfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 01:35:06 -0500
Received: by mail-ot1-f65.google.com with SMTP id n71so38390679ota.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 22:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iuvTqO3NSV6u7uQL7TsRgoXE3JzoZTVXEQCQK0o//4w=;
        b=tL/u/Og9OqVtnm6rpSZtuFs/AjEYUv9jwfGmilBoM06jfLI91a5QdEKmPbd7oUseyU
         MV1XJN+2N1bhn366V8/JmSm1ZfvO43s3MJwTfGZhKhqY0jzeel6Q5I5go/pWQdn9cMoz
         022NwXLfLKEGz3F8i+xoBRHp3qvxx0INoMYrixabTnPZR9EXXkYnwRtyy1sgBZnM7V4d
         N9gL9tlJA045KJK7lqmp9+tIt4/f2lx0p+i3v4lxIzDCaC8aaNg8Uwux80fyzF7tLIOG
         uNo2R6FtYOgFQMt5g3YEpEu0bGhskB3C13tyCSKZi9lEsQw5XDoJeuOo6jA4ah3pophY
         Jk2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iuvTqO3NSV6u7uQL7TsRgoXE3JzoZTVXEQCQK0o//4w=;
        b=GFE7+6T9zTIRfFLIQ0Lot73fR7W1dazTYtbLnZtf9n3nk/ji1xemgMBlfieE1w9bRF
         BQB633on/KZx6h9yGkpOOBorxQRauTg5jM6+Wg0TsyGsjQBXVSqNcyGaz86HqJ7KXE/+
         wbfqqxgYUbLLqYEzsHiICqQAq7c9yOAsAjVdwopW5MHDERD05djo4v2qW+0TzasmIOrQ
         l4lTXQ0qG/ylJPU/zMIu2mgc1g4X1N1lNh+npgxgSkzH2+hdTdNodoj5mFwwgkMpqxLS
         BbldUKtJpxMc9Z+D2tq0PchVa5nRblcCyrwsbOZl5u+BQkTbW+zM9vU2+b8K48XRWFyP
         TFkA==
X-Gm-Message-State: AHQUAubyzXL2r3rahLoElgS4q4Va+dQViEBG6jgSemcG2gAxqxTUjKuS
        d0DMhLh9KSON/M1zCHFmHFwWCtx/usVKuWj4aT6IzjFe/guSbg==
X-Google-Smtp-Source: AHgI3IbN9t5iLIVEsz3+a1Yt7pmhCBCGPPShDndBML0UtJpJZZl0clo9MJ1JGF9ROmZ0p2jfJeTeFWT4q4+2KaypVck=
X-Received: by 2002:a9d:5549:: with SMTP id h9mr18864609oti.83.1550644504978;
 Tue, 19 Feb 2019 22:35:04 -0800 (PST)
MIME-Version: 1.0
References: <20190214213729.21702-1-brendanhiggins@google.com> <a6ae907e-391b-993e-6011-6f40c761b339@gmail.com>
In-Reply-To: <a6ae907e-391b-993e-6011-6f40c761b339@gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 19 Feb 2019 22:34:54 -0800
Message-ID: <CAFd5g44AmF6eN-HKwHOqPiGZHNc2K_wAmWR3PkV0OX-=YNUKDw@mail.gmail.com>
Subject: Re: [RFC v4 00/17] kunit: introduce KUnit, the Linux kernel unit
 testing framework
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Kees Cook <keescook@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>, shuah@kernel.org,
        Rob Herring <robh@kernel.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Joe Perches <joe@perches.com>, brakmo@fb.com,
        Steven Rostedt <rostedt@goodmis.org>,
        "Bird, Timothy" <Tim.Bird@sony.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        linux-um@lists.infradead.org, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Knut Omang <knut.omang@oracle.com>,
        devicetree <devicetree@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Amir Goldstein <amir73il@gmail.com>, dan.carpenter@oracle.com,
        wfg@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 12:02 PM Frank Rowand <frowand.list@gmail.com> wrote:
<snip>
> I have not read through the patches in any detail.  I have read some of
> the code to try to understand the patches to the devicetree unit tests.
> So that may limit how valid my comments below are.

No problem.

>
> I found the code difficult to read in places where it should have been
> much simpler to read.  Structuring the code in a pseudo object oriented
> style meant that everywhere in a code path that I encountered a dynamic
> function call, I had to go find where that dynamic function call was
> initialized (and being the cautious person that I am, verify that
> no where else was the value of that dynamic function call).  With
> primitive vi and tags, that search would have instead just been a
> simple key press (or at worst a few keys) if hard coded function
> calls were done instead of dynamic function calls.  In the code paths
> that I looked at, I did not see any case of a dynamic function being
> anything other than the value it was originally initialized as.
> There may be such cases, I did not read the entire patch set.  There
> may also be cases envisioned in the architects mind of how this
> flexibility may be of future value.  Dunno.

Yeah, a lot of it is intended to make architecture specific
implementations and some other future work easier. Some of it is also
for testing purposes. Admittedly some is for neither reason, but given
the heavy usage elsewhere, I figured there was no harm since it was
all private internal usage anyway.
