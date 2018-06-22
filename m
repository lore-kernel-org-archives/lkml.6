Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 319D6C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 02:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC3DE23C35
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 02:08:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC3DE23C35
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934328AbeFVCIj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 22:08:39 -0400
Received: from mga14.intel.com ([192.55.52.115]:37897 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934181AbeFVCIh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 22:08:37 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jun 2018 19:08:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,255,1526367600"; 
   d="scan'208";a="51896125"
Received: from sandybridge-desktop.sh.intel.com (HELO sandybridge-desktop) ([10.239.160.116])
  by orsmga006.jf.intel.com with ESMTP; 21 Jun 2018 19:08:35 -0700
Date:   Fri, 22 Jun 2018 10:14:10 +0800
From:   Yu Chen <yu.c.chen@intel.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>,
        "Lee, Chun-Yi" <jlee@suse.com>, Borislav Petkov <bp@alien8.de>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3][RFC] Introduce the in-kernel hibernation encryption
Message-ID: <20180622021410.GA30305@sandybridge-desktop>
References: <cover.1529486870.git.yu.c.chen@intel.com>
 <20180621085332.GA21807@amd>
 <CAJZ5v0izS8CNzhsd_bjB40xTkZxaxh13NtHsJi9LYXEr84MoMA@mail.gmail.com>
 <20180621191443.GB14623@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621191443.GB14623@amd>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Thu, Jun 21, 2018 at 09:14:43PM +0200, Pavel Machek wrote:
> On Thu 2018-06-21 14:08:40, Rafael J. Wysocki wrote:
> > On Thu, Jun 21, 2018 at 10:53 AM, Pavel Machek <pavel@ucw.cz> wrote:
> > > Hi!
> > >
> > >> As security becomes more and more important, we add the in-kernel
> > >> encryption support for hibernation.
> > > ...
> > >> There was a discussion on the mailing list on whether this key should
> > >> be derived in kernel or in user space. And it turns out to be generating
> > >> the key by user space is more acceptable[1]. So this patch set is divided
> > >> into two parts:
> > >> 1. The hibernation snapshot encryption in kernel space,
> > >> 2. the key derivation implementation in user space.
> > >
> > > uswsusp was created so that this kind of stuff could be kept in
> > > userspace. You get graphical progress bar (etc) too. As you already
> > > have userspace component for key derivation, I see no advantages to
> > > uswsusp.
> > >
> > > If you have some, please explain.
> > 
> > Not having to transfer plain text kernel memory to user space is one
> > IMO.
> 
> Well, AFAICT in this case userland has the key and encrypted data are
> on disk. That does not seem to be improvement.
> 
uswsusp needs to read the snapshot from kernel first, while
do encryption in kernel directly would reduce the IO. Besides,
the kernel memory content is protect from been read from
user space from first place, although finally they are
encrypted on the disk.

Best,
Yu

