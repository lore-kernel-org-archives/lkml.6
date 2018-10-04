Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C03C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 19:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5100020877
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 19:09:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5100020877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbeJECEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 22:04:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:50010 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727293AbeJECEW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 22:04:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F3804B059;
        Thu,  4 Oct 2018 19:09:43 +0000 (UTC)
Date:   Thu, 4 Oct 2018 21:09:43 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Harry Cutts <hcutts@chromium.org>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Input: reserve 2 events code because of HID
In-Reply-To: <20181004123430.29348-1-benjamin.tissoires@redhat.com>
Message-ID: <nycvar.YFH.7.76.1810042109100.14430@cbobk.fhfr.pm>
References: <20181004123430.29348-1-benjamin.tissoires@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Oct 2018, Benjamin Tissoires wrote:

> Prior to commit 190d7f02ce8e ("HID: input: do not increment usages when
> a duplicate is found") from the v4.18 kernel, HID used to shift the
> event codes if a duplicate usage was found. This ended up in a situation
> where a device would export a ton of ABS_MISC+n event codes, or a ton
> of REL_MISC+n event codes.
> 
> This is now fixed, however userspace needs to detect those situation.
> Fortunately, ABS_MT_SLOT-1 (ABS_MISC+6) was never assigned a code, and
> so libinput can detect fake multitouch devices from genuine ones by
> checking if ABS_MT_SLOT-1 is set.
> 
> Now that we have REL_WHEEL_HI_RES, libinput won't be able to differentiate
> true high res mice from some other device in a pre-v4.18 kernel.
> 
> Set in stone that the ABS_MISC+6 and REL_MISC+1 are reserved and should not
> be used so userspace can properly work around those old kernels.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---
> 
> Dmitry, I did not take your Acked-by, as I added 2 new events and wanted to
> be sure you are still OK.
> 
> Jiri, this will still need to go through your tree, as the input-event-codes
> changes that introduce REL_WHEEL_HI_RES are in your for-4.20/logitech-highres.

Applied, thanks Benjamin.

-- 
Jiri Kosina
SUSE Labs

