Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6350DECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 08:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06CC3208FC
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 08:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pNyQco+P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06CC3208FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729591AbeGPJWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 05:22:08 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:46978 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727431AbeGPJWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 05:22:08 -0400
Received: by mail-oi0-f66.google.com with SMTP id y207-v6so73336036oie.13;
        Mon, 16 Jul 2018 01:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=yZApqhWIm/YEiS8PZ9W9x7CV5xZ7QBWqPpr20gRI5BM=;
        b=pNyQco+PcQLCKjEYnPDHU4kEOwcaMRbq9dZvQoi7gpTHiebgEv6alGxTmONIdeBSZq
         37RQaDCam3jjxWdN6k3ugW7jfmmgT9EAMAsCKGtdMFs9b9OanvF7+ZbeQOPxDaeNbXzj
         bErMNUKvqoiduONx01TNcHo/BSvkTWAzt19aTkBojwRZfvpgAe4Qex0r+Lt8n6wjLmw2
         2E3yzhnmKce4dKrqxcVd2ce2qEfjk3NfKFou+autAm0u+jp5h6OaVL+hnZ+ipd8Xl5z6
         310sJnSQ/+xK9E3wpWASohcUJuJF5NooR6lNqjloHSM/65sXxVb+2JGMWy0olroy8iRl
         sfNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=yZApqhWIm/YEiS8PZ9W9x7CV5xZ7QBWqPpr20gRI5BM=;
        b=dz9s2ZYK/ljW0BlDpl29uELNZKLQ5pzCSyIAq21/K9hKMQCEuA7YPhK9Do1q9cmGq4
         IM3t5HQHoX6zlrJHIUh8rN5LOPvX78xgOVZlZY0h5by5t99oxED1AJPYRo2qf7dLaM3k
         W8QYusSq6izapZRxGn5QA4tSsunAv4aFtrRN+/LJmjAUzmyW16y95UPF+0pru+C4gfne
         nPCcDJh1/QugNNETJo7DMIi0A3T9dsOMHVnLVJcr/AsZ4AB4IARBov3hUz3KpAqWMkLd
         NUm/PWgQti9yyF5Un3rgytWrHXAbf2WDOvC0S3LzhRplsbBFuTNAi+LPq4Xehjw601Zh
         0tjw==
X-Gm-Message-State: AOUpUlGH/+pEq5rIwYzY4fgobnyH9xdBzibOBOqTJ8FxrUrckoy9Tjrj
        ItwTeQh/XDZiYplLqQQPffqSsrKLiFNbyEPJApM=
X-Google-Smtp-Source: AAOMgpcksMsNpPvNfUHQuvPcpteLZARGJXBf1MKyovW1QHA3ZSOscBIHdvz1YEnqGv9Se/8nyTw0FXQuwV44H9/fVZQ=
X-Received: by 2002:aca:ecd0:: with SMTP id k199-v6mr18380909oih.227.1531731344848;
 Mon, 16 Jul 2018 01:55:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:63d2:0:0:0:0:0 with HTTP; Mon, 16 Jul 2018 01:55:44
 -0700 (PDT)
In-Reply-To: <CAFp+6iFTgEhPLYQEyBX_Fb0k3n0OzGhKuSoBNV5XzpD01+V8qw@mail.gmail.com>
References: <20180708173413.1965-1-vivek.gautam@codeaurora.org>
 <20180708173413.1965-4-vivek.gautam@codeaurora.org> <5179668.PHK6S3sxLu@aspire.rjw.lan>
 <741cc78b-59a7-5289-e42f-1511ebedb15d@codeaurora.org> <CAFp+6iFTgEhPLYQEyBX_Fb0k3n0OzGhKuSoBNV5XzpD01+V8qw@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 16 Jul 2018 10:55:44 +0200
X-Google-Sender-Auth: -ILpbuGrA8a_6ZqJJ_3LL0zD_Vc
Message-ID: <CAJZ5v0iQ2wxsXvuaLK2M9a_Jwe_fnwR2Afrq_Oa8h0--Ch7-5g@mail.gmail.com>
Subject: Re: [PATCH v12 3/4] iommu/arm-smmu: Add the device_link between
 masters and smmu
To:     Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <joro@8bytes.org>,
        "robh+dt" <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Rob Clark <robdclark@gmail.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Sricharan R <sricharan@codeaurora.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Archit Taneja <architt@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Lukas Wunner <lukas@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 2:41 PM, Vivek Gautam
<vivek.gautam@codeaurora.org> wrote:
> Hi Rafael,
>
>
> On Wed, Jul 11, 2018 at 4:06 PM, Vivek Gautam
> <vivek.gautam@codeaurora.org> wrote:
>> Hi Rafael,
>>
>>
>>
>> On 7/11/2018 3:23 PM, Rafael J. Wysocki wrote:
>>>
>>> On Sunday, July 8, 2018 7:34:12 PM CEST Vivek Gautam wrote:
>>>>
>>>> From: Sricharan R <sricharan@codeaurora.org>
>>>>
>>>> Finally add the device link between the master device and
>>>> smmu, so that the smmu gets runtime enabled/disabled only when the
>>>> master needs it. This is done from add_device callback which gets
>>>> called once when the master is added to the smmu.
>>>>
>>>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>>>> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
>>>> Reviewed-by: Tomasz Figa <tfiga@chromium.org>
>>>> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
>>>> Cc: Lukas Wunner <lukas@wunner.de>
>>>> ---
>>>>
>>>>   - Change since v11
>>>>     * Replaced DL_FLAG_AUTOREMOVE flag with DL_FLAG_AUTOREMOVE_SUPPLIER.
>>>>
>>>>   drivers/iommu/arm-smmu.c | 12 ++++++++++++
>>>>   1 file changed, 12 insertions(+)
>>>>
>>>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>>>> index 09265e206e2d..916cde4954d2 100644
>>>> --- a/drivers/iommu/arm-smmu.c
>>>> +++ b/drivers/iommu/arm-smmu.c
>>>> @@ -1461,8 +1461,20 @@ static int arm_smmu_add_device(struct device *dev)
>>>>         iommu_device_link(&smmu->iommu, dev);
>>>>   +     if (pm_runtime_enabled(smmu->dev) &&
>>>
>>> Why does the creation of the link depend on whether or not runtime PM
>>> is enabled for the MMU device?
>>
>>
>> The main purpose of this device link is to handle the runtime PM
>> synchronization
>> between the supplier (iommu) and consumer (client devices, such as
>> GPU/display).
>> Moreover, the runtime pm is conditionally enabled for smmu devices that
>> support
>> such [1].
>
> Is there something you would like me to modify in this patch?

Not really, as long as you are sure that it is correct. :-)

You need to remember, however, that if you add system-wide PM
callbacks to the driver, the ordering between them and the client
device callbacks during system-wide suspend matters as well.  Don't
you need the link the ensure the correct system-wide suspend ordering
too?
