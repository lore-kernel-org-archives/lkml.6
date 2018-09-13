Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B92AFC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 09:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A93E20882
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 09:58:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A93E20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbeIMPGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 11:06:42 -0400
Received: from mga11.intel.com ([192.55.52.93]:42118 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726741AbeIMPGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 11:06:42 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Sep 2018 02:57:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,368,1531810800"; 
   d="scan'208";a="72873832"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by orsmga008.jf.intel.com with SMTP; 13 Sep 2018 02:57:53 -0700
Received: by lahna (sSMTP sendmail emulation); Thu, 13 Sep 2018 12:57:53 +0300
Date:   Thu, 13 Sep 2018 12:57:53 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Yehezkel Bernat <yehezkelshb@gmail.com>
Cc:     lukas@wunner.de, Andreas Noever <andreas.noever@gmail.com>,
        michael.jamet@intel.com, stephen@networkplumber.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/5] thunderbolt: Correlate PCI devices with Thunderbolt
 ports
Message-ID: <20180913095753.GF14465@lahna.fi.intel.com>
References: <cover.1536517047.git.lukas@wunner.de>
 <f53ea40a7487e145aa1a62c347cef1814072e140.1536517047.git.lukas@wunner.de>
 <20180910094454.GJ14465@lahna.fi.intel.com>
 <CA+CmpXtUHwu97tA6bTDJKbVyiPrYT0aEWr1SGrP88DFKNybEcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CmpXtUHwu97tA6bTDJKbVyiPrYT0aEWr1SGrP88DFKNybEcA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 12:43:03PM +0300, Yehezkel Bernat wrote:
> On Mon, Sep 10, 2018 at 12:45 PM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> >
> > Hi Lukas,
> >
> > On Sun, Sep 09, 2018 at 11:42:01PM +0200, Lukas Wunner wrote:
> > > Ideas what we can do with correlation:
> > >
> > > * Represent the relationship between PCI devices and Thunderbolt ports
> > >   with symlinks in sysfs.
> >
> > I wonder is that really useful? I don't think we should be adding sysfs
> > entries without any real reason why it would be needed and who would be
> > using them.
> 
> I think Lukas mentioned where it can be useful, even if it isn't used right now.
> We also know this can be useful for some QoS configurations (even if we didn't
> found it useful enough for now).

I have no doubts that is not useful :) The issue is that currently it
does not do anything except adds this functionality to the driver but
nobody uses it. Like in the other parts of the kernel, let's merge this
at the same time when there is a legitimate user for the feature.
