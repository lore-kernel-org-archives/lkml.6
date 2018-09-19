Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8975C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 08:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D08E208A3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 08:47:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D08E208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731072AbeISOYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 10:24:49 -0400
Received: from mga18.intel.com ([134.134.136.126]:18731 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727669AbeISOYt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 10:24:49 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Sep 2018 01:47:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,393,1531810800"; 
   d="scan'208";a="74216878"
Received: from chenyu-desktop.sh.intel.com (HELO chenyu-desktop) ([10.239.160.116])
  by orsmga007.jf.intel.com with ESMTP; 19 Sep 2018 01:47:53 -0700
Date:   Wed, 19 Sep 2018 16:54:41 +0800
From:   Yu Chen <yu.c.chen@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        kookoo.gu@intel.com
Subject: Re: [PATCH 03/12][RFC v3] x86-32/asm/power: Create stack frames in
 hibernate_asm_32.S
Message-ID: <20180919085441.GA2335@chenyu-desktop>
References: <cover.1537275915.git.yu.c.chen@intel.com>
 <19aed6bb376b47f672800b4c59da07efca0f9e5a.1537275915.git.yu.c.chen@intel.com>
 <CAJZ5v0jrodgg_j_dEUDsfPibaSDouXVpt-++UQ3-k_7M41dpTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jrodgg_j_dEUDsfPibaSDouXVpt-++UQ3-k_7M41dpTA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 10:41:16AM +0200, Rafael J. Wysocki wrote:
> On Wed, Sep 19, 2018 at 9:31 AM Chen Yu <yu.c.chen@intel.com> wrote:
> >
> > From: Zhimin Gu <kookoo.gu@intel.com>
> >
> > Backport
> > Commit ef0f3ed5a4ac (x86/asm/power: Create stack frames
> > in hibernate_asm_64.S)
> > and
> > Commit 4ce827b4cc58 (x86/power/64: Fix hibernation return
> > address corruption)
> >
> > And also prepare for relocated code and jump address
> > mapping.
> 
> I don't like the changelog.
> 
> It should explain the technical reasons for making the changes in the
> first place and then mention that analogous changes were made for
> 64-bit before and by which commits.
>
Ok, will change it in next version.

Thanks,
Yu
> Thanks,
> Rafael
