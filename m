Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17714C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 18:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0F7A2080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 18:03:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0F7A2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbeJaC5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 22:57:54 -0400
Received: from mga06.intel.com ([134.134.136.31]:58659 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727958AbeJaC5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 22:57:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Oct 2018 11:03:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,445,1534834800"; 
   d="scan'208";a="276950090"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by fmsmga006.fm.intel.com with ESMTP; 30 Oct 2018 11:03:24 -0700
Message-ID: <0d940313e1be7ddaa06c5ebf4aea7a4df84540f2.camel@linux.intel.com>
Subject: Re: [PATCH v2 1/4] platform/x86: intel_pmc_core: Show Latency
 Tolerance info
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        rajneesh.bhardwaj@linux.intel.com
Cc:     Platform Driver <platform-driver-x86@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
Date:   Tue, 30 Oct 2018 11:03:24 -0700
In-Reply-To: <CAHp75Vd8zUR9LYOj1X-3FgqnB_XVZD5hbA+WPN_7T_6kZBAQ5w@mail.gmail.com>
References: <20181006065113.669-1-rajneesh.bhardwaj@linux.intel.com>
         <CAHp75VcQ3SDQ4X9+LX+y2vB4PWQURid4R=qy5+5PkWHC5nGqQA@mail.gmail.com>
         <a839e9d3-838b-0fb1-55ac-07562ec71313@linux.intel.com>
         <CAHp75Vd8zUR9LYOj1X-3FgqnB_XVZD5hbA+WPN_7T_6kZBAQ5w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]
> > > For example, index printing. Please, remove it. I completely
> > > forgot
> > > about userspace powerful tools. At least two very old and nice
> > > can
> > > enumerate lines for you.
> > > Obviously the index printing is redundant.
> > 
> > Index printing is required here (for LTR Show and LTR Ignore)
> > because it
> > paves an obvious and easy way for the users of this driver to know
> > the
> > IP number to be used for LTR ignore. This was specifically
> > requested by
> > some customer and Srinivas asked me to implement this so adding him
> > for
> > his inputs.
> 
> So, why it should be in kernel? When user prints this, they usually
> call `cat /.../file`, right?
> Is it too hard to call `cat -n /.../file` instead? The benefit of
> such
> approach is that it's independent on the file we are printing.
> 
> (Note, `grep -n <PATTERN> /.../file` does the same`)
> 
> For more variants
> 
https://stackoverflow.com/questions/8206370/add-numbers-to-the-beginning-of-every-line-in-a-file
> 
We get copy/paste data from some serial terminals from systems which
don't have traditional linux shell or busy box. Not sure if they can do
cat "-n" option or have this command at all. So line number helps. They
can't even store output as as file as this is RO file system.

But I am not as sticky on this.

Thanks,
Srinivas



