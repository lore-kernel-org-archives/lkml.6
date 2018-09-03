Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 824CDC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 23:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3773620843
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 23:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=zendesk.com header.i=@zendesk.com header.b="KD6qcKQ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3773620843
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=zendesk.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbeIDDx7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 23:53:59 -0400
Received: from us-smtp-delivery-110.mimecast.com ([63.128.21.110]:45609 "EHLO
        us-smtp-delivery-110.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726167AbeIDDx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 23:53:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zendesk.com; s=mimecast20150210; t=1536017494; h=from:from:sender:reply-to:subject:subject:date:date: message-id:message-id:to:to:cc:cc:mime-version:mime-version: content-type:content-type: content-transfer-encoding:content-transfer-encoding: in-reply-to:in-reply-to:references:references; bh=6rAQePRkC3mX7k8tBjhkLzgBz8Glxd6cv38mjDl2LsY=; b=KD6qcKQ1zg+HnbWiLDbI9xE3WHUIik1+t0eEDRR0mL88TBZ6pkU8zs0vtRpSwtAXLxSRTnmCYc3+Dqf6irV7cGnYmErmNOIOg3c518NjCJSZkgINyohCvoeCggUWeBwwKxKX8R4F5u3rpPDKixIxJBOwrPSBQCwQldBTsTqZ2D8=
Received: from mail-yw1-f70.google.com (mail-yw1-f70.google.com
 [209.85.161.70]) (Using TLS) by us-smtp-1.mimecast.com with ESMTP id
 us-mta-281-_FORWPgSORmeROyeRrFevA-1; Mon, 03 Sep 2018 19:30:31 -0400
Received: by mail-yw1-f70.google.com with SMTP id d20-v6so1532022ywa.16
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 16:30:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gx7l7C+J2oZM2a1mutp5oEZ9R5865CH05XVQcq9T56Y=;
        b=MQyZgBp07ppoHBzj8ENokuLjLi171dSZ+Za+HLDj3xfysGNk2aORLVhEDP/j6xLUZx
         FTN0fRTbPKdnyIE8WsFP/kogIkPs3opGvcwGDhFZ0qMylWSi+FVVhC5yVTqkIq8Q8JAR
         uR95LniSxDsGfW+Y4PvSlHkfqwDxOhToGyFPpattlY9gsRjsg2P7EGmt4U5VVIZ/t+T2
         vwM7q8Im9fWbQWZLyfQG5bmMvtcgYklZyh2wrCMyGEKJBfrpE3vikbB7TFLdQBKcRUjh
         1Lx8lKnmK9LbNTdzXyED076q0+x+vlTDv7ILFvLxzx4ZgZsO3QO6J7lZaO2zRPrUZheb
         wCXw==
X-Gm-Message-State: APzg51BKUxsQVfxnxS9I8AKIeKO9DEUTFR+/CoRGduQ0ea2fMeVQk3sF
        KE7pGajbUlL3TzUse0HM+S/GzEydWnsxBRNlHmxjqliOm8enku3HWlYgY388MQqgfTz9mcoHbi1
        1sTP90dFs/C7G9OnGJ8Q+Wq2XlEODw1HZiREiMb0w3hUKpl1kIGJJ0tQ=
X-Received: by 2002:a81:6554:: with SMTP id z81-v6mr16903613ywb.34.1536017428101;
        Mon, 03 Sep 2018 16:30:28 -0700 (PDT)
X-Google-Smtp-Source: ANB0Vdb//+VpaLvYF1AyPy3g95+vqNwgyTxcOiVJZ86KNr1bBrP23cW3tNAxLnUz71BEnMzoClx6n7+ByGZMx2qPddo=
X-Received: by 2002:a81:6554:: with SMTP id z81-v6mr16903594ywb.34.1536017427727;
 Mon, 03 Sep 2018 16:30:27 -0700 (PDT)
MIME-Version: 1.0
References: <20180903111016.46461-1-ktsanaktsidis@zendesk.com> <20180903162215.3069867de3ed953ae1484e06@linux-foundation.org>
In-Reply-To: <20180903162215.3069867de3ed953ae1484e06@linux-foundation.org>
From:   KJ Tsanaktsidis <ktsanaktsidis@zendesk.com>
Date:   Tue, 4 Sep 2018 09:30:12 +1000
Message-ID: <CAJ7wOOsY=FxNgMviJyZpxQCfDZtJN-SHx0bjkAAhV-MqKXxuHg@mail.gmail.com>
Subject: Re: [PATCH] fork: report pid exhaustion correctly
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, trivial@kernel.org, mhocko@suse.cz,
        oleg@redhat.com
X-MC-Unique: _FORWPgSORmeROyeRrFevA-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks :) yeah, first kernel patch. I got pretty annoyed by how long I
spent trying to figure
out why my database was reporting disk space errors on pthread_create,
and when I
finally worked out what was going on sending a patch to fix it was
somewhat therapeutic!

On Tue, Sep 4, 2018 at 9:22 AM Andrew Morton <akpm@linux-foundation.org> wr=
ote:
>
> On Mon,  3 Sep 2018 04:10:16 -0700 ktsanaktsidis@zendesk.com wrote:
>
> > From: KJ Tsanaktsidis <ktsanaktsidis@zendesk.com>
> >
> > Make the clone and fork syscalls return EAGAIN when the limit on the
> > number of pids /proc/sys/kernel/pid_max is exceeded.
> >
> > Currently, when the pid_max limit is exceeded, the kernel will return
> > ENOSPC from the fork and clone syscalls. This is contrary to the
> > documented behaviour, which explicitly calls out the pid_max case as on=
e
> > where EAGAIN should be returned. It also leads to really confusing erro=
r
> > messages in userspace programs which will complain about a lack of disk
> > space when they fail to create processes/threads for this reason.
> >
> > This error is being returned because the alloc_pid function uses the id=
r
> > api to find a new pid; when there are none available, idr_alloc_cyclic
> > is returns -ENOSPC, and this is being propagated back into userspace.
> >
> > This behaviour has been broken before, and was explicitly fixed in
> > commit 35f71bc0a09a ("fork: report pid reservation failure properly"),
> > so I think -EAGAIN is definitely the right thing to return in this case=
.
> > The current behaviour change dates from commit 95846ecf9dac ("pid:
> > replace pid bitmap implementation with IDR AIP") and was I believe
> > unintentional.
> >
> > This patch has no impact on the case where allocating a pid fails
> > because the child reaper for the namespace is dead; that case will stil=
l
> > return -ENOMEM.
>
> Thanks.  First ever kernel patch?  It was a damn good one!
>
> > Fixes: 95846ecf9dac ("pid: replace pid bitmap implementation with IDR A=
IP")
> > Signed-off-by: KJ Tsanaktsidis <ktsanaktsidis@zendesk.com>
>
> I'll add cc:stable here so the fix gets backported into earlier kernels
>

