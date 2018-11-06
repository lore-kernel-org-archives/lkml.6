Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A091BC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 17:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FDCF20862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 17:07:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FDCF20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389570AbeKGCdS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 21:33:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39536 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389396AbeKGCdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 21:33:18 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B6CCEC049585;
        Tue,  6 Nov 2018 17:07:08 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.43.2.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8D8D2608E7;
        Tue,  6 Nov 2018 17:07:06 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Jiri Kosina <jikos@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] hyper-v: Fix wakeup from suspend-to-idle
In-Reply-To: <CAJZ5v0g10fyZZhvLTz_qSADWQCO==fg=zcFQHD7QLZYwVDOsgA@mail.gmail.com>
References: <20180912161101.2634-1-vkuznets@redhat.com> <nycvar.YFH.7.76.1809241123040.15880@cbobk.fhfr.pm> <CAJZ5v0g10fyZZhvLTz_qSADWQCO==fg=zcFQHD7QLZYwVDOsgA@mail.gmail.com>
Date:   Tue, 06 Nov 2018 18:07:05 +0100
Message-ID: <87ftweuocm.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 06 Nov 2018 17:07:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Rafael J. Wysocki" <rafael@kernel.org> writes:

> On Mon, Sep 24, 2018 at 11:24 AM Jiri Kosina <jikos@kernel.org> wrote:
>>
>> On Wed, 12 Sep 2018, Vitaly Kuznetsov wrote:
>>
>> > It makes little sense but still possible to put Hyper-V guests into
>> > suspend-to-idle state. To wake them up two wakeup sources were registered
>> > in the past: hyperv-keyboard and hid-hyperv. However, since
>> > commit eed4d47efe95 ("ACPI / sleep: Ignore spurious SCI wakeups from
>> > suspend-to-idle") pm_wakeup_event() from these devices is ignored. Switch
>> > to pm_wakeup_hard_event() API as these devices are actually the only
>> > possible way to wakeup Hyper-V guests.
>> >
>> > Fixes: eed4d47efe95 (ACPI / sleep: Ignore spurious SCI wakeups from suspend-to-idle)
>> > Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> > ---
>> >  drivers/hid/hid-hyperv.c              | 2 +-
>>
>>         Acked-by: Jiri Kosina <jkosina@suse.cz>
>>
>> for the above. I guess this'd better go through ACPI tree?
>
> No problem with that if you prefer.
>

It seems this patch got lost somewhere :-( 

-- 
Vitaly
