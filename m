Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D612FC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 11:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9618F204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 11:34:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9618F204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935544AbeFMLeQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 07:34:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:33621 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935528AbeFMLeO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 07:34:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3770AAC46;
        Wed, 13 Jun 2018 11:34:13 +0000 (UTC)
Date:   Wed, 13 Jun 2018 13:34:12 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Even Xu <even.xu@intel.com>
cc:     srinivas.pandruvada@linux.intel.com, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] hid: intel_ish-hid: ipc: register more pm callbacks to
 support hibernation
In-Reply-To: <1455221494-2915-1-git-send-email-even.xu@intel.com>
Message-ID: <nycvar.YFH.7.76.1806131333500.6203@cbobk.fhfr.pm>
References: <1455221494-2915-1-git-send-email-even.xu@intel.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Feb 2016, Even Xu wrote:

> Current ISH driver only registers suspend/resume PM callbacks which don't
> support hibernation (suspend to disk). Basically after hiberation, the ISH
> can't resume properly and user may not see sensor events
> (for example: screen rotation may not work).
> 
> User will not see a crash or panic or anything except the following message
> in log:
> hid-sensor-hub 001F:8086:22D8.0001: timeout waiting for response from ISHTP device
> 
> So this patch adds support for S4/hiberbation to ISH by using the
> SIMPLE_DEV_PM_OPS() MACRO instead of struct dev_pm_ops directly. The suspend
> and resume functions will now be used for both suspend to RAM and hibernation.
> 
> If power management is disabled, SIMPLE_DEV_PM_OPS will do nothing, the suspend
> and resume related functions won't be used, so mark them as __maybe_unused to
> clarify that this is the intended behavior, and remove #ifdefs for power
> management.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Even Xu <even.xu@intel.com>
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Applied to hid.git#for-4.18/upstream-fixes. Thanks,

-- 
Jiri Kosina
SUSE Labs

