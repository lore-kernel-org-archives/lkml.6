Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0838EC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 07:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A420721522
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 07:56:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A420721522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389391AbeIUNoW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 09:44:22 -0400
Received: from mga12.intel.com ([192.55.52.136]:16967 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389156AbeIUNoW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 09:44:22 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Sep 2018 00:56:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,284,1534834800"; 
   d="scan'208";a="259103794"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by orsmga005.jf.intel.com with SMTP; 21 Sep 2018 00:56:37 -0700
Received: by lahna (sSMTP sendmail emulation); Fri, 21 Sep 2018 10:56:36 +0300
Date:   Fri, 21 Sep 2018 10:56:36 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        rajatja@google.com, casey.g.bowman@intel.com,
        matthew.s.atwood@intel.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pinctrl: intel: Do pin translation in other GPIO
 operations as well
Message-ID: <20180921075636.GD2664@lahna.fi.intel.com>
References: <20180918153621.71984-1-mika.westerberg@linux.intel.com>
 <CACRpkdYhpBYEY0OJA0A15Q7OOM31ogGxeaUbNNqSMpJ9af4hOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdYhpBYEY0OJA0A15Q7OOM31ogGxeaUbNNqSMpJ9af4hOA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 08:26:25AM -0700, Linus Walleij wrote:
> On Tue, Sep 18, 2018 at 8:36 AM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> 
> > For some reason I thought GPIOLIB handles translation from GPIO ranges
> > to pinctrl pins but it turns out not to be the case. This means that
> > when GPIOs operations are performed for a pin controller having a custom
> > GPIO base such as Cannon Lake and Ice Lake incorrect pin number gets
> > used internally.
> >
> > Fix this in the same way we did for lock/unlock IRQ operations and
> > translate the GPIO number to pin before using it.
> >
> > Fixes: a60eac3239f0 ("pinctrl: intel: Allow custom GPIO base for pad groups")
> > Reported-by: Rajat Jain <rajatja@google.com>
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> I applied this for fixes.
> 
> However when merging with devel I get some a merge conflict,
> probably due to some cleanups from Andy.
> 
> I tried to fix it up (just use your code) but please check the
> result.

Looks good to me. Thanks!
