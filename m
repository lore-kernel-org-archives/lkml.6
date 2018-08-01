Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA09C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A40A20862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:25:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="d1oRLySr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A40A20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732269AbeHAXNI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 19:13:08 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40298 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727086AbeHAXNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 19:13:08 -0400
Received: by mail-pf1-f194.google.com with SMTP id e13-v6so24057pff.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 14:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kE1AGdJ939jQO6DWYLwLyERgIXcKrtdQ0Cb0TkwQWrs=;
        b=d1oRLySrUsBlAah+HeTjeeSJdkueTZIbfzKjP5/yjmBUntlltExmn4Pb2j1HBHIakx
         TbI04WbzYAV8Vh0cki8xEWUHU28pm+AZf50mk0t0lyKNjVFbsB17USBKAxQRabCqfed4
         XDDdJw3815R81RKnwpBSsL1wn5TkICnUxEU0kzqd20/wPhk6XnAHP3BI5OuP83ND17nE
         tjiX693bXOeBquDEYkuzHJRHJ6Ci5m+T7xOOHOPxUS7bFwMezK+C8rFes56u4/NWkTNx
         pnZxCbr/Y5cJ2ytlxAJUJg2Wjz73s5jDTdX26ZawxttutsEYxiXQ9e1/s31Tb90zYvwl
         QYLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kE1AGdJ939jQO6DWYLwLyERgIXcKrtdQ0Cb0TkwQWrs=;
        b=OjowmqKZuzbmEGjDHUA6V4tltwgd7tw//0fjphNEphEBLvSO4T9JMXPeLoSj4I+RVO
         f4skhnwS050L7Fldm5HzLnuAHMXzlC5e5GyCc0yHWZWXlRTGJE/S7+0U10eW+J+kkmrF
         wkrLQ5Re/qIbcZhMyGkLP9XKoWlN6me5KbJzwjGUHkEpDpg92Obols518rKynoRf28oX
         z8pxB0aCd5XOOm+RwwSbtRatS1ZIo6mqP9btWxg2xkPqQUXVB4Pon/SbbvMKKQHTY+Pe
         6QmcVPHpauRfpyd2xwmnCwoLO6+19y2h83cWn1CqhgLZ+uded6lSgmrcq8qFEDovktQm
         Em8g==
X-Gm-Message-State: AOUpUlERw3mf1fMDAV3BoIwCrR3nQCUt5du8x6/rZJsZgOl+aVRDqfBM
        ++5qMH1Eur00/wWrFHBSnW/fYw==
X-Google-Smtp-Source: AAOMgpcl+ZxE2ihBLVaxKi+3ZM+1EKjcWu06csF5P86ynHs5pSW86UTqN7Zz8s+nN0WKrDKs5GtF0w==
X-Received: by 2002:a62:ce81:: with SMTP id y123-v6mr32281pfg.95.1533158724232;
        Wed, 01 Aug 2018 14:25:24 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([134.134.139.83])
        by smtp.gmail.com with ESMTPSA id v6-v6sm68003pfa.28.2018.08.01.14.25.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 14:25:23 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 15EEB3002A5; Thu,  2 Aug 2018 00:25:18 +0300 (+03)
Date:   Thu, 2 Aug 2018 00:25:18 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Linus Torvalds <torvalds@linux-foundation.org>
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
Subject: Re: Linux 4.18-rc7
Message-ID: <20180801212518.jjdwf53p3sj4b455@kshutemo-mobl1>
References: <alpine.LSU.2.11.1807301940460.5904@eggly.anvils>
 <CALAqxLU3cmu4g+HaB6A7=VhY-hW=d9e68EZ=_4JiwX_BigzjPQ@mail.gmail.com>
 <CAMi1Hd0-2eDod4HiBifKCxY0cUUEW_A-yv7sZ7GRgL0whWQt+w@mail.gmail.com>
 <CA+55aFx=-tHXjv3gv4W=xYwM+VOHJQE5q5VyihkPK7s560x-vQ@mail.gmail.com>
 <20180731170328.ocb5oikwhwtkyzrj@kshutemo-mobl1>
 <20180731174349.GA12944@agluck-desk>
 <CA+55aFxJpJvcYKos-sVTsn9q4wK0-m4up1SXrcqfbXHKxaKxjg@mail.gmail.com>
 <CA+55aFz0eKks=v872LA-tDx4qcmBtxTYXbeztZcWbgx6SeQHNg@mail.gmail.com>
 <20180801205156.zv45fcveexwa2dqs@kshutemo-mobl1>
 <CA+55aFzDxsUU8jUyJN7J35TfeUh7n2xRDjEbW-A-2Fq1CDYQ0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFzDxsUU8jUyJN7J35TfeUh7n2xRDjEbW-A-2Fq1CDYQ0w@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2018 at 01:56:19PM -0700, Linus Torvalds wrote:
> On Wed, Aug 1, 2018 at 1:52 PM Kirill A. Shutemov <kirill@shutemov.name> wrote:
> >
> > Is there a reason why we pass vma to flush_tlb_range?
> 
> Yes. It's even in that patch.
> 
> The fact is, real MM users *have* a vma, and passing it in to the TLB
> flushing is the right thing to do. That allows architectures that care
> (mainly powerpc, I think) to notice that "hey, this range only had
> execute permissions, so I only need to flush the ITLB".
> 
> The people who use tlb_flush_range() any other way are doing an
> arch-specific hack.  It's not how tlb_flush_range() was defined, and
> it's not how you can use it in general.

Okay, I see.

ARM, unicore32 and xtensa avoid iTLB flush for non-executable VMAs.

> 
> > It's not obvious to me what information from VMA can be useful for an
> > implementation.
> 
> See the patch I sent, which had this as part of it:
> 
> -                * XXX fix me: flush_tlb_range() should take an mm
> pointer instead of a
> -                * vma pointer.
> +                * flush_tlb_range() takes a vma instead of a mm pointer because
> +                * some architectures want the vm_flags for ITLB/DTLB flush.
> 
> because I wanted to educate people about why the interface was what it
> was, and the "fixme" was bogus shit.

I didn't noticied this. Sorry.

-- 
 Kirill A. Shutemov
