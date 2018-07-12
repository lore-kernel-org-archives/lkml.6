Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 882C0C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 13:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2971E208E9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 13:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="S//9Tjmg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2971E208E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732444AbeGLODx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 10:03:53 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:52368 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbeGLODx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 10:03:53 -0400
Received: by mail-it0-f66.google.com with SMTP id p4-v6so6922773itf.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 06:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=w8YvEjiLA/4L3GEa/k/+iGppymABmOp1WNRqWKDZHI0=;
        b=S//9Tjmg13mDZdFZ6GdIcc1KM9e0xFVa97tsbqC7/9mqLPG3jfCFwAIcAaflBfc+Po
         6/02IstO6hUcyNSxt9mN6h0wo/BYbp5BInM/SyzNuAXnrTFETienyg68LcWcwLZ3jp6+
         Eh75Ld0yG6cAbenkAf88/2GVSBMq1tG2JLrR1jPkxFDis+QIvB6CyklYoPLtRL+vT1nR
         dZqIqdbTc3gPgNfI6U847ZaKM0SwbMW1G0wqO/5JPdudwaivkT9NsT3HPPmkkBzwO/Hg
         PN7lgoDc4UKiu/2QxxAQiaQnzPSnBGR7mPhIWLjiQmy3UwDxPRd+7E3bK32jcXNrF+yA
         Fkkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w8YvEjiLA/4L3GEa/k/+iGppymABmOp1WNRqWKDZHI0=;
        b=hFwxg6WhuN0BGRwQWrmm5eePmZ6xV4XELurKSwxGX7KiJS9a8HYmxPKGoP4WaFnkR8
         3EXb1N/vBZrPFTWyybTTGu4XuNa8zIeTyzb2V8mSyz+29/js+2dWrsdUUQoQJTmESOyM
         I5f9QGIu9YcE9Vrk7yTWnEtP1siEqAYB5tZnrxup+YUla4UmGhcThn64kHJWew0f7qq8
         H/dkS53qTNtdcFcVg2UrTsPIM2OdN/qhrirw+koi5VXk156GIVUzON8ba/smjo8MMduS
         Y61eJE/nAe7oT/Jp7hsWGdHOalvRLJImgtWsPECWR9EzIe36zqku57Wshr8dSB81wI3g
         UNnA==
X-Gm-Message-State: AOUpUlHRass1pzOicFa6wTA8AxEgLpawV6NuNmpBaAZHJUYhScoD5A5W
        WRur8RwZs7Yd4IEwF9MBBoFbgg==
X-Google-Smtp-Source: AAOMgpfGf/yzB/gzI0UN4SKWpwd4+BWLCL9z385MWDu7pX3gdv2IVVNnyitETEpTbCDC5DJKJ+rqFQ==
X-Received: by 2002:a24:f6c5:: with SMTP id u188-v6mr1448171ith.150.1531403652862;
        Thu, 12 Jul 2018 06:54:12 -0700 (PDT)
Received: from [192.168.1.167] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id v3-v6sm6495511iop.78.2018.07.12.06.54.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 06:54:11 -0700 (PDT)
Subject: Re: [PATCH 02/12] blk: use for_each_if
To:     Joe Perches <joe@perches.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Shaohua Li <shli@fb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>
References: <20180709083650.23549-1-daniel.vetter@ffwll.ch>
 <20180709083650.23549-2-daniel.vetter@ffwll.ch>
 <20180711164058.GC72677@devbig577.frc2.facebook.com>
 <20180711164536.GD72677@devbig577.frc2.facebook.com>
 <965184f9-e5ed-3c8b-bfd7-a033a252371b@kernel.dk>
 <CAKMK7uE5aJq-1wd0ZOhwFaTy3iKMAZsfdAf=Tw+eGxtCmfcVQg@mail.gmail.com>
 <2296606a890a1f3543c5db825ed172f7d295a504.camel@perches.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <efb7a7fe-16ef-1928-9d95-50b1fb84f0c3@kernel.dk>
Date:   Thu, 12 Jul 2018 07:54:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <2296606a890a1f3543c5db825ed172f7d295a504.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/12/18 12:45 AM, Joe Perches wrote:
> On Wed, 2018-07-11 at 20:50 +0200, Daniel Vetter wrote:
>> On Wed, Jul 11, 2018 at 8:30 PM, Jens Axboe <axboe@kernel.dk> wrote:
>>> On 7/11/18 10:45 AM, Tejun Heo wrote:
>>>> On Wed, Jul 11, 2018 at 09:40:58AM -0700, Tejun Heo wrote:
>>>>> On Mon, Jul 09, 2018 at 10:36:40AM +0200, Daniel Vetter wrote:
>>>>>> Makes the macros resilient against if {} else {} blocks right
>>>>>> afterwards.
>>>>>>
>>>>>> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
>>>>>> Cc: Tejun Heo <tj@kernel.org>
>>>>>> Cc: Jens Axboe <axboe@kernel.dk>
>>>>>> Cc: Shaohua Li <shli@fb.com>
>>>>>> Cc: Kate Stewart <kstewart@linuxfoundation.org>
>>>>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>>>> Cc: Joseph Qi <joseph.qi@linux.alibaba.com>
>>>>>> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
>>>>>> Cc: Arnd Bergmann <arnd@arndb.de>
>>>>>
>>>>> Acked-by: Tejun Heo <tj@kernel.org>
>>>>>
>>>>> Jens, it'd probably be best to route this through block tree.
>>>>
>>>> Oops, this requires an earlier patch to move the for_each_if def to a
>>>> common header and should be routed together.
>>>
>>> Yeah, this is a problem with the submission.
>>>
>>> Always (ALWAYS) CC folks on at least the cover letter and generic
>>> earlier patches. Getting just one patch sent like this is mostly
>>> useless, and causes more harm than good.
>>
>> Ime sending a patch with more than 20 or so recipients means it gets
>> stuck everywhere in moderation queues. Or outright spam filters. I
>> thought the correct way to do this is to cc: mailing lists (lkml has
>> them all), but apparently that's not how it's done. Despite that all
>> the patch series I get never have the cover letter addressed to me
>> either.
>>
>> So what's the magic way to make this possible?
> 
> Jens' advice is crap.
> 
> There is no generic way to make this possible.

Nobody claimed there was. And the advice is perfectly fine,
sending out patches to folks that have hidden dependencies on other
patches is a no-go.

> BCC's don't work, series that touch multiple subsystems
> get rejected when the recipient list is too large.
> 
> I think you did it correctly.

Clearly that's not the case, regardless of what you think.

Thanks for your invaluable and useful feedback, sharing your vast
experience in patchsets with dependencies.

-- 
Jens Axboe

