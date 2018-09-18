Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC14ECE566
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13F2020657
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:30:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13F2020657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729807AbeIRTCi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 15:02:38 -0400
Received: from mga18.intel.com ([134.134.136.126]:12875 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727207AbeIRTCi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 15:02:38 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Sep 2018 06:30:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,389,1531810800"; 
   d="scan'208";a="74204953"
Received: from chenyu-desktop.sh.intel.com (HELO chenyu-desktop) ([10.239.160.116])
  by orsmga008.jf.intel.com with ESMTP; 18 Sep 2018 06:29:58 -0700
Date:   Tue, 18 Sep 2018 21:36:44 +0800
From:   Yu Chen <yu.c.chen@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Pavel Machek <pavel@ucw.cz>,
        Rui Zhang <rui.zhang@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        Zhimin Gu <kookoo.gu@intel.com>,
        Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 3/4][v2] x86, hibernate: Extract the common code of 64/32
 bit system
Message-ID: <20180918133643.GA3120@chenyu-desktop>
References: <cover.1536685746.git.yu.c.chen@intel.com>
 <7266f9b93000c57edd41fcf2cee0dd4d6252a8ef.1536685746.git.yu.c.chen@intel.com>
 <3135968.eiNgRHp3gn@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3135968.eiNgRHp3gn@aspire.rjw.lan>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Fri, Sep 14, 2018 at 11:21:17AM +0200, Rafael J. Wysocki wrote:
> On Tuesday, September 11, 2018 7:20:46 PM CEST Chen Yu wrote:
> > From: Zhimin Gu <kookoo.gu@intel.com>
> > 
> > Reduce the hibernation code duplication between x86-32 and x86-64
> > by extracting the common code into hibernate.c.
> > 
> > No functional change.
> > 
> > +#include "hibernate.c"
> 
> I don't particularly like this.
> 
> Why excatly do you need to include the C file here?
>
OK, I've removed this in a new version.
> Also, the way this change is made makes it quite hard to review, as the
> new code is not exactly the same as the code being removed, so it is
> hard to say whether or not there really are no functional changes
> as claimed.
I've splitted the patch into several sub-patches and reorganized the
code to make it more readable on a new version.
> 
> This is sensitive code, mind you, and really hard to debug if anything goes
> wrong.  Please be super-careful about changing it.
> 
Ok, will test on several platforms and send out the modification.
Best,
Yu
> Thanks,
> Rafael
> 
