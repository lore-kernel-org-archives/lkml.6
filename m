Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA1AC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 21:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57FCD20823
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 21:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbfBEVVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 16:21:49 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:48048 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfBEVVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 16:21:49 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 90126A6FF;
        Tue,  5 Feb 2019 21:21:48 +0000 (UTC)
Date:   Tue, 5 Feb 2019 13:21:46 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        Markus T Metzger <markus.t.metzger@intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 01/13] taint: Introduce a new taint flag (insecure)
Message-Id: <20190205132146.2e61b3df9e7be49e22b7d903@linux-foundation.org>
In-Reply-To: <CALCETrXi=PEOXCQYkCO9BLL+oaoJonRohWoxvUqxZdiWURc3=Q@mail.gmail.com>
References: <20190201205319.15995-1-chang.seok.bae@intel.com>
        <20190201205319.15995-2-chang.seok.bae@intel.com>
        <CALCETrXi=PEOXCQYkCO9BLL+oaoJonRohWoxvUqxZdiWURc3=Q@mail.gmail.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Feb 2019 18:42:29 -0800 Andy Lutomirski <luto@kernel.org> wrote:

> On Fri, Feb 1, 2019 at 12:54 PM Chang S. Bae <chang.seok.bae@intel.com> wrote:
> >
> > For testing (or root-only) purposes, the new flag will serve to tag the
> > kernel taint accurately.
> >
> > When adding a new feature support, patches need to be incrementally
> > applied and tested with temporal parameters. Currently, there is no flag
> > for this usage.
> 
> I think this should be reviewed by someone like akpm.  akpm, for
> background, this is part of an x86 patch series.  If only part of the
> series is applied, the kernel will be blatantly insecure (but still
> functional and useful for testing and bisection), and this taint flag
> will be set if this kernel is booted.  With the whole series applied,
> there are no users of the taint flag in the kernel.
> 
> Do you think this is a good idea?

What does "temporal parameters" mean?  A complete description of this
testing process would help.

I sounds a bit strange.  You mean it assumes that people will partially
apply the series to test its functionality?  That would be inconvenient.

- Can the new and now-unused taint flag be removed again at
  end-of-series?

- It would be a lot more convenient if we had some means of testing
  after the whole series is applied, on a permanent basis - some
  debugfs flag, perhaps?
