Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE3DC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 20:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1ABB208AC
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 20:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EjDJ7SKg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1ABB208AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732379AbeHAWoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 18:44:09 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:46323 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732067AbeHAWoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 18:44:08 -0400
Received: by mail-io0-f178.google.com with SMTP id i18-v6so17279086ioj.13
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 13:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xn2lt8BXGw6bwS7abZR8sOWQ94Xspg7qm7ANWbRUai4=;
        b=EjDJ7SKgVSRZZjP2ly/a6Z4JK53PAUehE0fJxZk6lwzNFXJYTei3bb8JWIQTZhQliS
         CE7oOvCZIteFMHhjZT3P97AbV1V8qY/707GZufTIlnNYdbZV7uRNDgN1avwaN83y57BJ
         swG12DHMP4LpBdOWesUmZTXmw125264zbyvEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xn2lt8BXGw6bwS7abZR8sOWQ94Xspg7qm7ANWbRUai4=;
        b=bzIOeuM2gSBvZ4f0/mJ1CeZTm3FMyZexq9dSxUvwKCFPmPnucwn75WBQpQdXyH6mnY
         uiOfUUaJHpE7xmZHbhDQ9eJYLcI7Ie4+vauTqi7yaZ39QTSBLRtx9+WIaLlcd6244/yD
         SlkJ0u+3PiG1K82LPkzJOdyH0BfBQzj8VQS8MZRQu4gzK+R/fHUNOnKN8GmXIuieFVad
         2o5wsB2WttixsOG5cxeJOUvcJ1NwUC8UJeyrvjVX2cxiBD+JDtsik5CGI7QkkmhBOHOb
         +jDNV/AurQo15DQpVOwiUoBmOH0PjC2Qk3/3K6zbyMN7YOGVp0YFnBFTJ4chu1Sj9VR4
         ha8Q==
X-Gm-Message-State: AOUpUlFUh2FnkCrKd4goYPFCPzO5gXKcdz9qna6jn5F+0JrtlNpyRlK5
        mh3t53stbyvZMnUgtj+SARRhYvh4m3NIzCOsZpE=
X-Google-Smtp-Source: AAOMgpdsV8RhKgkO9PBSjgQNUNtFqV8hoa6seFT60qWabKBGP/B5c2E2p0pwW1AnUpCOMErbY7aUVAzCE9Hfv34/lUw=
X-Received: by 2002:a6b:7a05:: with SMTP id h5-v6mr5015874iom.238.1533156990515;
 Wed, 01 Aug 2018 13:56:30 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LSU.2.11.1807301410470.4805@eggly.anvils>
 <CA+55aFx3qR1FW0T3na25NrwLZAvpOdUEUJa879CnaJT2ZPfhkg@mail.gmail.com>
 <alpine.LSU.2.11.1807301940460.5904@eggly.anvils> <CALAqxLU3cmu4g+HaB6A7=VhY-hW=d9e68EZ=_4JiwX_BigzjPQ@mail.gmail.com>
 <CAMi1Hd0-2eDod4HiBifKCxY0cUUEW_A-yv7sZ7GRgL0whWQt+w@mail.gmail.com>
 <CA+55aFx=-tHXjv3gv4W=xYwM+VOHJQE5q5VyihkPK7s560x-vQ@mail.gmail.com>
 <20180731170328.ocb5oikwhwtkyzrj@kshutemo-mobl1> <20180731174349.GA12944@agluck-desk>
 <CA+55aFxJpJvcYKos-sVTsn9q4wK0-m4up1SXrcqfbXHKxaKxjg@mail.gmail.com>
 <CA+55aFz0eKks=v872LA-tDx4qcmBtxTYXbeztZcWbgx6SeQHNg@mail.gmail.com> <20180801205156.zv45fcveexwa2dqs@kshutemo-mobl1>
In-Reply-To: <20180801205156.zv45fcveexwa2dqs@kshutemo-mobl1>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 1 Aug 2018 13:56:19 -0700
Message-ID: <CA+55aFzDxsUU8jUyJN7J35TfeUh7n2xRDjEbW-A-2Fq1CDYQ0w@mail.gmail.com>
Subject: Re: Linux 4.18-rc7
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Tony Luck <tony.luck@intel.com>,
        Amit Pundir <amit.pundir@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        youling 257 <youling257@gmail.com>,
        Joel Fernandes <joelaf@google.com>,
        Colin Cross <ccross@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 1, 2018 at 1:52 PM Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> Is there a reason why we pass vma to flush_tlb_range?

Yes. It's even in that patch.

The fact is, real MM users *have* a vma, and passing it in to the TLB
flushing is the right thing to do. That allows architectures that care
(mainly powerpc, I think) to notice that "hey, this range only had
execute permissions, so I only need to flush the ITLB".

The people who use tlb_flush_range() any other way are doing an
arch-specific hack.  It's not how tlb_flush_range() was defined, and
it's not how you can use it in general.

> It's not obvious to me what information from VMA can be useful for an
> implementation.

See the patch I sent, which had this as part of it:

-                * XXX fix me: flush_tlb_range() should take an mm
pointer instead of a
-                * vma pointer.
+                * flush_tlb_range() takes a vma instead of a mm pointer because
+                * some architectures want the vm_flags for ITLB/DTLB flush.

because I wanted to educate people about why the interface was what it
was, and the "fixme" was bogus shit.

> In longer term we can change the interface to take mm instead of vma.

FUCK NO!

Goddammit, read the code, or read the patch. The places ytou added
those broken vma_init() calls to were architecture-specific hacks.

Those architecture-specific hacks do not get to screw up the design
for everybody else.

                     Linus
