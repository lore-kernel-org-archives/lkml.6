Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2325483-1523320708-2-9557139072136588583
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523320707; b=wQjwYB8g0fbM2Vvy/PmU0F/6zt/n46smFbLXCBaJWhXVO3sm34
    iOU8irpfs8SoKmAiq+ATzi415q8GO1p9VDtVGgb+Hu8BgCEYJkADG4CQ1jAVHLD0
    XmNsXiBLwLdq64JX5COWFST8PY3I+aTqe2jWQ/0Vl6mGZRtZ/gaqtoid7a++G+hr
    3wloiypQ9adXUggHQaUXYgBjaeUFKqYm36SBusLJzd/zirSx58N5Qc51BJqTXXne
    I4eGC5eZ9mBApmP0XzicCiwnsQipr/vgyMuBRlatGZJE8HY/laRiiuGuoec4vQks
    HMmnbGN4tb8hOQ6NI3kWoRXmShHRkVb7jQUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523320707;
    bh=1UtgSxwXfEFaX8Df7UWi/OABkfbwkAEvkSKfkO+YfnU=; b=Iz0iwQdYBOT+
    xbgBQeHhe0PEW3M7Mmn2fup/QAuNm4v5w4N27vBGJUcXGj3MOFp+pIC3xRPyBaDs
    2AHRY1Hu8Qd3CWSvTURHJZQJy67AlrOSxxnYHqMgBLCpajG9PshJl+92ewqx3nLm
    8Fonn+00v+Y/vs+OWKcUg/UrmHmspIqPOKBopMfL/GTOCtITnzB5lbowaNI7WZES
    ri3XLiuFK5QfQxL6WppxqXXEVf/JPR3sUXm8J8R94TTnu+9Eae71EmiarnY+kBme
    i0x4ttz5ykc/rhm9FQriIGIf+8YZxfJtuHzilSPb3BYujxTxgWBhprLKpdnWJ3Sj
    wgcVTNAe4w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGdjJsUHMqSv1ZG92FFKxHzLzf1v4FUzb+QZSCH1LKW9x0XCTmYXS8llnkwKsnoFcSn6Hy2fgCxsBJ9dnWcuhUA8y8MvnrFVvYjJbmQi00UlsSnPp8A9
    mGA6lmphEN/WUJ2nk+LBoYo1cuDVPj/w01M2Y+Owqn2HFP2vsa6Fa2Bm5O/bZFw4eefWUN7H1a7BQuPYXWfI0aG1c1Wyd/5VbxbN6pcc3HxInDm98oR7nAWe
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=eIoA60m3DmDpKKo2DPUA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751550AbeDJAiX (ORCPT <rfc822;greg@kroah.com>);
        Mon, 9 Apr 2018 20:38:23 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37022 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751539AbeDJAiX (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Apr 2018 20:38:23 -0400
Date: Mon, 9 Apr 2018 17:38:21 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        stable <stable@vger.kernel.org>, linux-mm <linux-mm@kvack.org>
Subject: Re: [PATCH v2 1/3] mm/gup_benchmark: handle gup failures
Message-Id: <20180409173821.889f0a2dd4385ee2428c16b8@linux-foundation.org>
In-Reply-To: <20180408060935-mutt-send-email-mst@kernel.org>
References: <1522962072-182137-1-git-send-email-mst@redhat.com>
        <1522962072-182137-3-git-send-email-mst@redhat.com>
        <CA+55aFywfktB83dERzYaC1NCYxD+Lg+NRft5ypjmbbcM_qdxpQ@mail.gmail.com>
        <20180408060935-mutt-send-email-mst@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, 8 Apr 2018 06:12:13 +0300 "Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Sat, Apr 07, 2018 at 01:08:43PM -0700, Linus Torvalds wrote:
> > On Thu, Apr 5, 2018 at 2:03 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > >                 nr = get_user_pages_fast(addr, nr, gup->flags & 1, pages + i);
> > > -               i += nr;
> > > +               if (nr > 0)
> > > +                       i += nr;
> > 
> > Can we just make this robust while at it, and just make it
> > 
> >         if (nr <= 0)
> >                 break;
> > 
> > instead? Then it doesn't care about zero vs negative error, and
> > wouldn't get stuck in an endless loop if it got zero.
> > 
> >              Linus
> 
> I don't mind though it alredy breaks out on the next cycle:
> 
>                 if (nr != gup->nr_pages_per_call)
>                         break;
> 
> the only issue is i getting corrupted when nr < 0;
> 

It does help readability to have the thing bail out as soon as we see
something go bad.  This?

--- a/mm/gup_benchmark.c~mm-gup_benchmark-handle-gup-failures-fix
+++ a/mm/gup_benchmark.c
@@ -41,8 +41,9 @@ static int __gup_benchmark_ioctl(unsigne
 		}
 
 		nr = get_user_pages_fast(addr, nr, gup->flags & 1, pages + i);
-		if (nr > 0)
-			i += nr;
+		if (nr <= 0)
+			break;
+		i += nr;
 	}
 	end_time = ktime_get();
 
_
