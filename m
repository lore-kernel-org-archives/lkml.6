Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 128ACC43145
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4D7A22523
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:03:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="eEEnqxHe";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="k687rbzS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4D7A22523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934317AbeFZKDv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 06:03:51 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41418 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934205AbeFZKDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 06:03:47 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 436CE60274; Tue, 26 Jun 2018 10:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530007427;
        bh=5VQabHnjQEr9dxHzFuJmVqGU5cn7e6OavA7JpZqJ4To=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=eEEnqxHeBmk1r8bMs8f0HoqToNWn4aL310VvrudjNj5/aza4VcpVEpMfb+D7lu9gv
         VFJ5qj4v3+Q2qWjNC+f4Yi8CrEKYDQYExGrSHZiWF7p/HPE08Asyjw3y2yTmjvZAr8
         p7qHRND/1NnYx8bxI9EgiuM5gGd80XTxWA7I60Pk=
Received: from mail-qt0-f179.google.com (mail-qt0-f179.google.com [209.85.216.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3183960131;
        Tue, 26 Jun 2018 10:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530007426;
        bh=5VQabHnjQEr9dxHzFuJmVqGU5cn7e6OavA7JpZqJ4To=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=k687rbzSubCYDodvjGLRhmo6du1YKKtqYuOHLxerMWHs3VQz7WdshRlopaJHzmXZU
         p+1r/bnRFIKuXnrcRlGxzh3liZ0uBDY8sPgLXG2rhL7haTxUsMa8ancryT04ivpmzt
         IqD8cFbOoPNk2bJ9i1gjbG0bhniZKBF1AhqpGzqQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3183960131
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-qt0-f179.google.com with SMTP id o9-v6so14574346qtp.3;
        Tue, 26 Jun 2018 03:03:46 -0700 (PDT)
X-Gm-Message-State: APt69E1/2iABJKzPUVTCA1bUm3lgdL6pE6hzSU5KuRUamK87neVMx4Hr
        JRsdU3U7uy4zabnanv6axF/Qah2wDkaIKNYqvxs=
X-Google-Smtp-Source: AAOMgpeHDFK2fAqEpqhNV5yUnsGvHUJktqx3Cm/ec0DaSF43I5VJHm/KT+0hm5p2MLa+P3UigldcGKA8vfFGFlWcPEk=
X-Received: by 2002:a0c:f489:: with SMTP id i9-v6mr702357qvm.0.1530007425373;
 Tue, 26 Jun 2018 03:03:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:1082:0:0:0:0:0 with HTTP; Tue, 26 Jun 2018 03:03:44
 -0700 (PDT)
In-Reply-To: <541c84e9-47fc-e7bc-8249-1477b9e63455@codeaurora.org>
References: <20180530095704.5788-1-vivek.gautam@codeaurora.org>
 <a85d44e7-3bb1-f282-088d-c4311a108bcd@intel.com> <541c84e9-47fc-e7bc-8249-1477b9e63455@codeaurora.org>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Date:   Tue, 26 Jun 2018 15:33:44 +0530
X-Gmail-Original-Message-ID: <CAFp+6iGwcbOm0p33o9NEE7YBZNNvRsBeU0ySy0HcEmvq8mhBJA@mail.gmail.com>
Message-ID: <CAFp+6iGwcbOm0p33o9NEE7YBZNNvRsBeU0ySy0HcEmvq8mhBJA@mail.gmail.com>
Subject: Re: [PATCH 1/1] device core: Add flag to autoremove device link on
 supplier unbind
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, lukas@wunner.de,
        dmitry.torokhov@gmail.com, aspriel@gmail.com,
        Robin Murphy <robin.murphy@arm.com>,
        open list <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 6:21 PM, Vivek Gautam
<vivek.gautam@codeaurora.org> wrote:

Adding Ulf and Marek for their side of comments.
In summary, we do not want to not maintain a device link pointer
when adding a device link in supplier's driver, to delete the link later.
An autoremove flag from the suppliers side (similar to what we already
have for consumer side) can help autoremove the device link
when supplier driver goes away.

Hi Rafael, Lukas,
Gentle ping. Can you please consider reviewing this patch.

Best regards
Vivek

> Hi Rafael,
>
>
> On 5/30/2018 4:29 PM, Rafael J. Wysocki wrote:
>>
>> On 5/30/2018 11:57 AM, Vivek Gautam wrote:
>>>
>>> When using the device links without the consumers or
>>> suppliers maintaining pointers to these links, a flag can
>>> help in autoremoving the links on supplier driver unbind.
>>> We remove these links only when the supplier's link to its
>>> consumers has gone in DL_STATE_SUPPLIER_UNBIND state.
>>>
>>> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
>>> Suggested-by: Lukas Wunner <lukas@wunner.de>
>>> ---
>>>
>>> Lukas, as suggested in the thread [1] this change adds additional flag
>>> to autoremove device links on supplier unbind.
>>> For arm-smmu, we want to _not_ keep references to the device links
>>> added between arm-smmu, and consumer devices.
>>> Robin also pointed to [2] the need to autoremove the device link on
>>> supplier unbind rather than consumer unbind.
>>
>>
>> Please CC device links patches to linux-pm.
>
>
> Thanks for the quick review. Sure, will keep this noted from now on.
>
>
>>
>>> [1] https://lkml.org/lkml/2018/3/14/390
>>> [2] https://lkml.org/lkml/2018/5/21/381
>>>
>>>   drivers/base/core.c    | 10 ++++++++++
>>>   include/linux/device.h |  2 ++
>>>   2 files changed, 12 insertions(+)
>>>
>>> diff --git a/drivers/base/core.c b/drivers/base/core.c
>>> index b610816eb887..52c7222bb3c4 100644
>>> --- a/drivers/base/core.c
>>> +++ b/drivers/base/core.c
>>> @@ -490,6 +490,16 @@ void device_links_driver_cleanup(struct device *dev)
>>>             WARN_ON(link->flags & DL_FLAG_AUTOREMOVE);
>>>           WARN_ON(link->status != DL_STATE_SUPPLIER_UNBIND);
>>> +
>>> +        /*
>>> +         * autoremove the links between this @dev and its consumer
>>> +         * devices that are not active, i.e. where the link state
>>> +         * has moved to DL_STATE_SUPPLIER_UNBIND.
>>> +         */
>>> +        if (link->status == DL_STATE_SUPPLIER_UNBIND &&
>>> +            link->flags & DL_FLAG_AUTOREMOVE_S)
>>> +            kref_put(&link->kref, __device_link_del);
>>> +
>>>           WRITE_ONCE(link->status, DL_STATE_DORMANT);
>>>       }
>>>   diff --git a/include/linux/device.h b/include/linux/device.h
>>> index 477956990f5e..6033bf58453d 100644
>>> --- a/include/linux/device.h
>>> +++ b/include/linux/device.h
>>> @@ -779,11 +779,13 @@ enum device_link_state {
>>>    * AUTOREMOVE: Remove this link automatically on consumer driver
>>> unbind.
>>>    * PM_RUNTIME: If set, the runtime PM framework will use this link.
>>>    * RPM_ACTIVE: Run pm_runtime_get_sync() on the supplier during link
>>> creation.
>>> + * AUTOREMOVE_S: Remove this link automatically on supplier driver
>>> unbind.
>>>    */
>>>   #define DL_FLAG_STATELESS    BIT(0)
>>>   #define DL_FLAG_AUTOREMOVE    BIT(1)
>>>   #define DL_FLAG_PM_RUNTIME    BIT(2)
>>>   #define DL_FLAG_RPM_ACTIVE    BIT(3)
>>> +#define DL_FLAG_AUTOREMOVE_S    BIT(4)
>>
>>
>> Couldn't you invent a better name for this one?
>
>
> Frankly, I wanted to have something like DL_FLAG_AUTOREMOVE_SUPPLIER, but
> that
> felt a bit too long considering other flags.
> Can you please consider suggesting a concise name?
>
> Regards
> Vivek
>
>>
>>>     /**
>>>    * struct device_link - Device link representation.
>>
>>
>>
>



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
