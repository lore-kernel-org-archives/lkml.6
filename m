Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F84AC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 16:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15E6520666
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 16:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qyUWwfhO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15E6520666
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729424AbeI1Wef (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 18:34:35 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38618 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbeI1Wef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 18:34:35 -0400
Received: by mail-pf1-f194.google.com with SMTP id x17-v6so4640621pfh.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 09:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=C901x3jqNr20aV/bAUPG0A2Qm4Dp3/pjH7/7Mf1Ga54=;
        b=qyUWwfhO5r4u5lsXkufaVeOCzsi0St4MMwl9lGBl2V5BhHaqXBlr71p5XnfNbgBvGr
         JcJoMuDYsFyv6umLM90WGuvigmH0sq3WHPFz/QCa7Ov8B35P+mcjhTI9ehyOo+Ahp4Gi
         +27lhke2GrJDrizlDhPJsmyCOJMoEgy59wep7vogsAhyTGHuAzfJYdS1sPtzT+WmxW/w
         1rpLw9ju+apWlgkND7d/w7ft0NEEBjKZEE9tWSxYb020APQhadnvv2rjoAlrrdF64ssk
         wa8SBgD6vxEE4zzPqv6xebXvTRCVgrC2xP5xMRh/6gF2zxZZeAb/WDk09TEYA7d7lzrW
         vmvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C901x3jqNr20aV/bAUPG0A2Qm4Dp3/pjH7/7Mf1Ga54=;
        b=Uuyqcc0xHXHIwcI0K2yfWw2a8yuYkUTp5qMdIXmSJ5PR4zR93PI9fkgPL9kMVRbi2O
         Z7FncuDAgQADP5+Wy9emWwXoqYak6I+4cwcAVWQRyFORUO16wH+yNfT6RyO4UmH16SEE
         LrXlHWFMC9uFu5u4LteFvjkmqpr9YJLfQ3bYECwKKoUlqZ/v/zcopnAx7YjojYs9mgSG
         PM20BfAFEUZ2Qx8t+UPBjrc8NcZKty5XHav7F/0y7Kv0V/t+WluiSpUg34Nr7FMfxixI
         3zWp8RvRIexlxz28ujGeBsjbr/fYUwT000esjHSpnG7tyH9TUMuQmgjPF4Qm9UoE0tZN
         Fk/w==
X-Gm-Message-State: ABuFfogzY1oZ6KTFr8YuIC1TV6ydolnEArfrh4Nv8XGY5DhpnfmGEjeK
        BDHTKrFOAXH965xa90tvuTsTVw==
X-Google-Smtp-Source: ACcGV61tnvnWxlMc5wXEnfr9AYaIXZHLc/8ok+b7fHfUBUnL90+p1Dm8lvw1sDFoUwRfK/nS3+S0/w==
X-Received: by 2002:a63:2106:: with SMTP id h6-v6mr15679947pgh.161.1538151007486;
        Fri, 28 Sep 2018 09:10:07 -0700 (PDT)
Received: from ?IPv6:2620:0:1000:1610:47d0:ea06:8306:a4ca? ([2620:0:1000:1610:47d0:ea06:8306:a4ca])
        by smtp.gmail.com with ESMTPSA id z5-v6sm7592138pfh.83.2018.09.28.09.10.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 09:10:06 -0700 (PDT)
Subject: Re: [PATCH] sched/fair: vruntime should normalize when switching from
 fair
To:     Wanpeng Li <kernellwp@gmail.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Miguel de Dios <migueldedios@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@android.com,
        Todd Kjos <tkjos@google.com>, Paul Turner <pjt@google.com>,
        quentin.perret@arm.com, Patrick Bellasi <Patrick.Bellasi@arm.com>,
        Chris.Redpath@arm.com, Morten Rasmussen <Morten.Rasmussen@arm.com>,
        John Dias <joaodias@google.com>,
        Wanpeng Li <wanpengli@tencent.com>
References: <20180817182728.76129-1-smuckle@google.com>
 <dcd2fa21-7fef-d648-017d-9d42d11793e0@google.com>
 <20180824093227.GN24124@hirez.programming.kicks-ass.net>
 <20180824094742.GJ24142@hirez.programming.kicks-ass.net>
 <ae94fb88-646b-1d82-b61d-103792965dbf@google.com>
 <20180827111458.GB24124@hirez.programming.kicks-ass.net>
 <2ed346fa-dbe8-4928-928b-a34338b2d8c9@arm.com>
 <CANRm+CwEKf9bBj3zBQAL2nYjdt-zymz1xg7=PRcFz6DUOjLVJg@mail.gmail.com>
 <62134bba-b6bd-ba16-a49b-e4887c326559@arm.com>
 <CANRm+CzasXnjUtA_Xkm27=YDArc-gcpLmpSHv1cAqxihfocxRw@mail.gmail.com>
 <fab279dd-0f6c-af7a-5a06-d26e77afad6a@arm.com>
 <CANRm+CyJQ_D9BP70OmB6z6r0zxDPoB0y828+E0tqis0x=jsd5A@mail.gmail.com>
From:   Steve Muckle <smuckle@google.com>
Message-ID: <c0ec8322-4256-d8ae-0978-25ab44e34d68@google.com>
Date:   Fri, 28 Sep 2018 09:10:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CANRm+CyJQ_D9BP70OmB6z6r0zxDPoB0y828+E0tqis0x=jsd5A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/27/2018 05:43 PM, Wanpeng Li wrote:
>>> On your CPU4:
>>> scheduler_ipi()
>>>    -> sched_ttwu_pending()
>>>         -> ttwu_do_activate()    => p->sched_remote_wakeup should be
>>> false, so ENQUEUE_WAKEUP is set, ENQUEUE_MIGRATED is not
>>>              -> ttwu_activate()
>>>                   -> activate_task()
>>>                        -> enqueue_task()
>>>                             -> enqueue_task_fair()
>>>                                  -> enqueue_entity()
>>>                                       bool renorm = !(flags &
>>> ENQUEUE_WAKEUP) || (flags & ENQUEUE_MIGRATE)
>>> so renorm is false in enqueue_entity(), why you mentioned that the
>>> cfs_rq->min_vruntime is still added to the se->vruntime in
>>> enqueue_task_fair()?
>>
>> Maybe this is a misunderstanding on my side but didn't you asked me to
>> '... Could you point out when the fair rq's min_vruntime is added to the
>> task's vruntime in your *later* scenario? ...'
> 
> Yeah, if the calltrace above and my analysis is correct, then the fair
> rq's min_vruntime will not be added to the task's vruntime in your
> *later* scenario, which means that your patch is not necessary.

In the scenario I observed, the task is not waking - it is running and 
being deboosted from priority inheritance, transitioning from RT to CFS.

Dietmar and I both were able to reproduce the issue with the testcase I 
posted earlier in this thread.

thanks,
Steve
