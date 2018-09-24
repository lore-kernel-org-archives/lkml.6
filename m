Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B874DC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 09:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6913D2145D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 09:24:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6913D2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbeIXPZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 11:25:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:34954 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725935AbeIXPZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 11:25:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 96221AD94;
        Mon, 24 Sep 2018 09:24:13 +0000 (UTC)
Date:   Mon, 24 Sep 2018 11:24:12 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
cc:     linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hyper-v: Fix wakeup from suspend-to-idle
In-Reply-To: <20180912161101.2634-1-vkuznets@redhat.com>
Message-ID: <nycvar.YFH.7.76.1809241123040.15880@cbobk.fhfr.pm>
References: <20180912161101.2634-1-vkuznets@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Sep 2018, Vitaly Kuznetsov wrote:

> It makes little sense but still possible to put Hyper-V guests into
> suspend-to-idle state. To wake them up two wakeup sources were registered
> in the past: hyperv-keyboard and hid-hyperv. However, since
> commit eed4d47efe95 ("ACPI / sleep: Ignore spurious SCI wakeups from
> suspend-to-idle") pm_wakeup_event() from these devices is ignored. Switch
> to pm_wakeup_hard_event() API as these devices are actually the only
> possible way to wakeup Hyper-V guests.
> 
> Fixes: eed4d47efe95 (ACPI / sleep: Ignore spurious SCI wakeups from suspend-to-idle)
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  drivers/hid/hid-hyperv.c              | 2 +-

	Acked-by: Jiri Kosina <jkosina@suse.cz>

for the above. I guess this'd better go through ACPI tree?

Thanks,

-- 
Jiri Kosina
SUSE Labs

