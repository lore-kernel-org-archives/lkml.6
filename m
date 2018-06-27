Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3796BC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 18:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5FFD25F06
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 18:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Yh9mp5wL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5FFD25F06
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965987AbeF0Sr3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 14:47:29 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:46581 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965931AbeF0Sr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 14:47:27 -0400
Received: by mail-qt0-f194.google.com with SMTP id h5-v6so2552696qtm.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 11:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=H+g5O++/Ia1K2vBaVcBB4bjPX4WwIoj8nhkRpExP+9g=;
        b=Yh9mp5wLkdihRwTVhNGkVOZbcP/mGB1kc9fVTNvqBtsVpBdH27UICkeV5bCQ/59vSv
         AYpcNu+Da4UJEHtQHelAVdurf6+C9TrRO/WfzeF51LqYokOTZ+cGsSjtHm+tlifLOq9o
         W4yH4HpEakVa53g6rd1ii6NeevvWFZIhyBG6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=H+g5O++/Ia1K2vBaVcBB4bjPX4WwIoj8nhkRpExP+9g=;
        b=XmUkW9LnY1qi9ze/BK/WTOxcpMIFfpajJnT8EyrzURGqFZuVzey1sjqYI/ozOArsAk
         hK0v5ycBlzlsn8eDg6rd2EDiNQla/JJO1VAjcYCZ4yKwZZtNpIBS2ypZTzl4vwY2NaRo
         XlEkrtcGUVYH6t2wXRSulMnbdsDKn3bkntvc7PwObX/5a1xFWa92LC2vtqUgF3j0ItOQ
         FeXFbCJoVW2LWX7a0e4hCYwQypOF34LpXcLx+dBDbz6vCK+N08co//nOz549o4dLiOTV
         CfJEj58GczoWoL6Hbl99mwMn5VsxDCkF0Uqgg9UH2MlE+9R7atzSrSR3LS5kEXxPBatb
         q0+w==
X-Gm-Message-State: APt69E2bQWYbrot8TApHbA1yqnN9e9gxTx7ailhMmEI7tugg01QjldMv
        okdZG+EaaB3B2gFTtV3aib/VTa5cQjc=
X-Google-Smtp-Source: AAOMgpfTZH8w1ntOQO6rVm/clD6DRNOq7yXuDQryLMUrU6uP7z3OP2WbTZ3hGdvPiSgooOxhC+fPhQ==
X-Received: by 2002:aed:36e4:: with SMTP id f91-v6mr2957136qtb.268.1530125246347;
        Wed, 27 Jun 2018 11:47:26 -0700 (PDT)
Received: from [10.136.8.248] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id n59-v6sm3413528qte.97.2018.06.27.11.47.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 11:47:25 -0700 (PDT)
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
References: <1527530497-10392-1-git-send-email-ray.jui@broadcom.com>
 <1527530497-10392-2-git-send-email-ray.jui@broadcom.com>
 <20180605194124.GA26885@rob-hp-laptop>
 <e91c75f3-f7a4-6f51-9911-7e22d5d05084@roeck-us.net>
 <CABGGisxEvWDy16SKE2RG-vhUHBZHSCCHyfwJsPY16B1fQS-=cA@mail.gmail.com>
 <09c870cd-0a44-6634-58d8-f57f9fcd0cb5@broadcom.com>
 <46ca340f-4347-94ca-6463-d38bece820e2@broadcom.com>
 <20180627183327.GD16753@roeck-us.net>
 <a18733e2-be06-4ea9-dbfb-1d4f756a97e7@broadcom.com>
 <20180627184234.GA19538@roeck-us.net>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <8483f675-0c7d-4b0f-25fd-a5eff4bc7937@broadcom.com>
Date:   Wed, 27 Jun 2018 11:47:21 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180627184234.GA19538@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/27/2018 11:42 AM, Guenter Roeck wrote:
> On Wed, Jun 27, 2018 at 11:38:48AM -0700, Ray Jui wrote:
>>
>>
>> On 6/27/2018 11:33 AM, Guenter Roeck wrote:
>>> On Wed, Jun 20, 2018 at 10:39:16AM -0700, Ray Jui wrote:
>>>> Hi Guenter/Rob,
>>>>
>>>> Kindly let me know how you want to proceed with this?
>>>>
>>>
>>> If I recall correctly, the patch series does not add a new problem
>>> but merely exposes one. Is my recollection correct ? If so, maybe
>>> we should just add a note somewhere indicating what might be wrong
>>> and otherwise apply the series.
>>>
>>> Does this make sense ?
>>
>> Yes this makes a lot of sense to me. This patch series exposes potential
>> problems in some SoCs that they might not be feeding the correct clock into
>> WDT, at least based on clock names from their DT entries.
>>
>> This patch series does not change/affect how SP805 works on those systems.
>>
>> Where should the note be added?
>>
> 
> I would suggest to add a note into the driver where the clock is used,
> with the details discussed here.

I assume you meant adding the notes to the SP805 driver where the clock 
is used.

If so, I think that makes sense. That notes deserves its own patch 
because it really has nothing to do with any of the change in this patch 
series.

Do you want me to 1) embed that patch into this patch series and send 
out v5; or 2) leave the patch series as it is and send out a separate 
patch to add the notes to the driver?

Thanks.

> 
> Does this make sense ?
> 
> Thanks,
> Guenter
> 
