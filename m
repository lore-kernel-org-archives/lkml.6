Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F1AC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 09:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E3F820BF2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 09:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="k3vP+WzO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E3F820BF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732394AbeGLJ1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 05:27:09 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:33726 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732250AbeGLJ1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 05:27:09 -0400
Received: by mail-oi0-f66.google.com with SMTP id l10-v6so7822777oii.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 02:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8d2pqce4j5baClWobMhZqT/ca+p1xkkv1IBlL5vI47Y=;
        b=k3vP+WzOWe+NgH0Khiut0oGQxQ0KVt68UfkkJUSUfelAHwxZRsPYWMiBrvZI1QHlXe
         7nAMLJJ9gjLQjylU+Yr/hfwsRrUORgNpXsiO87F85jSme1T4c46hgGWTS5qf4bjEqCIY
         smwGGnD5VzBzq2XV7WD48a0PCM+7F/aF/DXmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8d2pqce4j5baClWobMhZqT/ca+p1xkkv1IBlL5vI47Y=;
        b=o27nOPQPLaoZvU89jxnOu0TdnzuixLqVMg1o6sCEPRuGdUTw6VcunLylRunA37+x0p
         Z+0gmmMzM5cArzYnm6duyeGixDHPEsrlcsmty1mgWx/TWKaRR+XmhGyX3HrMlD6qMgXg
         iyAVi4PmUrG23OjCLTEDGRIy+HXtPyow794/73JKilaBdfYUj8Ll9KDQGmXvHSQHkl0g
         oEMFCjdQwf60ZyqrdLD8b3FRyL1SDi9CF83B5fZVIKWcPv5F4PBWc/BN7yRNkm3czr/n
         pU3zt9hnV62vesUmK4ZI5uA/OHZW2E053fQfKkSWUkK21AQHfotvOX6KVGuR73zFIMXL
         Nc1w==
X-Gm-Message-State: AOUpUlFyZzQo7HSD8D14364m+MxFTknKbfMNOsYG8B0wQNbet2NjFqCo
        XtJpWC+vd+oKPLKOkxg/sEfDYU/XZ63ixHw/FiCG4w==
X-Google-Smtp-Source: AAOMgpciVbIsgGAkUSEHKgQTu44ZVcc62GJ7VPznBQYa9ilWAPNDDInkHtxFfMCSrkUdsVYZG42LE9Cq1Ewn954Ipeg=
X-Received: by 2002:aca:f401:: with SMTP id s1-v6mr1494193oih.269.1531387106583;
 Thu, 12 Jul 2018 02:18:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:192d:0:0:0:0:0 with HTTP; Thu, 12 Jul 2018 02:18:26
 -0700 (PDT)
In-Reply-To: <20180712085501.GA25313@kroah.com>
References: <20180712080623.21203-1-benjamin.gaignard@st.com> <20180712085501.GA25313@kroah.com>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Thu, 12 Jul 2018 11:18:26 +0200
Message-ID: <CA+M3ks5nj2gfc+ePYg1y2w3P0cW861YkRqpuHh49n+noktPVUQ@mail.gmail.com>
Subject: Re: [PATCH] base: core: Remove WARN_ON from link dependencies check
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mark Brown <broonie@kernel.org>,
        pascal paillet <p.paillet@st.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-12 10:55 GMT+02:00 Greg KH <gregkh@linuxfoundation.org>:
> On Thu, Jul 12, 2018 at 10:06:23AM +0200, Benjamin Gaignard wrote:
>> In some cases the link between between customer and supplier
>> already exist. Do not warn about already existing dependencies
>> because device_link_add() take care of this case.
>
> Why would a link already exist that is asked to be created again?  What
> code path causes this?

It could happen that the link exist because a device use it parent as supplier.
That case has been describe by Marek in this thread (I forgot to add
it in the commit message, sorry):
https://lkml.org/lkml/2018/7/9/356

>
>>
>> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
>> ---
>>  drivers/base/core.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/base/core.c b/drivers/base/core.c
>> index df3e1a44707a..fcdc17f0f349 100644
>> --- a/drivers/base/core.c
>> +++ b/drivers/base/core.c
>> @@ -105,7 +105,7 @@ static int device_is_dependent(struct device *dev, void *target)
>>       struct device_link *link;
>>       int ret;
>>
>> -     if (WARN_ON(dev == target))
>> +     if (dev == target)
>>               return 1;
>>
>>       ret = device_for_each_child(dev, target, device_is_dependent);
>> @@ -113,7 +113,7 @@ static int device_is_dependent(struct device *dev, void *target)
>>               return ret;
>>
>>       list_for_each_entry(link, &dev->links.consumers, s_node) {
>> -             if (WARN_ON(link->consumer == target))
>> +             if (link->consumer == target)
>>                       return 1;
>
> Both of these WARN_ON are for valid code?  That feels really odd to me,
> I need more explanation here please.

The documentation of the function is clear about return values:
"Check if @target depends on @dev or any device dependent on it (its
child or ts consumer etc).  Return 1 if that is the case or 0
otherwise."
so, for me, not need to warn user about something that is expected.

Benjamin
>
> thanks,
>
> greg k-h
