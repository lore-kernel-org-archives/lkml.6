Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 685F1C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 15:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 266FF208B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 15:30:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 266FF208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934343AbeFLPad (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 11:30:33 -0400
Received: from mga03.intel.com ([134.134.136.65]:2605 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933762AbeFLPab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 11:30:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jun 2018 08:30:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,215,1526367600"; 
   d="scan'208";a="236522355"
Received: from dabuchho-elbk12.amr.corp.intel.com ([10.254.16.193])
  by fmsmga005.fm.intel.com with ESMTP; 12 Jun 2018 08:30:30 -0700
Message-ID: <634cd945beca786dc77876f71e39459cef6fbd75.camel@linux.intel.com>
Subject: Re: [PATCH] hid: intel_ish-hid: ipc: register more pm callbacks to
 support hibernation
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Jiri Kosina <jikos@kernel.org>, even.xu@intel.com
Cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, Even Xu <even.xu@intel.com>
Date:   Tue, 12 Jun 2018 08:30:30 -0700
In-Reply-To: <nycvar.YFH.7.76.1806121651460.6203@cbobk.fhfr.pm>
References: <20180611015650.51385-1-srinivas.pandruvada@linux.intel.com>
         <nycvar.YFH.7.76.1806121651460.6203@cbobk.fhfr.pm>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.2 (3.28.2-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-06-12 at 16:53 +0200, Jiri Kosina wrote:
> On Sun, 10 Jun 2018, Srinivas Pandruvada wrote:
> 
> > From: Even Xu <even.xu@intel.com>
> > 
> > Current ish driver only register resume/suspend PM callbacks which
> > don't support hibernation (suspend to disk). Now use the
> > SIMPLE_DEV_PM_OPS() MACRO instead of struct dev_pm_ops directly.
> > The suspend and resume functions will now be used for both suspend
> > to RAM and hibernation.
> > 
> > If power management is disable, SIMPLE_DEV_PM_OPS will do nothing,
> > the suspend and resume related functions won't be used, so mark
> > them
> > as __maybe_unused to clarify that this is intended behavior, and
> > remove #ifdefs for power management.
> 
> This describes details the patch does on code level, but what are the
> user 
> observable effects? Hibernation resume doesn't fail any more?
> Hibernation 
> is possible (and wasn't before)? Did kernel crash while trying to 
> hibernate and this is the fix? Or ... ?
Even,
Can you add more details and resubmit ASAP?

Basically after hiberation, the ISH can't resume properly and user may
not see sensor events (for example: screen rotation may not work).
User will not see a crash or panic or anything except the following
message in log:
hid-sensor-hub 001F:8086:22D8.0001: timeout waiting for response from 
ISHTP device 

So this is adding support for S4/hiberbation to ISH.



Thanks,
Srinivas

> 
> Thanks,
> 
