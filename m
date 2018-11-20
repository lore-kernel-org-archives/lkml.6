Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E6DC41536
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1663920684
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jOOpq+fr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1663920684
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbeKUETC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 23:19:02 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:37107 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbeKUETC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 23:19:02 -0500
Received: by mail-vs1-f65.google.com with SMTP id h18so1604241vsj.4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 09:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dN5F5JjkX8qXx7CGqsA8pOnFZ6513BsOrkwubwTzl6Y=;
        b=jOOpq+fraVncoarOWAFx7rMbxvglr0X2TN6+XPIecpWtseOivq4bhl37mS3+xWv5ly
         ZNkbsAR5kshlnNE9NSiHy1bH1cBqpNQUiVo1rixFectKn9dyHQoMVJoNJG397AEDj94j
         R4phZwjjJm9+u7s08ZtUKj/gpxNk8kCww5609VfLpSTGaL2FEtg5tNF3HybFRh4i7RGH
         Cl1AmXMT0SE3OwNPy5meSuwYf3oaeC70T9NFj1cfhmvSV7hpgEDxX+zOAjKFbBa+eOM2
         8lmcKz2pONp0+gymZnM0h1gER/alu22Km85bq8k/5wfR7m9hTw/WOd0Hvx9aSkKk2d4C
         TJww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dN5F5JjkX8qXx7CGqsA8pOnFZ6513BsOrkwubwTzl6Y=;
        b=kUAdoA/VcaO0RhWBVa44Km4/o2e6fGmPPYdbXuXxEnVG0IN+d/bd7C8OtgZmXdHH/3
         i8Wa4aFYjr0nYn/Nw2GjhVzXcrOsf1GAq3ch07y72lqDqPJuH3jOWGuMUKZVDYbDvNHA
         ubav9iBBe1KJYgq8j1nXuo14mcukkoOrckhgvPaWSAZdW5uoIk7iCG0CisH8ILoCKjhV
         F89ED3lY7ODyTacAy5MRGESmX1lalrCGLOFfXPxqkfODH6+fMG+avAXdorpfQIiqtrP5
         dxqmlugagvzMYVl+HKMQxlnURL7fmskjHPDPh747LlufvXAdgzkjJpEW/jj1FAy4C+YH
         kDRA==
X-Gm-Message-State: AGRZ1gLnmBdiN4UuD1igRnQfDZ/rm3l1Wy1KgY06UE6qIFafdKFZxF4W
        CL/TDiQdcfu7Xz5EPU8vcka//e+dliBxbgSqau2t+Q==
X-Google-Smtp-Source: AJdET5fzyAyh8Scry+3EDV54//ltBPMntEiwOTwDIzRN82jcDHZQ2nUKBhK9rR+lfp9UjCs4AGwoSQzT74Yy2fBuS/s=
X-Received: by 2002:a67:b44:: with SMTP id 65mr1272308vsl.77.1542736119374;
 Tue, 20 Nov 2018 09:48:39 -0800 (PST)
MIME-Version: 1.0
References: <20181031150625.147369-1-dancol@google.com> <20181105132205.138695-1-dancol@google.com>
 <20181119105426.GD28607@amd> <1c5caa66-3c61-cb57-754a-f099200c73b2@suse.cz>
 <20181120091829.GD16916@amd> <20181120173912.GD3065@bombadil.infradead.org>
In-Reply-To: <20181120173912.GD3065@bombadil.infradead.org>
From:   Daniel Colascione <dancol@google.com>
Date:   Tue, 20 Nov 2018 09:48:27 -0800
Message-ID: <CAKOZuevidVnZ+9vB1CxsetPVH=2P7eoORA1F445HOp-jS5rwOA@mail.gmail.com>
Subject: Re: [PATCH v2] Document /proc/pid PID reuse behavior
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Vlastimil Babka <vbabka@suse.cz>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>,
        Prashant Dhamdhere <pdhamdhe@redhat.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 9:39 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Tue, Nov 20, 2018 at 10:18:29AM +0100, Pavel Machek wrote:
> > > would ever rely on the pid being reused while having the descriptor
> > > open. How would that make sense?
> >
> > I agree this is corner space, but users might be surprised that
> > keeping FDs of /proc/pid/X would lead to PID space exhaustion, for
> > example.
>
> We have a limit on the number of FDs a process can have open for a reason.
> Well, for many reasons.

And the typical limit is too low. (I've seen people clamp it to 1024
for some reason.) A file descriptor is just a handle to a kernel
resource. All kernel resources held on behalf of applications need
*some* kind of management interface. File descriptors provide a
consistent and uniform instance of such a management interface. Unless
there's a very good reason, nobody should be using non-FD handles for
kernel resource management. A low default FD table size limit is not
an example of one of these good reasons, not when we can raise FD
table size limit. In general, the software projects should not have to
put up with ugly workarounds for limitations they impose on
themselves.
