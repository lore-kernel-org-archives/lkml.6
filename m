Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3799332-1522962495-2-13104024445027697899
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
    1522962493; b=QpEfmN1SZqVl6wlhNwQQb3nYBKNStjXg1aoPdf9sQ8wJBU+66P
    GCgFh+ycuugN939Tn1aninjIZtDeMFb80u3Eswr+v6s24pzxggSEHX1OAFu0VE4n
    uu4ENrBoVT/d0GAfQcnKoC/OAzf4yoaVPF7GLGdta0OpGi30O29QwWJfaDAsZ9Zy
    FxwZjQINrcKgKxPenihI7sxcWqzVQ8+cblT2ZcmqHLt83axeNCNflRd6rPrHLWMJ
    oO2lwKZ+T2ZHlt5DCUbnHBLG03XVeyuvO+eaCkhR+uYNUOJbMKgL4Ok77yVRD9rh
    s6hcU/Y3XP9oiYUuKGSt060e43J15kLAaxPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1522962493; bh=JMEk+06bvvB5F2pZk6Ru+JYlsZXtzY
    dnFZz0wNLhOm4=; b=oVAIQhfrQeoApXTjZiQqTeV9CSbUSQPHnl6YAuoQrhUqrg
    c2aBNVVXAwIbX9vKJ6LwihmUOD4a6bg62BKWUtwDJanVAhx+b9bFx4l+EL9zYpL4
    q8jPqKtLpE4GZSAQ+1tef3C+Bs5Nm1Q31yObuU3ykAJjWRiK6b+Sj1XQRYYA000w
    WMfYwWixf1pTMqGtQHuQfeLqLbCpANBbjGVi7yJCKBuMeYH3cdxqrwHZzni3gVfo
    YR432GDIHq4/m2NSBm+RI9BiKABrfLk20djc1VbcZlsMCBIB9jpkqcDfHRvTUTFj
    ZiNaoDBnCDiQIYmnECyyvnSROl3387p0eqV84CRw==
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
X-CM-Envelope: MS4wfOd3ln53OW0sJsswuuwPLz5seEUTEq7GoT5vAcGlGESU0A81Uih/qDH8dAg/LiuXmSgowVvni49BOLu9oM69U7T/76X3O3SXE9vdy3C4r/Lt1SHC7FSR
    Am3ZZNzlFysbGkLNWK5FFqSSRRAsG5lpcR20NHoMM9moyw9RGR7+tdkoROX/JuD5nVn32GwUVGnfvGodBFbYDlYunj2br9qUydr02URXJyzVM4Z9B9LMSf4s
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=YFJRoAmte1a55kWLGRkA:9 a=eBt-7hlQDx4KdIgP:21
    a=quuFsX5cWYNWAO1t:21 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751278AbeDEVIL (ORCPT <rfc822;greg@kroah.com>);
        Thu, 5 Apr 2018 17:08:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49514 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750726AbeDEVIK (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 5 Apr 2018 17:08:10 -0400
Date: Fri, 6 Apr 2018 00:08:08 +0300
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
        Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: [PATCH] gup: return -EFAULT on access_ok failure
Message-ID: <20180406000706-mutt-send-email-mst@kernel.org>
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

For now I sent a patchset
1. documenting current behaviour for __get_user_pages_fast.
2. fixing get_user_pages_fast for consistency.

-- 
MST
