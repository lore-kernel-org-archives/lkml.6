Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F05BC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 23:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42A1227A7A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 23:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Sp12u3cA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42A1227A7A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967312AbeF1XvG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 19:51:06 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:32918 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967125AbeF1XvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 19:51:03 -0400
Received: by mail-qt0-f193.google.com with SMTP id l10-v6so6414553qtj.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 16:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jQHIaTDL5DkUMSHH6G5cjyJ5MIspbu+IfJPSHaH19sY=;
        b=Sp12u3cAP2wwR2mlBNYajnDxZPwAs86P7sr0znUNzTB2DWZafLCA0/DmI7jbMTlRMq
         b+L1JqNWqNNwnydAOoDVmdizlUPo2rxLz2d6bEq99zyjdHh5s1F9ET3oEzpvd0rlDbm4
         /05y4d5vfQqRLyCfqx1Y7680Q/3PcWu/V2+Xg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jQHIaTDL5DkUMSHH6G5cjyJ5MIspbu+IfJPSHaH19sY=;
        b=PfEq2p5pw3Owd+OJa51QUPN4oI1y74MtNqmNRDLG7cxCpkVL83i0pm7vJ217MT1GlW
         seaeZpbNXu0CCIAbjMWiaHM+J1VJ3mLRExculld62AJ/NOT1Og6CEKM+kpNFi3MtXkLI
         COH4sH3H3YTaOor9fal9IVdPGSBuh0CFTXKsdglRl5uShnsd3UnLG4X/aTQIIqNdwcJr
         MWuu3ghSgjKCnq5U7FI/uGjXnIvWusZG5ceC7yfQbJ49avhI4Z6L3javjIFz2+hAbcJ5
         F6RkxP4yE0IL0uO6d9hE+2jkcMPOBX1HfJ0WDt7dKkS7Ewp2fPbVkG+sPz0TOgYQdQnp
         TNuQ==
X-Gm-Message-State: APt69E37Z5A0k9ecFg+iv/GMKMUYmrNeSbQFNrDAfz22Gn6C1H7JzsLJ
        YQ3Lp26Rw2LzgiEg8SZ95Vk6dw==
X-Google-Smtp-Source: AAOMgpfxowiUK4pZVa4cVe383toZEF2MKH9IfnO4xydLl/vVcq2tYkWNo+xSJDAZDxYM1vfZT3f/6A==
X-Received: by 2002:ac8:282a:: with SMTP id 39-v6mr11692147qtq.109.1530229862243;
        Thu, 28 Jun 2018 16:51:02 -0700 (PDT)
Received: from [10.136.8.248] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id l84-v6sm1560640qki.69.2018.06.28.16.50.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 16:51:01 -0700 (PDT)
Subject: Re: [PATCH v4 1/6] Documentation: DT: Consolidate SP805 binding docs
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Rob Herring <robh@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
References: <1527530497-10392-2-git-send-email-ray.jui@broadcom.com>
 <20180605194124.GA26885@rob-hp-laptop>
 <e91c75f3-f7a4-6f51-9911-7e22d5d05084@roeck-us.net>
 <CABGGisxEvWDy16SKE2RG-vhUHBZHSCCHyfwJsPY16B1fQS-=cA@mail.gmail.com>
 <09c870cd-0a44-6634-58d8-f57f9fcd0cb5@broadcom.com>
 <46ca340f-4347-94ca-6463-d38bece820e2@broadcom.com>
 <20180627183327.GD16753@roeck-us.net>
 <a18733e2-be06-4ea9-dbfb-1d4f756a97e7@broadcom.com>
 <20180627184234.GA19538@roeck-us.net>
 <8483f675-0c7d-4b0f-25fd-a5eff4bc7937@broadcom.com>
 <20180627185529.GB19743@roeck-us.net>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <42b856bf-2dc1-f69b-44e1-f5a04715f673@broadcom.com>
Date:   Thu, 28 Jun 2018 16:50:57 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180627185529.GB19743@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter/Florian,

On 6/27/2018 11:55 AM, Guenter Roeck wrote:
> On Wed, Jun 27, 2018 at 11:47:21AM -0700, Ray Jui wrote:
>>
>>
>> On 6/27/2018 11:42 AM, Guenter Roeck wrote:
>>> On Wed, Jun 27, 2018 at 11:38:48AM -0700, Ray Jui wrote:
>>>>
>>>>
>>>> On 6/27/2018 11:33 AM, Guenter Roeck wrote:
>>>>> On Wed, Jun 20, 2018 at 10:39:16AM -0700, Ray Jui wrote:
>>>>>> Hi Guenter/Rob,
>>>>>>
>>>>>> Kindly let me know how you want to proceed with this?
>>>>>>
>>>>>
>>>>> If I recall correctly, the patch series does not add a new problem
>>>>> but merely exposes one. Is my recollection correct ? If so, maybe
>>>>> we should just add a note somewhere indicating what might be wrong
>>>>> and otherwise apply the series.
>>>>>
>>>>> Does this make sense ?
>>>>
>>>> Yes this makes a lot of sense to me. This patch series exposes potential
>>>> problems in some SoCs that they might not be feeding the correct clock into
>>>> WDT, at least based on clock names from their DT entries.
>>>>
>>>> This patch series does not change/affect how SP805 works on those systems.
>>>>
>>>> Where should the note be added?
>>>>
>>>
>>> I would suggest to add a note into the driver where the clock is used,
>>> with the details discussed here.
>>
>> I assume you meant adding the notes to the SP805 driver where the clock is
>> used.
>>
>> If so, I think that makes sense. That notes deserves its own patch because
>> it really has nothing to do with any of the change in this patch series.
>>
>> Do you want me to 1) embed that patch into this patch series and send out
>> v5; or 2) leave the patch series as it is and send out a separate patch to
>> add the notes to the driver?
>>
> 2) is fine. I don't have the series here right now; if I recall correctly
> all patches in the series are all marked as Reviewed-by: and/or Acked-by:.
> If so, I'll apply them to my tree tonight, or at least the ones that will
> go in through the watchdog tree.
> 
> Guenter
> 

Guenter, please let us know once you take the first 4 patches.

Florian, could you please help with the last 2, once Guenter confirmed 
the first 4 are merged.

Thanks!

Ray
