Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id DABA9C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 19:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 877722086E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 19:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IFREy+HM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 877722086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933878AbeFLTnw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 15:43:52 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:55647 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933328AbeFLTnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 15:43:47 -0400
Received: by mail-it0-f65.google.com with SMTP id 16-v6so801084itl.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 12:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=K/1i4PQppEy6ckp9J9hJDoKmD2VBt+4PgWc9u6ykU4U=;
        b=IFREy+HMjSWQHkha6C+/055/c4zFDEzkgN1wtw+gtO4uq5b1XfSetee6NMuD+6Bw/g
         qIy8he+8oWA5GiNaYB0T50cOuayTO+EZid6x3/uZXI1NMJK+RDJdlsk7oCxxEZ5WPDBU
         N091DhgBzQ1FgOFHJRAM82sRKfb/fAVwP+YGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=K/1i4PQppEy6ckp9J9hJDoKmD2VBt+4PgWc9u6ykU4U=;
        b=KZ/Er9kHkUQl7W46bI9lksVYcpkU8KnqJhvTWUGZTAZYnphdsy+A8SgdNVA3KGVu3C
         3JpvxIfgEd9+G9Jg4XmPaWpdk5nUQN4UisPPQemkAyx/jZ4q5HuAzG/2lDRKyJ7h8G3M
         FAM3SjrqPoYIxWYXL2LTEcs5U50gXWqlmyC3gO1UfKb5KfcJuDjznyKGyLDAtwdYGNBc
         jbfff0+Vsl+HItdfWeQQKapM0WZYp2l2FtGqAHi6yw0l1v/TqPIfHYb5twpl9F+RsviO
         leX8ZsAX7H2lzwHBop1SZt8SyyUa5K7rtFG01DYkNNK5+rKRV25zFy1JTSI1BH2iMkLO
         CdUA==
X-Gm-Message-State: APt69E3pE4KUaCuN2oGKQ1x9Sk0drggEZ9agJPGMre50c2I+Dj1r5apj
        rKqQ5f5p/Z+4a9qFxFr6MfUyexTn0TXdUCa3r++vbg==
X-Google-Smtp-Source: ADUXVKJ3oIVWw2w67ERPpJrNpuIOEQ9dd8ZE8gA6PeuGuZZqDzvsqnefIryZgz8mDYO2vqcwRFHRnenEZqC2EfrFczM=
X-Received: by 2002:a24:308:: with SMTP id e8-v6mr1982899ite.102.1528832626651;
 Tue, 12 Jun 2018 12:43:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:c054:0:0:0:0:0 with HTTP; Tue, 12 Jun 2018 12:43:45
 -0700 (PDT)
In-Reply-To: <20180612124424eucas1p101e61369a42132234d103ce52918b08e~3akoRUwbQ3138731387eucas1p17@eucas1p1.samsung.com>
References: <CGME20180612110807epcas5p10e076681eac6f50b01840c0052748d12@epcas5p1.samsung.com>
 <10125310.W3e2TP0641@aspire.rjw.lan> <20180612124424eucas1p101e61369a42132234d103ce52918b08e~3akoRUwbQ3138731387eucas1p17@eucas1p1.samsung.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 12 Jun 2018 21:43:45 +0200
Message-ID: <CAPDyKFpSx7Kif_AtrVNtPSW0gy4058VBCfFQgMqMWVQGq+2BXA@mail.gmail.com>
Subject: Re: [PATCH] PM / core: Fix supplier device runtime PM usage counter imbalance
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lukas Wunner <lukas@wunner.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 June 2018 at 14:44, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> Hi Rafael,
>
> On 2018-06-12 13:00, Rafael J. Wysocki wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> If a device link is added via device_link_add() by the driver of the
>> link's consumer device, the supplier's runtime PM usage counter is
>> going to be dropped by the pm_runtime_put_suppliers() call in
>> driver_probe_device().  However, in that case it is not incremented
>> unless the supplier driver is already present and the link is not
>> stateless.  That leads to a runtime PM usage counter imbalance for
>> the supplier device in a few cases.
>>
>> To prevent that from happening, bump up the supplier runtime
>> PM usage counter in device_link_add() for all links with the
>> DL_FLAG_PM_RUNTIME flag set that are added at the consumer probe
>> time.  Use pm_runtime_get_noresume() for that as the callers of
>> device_link_add() who want the supplier to be resumed by it should
>> pass DL_FLAG_RPM_ACTIVE in flags to it anyway.
>>
>> Fixes: 21d5c57b3726 (PM / runtime: Use device links)
>> Reported-by: Ulf Hansson <ulf.hansson@linaro.org>
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> ---
>>
>> This is a replacement for commit 1e8378619841 (PM / runtime: Fixup
>> reference counting of device link suppliers at probe) that is going
>> to be reverted.
>
> Thanks Rafael for the patch. I've applied it and now I'm a bit puzzled.
> Let's get back to my IOMMU and codec case, mentioned here:
> https://marc.info/?l=linux-pm&m=152878741527962&w=2
>
> Now, after applying your patch, when IOMMU creates a link with
> DL_FLAG_PM_RUNTIME to the jpeg device (this happens when jpeg device is
> being probed), it is not IOMMU is not runtime resumed anymore (that's
> because the patch changes pm_runtime_get_sync to pm_runtime_get_noresume).

According to your earlier replies, I thought this is what you wanted. No?

> This means that until jpeg driver enables runtime pm for its device and
> finally performs runtime pm suspends/resume cycle, the supplier won't be
> resumed.

What's the problem with that? When does the IOMMU device needs to be
runtime resumed?

> On the other hand, when I add DL_FLAG_RPM_ACTIVE flag to link
> creation, the supplier is properly resumed, but then, once the jpeg
> device probe finishes, the supplier is still in runtime active state
> until a next runtime suspend/resume cycle of jpeg device.

Could you elaborate on the what happens in jpeg driver during probe,
in regards to runtime PM. Perhaps you can also point me to what driver
it is?

> If I understand
> right, the DL_FLAG_RPM_ACTIVE flag should be there from the beginning,
> but that time it runtime pm part of links worked in a bit different way
> than now.

Just to make sure, you also reverted 1e8378619841, before trying
Rafael's change on top?

>
> Is there any way to keep old behavior?

I think the old behavior is sub-optimal. I am sure there are users
that really don't want the driver core to runtime resume the supplier
unconditionally.

I would rather go and fix the few users of device_link_add(), to use
DL_FLAG_RPM_ACTIVE, in cases when they need it. Of course I am fine if
we do these changes in a step by step basis as well.

[...]

Kind regards
Uffe
