Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D635AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 20:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9997721B24
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 20:54:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HNweZ4ek"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503283AbfBNUyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 15:54:10 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46763 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503272AbfBNUyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 15:54:07 -0500
Received: by mail-qt1-f193.google.com with SMTP id y20so8453369qtm.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 12:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UCLVnnyIkJIWvIhkOPIRsD33pAc3xGCaA+qxojDDFcU=;
        b=HNweZ4ekICrK1dMJckkHky0IfhFJG7awGpHHiVA4BQEjj59YzXP8wUeABVurl2oVKY
         vxsWLEowwv3rcDCJ0lgCttyo+aWohmQyATDEgvLNQ5UcLfAByJw8ppnzJVOa1PcVWHt9
         Z0YhdyoL9rcHKbIZAj3zix6AnpDuPTBO3dOs4ebj5k+96Vlt6a+ipsM4dAqKmQ4BZohj
         rJLliqBxdhq9SEC0nJvYy57Yu+J34xA3+fVwg5ITNPmJpwI8/1XRUyQTJvsij6TwhfFL
         HZalyUHm4vO7/tmz56+5HPNeMOZ1klG3unwyqCPvZXYPcc02HsAzfAS9ebGfIZQdBToZ
         xgtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UCLVnnyIkJIWvIhkOPIRsD33pAc3xGCaA+qxojDDFcU=;
        b=nSmuHDueDyLy7LpQEZlzlFEiW4JFXmp81W2GPpX87+vYlFbNCtE9FjQ1XSc4Kow65a
         mF0B6crdTL/MKYQpkPvMmYWkEFvXwh7UCpEHdcvrIbNKRbhGNrPFkiUwvQZY1OyQMrzh
         QGEdhTNW5CpxURq3ZYmq9ro00lJDSwrkx8A1OBSeMjj+1chySaKDhfxOAOXj2tsKyuuh
         TkEvnY+qJeyXcxlqs8SkEHew/VM4vygR2ubgpNmu0MKbeh/VPBNAtdwHfkGVZOCoEmCS
         95dHXWVkO10ACbXsNYLajDaQlfI8f5n1+lgj4nGOQzesmjHOUNoJHafbtlzlrajoN2EE
         fpRA==
X-Gm-Message-State: AHQUAuYpQoQ9U/1B+UqWei3oZcA3ek2tDnecHqoCMgOBowCOY6nPpV3+
        n6VaTdxdKdJf+siN9DC/PoBnUq1zUPszAGTNLhj/7f0nK6c=
X-Google-Smtp-Source: AHgI3IYtSpawrGAZnxJu0OCOREkFq8SNc3WaLDX2BggIuRtTVeVUoOZbXjDkz+etAtA4nJWe6nysQgggvRtqhQW3wK8=
X-Received: by 2002:ac8:44d3:: with SMTP id b19mr4878279qto.304.1550177645750;
 Thu, 14 Feb 2019 12:54:05 -0800 (PST)
MIME-Version: 1.0
References: <20190208183520.30886-1-tkjos@google.com> <20190208183520.30886-2-tkjos@google.com>
 <20190214194540.GA185075@google.com> <CAHRSSEw22kuwLqjXHocBQTv4d5hS1tXi4uirjBhgQ=yGbw9J4g@mail.gmail.com>
In-Reply-To: <CAHRSSEw22kuwLqjXHocBQTv4d5hS1tXi4uirjBhgQ=yGbw9J4g@mail.gmail.com>
From:   Joel Fernandes <joelaf@google.com>
Date:   Thu, 14 Feb 2019 15:53:54 -0500
Message-ID: <CAJWu+oqq0s3x7j+gPzSRREj2gjZxzAPS_=XVM4uhC9GjSM9zfw@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] binder: create userspace-to-binder-buffer copy function
To:     Todd Kjos <tkjos@google.com>
Cc:     Todd Kjos <tkjos@android.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Martijn Coenen <maco@google.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 3:42 PM Todd Kjos <tkjos@google.com> wrote:
>
> On Thu, Feb 14, 2019 at 11:45 AM Joel Fernandes <joelaf@google.com> wrote:
[snip]
> > > + * check_buffer() - verify that buffer/offset is safe to access
> > > + * @alloc: binder_alloc for this proc
> > > + * @buffer: binder buffer to be accessed
> > > + * @offset: offset into @buffer data
> > > + * @bytes: bytes to access from offset
> > > + *
> > > + * Check that the @offset/@bytes are within the size of the given
> > > + * @buffer and that the buffer is currently active and not freeable.
> > > + * Offsets must also be multiples of sizeof(u32). The kernel is
> >
> > In all callers of binder_alloc_copy_user_to_buffer, the alignment of offsets
> > is set to sizeof(void *). Then shouldn't this function check for sizeof(void *)
> > alignment instead of u32?
>
> But there are other callers of check_buffer() later in the series that
> don't require pointer-size alignment. u32 alignment is consistent with
> the alignment requirements of the binder driver before this change.
> The copy functions don't actually need to insist on alignment, but
> these binder buffer objects have always used u32 alignment which has
> been checked in the driver. If user code misaligned it, then errors
> are returned. The alignment checks are really to be consistent with
> previous binder driver behavior.

Got it, thanks.

 - Joel
