Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 80DB5C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 14:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40E21208B2
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 14:53:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40E21208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934264AbeFLOxS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 10:53:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:45264 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933228AbeFLOxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 10:53:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2B6CFAC8A;
        Tue, 12 Jun 2018 14:53:13 +0000 (UTC)
Date:   Tue, 12 Jun 2018 16:53:12 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, Even Xu <even.xu@intel.com>
Subject: Re: [PATCH] hid: intel_ish-hid: ipc: register more pm callbacks to
 support hibernation
In-Reply-To: <20180611015650.51385-1-srinivas.pandruvada@linux.intel.com>
Message-ID: <nycvar.YFH.7.76.1806121651460.6203@cbobk.fhfr.pm>
References: <20180611015650.51385-1-srinivas.pandruvada@linux.intel.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Jun 2018, Srinivas Pandruvada wrote:

> From: Even Xu <even.xu@intel.com>
> 
> Current ish driver only register resume/suspend PM callbacks which
> don't support hibernation (suspend to disk). Now use the
> SIMPLE_DEV_PM_OPS() MACRO instead of struct dev_pm_ops directly.
> The suspend and resume functions will now be used for both suspend
> to RAM and hibernation.
> 
> If power management is disable, SIMPLE_DEV_PM_OPS will do nothing,
> the suspend and resume related functions won't be used, so mark them
> as __maybe_unused to clarify that this is intended behavior, and
> remove #ifdefs for power management.

This describes details the patch does on code level, but what are the user 
observable effects? Hibernation resume doesn't fail any more? Hibernation 
is possible (and wasn't before)? Did kernel crash while trying to 
hibernate and this is the fix? Or ... ?

Thanks,

-- 
Jiri Kosina
SUSE Labs

