Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3645978-1522957227-2-18113905984695966477
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522957226; b=oswS0LY1jNRrqVl7r/RiZSsZ+r3h0GJIpbGtMdjcWSnBgSUKfA
    tAJQ8u3MNT5p8kR2581zekyXk9c/oK7GtfmlqteRgTca1gp/w/rTSnvlJlY31v/l
    aQNZ0HeNSx/aygbOwGv7c+lrH4qA0iiCsJ4L8/F3szET2s68htDSSoPGc/jKLcdd
    6R3Rk1NFEJMUJ/kOILs4ud6tJHYWKODuzOZXIx1QrrD9dO6YWjBIowvdw+po+DuR
    w2hWVACXxd1XHd+1WoIm3SdmmwKCcrNEEnchem7wV+GjREVvKP0a0HlwoYzUxlEy
    aZqfnFiGm/mcsQmgX3ZOEBtmcPtnVxtm8Z0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:mime-version
    :content-transfer-encoding:to:from:in-reply-to:cc:references
    :message-id:subject:date:sender:list-id; s=fm2; t=1522957226;
    bh=aF0SXRaPnYrChkz1v4SE8NrOmk7Qy6Z41bkVGYL9edU=; b=b6apPJ9CNRa0
    BbQxmwsNdO6LaLZ7BAccOxiaBj1tZ7Pml3Cw49Z+yHp7+yVXHQKSohDqyoYNkxyV
    /idicV494h+ULRNX21EbkaYjWjBsH7D5D29pDZleuUn5tQJXHKOp7/SAVr1RtC1o
    dhBbtV1G4JqGNpnnXkNYNuE9gX15oI+JPlGDBYJX0IIM7bdwA7yvmHQkdX2O+9Wf
    HwGaNRTUMwQ8kV1pqDz9XusmNXTvYMbOLyIss0sLon6l2b3Gt6249oq7MEsAyKGL
    PweC6I3n8CgFYeS+fHJZfEtR9XdxClbc4ZMKfCN+7X7PXHn3r9dat7cPyYU4lvVi
    SgyPkK2STg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=chris-wilson.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chris-wilson.co.uk header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=chris-wilson.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chris-wilson.co.uk header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGqZ8SAyNUqhOyPDUXg4C5mUhpBNayjBiMGtggQ3GTnantDV+Fjau3iCfiekDz001/Td15Zr4e7Z78DD1k9g+02ZMGXEypH+FQ25gX89lTq6kIQh8JSb
    Czb1aHv6eUVdNcTZ/JAibck1zPRe/orBOz/UPnxbzar8Uqllet1cWWUpDjsIJdK2L9ucGav6ZpNYLVcfgtvpYfCDJFfKDCwdIof6XWFoQ3z79eLRw+7ECcCB
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=6G3QAWe9yubeOTrm6rwA:9 a=yJbCQCp5_vgH_PXD:21
    a=pkCVvNeuD7-q-Ohb:21 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752147AbeDETkY convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Thu, 5 Apr 2018 15:40:24 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:55484 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751952AbeDETkX (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 5 Apr 2018 15:40:23 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: "Michael S. Tsirkin" <mst@redhat.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>
From: Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <20180405215744-mutt-send-email-mst@kernel.org>
Cc: "Al Viro" <viro@zeniv.linux.org.uk>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "stable" <stable@vger.kernel.org>,
        syzbot+6304bf97ef436580fede@syzkaller.appspotmail.com,
        "linux-mm" <linux-mm@kvack.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Huang Ying" <ying.huang@intel.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Thorsten Leemhuis" <regressions@leemhuis.info>,
        "Tvrtko Ursulin" <tvrtko.ursulin@linux.intel.com>,
        "Gong, Zhipeng" <zhipeng.gong@intel.com>,
        "Akash Goel" <akash.goel@intel.com>,
        "Volkin, Bradley D" <bradley.d.volkin@intel.com>,
        "Daniel Vetter" <daniel.vetter@ffwll.ch>
References: <1522431382-4232-1-git-send-email-mst@redhat.com>
 <20180405045231-mutt-send-email-mst@kernel.org>
 <CA+55aFwpe92MzEX2qRHO-MQsa1CP-iz6AmanFqXCV6_EaNKyMg@mail.gmail.com>
 <20180405171009-mutt-send-email-mst@kernel.org>
 <CA+55aFz_mCZQPV6ownt+pYnLFf9O+LUK_J6y4t1GUyWL1NJ2Lg@mail.gmail.com>
 <20180405211945-mutt-send-email-mst@kernel.org>
 <CA+55aFwEqnY_Z5T-5UUwbxNJfV5MmfV=-8r73xvBnA1tnU_d_w@mail.gmail.com>
 <20180405215744-mutt-send-email-mst@kernel.org>
Message-ID: <152295717252.23264.15314297102427001125@mail.alporthouse.com>
User-Agent: alot/0.3.6
Subject: Re: [PATCH] gup: return -EFAULT on access_ok failure
Date: Thu, 05 Apr 2018 20:39:32 +0100
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Quoting Michael S. Tsirkin (2018-04-05 20:34:08)
> On Thu, Apr 05, 2018 at 11:43:27AM -0700, Linus Torvalds wrote:
> > On Thu, Apr 5, 2018 at 11:28 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > to repeat what you are saying IIUC __get_user_pages_fast returns 0 if it can't
> > > pin any pages and that is by design.  Returning 0 on error isn't usual I think
> > > so I guess this behaviour should we well documented.
> > 
> > Arguably it happens elsewhere too, and not just in the kernel.
> > "read()" at past the end of a file is not an error, you'll just get 0
> > for EOF.
> > 
> > So it's not really "returning 0 on error".
> > 
> > It really is simply returning the number of pages it got. End of
> > story. That number of pages can be smaller than the requested number
> > of pages, and _that_ is due to some error, but note how it can return
> > "5" on error too - you asked for 10 pages, but the error happened in
> > the middle!
> > 
> > So the right way to check for error is to bverify that you get the
> > number of pages that you asked for. If you don't, something bad
> > happened.
> > 
> > Of course, many users don't actually care about "I didn't get
> > everything". They only care about "did I get _something_". Then that 0
> > ends up being the error case, but note how it depends on the caller.
> > 
> > > What about get_user_pages_fast though?
> > 
> > We do seem to special-case the first page there. I'm not sure it's a
> > good idea. But like the __get_user_pages_fast(), we seem to have users
> > that know about the particular semantics and depend on it.
> > 
> > It's all ugly, I agree.
> > 
> > End result: we can't just change semantics of either of them.
> > 
> > At least not without going through every single user and checking that
> > they are ok with it.
> > 
> > Which I guess I could be ok with. Maybe changing the semantics of
> > __get_user_pages_fast() is acceptable, if you just change it
> > *everywhere* (which includes not just he users, but also the couple of
> > architecture-specific versions of that same function that we have.
> > 
> >                     Linus
> 
> OK I hope I understood what you are saying here.
> 
> At least drivers/gpu/drm/i915/i915_gem_userptr.c seems to
> get it wrong:
> 
>         pinned = __get_user_pages_fast(obj->userptr.ptr,
> 
>         if (pinned < 0) {
>                 pages = ERR_PTR(pinned);
>                 pinned = 0;
>         } else if (pinned < num_pages) {
>                 pages = __i915_gem_userptr_get_pages_schedule(obj);
>                 active = pages == ERR_PTR(-EAGAIN);
>         } else {
>                 pages = __i915_gem_userptr_alloc_pages(obj, pvec, num_pages);
>                 active = !IS_ERR(pages);
>         }
> 
> The <0 path is never taken.

Please note that it only recently lost other paths that set an error
beforehand. Not exactly wrong since the short return is expected and
handled.

> Cc maintainers - should that driver be changed to use
> get_user_pages_fast?

It's not allowed to fault. __gup_fast has that comment, gup_fast does
not.
-Chris
