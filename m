Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12064C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2BE621B1A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P6p+VoXM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730005AbfBKRIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 12:08:54 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44185 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727809AbfBKRIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 12:08:53 -0500
Received: by mail-lj1-f194.google.com with SMTP id a16so5318604ljb.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 09:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/epyN4S3As8DhEjdK3otcl/1yvaoHTQZrUBJfybiyLY=;
        b=P6p+VoXMjCWAfyGR+8ESjjNMYs//hvEgWQts/M+hB8aQyP7Z2A6ud0vRdPFRJ+VzYy
         cTCYZ+zRIV+f0MRS8rR/w2lcWtRE0F69M8fU/oxtet28hW5lUAD6/0Hf3BnzWHB+Zyfb
         ZLKpcTDBfA1zjxd02CJTvZbTv7K/HGfUteS3CYoDxDm16YvG7f6FBMA6vQngbpySpCqR
         5N406+j/ShWCWja1gPj3pDGYOlhh/jFdBnu3LXYkTMlEylVjd9IV+3CWDVJDao3vEPBh
         wi0BY8nrSJH+Kl46Mnzsh1lNfyktRPvQiMzWDKUZuX70SneFJTL/+7nMXE/xxVHdxb3u
         dIow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/epyN4S3As8DhEjdK3otcl/1yvaoHTQZrUBJfybiyLY=;
        b=Gvdp6RoBsOAWNYeGT8TcoyUpH/agrCaNyd3745OFX52Evi9mjJ+5KtuCnnFuf3XDuj
         k5bprRs0EWKAmn9M0B47yi0bvPRn9qYsCQWBOjyugUgNp+prLb8S/ypj4/lGjFvgg7IW
         ZMBED57EaccxLrwqmOGIg11ld5cZXhTlP/ID3bzlQ2U5oYfGUg0Z3tN6JFmUCHkeOMnj
         Bm8pPbahD9SHrgXuA/ZSn8844za7T2AH1q7EK6WOrAzBamiV3/jbwuPh0zRP9feuRKpo
         N1K3SVJ3Z+0Qu0rxFpqmZQQ2FqlCfvuCQkgCU9136iWzH1HkR+UXqvVf42pZJ7num5Vg
         z0bA==
X-Gm-Message-State: AHQUAua4+i9lMZIqps7dO9cD1OYvTCoDeHXMHlL6e9G0O0kbEBeccZ0n
        nJMGPXqwmtwy0ZEojJtLb8/b6tLkKNiqhBva2kptgw==
X-Google-Smtp-Source: AHgI3Ibrr4oQlKL4ipHEzn9snMQF0ZIJmHc2ye0vsLdlTqIxXAN3wA0CQsjSBCWI78Vjw3eLe0veFcCp2wMaG/AcTUM=
X-Received: by 2002:a2e:9457:: with SMTP id o23-v6mr22131446ljh.7.1549904931531;
 Mon, 11 Feb 2019 09:08:51 -0800 (PST)
MIME-Version: 1.0
References: <20190208183520.30886-1-tkjos@google.com> <20190211165708.GA25685@infradead.org>
In-Reply-To: <20190211165708.GA25685@infradead.org>
From:   Todd Kjos <tkjos@google.com>
Date:   Mon, 11 Feb 2019 09:08:40 -0800
Message-ID: <CAHRSSExpDnm+630y_8z8h91CEQ5sviqOdDazq=XwG-creZ+DxQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] binder: eliminate use of vmalloc space for binder buffers
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Todd Kjos <tkjos@android.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Martijn Coenen <maco@google.com>, joel@joelfernandes.org,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 8:57 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Fri, Feb 08, 2019 at 10:35:13AM -0800, Todd Kjos wrote:
> > Binder buffers have always been mapped into kernel space
> > via map_kernel_range_noflush() to allow the binder driver
> > to modify the buffer before posting to userspace for
> > processing.
> >
> > In recent Android releases, the number of long-running
> > binder processes has increased to the point that for
> > 32-bit systems, there is a risk of running out of
> > vmalloc space.
> >
> > This patch set removes the persistent mapping of the
> > binder buffers into kernel space. Instead, the binder
> > driver creates temporary mappings with kmap() or
> > kmap_atomic() to copy to or from the buffer only when
> > necessary.
>
> Is there any good reason to actually map the user memory to kernel
> space instead of just using copy_{to,from}_user?

Yes, the mappings are needed for cases where we are accessing binder
buffers of the target while in sender context. For example, we copy
the message from the sender to the target with 1 copy while in the
sender's context. For this we use copy_from_user(), but use these
temporary mappings for the destination (target process).

-Todd
