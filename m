Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E93B8C6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 17:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FA7324650
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 17:50:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FA7324650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934877AbeF2RuS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 13:50:18 -0400
Received: from mga03.intel.com ([134.134.136.65]:62304 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752231AbeF2RuQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 13:50:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jun 2018 10:50:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,286,1526367600"; 
   d="scan'208";a="50920560"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga007.fm.intel.com with ESMTP; 29 Jun 2018 10:50:09 -0700
Message-ID: <24734cab3a622e17a4f6408b63ad8ecdc7b496e6.camel@linux.intel.com>
Subject: Re: [PATCH v12 09/11] x86/tsc: prepare for early sched_clock
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Pavel Tatashin <pasha.tatashin@oracle.com>
Cc:     Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        linux@armlinux.org.uk, Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        John Stultz <john.stultz@linaro.org>, sboyd@codeaurora.org,
        x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        mingo@redhat.com, "H. Peter Anvin" <hpa@zytor.com>,
        douly.fnst@cn.fujitsu.com, Peter Zijlstra <peterz@infradead.org>,
        Prarit Bhargava <prarit@redhat.com>, feng.tang@intel.com,
        Petr Mladek <pmladek@suse.com>, gnomes@lxorguk.ukuu.org.uk,
        linux-s390@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Date:   Fri, 29 Jun 2018 20:50:09 +0300
In-Reply-To: <3ae524498e6833abd5bb225987de97580262c4de.camel@linux.intel.com>
References: <20180621212518.19914-1-pasha.tatashin@oracle.com>
         <20180621212518.19914-10-pasha.tatashin@oracle.com>
         <alpine.DEB.2.21.1806231815060.8650@nanos.tec.linutronix.de>
         <alpine.DEB.2.21.1806232210110.8650@nanos.tec.linutronix.de>
         <CAGM2reYQx769omkWVweEcTMy8WNrKOiuUVo4OFWNh4zW-rc4pg@mail.gmail.com>
         <alpine.DEB.2.21.1806232347540.8650@nanos.tec.linutronix.de>
         <alpine.DEB.2.21.1806261725510.1587@nanos.tec.linutronix.de>
         <CAGM2reYQ23XhQHAOO0Oo8MGvgrjpNZPZkwp+wwsU8Fb+jfANyA@mail.gmail.com>
         <alpine.DEB.2.21.1806270947410.1587@nanos.tec.linutronix.de>
         <alpine.DEB.2.21.1806281159590.1778@nanos.tec.linutronix.de>
         <3ae524498e6833abd5bb225987de97580262c4de.camel@linux.intel.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-06-29 at 17:30 +0300, Andy Shevchenko wrote:
> On Thu, 2018-06-28 at 12:43 +0200, Thomas Gleixner wrote:
> > On Thu, 28 Jun 2018, Thomas Gleixner wrote:
> > > 

> Taking above into consideration, I think we may just remove the legacy
> code from mfld.c and mrfld.c and see what happen.
> 
> If you can tell me points to test, I can prepare patches to remove and
> test on both Medfiled and Merrifield platforms (Penwell and Tangier
> SoCs
> respectively).

I'm almost have a patch series. Tested for now for Intel Merrifield
(Tangier SoC).


-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
