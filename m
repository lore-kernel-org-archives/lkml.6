Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B29C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 12:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FB4A21522
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 12:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TrcaWdiq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FB4A21522
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731543AbeIVSq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 14:46:27 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45578 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729017AbeIVSq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 14:46:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/bjpq5o0/XFTnrSqFgRMHoX4x0Y5+DaI95cP+reMwVA=; b=TrcaWdiqUiABPMmkd8Flfefiv
        eYNJUrdVABYoa8PooinxlfNQ8+214Y5PD414zWFGzCJ6zwzuxov3QVrm3jHmfeUL60YNlkKi8lhII
        UbnftpJZkmvQuHRXSEFuXmgB85IiLiiJ7oqrzuMXl9UowN21LOimOaKy9/RIOPh/whvJXRdjjiNcj
        0eevkL+r6FHSlmAXbx/AdrPBVzED4I/FtT4KGCvAHOVwp4IMw3AlaaQbAe/kqr61BfpfsRj7GS4ft
        Pxr8BK3vnzfmtxPNTr6guc7wv90bIqbYu8czyTM6HpenVDSzB4v7DtaZRj2+MecDDFk4hFiRgP8DB
        PO/1F690Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g3hP6-0007Z7-Nw; Sat, 22 Sep 2018 12:52:56 +0000
Date:   Sat, 22 Sep 2018 05:52:56 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Dhaval Giani <dhaval.giani@gmail.com>
Cc:     alexander.levin@microsoft.com, LKML <linux-kernel@vger.kernel.org>,
        gregkh@linuxfoundation.org, alice.ferrazzi@gmail.com,
        Kevin Hilman <khilman@baylibre.com>,
        Tim Bird <tbird20d@gmail.com>, dvyukov@google.com,
        Laura Abbott <labbott@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        gustavo.padovan@collabora.co.uk,
        "Carpenter,Dan" <dan.carpenter@oracle.com>, knut.omang@oracle.com
Subject: Re: [Announce] LPC 2018: Testing and Fuzzing Microconference
Message-ID: <20180922125256.GB14042@bombadil.infradead.org>
References: <CAPhKKr_XFzGcBBuQ51w7HjZd_Kq3nTOB6uAFG2vP5JH+Vx_eng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPhKKr_XFzGcBBuQ51w7HjZd_Kq3nTOB6uAFG2vP5JH+Vx_eng@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 10:13:15AM -0700, Dhaval Giani wrote:
> Sasha and I are pleased to announce the Testing and Fuzzing track at
> LPC [ 1 ]. We are planning to continue the discussions from last
> year's microconference [2]. Many discussions from the Automated
> Testing Summit [3] will also continue, and a final agenda will come up
> only soon after that.
> 
> Suggested Topics
> 
> - Syzbot/syzkaller
> - ATS
> - Distro/stable testing
> - kernelci
> - kernelci auto bisection
> - Unit testing framework
> 
> We look forward to other interesting topics for this microconference
> as a reply to this email.

I would like to talk about the IDA test suite that was recently merged.
See lib/test_ida.c.  It can be built as a module (CONFIG_TEST_IDA=m),
built-in (=y) or built in userspace (as part of the radix tree test
suite for historical reasons) along with the current kernel code.

Being able to build the test suite in userspace allows for much more
rapid development.  Building it in kernel space offers testing across
a wide range of configurations that I don't have access to and can't
necessarily simulate well in userspace.

My userspace implementation of kmalloc() simulates failures (in a rather
heavy-handed way; every non-GFP_KERNEL allocation fails).  That's rather
harder to simulate in kernel space.  I'd like there to be a way for a
kernel space test suite to ask for kmalloc failures so that the failure
paths can be tested.

I think the idea of building parts of the core kernel libraries in
userspace and testing them there has greater generality than just the
IDA, IDR, XArray & radix tree and might profitably be adopted by other
parts of lib/.  The userspace simulation of other parts of the kernel
may well need to be extended.

I'd also like to do at least kernel-space testing of the page cache.
I have some ideas around that too, but I don't know if they're
sufficiently far advanced to talk about in November.

