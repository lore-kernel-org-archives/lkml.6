Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D373C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 09:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 413EB20652
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 09:18:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 413EB20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbeJBQA1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 12:00:27 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:59328 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbeJBQA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 12:00:26 -0400
Received: from p5492e4c1.dip0.t-ipconnect.de ([84.146.228.193] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g7GoX-0005jw-Ov; Tue, 02 Oct 2018 11:17:57 +0200
Date:   Tue, 2 Oct 2018 11:17:57 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Feng Tang <feng.tang@intel.com>
cc:     Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        H Peter Anvin <hpa@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Stuart R . Anderson" <stuart.r.anderson@intel.com>,
        alan@linux.intel.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/earlyprintk: Add a force option for pciserial
 device
In-Reply-To: <20181002091627.3vm6ow4y7me2uju3@shbuild888>
Message-ID: <alpine.DEB.2.21.1810021112100.32062@nanos.tec.linutronix.de>
References: <20180928094008.23138-1-feng.tang@intel.com> <20180929163458.GA25608@zn.tnic> <20180930131619.jecqh4umrkmifavb@shbuild888> <20181001123916.GC7269@zn.tnic> <20181001141810.fbo3amfqnr5243mc@shbuild888> <20181001203004.GG7269@zn.tnic>
 <20181002091627.3vm6ow4y7me2uju3@shbuild888>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Oct 2018, Feng Tang wrote:

> Hi Boris,
> 
> On Mon, Oct 01, 2018 at 10:30:04PM +0200, Borislav Petkov wrote:
> > On Mon, Oct 01, 2018 at 10:18:10PM +0800, Feng Tang wrote:
> > > As I rechecked, the baud rate for pciserial is optional, so there may
> > > be no ",baudrate" following the "force". So this 2 strncmp is to
> > > cover conditions for with and without baudrate.
> > 
> > And what guarantees you have a space after the "force"?
> > 
> > 	!strncmp(s, "force ", 6)
> > 			  ^
> 
> You are right, it can't be guranteed. Can we still use strncmp(s, "force", 5)
> and rely on developer to set it right? any suggestions? thanks,

I don't know why you want strncmp() in the first place. "force" is null
terminated already.

Thanks,

	tglx
