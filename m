Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE84FC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 21:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7117021E97
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 21:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="wdlAtk+N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7117021E97
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbeHIX3q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 19:29:46 -0400
Received: from mail-io0-f182.google.com ([209.85.223.182]:33912 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbeHIX3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 19:29:45 -0400
Received: by mail-io0-f182.google.com with SMTP id l7-v6so5968678ioj.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 14:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9b3UMOrcodv3ULXMOKoy7HwZ2s8iZfliJjA3GeX66/s=;
        b=wdlAtk+NjUWCKa2LPCZqbKc824DAdpVWkHrkRv9f1knqtaVFlqqgD+uTyJSHE0+fUr
         MNSPAPl9Lw/+DqJ31obp3HVj+8Ig/1mrS84u7fpKNTV4MA3GeVgbK5dmi63ek7fSz06k
         peCnHF2Wwy/3o8VdDWR1tS1IB1y/T0GyeAFYoVD1mIv39/6Zdj469iAB/OVXvW+p8hep
         ol02wVK2QTfNfIQ8WPB1s2ZwLpfG2vsBRJjnBzkNPaMJvEgfl74KeUumgSuXd/xvkrB9
         IhjVIhspaWEiE3kzfANFeZCqXQi0FWQfXPTfo+jHopVtaJgDlEojg8rMjUDrBa6kwUxl
         0pjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9b3UMOrcodv3ULXMOKoy7HwZ2s8iZfliJjA3GeX66/s=;
        b=E/GhaXi549/kWcaA75W8gGd/YqB1EBbL9vCCnhZoG1CzeQqDBUReR03YhsopCR3gQ9
         5YugefuCvHdOTx3VXswkRxgfPiqJ/B+N1QYA7PU0L6sm939UmxkSI20Ecg3fPqSS3YhV
         oubCMqgAIOooSePMhWGGX6Bw6kvUO75vQvQQdWW/XWaOQC720oDDE+f1LDD0Q81yMNmY
         So6dOePXGhdLTQ4ATym/qQyxvlLNSSMXKELRMv0ZN+9fwf6jBGur7I1c1inIzsle1OR1
         7Z+khXfvQo2a/xrsKicsQFmQ/w4nJMwhk3IeT4gWo4Y9exASHfnRsV7fdNPRKZdSAsUy
         z0/g==
X-Gm-Message-State: AOUpUlH7rELraoP32q/CiaPmo4LvDJKG1Biqt3hnlTtQdNPXF0lVPJhC
        V2A6+zyhAqrHYxlrVVvOTk7o1A==
X-Google-Smtp-Source: AA+uWPw8yNh6tE1QJRyCQN3jcDe886CHTJJ021dRGFIl3quXizA50PVubvHC95PbJemKQ2Minit49A==
X-Received: by 2002:a6b:9651:: with SMTP id y78-v6mr3220809iod.283.1533848589623;
        Thu, 09 Aug 2018 14:03:09 -0700 (PDT)
Received: from [192.168.1.212] (107.191.0.158.static.utbb.net. [107.191.0.158])
        by smtp.gmail.com with ESMTPSA id t187-v6sm99794ita.28.2018.08.09.14.03.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 14:03:08 -0700 (PDT)
Subject: Re: Zoned block device support for fio
To:     Bart Van Assche <Bart.VanAssche@wdc.com>,
        "mb@lightnvm.io" <mb@lightnvm.io>,
        "loberman@redhat.com" <loberman@redhat.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
References: <20180706173839.28355-1-mb@lightnvm.io>
 <1530899118.31977.1.camel@redhat.com>
 <296d2d14-0bf6-e0a2-84dc-7d6e819625c1@lightnvm.io>
 <4421a151-85d9-52e4-2233-03ed7f17528a@kernel.dk>
 <8d8ae6c620217db92b95b6561345d7bdf7c7cdfa.camel@wdc.com>
 <229911cb-7eb1-1729-46f1-35aba81d98d1@kernel.dk>
 <a183979f10fda180176f671702f69efe338f56e7.camel@wdc.com>
 <9225abd8-35de-641d-2d2b-7ed566fb9956@kernel.dk>
 <ba99bc66928277b73cdbeb8579d739db0cf58639.camel@wdc.com>
 <be88923a-b960-0786-bd21-a4107cccd834@kernel.dk>
 <8d1946fb8f46c66b572a7643d47f9762154d1e8b.camel@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b9e3dd53-4b0d-3d95-ee28-aa4c1dc9b8d7@kernel.dk>
Date:   Thu, 9 Aug 2018 15:03:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <8d1946fb8f46c66b572a7643d47f9762154d1e8b.camel@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/18 2:51 PM, Bart Van Assche wrote:
> On Tue, 2018-07-10 at 12:51 -0600, Jens Axboe wrote:
>> On 7/10/18 12:49 PM, Bart Van Assche wrote:
>>> On Tue, 2018-07-10 at 12:45 -0600, Jens Axboe wrote:
>>>> The difference between the job file and the
>>>> workload run can be huge. Consider something really basic:
>>>>
>>>> [randwrites]
>>>> bs=4k
>>>> rw=randwrite
>>>>
>>>> which would be 100% random 4k writes. If I run this on a zoned device,
>>>> then that'd turn into 100% sequential writes.
>>>
>>> That's not correct. The ZBD code in the github pull request serializes writes
>>> per zone, not globally.
>>
>> That's a totally minor detail. If all my random writes fall within a single
>> zone, then they'd be 100% sequential. For N open zones, you'd be 100%
>> sequential within the zone. The point is that the workload as defined and
>> the workload as run are two totally different things, and THAT is the
>> problem.
> 
> Hello Jens,
> 
> What you proposed in a previous e-mail, namely to use the existing fio zone
> concept for zoned block devices sounds interesting to me. This is something I
> will definitely look further into. This will help to make a given workload
> that is suited for zoned block devices to behave (almost) identical when run
> against a regular block device. Since fio users expect that no zones are
> reset before e.g. a random write test is started, there will always be a small
> difference in behavior between a workload run against a zoned block device and
> a workload run against a regular device if some zones already contain data.
> 
> It's not clear to me how close you want the behavior of fio to be for zoned
> and regular block devices. Do you e.g. want me to introduce a new I/O pattern
> (--rw=...) that causes fio to write sequentially inside a zone and for which
> zones are selected randomly? I don't see any other approach that allows to
> make sure that the same workload definition behaves identically against zoned
> and regular block devices.

Yes exactly. Basically come up with something that just maps fio zones on
top of SMR zones. Then come up with something that allows you to have
sequential writes IO within a zone, and something that allows you to decide
how many zones to use, when to skip between zones, etc.

-- 
Jens Axboe

