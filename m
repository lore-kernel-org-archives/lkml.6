Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7745C004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 09:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F23820878
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 09:43:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F23820878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbeJBQZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 12:25:49 -0400
Received: from mga12.intel.com ([192.55.52.136]:21031 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbeJBQZs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 12:25:48 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Oct 2018 02:43:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,331,1534834800"; 
   d="scan'208";a="237805674"
Received: from shbuild888.sh.intel.com (HELO localhost) ([10.239.146.239])
  by orsmga004.jf.intel.com with ESMTP; 02 Oct 2018 02:43:24 -0700
Date:   Tue, 2 Oct 2018 17:48:52 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        H Peter Anvin <hpa@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Stuart R . Anderson" <stuart.r.anderson@intel.com>,
        alan@linux.intel.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/earlyprintk: Add a force option for pciserial
 device
Message-ID: <20181002094852.3bw2loje4zjriqe7@shbuild888>
References: <20180928094008.23138-1-feng.tang@intel.com>
 <20180929163458.GA25608@zn.tnic>
 <20180930131619.jecqh4umrkmifavb@shbuild888>
 <20181001123916.GC7269@zn.tnic>
 <20181001141810.fbo3amfqnr5243mc@shbuild888>
 <20181001203004.GG7269@zn.tnic>
 <20181002091627.3vm6ow4y7me2uju3@shbuild888>
 <alpine.DEB.2.21.1810021112100.32062@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1810021112100.32062@nanos.tec.linutronix.de>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Tue, Oct 02, 2018 at 11:17:57AM +0200, Thomas Gleixner wrote:
> On Tue, 2 Oct 2018, Feng Tang wrote:
> 
> > Hi Boris,
> > 
> > On Mon, Oct 01, 2018 at 10:30:04PM +0200, Borislav Petkov wrote:
> > > On Mon, Oct 01, 2018 at 10:18:10PM +0800, Feng Tang wrote:
> > > > As I rechecked, the baud rate for pciserial is optional, so there may
> > > > be no ",baudrate" following the "force". So this 2 strncmp is to
> > > > cover conditions for with and without baudrate.
> > > 
> > > And what guarantees you have a space after the "force"?
> > > 
> > > 	!strncmp(s, "force ", 6)
> > > 			  ^
> > 
> > You are right, it can't be guranteed. Can we still use strncmp(s, "force", 5)
> > and rely on developer to set it right? any suggestions? thanks,
> 
> I don't know why you want strncmp() in the first place. "force" is null
> terminated already.

Current code uses: 
	earlyprintk=pciserial,bus:device.function[,baudrate]
with the patch, it will be:
	earlyprintk=pciserial,bus:device.function[,force][,baudrate]

So the force could be followed by ",baudrate".

Thanks,
Feng


