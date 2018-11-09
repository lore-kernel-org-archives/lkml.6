Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04DBDC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 19:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9F2F20892
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 19:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dU//zwfr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9F2F20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729112AbeKJEpx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 23:45:53 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45663 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729032AbeKJEpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 23:45:52 -0500
Received: by mail-lf1-f65.google.com with SMTP id b20so2073567lfa.12
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 11:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B9LL2a/tZDBHwwLnXEWxkvm74SmYjIpGH13Ej5Bc4f0=;
        b=dU//zwfr6JEVkyHWvy0Y44ZUKoQhwv0PJ780UGxelglGXHShfJtMkK4K0TgAv9Cu81
         Qbn2ZttV4lkUv+Y+Hl12HeuoXPDxTtFVvUG8NvwdMBFEeHo2ELIK2HYuOEY/pIgvgLVl
         n4iGFQWVMr1udrmEwLgsxuppmwrKAVgwQ32fqSob17r32DG2bb5t5au4f1QUvRhbpiUu
         1HrB8jeje6tbk6AyetUsNPSLqA/RUzoqy/vH9IVqei16S8B4hXWyVLPvoUok0Kq2cmc7
         BAkO86yWWa9v6mb6F+WeAIBQuPK9FyET9zBrkIHoRsvUFedejX3hgDrEv8HP+cZolMno
         cQ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B9LL2a/tZDBHwwLnXEWxkvm74SmYjIpGH13Ej5Bc4f0=;
        b=pZQRTMWot0lpL2Iepe0bIFNt7OI56QiJrenUTi0dp5O5+5Altonp/eggxIJWHdajo9
         94wIRJ6UwxqiuJphJZ1eIDPBPUvwsVHUZyb1GA6kaP8p52PatYQX7yGUS5AfyYh8BrOe
         NfHXQdHthIBs3olUPclXYyn8YP4CtPZ+Ev235Se2F2UcYEAdod713gt9FdKyUyd5m87B
         CKviObd7H5MA34Vrh7hGRvjQysyMR8uwgq5T3nrLbYHuxd8jdof65nbuMAMCJe/BtbBz
         a7NBQ8LfQhGIPmoV+4NjcmNkHOhvkw+hkFoRIqpRKDOHfzHVMQvq7cc/Pvk9XApCHXyZ
         CwKg==
X-Gm-Message-State: AGRZ1gKxPCdFmQT5gGG8WFKsybPsb0VHOtaubYAwEEG9rdEKnSbM5ezF
        6G2qC8dnBCvAsovD9Rjn/mcZr7XJkv18Z6QTOrRxGg==
X-Google-Smtp-Source: AJdET5fHq/A/1L+66ZBXB22xj/Ti1mVMpWz+H7FakEYmraPoLCY+wSggak0W6AIj3d1XXLlLXHQiWl2mw+FgzhblYFY=
X-Received: by 2002:a19:c650:: with SMTP id w77mr6207414lff.56.1541790237183;
 Fri, 09 Nov 2018 11:03:57 -0800 (PST)
MIME-Version: 1.0
References: <5FBCBE569E134E4CA167B91C0A77FD610198F851AC@EXMBX-SZMAIL022.tencent.com>
 <20181109182654.ojzc7wae3jcivlup@linux-r8p5>
In-Reply-To: <20181109182654.ojzc7wae3jcivlup@linux-r8p5>
From:   Todd Kjos <tkjos@google.com>
Date:   Fri, 9 Nov 2018 11:03:45 -0800
Message-ID: <CAHRSSEzc96qbDOQt8L+J4JMAazYv-d2xdyLT2nyPe7_t+8_5=A@mail.gmail.com>
Subject: Re: [PATCH V3] binder: ipc namespace support for android binder
To:     dave@stgolabs.net
Cc:     chouryzhou@tencent.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>, akpm@linux-foundation.org,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 9, 2018 at 10:27 AM Davidlohr Bueso <dave@stgolabs.net> wrote:
>
> On Thu, 08 Nov 2018, chouryzhou(??????) wrote:
>
> >+#ifdef CONFIG_ANDROID_BINDER_IPC
> >+       /* next fields are for binder */
> >+       struct mutex      binder_procs_lock;
> >+       struct hlist_head binder_procs;
> >+       struct hlist_head binder_contexts;
> >+#endif
>
> Now, I took a look at how the binder_procs list is used; and no, what
> follows isn't really related to this patch, but a general observation.
>
> I think that a mutex is also an overkill and you might wanna replace it
> with a spinlock/rwlock. Can anything block while holding the binder_procs_lock?
> I don't see anything... you mainly need it for consulting the hlist calling
> print_binder_proc[_stat]() - which will take the proc->inner_lock anyway, so
> no blocking there.

print_binder_proc() drops proc->inner_lock and calls
binder_alloc_print_allocated() which acquires proc->alloc->mutex.
Likewise, print_binder_stats() calls print_binder_proc_stats() which
drops its locks to call binder_alloc_print_pages() which also acquires
proc->alloc->mutex. So binder_procs_lock needs to be a mutex since it
can block on proc->alloc->mutex.

> Also, if this is perhaps because of long hold times, dunno,
> the rb_first_cached primitive might reduce some of it, although I don't know
> how big the rbtrees in binder can get and if it matters at all.
>
> Anyway, that said and along with addressing Todd's comments, the ipc/ bits look
> good. Feel free to add my:
>
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
>
> Thanks,
> Davidlohr
