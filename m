Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1205759-1523157141-2-16303425884625300934
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
    1523157141; b=YkPwdruo24KfQaXPeGag5eP7Fv3jhm4mWr1JcG2mO7oEg4xFcl
    KFmy+1S5T2r2nKluT2oNa6ucv5f2KGrLL5gknTQCy7caM/6IUlmvZc7/P4VS/JlV
    9BAnjOqY/aAkPb866Ot8YXioxH3SH4Vkfep+8+J1p1Q8rM4imsKueU+p3uIGJvwY
    4etdiMIClEcoRF6PPMc4Csab0zZo3LRg2hu2oGD/ufS3ViIRKZwdXZU6RvCazk+V
    mUPZkQkZFwP4B8fCToKBWHMSrtMYCpd87zKgz/Dkc6s69AeIkDlEekD1JEIm5zib
    6ODiGNlE4gQiv0QH12W0VrTFUoWLlbnEQxkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523157141; bh=ZmS9NEtAAfxV7cNULLSVPTKJI+A9fX
    3O8OfPr9BghEE=; b=UXBLdIa+6jKcsZSPXxdLZxTMtBqTZ3o3e9A88z67MCUF+3
    hhW/zPyBbgRn6pvqmfLkyhbmissxsOdCcIkgB71juV7C2CJQdjIyCtmXIlTAQwWV
    MMoKuZX8PBWZMjEnE+HwDNybOjfxsK3BefVnUUclS97gb2e+UiMw/m72mVkQwJL0
    IyIkflxB7oYzgpyBcEr0eZW2rLwESE9lVLwov8tTqs6VH/zcoHpdmqW3tWN1Ouv2
    qaIyIkL2FZCUccZXnLitw2S7NMexa1YQAEmsI1lOtUlM8rIdj5LkBXcUhCMMMRH7
    rOPqv9aSdTEweXZsS+56yD1Pq6lKEt5AaM04an1g==
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
X-CM-Envelope: MS4wfMcsiaApiNsTpleH5LZQBidoBSnJNR2OIvCEkgA/MATPEkuAuPnhzUhzI3zlKhix+dporXxDUpCHXNK55lbw0AVq0et1QCcdKeXB4lb8sP/BuJsImumn
    QCGG7DcmqxwD1Ybdkhw+aGU4OsLRyXrbY6MOYzh1W+JR907/+RByB74pAS1h+vWP+Y4HOa+gbSU2aIMHg0J/dvMguj5PqtDZ3UWJ3TL27QLnIEDTbnzaE5Ar
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=lqAKIwt-UqUpJVJSZBIA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752463AbeDHDMS (ORCPT <rfc822;greg@kroah.com>);
        Sat, 7 Apr 2018 23:12:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57784 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752460AbeDHDMS (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 7 Apr 2018 23:12:18 -0400
Date: Sun, 8 Apr 2018 06:12:13 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        stable <stable@vger.kernel.org>, linux-mm <linux-mm@kvack.org>
Subject: Re: [PATCH v2 1/3] mm/gup_benchmark: handle gup failures
Message-ID: <20180408060935-mutt-send-email-mst@kernel.org>
References: <1522962072-182137-1-git-send-email-mst@redhat.com>
 <1522962072-182137-3-git-send-email-mst@redhat.com>
 <CA+55aFywfktB83dERzYaC1NCYxD+Lg+NRft5ypjmbbcM_qdxpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFywfktB83dERzYaC1NCYxD+Lg+NRft5ypjmbbcM_qdxpQ@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Apr 07, 2018 at 01:08:43PM -0700, Linus Torvalds wrote:
> On Thu, Apr 5, 2018 at 2:03 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> >                 nr = get_user_pages_fast(addr, nr, gup->flags & 1, pages + i);
> > -               i += nr;
> > +               if (nr > 0)
> > +                       i += nr;
> 
> Can we just make this robust while at it, and just make it
> 
>         if (nr <= 0)
>                 break;
> 
> instead? Then it doesn't care about zero vs negative error, and
> wouldn't get stuck in an endless loop if it got zero.
> 
>              Linus

I don't mind though it alredy breaks out on the next cycle:

                if (nr != gup->nr_pages_per_call)
                        break;

the only issue is i getting corrupted when nr < 0;
