Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2996056-1522937856-2-9074541136665565328
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
    1522937855; b=fiPI7Y8sNRQ2ZghJcPwXglMlLihn5NWeAQyKdqEfAxsae2IYid
    cufVS9UfOj/pLfsvg4IpPI937rjLeXSdeMr9G7kGrrFjdId55+aQvCwpcwMVd6By
    OBj8U9gVBCgDlo99I+LN3XjBzHxkYaKHCKMP+LLVG5pTWMPTGfv1wALndTdCybll
    8mTOfDQ1FFbXXHxNXDtY0KNlO/AsF51WedOpmdpW4+7enI8HSGkXkBSCbbxAxa5h
    ljWoqeQ3dSGcKeH/yYC0bMMP/wGY4aen4QSipRMVC0uCnDT+CrjCCD834SY5lT8B
    G0fGXIL97xXU7qqNwtDi4YcE/AHvqnS0hVrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1522937855; bh=KPmRhbcQ6pV1H578/CnSZ+xP8dNzWm
    yNW14B5AZXg5c=; b=rdbBXtxC6Na3ttJILKT2WKFfdeDaN9hny/ALg00VwRAUAp
    ZqivNzp99KJyEAvY15CSFzyVJg5L2Ij6yXZtvUMWdNQ/VKfDSTdQ9I31Tiko6RJH
    muWciGu38s3dM/sJ/vnNKzJ0+hfn4aX1YpIiSZ9jKtnS9p6GIMh3yxcZArNbr4TY
    3p1UKTNK8DASq1swcUXwEtV2guKfRKFm998gSh2IE2IQzW95qWkFF8Xvt/XpQ9kq
    qLrl1kVbNea3UvjNeXB+4+TQASuZ4jr+8ebW5R7L8iHjjoUDwtfmyWesjmKthEaz
    tFG2BaRI/PpUXZtY1JzCPJDHuxh3E0LS6y95mCKA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfIMsOM7HR2nGXAKc20ilBkUnzsRlAjHHFkvKYC1jWfjrK5hLxOvQ7Gi6gj+Abl6LLSMrbtQApgWmKMBjI+bOILl4YDE4XQPQDhRuoCZGH27pxFWd/2+o
    pvLya14VCb+lrrZHAWrjbhWskG/8CAwEDXC3azp5AepVgIxY/r/93eierm1HZLrk074UsOfJ3E/D/2QgPZX1UNI1JGcSuTHocU3EZYyHqKrwolafZjVRSuFn
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=2WSM5aGrnxeXdIeK-bkA:9 a=Z0iOBPkwlx8o0L_e:21
    a=fVXy5dIfzkLtMsse:21 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751179AbeDEORe (ORCPT <rfc822;greg@kroah.com>);
        Thu, 5 Apr 2018 10:17:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60622 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751165AbeDEORd (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 5 Apr 2018 10:17:33 -0400
Date: Thu, 5 Apr 2018 17:17:30 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
Message-ID: <20180405171009-mutt-send-email-mst@kernel.org>
References: <1522431382-4232-1-git-send-email-mst@redhat.com>
 <20180405045231-mutt-send-email-mst@kernel.org>
 <CA+55aFwpe92MzEX2qRHO-MQsa1CP-iz6AmanFqXCV6_EaNKyMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFwpe92MzEX2qRHO-MQsa1CP-iz6AmanFqXCV6_EaNKyMg@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 04, 2018 at 07:40:36PM -0700, Linus Torvalds wrote:
> On Wed, Apr 4, 2018 at 6:53 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > Any feedback on this? As this fixes a bug in vhost, I'll merge
> > through the vhost tree unless someone objects.
> 
> NAK.
> 
> __get_user_pages_fast() returns the number of pages it gets.
> 
> It has never returned an error code, and all the other versions of it
> (architecture-specific) don't either.

Thanks Linus. I can change the docs and all the callers.


I wonder however whether all the following should be changed then:

static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,

...

                        if (!vma || check_vma_flags(vma, gup_flags))
                                return i ? : -EFAULT;

is this a bug in __get_user_pages?


Another example:

                                ret = get_gate_page(mm, start & PAGE_MASK,
                                                gup_flags, &vma,
                                                pages ? &pages[i] : NULL);
                                if (ret)
                                        return i ? : ret;

and ret is -EFAULT on error.


Another example:
                        switch (ret) {
                        case 0:
                                goto retry;
                        case -EFAULT:
                        case -ENOMEM:
                        case -EHWPOISON:
                                return i ? i : ret;
                        case -EBUSY:
                                return i;
                        case -ENOENT:
                                goto next_page;
                        }

it looks like this will return -EFAULT/-ENOMEM/-EHWPOISON
if i is 0.


> If you ask for one page, and get zero pages, then that's an -EFAULT.
> Note that that's an EFAULT regardless of whether that zero page
> happened due to kernel addresses or just lack of mapping in user
> space.
> 
> The documentation is simply wrong if it says anything else. Fix the
> docs, and fix the users.
> 
> The correct use has always been to check the number of pages returned.
> 
> Just looking around, returning an error number looks like it could
> seriously confuse some things.
>
> You have things like the kvm code that
> does the *right* thing:
> 
>         unsigned long ... npinned ...
> 
>         npinned = get_user_pages_fast(uaddr, npages, write ?
> FOLL_WRITE : 0, pages);
>         if (npinned != npages) {
>      ...
> 
> err:
>         if (npinned > 0)
>                 release_pages(pages, npinned);
> 
> and the above code clearly depends on the actual behavior, not on the
> documentation.

This seems to work fine with my patch since it only changes the
case where npinned == 0.

> Any changes in this area would need some *extreme* care, exactly
> because of code like the above that clearly depends on the existing
> semantics.
> 
> In fact, the documentation really seems to be just buggy. The actual
> get_user_pages() function itself is expressly being careful *not* to
> return an error code, it even has a comment to the effect ("Have to be
> a bit careful with return values").
> 
> So the "If no pages were pinned, returns -errno" comment is just bogus.
> 
>                   Linus

I'd like to change the doc then, but it seems that I'll have to change
the implementation in that case too.

-- 
MST
