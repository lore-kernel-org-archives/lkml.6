Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A20ECC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 13:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 693A725A67
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 13:30:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 693A725A67
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933969AbeFYNaQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 09:30:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:50076 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933895AbeFYNaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 09:30:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E5594AEE3;
        Mon, 25 Jun 2018 13:30:13 +0000 (UTC)
Date:   Mon, 25 Jun 2018 15:30:12 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
cc:     Mario.Limonciello@dell.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: core: allow concurrent registration of drivers
In-Reply-To: <20180531114929.30545-1-benjamin.tissoires@redhat.com>
Message-ID: <nycvar.YFH.7.76.1806251529480.6203@cbobk.fhfr.pm>
References: <20180531114929.30545-1-benjamin.tissoires@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 May 2018, Benjamin Tissoires wrote:

> Detected on the Dell XPS 9365.
> The laptop has 2 devices that benefit from the hid-generic auto-unbinding.
> When those 2 devices are presented to the userspace, udev loads both
> wacom and hid-multitouch. When this happens, the code in
> __hid_bus_reprobe_drivers() is called concurrently and the second device
> gets reprobed twice.
> An other bug in the power_supply subsystem prevent to remove the wacom
> driver if it just finished its initialization, which basically kills
> the wacom node.
> 
> Fixes c17a7476e4c4 ("HID: core: rewrite the hid-generic automatic unbind")
> 
> Cc: stable@vger.kernel.org # v4.17
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Now staged in for-4.18/upstream-fixes_v2, with the plan to send it to 
Linus this week.

Thanks,

-- 
Jiri Kosina
SUSE Labs

