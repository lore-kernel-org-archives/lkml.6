Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3551251-1522956853-2-14691212160331873583
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522956852; b=hg9VeTZ6sSCoTNGDREvum1gbIWS+vAMgol41qdu4/6S9Aa2Ocm
    AAXzQblgX01OgMeJGPnlPtYxVZkrEnXhLV+4OBh+oMkfl90MApv05ujC7/IS1XVj
    4ZefO0+EQbw3VdNFmg4BsLtmHMFU7WStH3oxciOOgKPhpAs6cQz/8M9dOkLZH3yx
    JDdNBvG0DJBMaF/CKurD6XitKr8lb7dt/Cu4MY4WqeldfDD/rAbXoNsP4QZ35WGe
    vsG8Ir4r/niQnl1Vq0wCybusCyV4F4+hs4YwalG5F3v+GtA80TX3J/2dOhwjK0b8
    Zt4Nuv1r9KILpHXoptRWVgY3vlej6ee5VDZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1522956852; bh=eynfkmC9OUyXRHyCdcvpEvTsm8/LN+
    BjjTPSe7yhnng=; b=gmf41UTVah9LmTPuC/FX7Ib0x/dxV282UjSdGsh0NFUbxl
    sZspbavt3peE5D7nZRjQTyYVXpzh/InV5Ho5ZMqaLD0dpg1L33rr0E+W0Gx8f7nb
    J8PnaMkjrFlNjb3lkhtQxfAhXdaxlbN8vaovsGig7y7SD5JLdXQ9FxOK56i/BQTB
    t88JVWQ0dtGOAAQcHMCfdIw5M55X25icjG1kUagLYbjByv2l/EJGX/+Xc/cEdfHZ
    HMcq+ZrcRyHHcUYKJwt/YsI/OsZGP7AvxOwE5aGRR5iJYLxrKC8O2rZnsKg8al0g
    aAHpSn3EngVRIL1dUyUCsdyoEZqKiWh/F1xrFOmw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDhNoz40WoacYu92/jsffvI2e2pYtgawn1lh1Ctgge2mRcIJjg2++dMYiz0XrhtN9Vl66MOLdljlM6Ns/mpCpNHbMyza8Gvzz+z6em17QIsuM0ClEWoE
    lXRG977/ZPuSZQs7BD1KRTiov/u0uW1sB+CxgNJcqH0E9OXKfpCYTIZyaZOgDut2NOdH2Ba64inb+wg6VkF7wbrvFzEzrCRX5hPpOpRWlDv/AjZtA5I6MUmo
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=YFJRoAmte1a55kWLGRkA:9 a=hjdWwQsTuH9362_2:21
    a=8X4wDa6FZ-Hnfxvl:21 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752147AbeDETeL (ORCPT <rfc822;greg@kroah.com>);
        Thu, 5 Apr 2018 15:34:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45574 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751932AbeDETeK (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 5 Apr 2018 15:34:10 -0400
Date: Thu, 5 Apr 2018 22:34:08 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        syzbot+6304bf97ef436580fede@syzkaller.appspotmail.com,
        linux-mm <linux-mm@kvack.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        "Gong, Zhipeng" <zhipeng.gong@intel.com>,
        Akash Goel <akash.goel@intel.com>,
        "Volkin, Bradley D" <bradley.d.volkin@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [PATCH] gup: return -EFAULT on access_ok failure
Message-ID: <20180405215744-mutt-send-email-mst@kernel.org>
References: <1522431382-4232-1-git-send-email-mst@redhat.com>
 <20180405045231-mutt-send-email-mst@kernel.org>
 <CA+55aFwpe92MzEX2qRHO-MQsa1CP-iz6AmanFqXCV6_EaNKyMg@mail.gmail.com>
 <20180405171009-mutt-send-email-mst@kernel.org>
 <CA+55aFz_mCZQPV6ownt+pYnLFf9O+LUK_J6y4t1GUyWL1NJ2Lg@mail.gmail.com>
 <20180405211945-mutt-send-email-mst@kernel.org>
 <CA+55aFwEqnY_Z5T-5UUwbxNJfV5MmfV=-8r73xvBnA1tnU_d_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFwEqnY_Z5T-5UUwbxNJfV5MmfV=-8r73xvBnA1tnU_d_w@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 05, 2018 at 11:43:27AM -0700, Linus Torvalds wrote:
> On Thu, Apr 5, 2018 at 11:28 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > to repeat what you are saying IIUC __get_user_pages_fast returns 0 if it can't
> > pin any pages and that is by design.  Returning 0 on error isn't usual I think
> > so I guess this behaviour should we well documented.
> 
> Arguably it happens elsewhere too, and not just in the kernel.
> "read()" at past the end of a file is not an error, you'll just get 0
> for EOF.
> 
> So it's not really "returning 0 on error".
> 
> It really is simply returning the number of pages it got. End of
> story. That number of pages can be smaller than the requested number
> of pages, and _that_ is due to some error, but note how it can return
> "5" on error too - you asked for 10 pages, but the error happened in
> the middle!
> 
> So the right way to check for error is to bverify that you get the
> number of pages that you asked for. If you don't, something bad
> happened.
> 
> Of course, many users don't actually care about "I didn't get
> everything". They only care about "did I get _something_". Then that 0
> ends up being the error case, but note how it depends on the caller.
> 
> > What about get_user_pages_fast though?
> 
> We do seem to special-case the first page there. I'm not sure it's a
> good idea. But like the __get_user_pages_fast(), we seem to have users
> that know about the particular semantics and depend on it.
> 
> It's all ugly, I agree.
> 
> End result: we can't just change semantics of either of them.
> 
> At least not without going through every single user and checking that
> they are ok with it.
> 
> Which I guess I could be ok with. Maybe changing the semantics of
> __get_user_pages_fast() is acceptable, if you just change it
> *everywhere* (which includes not just he users, but also the couple of
> architecture-specific versions of that same function that we have.
> 
>                     Linus

OK I hope I understood what you are saying here.

At least drivers/gpu/drm/i915/i915_gem_userptr.c seems to
get it wrong:

        pinned = __get_user_pages_fast(obj->userptr.ptr,

        if (pinned < 0) {
                pages = ERR_PTR(pinned);
                pinned = 0;
        } else if (pinned < num_pages) {
                pages = __i915_gem_userptr_get_pages_schedule(obj);
                active = pages == ERR_PTR(-EAGAIN);
        } else {
                pages = __i915_gem_userptr_alloc_pages(obj, pvec, num_pages);
                active = !IS_ERR(pages);
        }

The <0 path is never taken.

Cc maintainers - should that driver be changed to use
get_user_pages_fast?
