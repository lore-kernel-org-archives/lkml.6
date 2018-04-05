Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3493453-1522952911-2-12274059175734828677
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
    1522952910; b=D2gcxuvdzF0BSATrYOvvkKrQNZp7MTKne4PUFajkM88jQ6VBvi
    XK05KG5zz3BJq1sLPmFda1nJAKTqnK/7h4gf0cejLRwMO6Qy3GG3LH/345AwcJP3
    ZL10S2bV/bnq2Q2U9FyRxvML0mGAHWDXWyQJ5RewURHzY84UK8TcMb+tx0uhLxHk
    RJgFf6LIFbjCfaj9uhPobKWjE3bjNU8OsoH2GXj+JGNm+3L5PCtHnazrrWBi4s9A
    PDxzFZxCsbikxQiBsdtMBSRVmUqYPIfrktBnmU9e0hZBwDrot64yAxQpFBLsBHHi
    U78H/qxOWpL0udKBFMDJhoCAZU8ZTyqYAH4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1522952910; bh=5p521ZdmvfQg+RTIqdDQVaeplqZqx5
    isCCfzodCgTBM=; b=RfjPjlnrOXZithzxOGZ26IxnObZmP0MlXs+bE7KkxZd55g
    l5bMyj7Bu5dRQ17uCtPUys1DifxiwFTXnqpJ2Pfb4Op9achxATUL1ZVi5YGTEkhS
    aXq+U0jXYj58PvwfXvejaS9z7aVcmqV9NVHTYmdkQBIIcQu1KW9GHgvxfY0rGtSO
    Jwi3Ycs32oUL3VFZigfEJgx8WTreEacxT3LXjNppzTrIL5PzBAK+1H12lyQMlZ7L
    Zcdeg7RlhRUA08f+bGjOgFrtJss8RRjkn4UPj64hic8mDCOiUSa+i9O+BTOyq0od
    xMzuzVEPFRzSf4EROP9+xQcqPnaZbmuY1JSUpt8Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfFq0/FAUe6J6YypfHBwcoXNzFgdBVEYduQCgra6Svyzl1DIXHiwhNljrf8V8JxQLGeSwwpvGO/XwNu2GviKBeu1me2yI4Xk1ESKb/B1CWE792AjiCXd2
    AeuxIToSWKeUbAlCQLh9C7CwVI5+ZECxSnCdymzkIWYTUyKsn9udHDEjJm2GbhUvYphPHoH06PfjBacUAfVdVaYnBBCeXbtDJES66v9NSS8Mpdd4wdwxMPbO
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=g4EqOUF-PbgzPDwEAKYA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751463AbeDES22 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 5 Apr 2018 14:28:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34838 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751442AbeDES21 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 5 Apr 2018 14:28:27 -0400
Date: Thu, 5 Apr 2018 21:28:25 +0300
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
Message-ID: <20180405211945-mutt-send-email-mst@kernel.org>
References: <1522431382-4232-1-git-send-email-mst@redhat.com>
 <20180405045231-mutt-send-email-mst@kernel.org>
 <CA+55aFwpe92MzEX2qRHO-MQsa1CP-iz6AmanFqXCV6_EaNKyMg@mail.gmail.com>
 <20180405171009-mutt-send-email-mst@kernel.org>
 <CA+55aFz_mCZQPV6ownt+pYnLFf9O+LUK_J6y4t1GUyWL1NJ2Lg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFz_mCZQPV6ownt+pYnLFf9O+LUK_J6y4t1GUyWL1NJ2Lg@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 05, 2018 at 08:40:05AM -0700, Linus Torvalds wrote:
> On Thu, Apr 5, 2018 at 7:17 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > I wonder however whether all the following should be changed then:
> >
> > static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
> >
> > ...
> >
> >                         if (!vma || check_vma_flags(vma, gup_flags))
> >                                 return i ? : -EFAULT;
> >
> > is this a bug in __get_user_pages?
> 
> Note the difference between "get_user_pages()", and "get_user_pages_fast()".
> 
> It's the *fast* versions that just return the number of pages pinned.
> 
> The non-fast ones will return an error code for various cases.
> 
> Why?
> 
> The non-fast cases actually *have* various error cases. They can block
> and get interrupted etc.
> 
> The fast cases are basically "just get me the pages, dammit, and if
> you can't get some page, stop".
> 
> At least that's one excuse for the difference in behavior.
> 
> The real excuse is probably just "that's how it worked" - the fast
> case just walked the page tables and that was it.
> 
>                  Linus

I see, thanks for the clarification Linus.

to repeat what you are saying IIUC __get_user_pages_fast returns 0 if it can't
pin any pages and that is by design.  Returning 0 on error isn't usual I think
so I guess this behaviour should we well documented.

That part of my patch was wrong and should be replaced with a doc
update.

What about get_user_pages_fast though? That's the other part of the
patch. Right now get_user_pages_fast does:

                ret = get_user_pages_unlocked(start, nr_pages - nr, pages,
                                write ? FOLL_WRITE : 0);

                /* Have to be a bit careful with return values */
                if (nr > 0) {
                        if (ret < 0)
                                ret = nr;
                        else
                                ret += nr;
                }

so an error on the 1st page gets propagated to the caller,
and that get_user_pages_unlocked eventually calls __get_user_pages
so it does return an error sometimes.

Would it be correct to apply the second part of the patch then
(pasted below for reference) or should get_user_pages_fast
and all its callers be changed to return 0 on error instead?

@@ -1806,9 +1809,12 @@ int get_user_pages_fast(unsigned long start, int nr_pages, int write,
 	len = (unsigned long) nr_pages << PAGE_SHIFT;
 	end = start + len;
 
+	if (nr_pages <= 0)
+		return 0;
+
 	if (unlikely(!access_ok(write ? VERIFY_WRITE : VERIFY_READ,
 					(void __user *)start, len)))
-		return 0;
+		return -EFAULT;
 
 	if (gup_fast_permitted(start, nr_pages, write)) {
 		local_irq_disable();

-- 
MST
