Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0102C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 18:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1F932086D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 18:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544724568;
	bh=qDBwkOTOn0HjUuprDA0mac7GDunlvK4TugoO8opAnqA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=PdfYDJYeqSPf9/T1hk+8ReWif0KIky8QO3L5v05dkm0bUpB4xPdVTKObft33e1s8u
	 lThU0R0Qru18XQnuJYzkHdS72sX3soufGBWEZf2Hi8oMUv9AfXtnrHRQQ51fFshi68
	 X0QU7JFyE4WMnBA9jsXY+igS5aV2CauVxoTy0OhY=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1F932086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbeLMSJ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 13:09:27 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42803 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727618AbeLMSJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 13:09:27 -0500
Received: by mail-oi1-f196.google.com with SMTP id w13so2363399oiw.9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 10:09:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qDBwkOTOn0HjUuprDA0mac7GDunlvK4TugoO8opAnqA=;
        b=XM/j3IbljFQ/V9yUlK2Ez9ga6md1kxTQjWekjuPTG9AIfNgr+cATiB1k7ev23Bk6Lz
         Z60MZ3XF/+1lCQ+e3OzwRnRAkF5JUQ/8+cwW2RiNkAEXrbFjpp6YB3F9lLX29OdfheFO
         V6XQbq3Fk9B4um2EANdEVBtp9VaR36/rJRyxYIm/ExTA11uuqAG6v+tflQcP31YaKSAP
         UO6bGBYdKw7t1qkTBA9e+STliuMQe6vwRVvVUufcJ3oZc4iuk2Jks/H+WSZqYfXEH5w6
         EjQtY0S7It7Ewa0OPVcWWvbI7EDEf3+1vgDGms/IgZ880q0sIvE2D3hA9M5mgOT0rYQ+
         kqaQ==
X-Gm-Message-State: AA+aEWYdaa2sZI5KmsfG7O8FMHGZtxB7G4upLMnbS+6vqqRrG4ij5vWs
        DLTCCBFod8uICAXkBNKMteG6ngeGP46CAzZDukQ=
X-Google-Smtp-Source: AFSGD/Wu2QseQfOHZspNR6Vawokqg3LYcDH1z7KvUC+T0OTWqFddmxrJsBqbykK3+QVW41gtMVrxuowVyq58Dr7sENw=
X-Received: by 2002:aca:a698:: with SMTP id t24mr2522192oij.76.1544724566459;
 Thu, 13 Dec 2018 10:09:26 -0800 (PST)
MIME-Version: 1.0
References: <20181210084653.7268-1-daniel.vetter@ffwll.ch> <CAJZ5v0jkE=Rt2ozwcTxRdUN++Sr4HXULksDeMx4jEWj1jVDcyA@mail.gmail.com>
 <20181213095814.GC21184@phenom.ffwll.local> <CAJZ5v0iWshem3kuurF53gutVJ8jFm_caAbetK2CiSCpyc6ReeQ@mail.gmail.com>
 <CAKMK7uF7noCEgwE0QYZWQFx-OPxipAF1MojUZ8KTo_SXfQW8+w@mail.gmail.com>
 <CAJZ5v0g+-R8tbbJscL-3s23UPhyNX1v1Lj3aC=QdUBzdSCrspw@mail.gmail.com> <CAKMK7uHACB5-ak0b_BT-HoAmXHZ9EaCNTt7WuqckNWKQM-g2fQ@mail.gmail.com>
In-Reply-To: <CAKMK7uHACB5-ak0b_BT-HoAmXHZ9EaCNTt7WuqckNWKQM-g2fQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 13 Dec 2018 19:09:15 +0100
Message-ID: <CAJZ5v0hOiL1oWGCmFv2N8-0UvCibXz02DhdFMyUQsQZ1hDjV=w@mail.gmail.com>
Subject: Re: [PATCH] drivers/base: use a worker for sysfs unbind
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        ramalingam.c@intel.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 5:25 PM Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
>
> On Thu, Dec 13, 2018 at 5:18 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Thu, Dec 13, 2018 at 1:36 PM Daniel Vetter <daniel.vetter@ffwll.ch> wrote:

[cut]

> > > I can do the old code exactly, but afaict the non-NULL parent just
> > > takes care of the parent bus locking for us, instead of hand-rolling
> > > it in the caller. But if I missed something, I can easily undo that
> > > part.
> >
> > It is different if device links are present, but I'm not worried about
> > that case honestly. :-)
>
> What would change with device links? We have some cleanup plans to
> remove our usage for early/late s/r hooks with a device link, to make
> sure i915 resumes before snd_hda_intel. Digging more into the code I
> only see the temporary dropping of the parent's device_lock, but I
> have no idea what that even implies ...

That's just it (which is why I said I was not worried).

Running device_links_unbind_consumers() with the parent lock held may
deadlock if another child of the same parent also is a consumer of the
current device (which really is a corner case), but the current code
has this problem - it goes away with your change.

But dev->bus->need_parent_lock checks are missing in there AFAICS, let
me cut a patch to fix that.

Cheers,
Rafael
