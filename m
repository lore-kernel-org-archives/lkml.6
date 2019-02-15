Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66706C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C69521B18
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mXrjc13K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388613AbfBOT7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 14:59:09 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35781 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfBOT7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 14:59:08 -0500
Received: by mail-wr1-f68.google.com with SMTP id t18so11611524wrx.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 11:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G6MpTRt9hITm16kxd0MSvasWfAxmc13KF5VrrSmaT7A=;
        b=mXrjc13KUlWOH0HdrmYZrpZAT617PSucAW49NSYkWpMRacG5C3qKo85q9sAV7ZiXq2
         nDfTPPqWWi5ERS3+6FdZDsTq6A2P900i4pdOT+YHJtCIWJMrAfN/fk/xfsMehpfXRQOf
         9gp8pDnyy5jtxi4yLNtrLg5BkUurtURaOUknfcnXhRCcBru8En8V/HqyYz+0AE35m0Wb
         Ktxt623lmRtsQ7cWhdi2cqR4rjhAi4d/UNKsU39y237QvQcQNtBDmtDu4LplfARQUjfO
         ohWrR6P0BTA1Qg07mtgLUNc0ezMCyG34fDhj/4DsKAMgISxJbti1q7ECBHVtsEzxyeHc
         kGRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G6MpTRt9hITm16kxd0MSvasWfAxmc13KF5VrrSmaT7A=;
        b=Uy8jy4HeXk6BuwuKJAY7lvA3i0GRvhoeKBASajNf2nWAFo6WsH4DBSki4bi/jS5kB+
         EkrMxvytOEC2zAGvH5IUvg/NCRZ/Z0qTST99zdHpRDS60g5oDzBG3nFDdlF0RjEst899
         W4Zn8d/Mkl4soW5KspDN7rJhJSyyPJ5zAr15BywAtv2zKEkkpVI32feUkwgmAF0C0Jqj
         SqkSt9LZErk8QAOI1+epSCMH765CSxcX0/txhaY+DsZgvzpWR7P5fPnNMjGtNLqkJPkQ
         ukCXMHrIW4bCmOMmDJk21wzpWCRqQOCwFdIIRu17k18nanFomBIzfP1vI0Dhmhjb5RL+
         JRMw==
X-Gm-Message-State: AHQUAuaww5cEgM8ATjiV9TY29DYSYQ6JhIGN02NZjBn42l7FE25SVOZj
        BNVCFHAdkysSDKB+mEeFKUqBWOyIpt2Fwf2M8UH6Ew==
X-Google-Smtp-Source: AHgI3IbkDFwz7RKGh+x3M6EpAxv8kemBk/DxMCmn8iLvTbmJtf3ioS15rNOw+4I/QhQTrRTKz0LAsO90YkD8hhUn+hg=
X-Received: by 2002:adf:a2cc:: with SMTP id t12mr2571541wra.253.1550260745395;
 Fri, 15 Feb 2019 11:59:05 -0800 (PST)
MIME-Version: 1.0
References: <20190128214408.25442-1-afd@ti.com> <CALAqxLXb53nsBJtb958sMzpr-fnXxqFE0s2B6YJzoGcswv50wg@mail.gmail.com>
 <20190215105057.jujgm4k77rhkvmo7@DESKTOP-E1NTVVP.localdomain>
 <CALAqxLU=L3Y7KJEo9c-Nu1rS3EquofGf1UGWBWqAO+Qke72Ekw@mail.gmail.com> <0cc81357-034b-9c74-8172-2a7a26e77804@ti.com>
In-Reply-To: <0cc81357-034b-9c74-8172-2a7a26e77804@ti.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Fri, 15 Feb 2019 11:58:51 -0800
Message-ID: <CALAqxLXe8KHvx_ce10_W_0uxBsLBsyWw+B9J-fzZU5vTY8VC+Q@mail.gmail.com>
Subject: Re: [PATCH v2] staging: android: ion: Allocate from heap ID directly
 without mask
To:     "Andrew F. Davis" <afd@ti.com>
Cc:     Brian Starkey <Brian.Starkey@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Christoph Hellwig <hch@infradead.org>,
        Liam Mark <lmark@codeaurora.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        lkml <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>, nd <nd@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 11:22 AM Andrew F. Davis <afd@ti.com> wrote:
