Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C09C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 21:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B4642150F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 21:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IJrf/wln"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B4642150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbeHYBBM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 21:01:12 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36530 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbeHYBBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 21:01:12 -0400
Received: by mail-pg1-f195.google.com with SMTP id h17-v6so4840161pgv.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 14:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wVNaP7cQg4a3pxkFxPonWowsN2mCVx8YyA1KYt5WFAA=;
        b=IJrf/wlnJ9i6ujQ6UjFtIiV+pYIIdkX2aqCR01XqJ/WZNIAyxv2YuJ9u13tTgSfnsz
         +nPrpeQAr1ReuXTxlSU1uenOBZpMHry/H4y+Mqm5srnFgPvOsFxSqGqpL2zJqETIY+69
         anoZKQdXnvH0g1s+aqg+8Ks4ifjBCopLONpi7ONxUdUA3E/wnfOq/iN93M50pKb9p/z+
         Qt90VvEmV52ddzQS7GB83t61R6Al92vncWCX1rf6l1g6ty9BbZMfcuFS9o6WoDfxzg7g
         4FbxQJq49+MY7VTnH2Ef0QjUyWSIFNXNG/aOtz8YLTX2ZAeK8saXrVnd4Vz5eLuvhR0n
         H/JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wVNaP7cQg4a3pxkFxPonWowsN2mCVx8YyA1KYt5WFAA=;
        b=HxAabnAedmewCdgeNvPSWjtlixUSC8jd8YBlfWDgDuN7xu0AhzMS/5rssPWUftSsud
         XDU0JxfIAjtKk2aLVCSwPHnw1vVPoliKyuqtxmnhSgkOZV8Ks701dQZAXyZB3mdzY6Fs
         +3N/DrSBsijPxdKTSZ4NKWySQxQ9MaDTahTYF+os9700mTM2rRhagvNAL0JBMMOkaOpX
         2qLlaGOkHZlA5H87f7qjPensoq/g4WYpm1EgPImg5P3Ze5noCHdyobKFRd53GwZnNR6Q
         9iuxr+TN6kvNIILNDwfF/aZqPnL22DBMGCeNngGos6t32cu/yeZt6u+hMLaBND3tLxKo
         4Odg==
X-Gm-Message-State: APzg51CsBGeG994eE7ieCB3pIVXJtGMSBGUhoEnDiUvpgf7gi01M9j3s
        pWFy97Wx4Wue/DInW/7LFzQfJQ==
X-Google-Smtp-Source: ANB0VdY0vtvPY+7tyF7BEyNI25HIk9pQAs2AV6zy8fxiNfYtXX5JUq8MbfeAa/sBakXvQBw2k77Ikw==
X-Received: by 2002:a63:e001:: with SMTP id e1-v6mr3247118pgh.380.1535145890768;
        Fri, 24 Aug 2018 14:24:50 -0700 (PDT)
Received: from smuckle.san.corp.google.com ([2620:15c:2d:3:fa74:b312:5fef:6cbf])
        by smtp.gmail.com with ESMTPSA id l9-v6sm10200260pgg.79.2018.08.24.14.24.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Aug 2018 14:24:50 -0700 (PDT)
Subject: Re: [PATCH] sched/fair: vruntime should normalize when switching from
 fair
To:     Peter Zijlstra <peterz@infradead.org>,
        Miguel de Dios <migueldedios@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Todd Kjos <tkjos@google.com>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Patrick Bellasi <Patrick.Bellasi@arm.com>,
        Chris Redpath <Chris.Redpath@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        John Dias <joaodias@google.com>
References: <20180817182728.76129-1-smuckle@google.com>
 <dcd2fa21-7fef-d648-017d-9d42d11793e0@google.com>
 <20180824093227.GN24124@hirez.programming.kicks-ass.net>
 <20180824094742.GJ24142@hirez.programming.kicks-ass.net>
From:   Steve Muckle <smuckle@google.com>
Message-ID: <ae94fb88-646b-1d82-b61d-103792965dbf@google.com>
Date:   Fri, 24 Aug 2018 14:24:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180824094742.GJ24142@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/24/2018 02:47 AM, Peter Zijlstra wrote:
>>> On 08/17/2018 11:27 AM, Steve Muckle wrote:
> 
>>>> When rt_mutex_setprio changes a task's scheduling class to RT,
>>>> we're seeing cases where the task's vruntime is not updated
>>>> correctly upon return to the fair class.
> 
>>>> Specifically, the following is being observed:
>>>> - task is deactivated while still in the fair class
>>>> - task is boosted to RT via rt_mutex_setprio, which changes
>>>>     the task to RT and calls check_class_changed.
>>>> - check_class_changed leads to detach_task_cfs_rq, at which point
>>>>     the vruntime_normalized check sees that the task's state is TASK_WAKING,
>>>>     which results in skipping the subtraction of the rq's min_vruntime
>>>>     from the task's vruntime
>>>> - later, when the prio is deboosted and the task is moved back
>>>>     to the fair class, the fair rq's min_vruntime is added to
>>>>     the task's vruntime, even though it wasn't subtracted earlier.
> 
> I'm thinking that is an incomplete scenario; where do we get to
> TASK_WAKING.

Yes there's a missing bit of context here at the beginning that the task 
to be boosted had already been put into TASK_WAKING.
