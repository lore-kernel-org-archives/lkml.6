Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A89EC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 12:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4895D2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 12:10:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4895D2089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbeJPUAz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 16:00:55 -0400
Received: from mga07.intel.com ([134.134.136.100]:21816 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726718AbeJPUAy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 16:00:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Oct 2018 05:10:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,388,1534834800"; 
   d="scan'208";a="99628267"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.72.61])
  by fmsmga001.fm.intel.com with ESMTP; 16 Oct 2018 05:10:42 -0700
From:   Jani Nikula <jani.nikula@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/2] sysfs: constify sysfs create/remove files harder
In-Reply-To: <20181016114347.GA21790@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20181004143750.30880-1-jani.nikula@intel.com> <20181016104845.GB4768@kroah.com> <87pnwakto2.fsf@intel.com> <20181016114347.GA21790@kroah.com>
Date:   Tue, 16 Oct 2018 15:10:24 +0300
Message-ID: <87k1miks7j.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Oct 2018, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> On Tue, Oct 16, 2018 at 02:38:53PM +0300, Jani Nikula wrote:
>> On Tue, 16 Oct 2018, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>> > On Thu, Oct 04, 2018 at 05:37:49PM +0300, Jani Nikula wrote:
>> >> Let the passed in array be const (and thus placed in rodata) instead of
>> >> a mutable array of const pointers.
>> >> 
>> >> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> >> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
>> >> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
>> >> ---
>> >>  fs/sysfs/file.c       | 4 ++--
>> >>  include/linux/sysfs.h | 8 ++++----
>> >>  2 files changed, 6 insertions(+), 6 deletions(-)
>> >
>> > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> 
>> Thanks; who should pick them up?
>
> I could pick the first one up, but as you need this for a drm patch,
> both should probably go through that tree, right?

I can pick them both if it doesn't bother you that the sysfs parts will
be merged in the merge window for v4.21 i.e. the change would be in drm
trees for an entire release cycle. We've been done for v4.20 merge
window for a while now.

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