>
> On 2/15/19 1:01 PM, John Stultz wrote:
> > On Fri, Feb 15, 2019 at 2:51 AM Brian Starkey <Brian.Starkey@arm.com> wrote:
> >> On Thu, Feb 14, 2019 at 09:38:29AM -0800, John Stultz wrote:
> >>> 2) For patches that cause ABI breaks, it might be good to make it
> >>> clear in the commit what the userland impact looks like in userspace,
> >>> possibly with an example, so the poor folks who bisect down the change
> >>> as breaking their system in a year or so have a clear example as to
> >>> what they need to change in their code.
> >>>
> >>> 3) Also, its not clear how a given userland should distinguish between
> >>> the different ABIs.  We already have logic in libion to distinguish
> >>> between pre-4.12 legacy and post-4.12 implementations (using implicit
> >>> ion_free() behavior). I don't see any such check we can make with this
> >>> code. Adding another ABI version may require we provide an actual
> >>> interface version ioctl.
> >>>
> >>
> >> A slightly fragile/ugly approach might be to attempt a small
> >> allocation with a heap_mask of 0xffffffff. On an "old" implementation,
> >> you'd expect that to succeed, whereas it would/could be made to fail
> >> in the "new" one.
> >
> > Yea I think having a proper ION_IOC_VERSION is going to be necessary.
> >
>
> I think that will be helpful to have ready the future just looking at
> the way libdrm does things, but not right now as backwards compatibility
> with staging code is not a reasonable thing to do.

I'm not sure I'm following what you mean here?  While we don't have
any commitment to userland for interfaces in staging, the reality is
that there are a fair number of users affected, and we probably should
avoid causing any needless pain if possible.

Further, as part of my work, I try to keep the hikey boards with an
array of kernels (4.4, 4.9, 4.14, 4.19 and mainline) running with AOSP
master. Having hard build breaks so AOSP has to have build time
dependencies on newer or older kernels is a big pain, and the 4.12 ABI
break was not easy.

So yea, I don't think we should tie our hands in reworking the
interfaces, but it would be nice to avoid having subtle ABI changes
that don't have clear ways for userland to detect which interface
version its using.

> > I'm hoping to send out an ugly first stab at the kernel side for
> > switching to per-heap devices (with a config for keeping /dev/ion for
> > legacy compat), which I hope will address the core issue this patch
> > does (moving away from heap masks to specifically requested heaps).
> >
>
> Yes, that would remove the need for what this patch does.
> Question though, what does the user side look like for this? With the
> old /dev/ion we would:
>
> ion_fd = open("/dev/ion")
> ask for a list of heaps (ioctl on ion_fd)
> iterate over the details of each heap
> pick the best heap for the job
> request allocation from that heap (ioctl on ion_fd)
>
> with per-heap devs we need some way to iterate all over heap devices in
> a system, and extract details from each heap device. Maybe we leave
> /dev/ion but it's only job is to service ION_IOC_HEAP_QUERY requests but
> instead of heap numbers it returns heap names, then device files just
> match those names. Then we go allocate() from those.
>


So my initial thought is we simply use a /dev/ion_heaps/ dir which has
a list of heap devicenodes. /dev/ion goes away.

Currently ION_IOC_HEAP_QUERY returns:
  char name[MAX_HEAP_NAME];
  __u32 type;
  __u32 heap_id;

The names are discoverable via "ls /dev/ion_heaps/"

The heap_id is really only useful as a handle, and after opening the
heap device, we'll have the fd to use.

The only detail we're missing is the type. I'm a little skeptical how
useful type is, but worse case we provide a QUERY ioctl on the heap
device to provide type info.

Most likely, I expect users to:
1) Open "/dev/ion_heaps/<heapname>" for the heap they want (since they
probably already know)
2) make a HEAP_ALLOCATE ioctl on the fd to allocate

But to match the use case you describe:
1) ls /dev/ion_heaps/ for a list of heaps
2) For each heap name, open the heap and make a QUERY ioctl to get
type info (for what its worth)
3) Pick best heap for the job (*handwaving magic!*)
4) Do an ALLOC ioctl on the heap's fd to allocate


Does that sound reasonable?  And I don't really mean to dismiss the
dynamic picking of the best heap part, and having something like a
opaque constraints bitfield that each device and each heap export so
userland can match things up would be great.  But since we don't have
any real solutions there yet(still!), it seems like most gralloc
implementations are likely to be fully knowing which heap they want at
allocation time.

thanks
-john
