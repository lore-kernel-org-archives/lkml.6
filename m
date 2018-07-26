Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89420C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 13:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AB392083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 13:31:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AB392083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731183AbeGZOsL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 10:48:11 -0400
Received: from twin.jikos.cz ([91.219.245.39]:33825 "EHLO twin.jikos.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730445AbeGZOsL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 10:48:11 -0400
Received: from twin.jikos.cz (jikos@[127.0.0.1])
        by twin.jikos.cz (8.13.6/8.13.6) with ESMTP id w6QDTtBr022122
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 26 Jul 2018 15:29:56 +0200
Received: from localhost (jikos@localhost)
        by twin.jikos.cz (8.13.6/8.13.6/Submit) with ESMTP id w6QDTrvj022118;
        Thu, 26 Jul 2018 15:29:54 +0200
X-Authentication-Warning: twin.jikos.cz: jikos owned process doing -bs
Date:   Thu, 26 Jul 2018 15:29:53 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Alan Cox <alan@linux.intel.com>
cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rich Felker <dalias@libc.org>, x86@kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        LKML <linux-kernel@vger.kernel.org>, jroedel@suse.de
Subject: Re: cpu_no_speculation omissions?
In-Reply-To: <1531767303.4364.109.camel@linux.intel.com>
Message-ID: <alpine.LRH.2.00.1807261529020.1881@gjva.wvxbf.pm>
References: <20180716160513.GA6080@brightrain.aerifal.cx>         <alpine.DEB.2.21.1807161851290.1693@nanos.tec.linutronix.de>         <193fb2f5-8f6c-8fe6-298f-a6af4fae862a@linux.intel.com> <1531767303.4364.109.camel@linux.intel.com>
User-Agent: Alpine 2.00 (LRH 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jul 2018, Alan Cox wrote:

> > > > At least the Centerton (late-generation Bonnell uarch) Atom family 
> > > > is omitted from the cpu_no_speculation table added by commit 
> > > > fec9434a12f3 to arch/x86/kernel/cpu/common.c. Is this intentional? 
> > > > Would a patch adding it and possibly other omissions be welcome?
> > > 
> > > Probably. Dave?
> > 
> > IIRC, Alan Cox was compiling a list on what is affected vs. not.  He
> > would know way better than I.
> 
> The pre Silvermont atom cores are in order. When I did the original
> list I didn't bother with all the 32bit cores as we didn't have any
> 32bit mitigations then.

Now that 32bit PTI is in tip, I believe refresh of that list would be 
justified. CCing Joerg.

-- 
Jiri Kosina
SUSE Labs
