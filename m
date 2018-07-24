Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D843AECDE5F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 01:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9393D20875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 01:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SL/ZyiW0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9393D20875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388373AbeGXCq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 22:46:29 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41447 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388267AbeGXCq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 22:46:29 -0400
Received: by mail-pf1-f195.google.com with SMTP id y10-v6so452488pfn.8;
        Mon, 23 Jul 2018 18:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=1EYjYgyCmvJ5V7OgwzHMHiRu3AN7mFz2MQ8kepnXbdc=;
        b=SL/ZyiW0YqLjUoCZFQd2y4wo653LhJjatA1XNreJEgzznAn11XTgyi3xjuCAMXk0XJ
         cfs0eW6nZBwJ53btPaIfPjYaCwx74lnXOPjOUaT/e5lZ+a5pu7jFvS5Pr37JVDnwpd2f
         iTJQ8yi8kUEWimXhgGPElR2VjrF1/4KROSbztqrD+vlBzoQZYxsY+zW3pApzKq5ZoM8z
         f8eg/75gEdnV+wcpXqThYpTGhsagUFbF/CyXPYETGL/Ox6CF44PoZXm7/0RNiepHYOeQ
         FjVO+p0CCzaAv1zKr/vRaa03sWQbjpbSjlQBSujruVzBg/ZbO0GyaCHHTuOiQ9Su5ZD8
         Tnjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=1EYjYgyCmvJ5V7OgwzHMHiRu3AN7mFz2MQ8kepnXbdc=;
        b=nBfLj2ifE4uyV0Qa8Vq4qDdgqZht4sqC+v3sZgwtq4ljDq0daqvlGkRNvDbsCu+9jK
         8dP3ZddY1azkFUkWoNsbVJDZJADb20GwRhs/6F3w9cw+LK39YLzQxo4QXVEcMzlZOEEh
         Ip21lnyWw4EB7MqZ103UCKVX2W6N+9W2b+jZlULxKVLL2k8Rbke4WZxXJOkEwHXBmRJz
         hgfZ3juYFxnKnxnArwBLupUaTbPUHXniRnM0+LeKu4ZTecNH4Q0kiAveRUqeNEEloAfA
         mAxwgGyvRAKATg+20QDzYQeTTI9Lfv0qteIImDpb6GiD92TIbGMpWnpqWg7m3tUqhoGp
         zWpQ==
X-Gm-Message-State: AOUpUlFK07cYinil2K29zlqdy8jxoVkMO6pyVr2Qj+ZihlMF+6aV14sc
        v7RHT+vUY31fj6iO40yZulmLQS2t
X-Google-Smtp-Source: AAOMgpdMH65SmdOtoi2nbZVuSnxVrwbl8dLGC9K8KlYsu0ovAvIK44qIYYUrjMMpJYWM/l6PVZ/FRg==
X-Received: by 2002:a63:9311:: with SMTP id b17-v6mr14412433pge.261.1532396551837;
        Mon, 23 Jul 2018 18:42:31 -0700 (PDT)
Received: from ?IPv6:2402:f000:1:1501:200:5efe:101.5.211.5? ([2402:f000:1:1501:200:5efe:6505:d305])
        by smtp.gmail.com with ESMTPSA id 22-v6sm18040178pfl.126.2018.07.23.18.42.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 18:42:31 -0700 (PDT)
Subject: Re: [PATCH] block: ioprio: Replace GFP_ATOMIC with GFP_KERNEL in
 set_task_ioprio()
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Christoph Hellwig <hch@infradead.org>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180723022116.6919-1-baijiaju1990@gmail.com>
 <20180723071803.GA30817@infradead.org>
 <8dab79c6-eb75-b013-1f83-3af43a7052cb@I-love.SAKURA.ne.jp>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <00149ccf-71d7-14e9-fb64-9b8b2ca1e74e@gmail.com>
Date:   Tue, 24 Jul 2018 09:42:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <8dab79c6-eb75-b013-1f83-3af43a7052cb@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/7/24 5:49, Tetsuo Handa wrote:
> On 2018/07/23 16:18, Christoph Hellwig wrote:
>> Looks good,
> Looks bad. :-(
>
> SYSCALL_DEFINE3(ioprio_set, int, which, int, who, int, ioprio)
> {
> (...snipped...)
> 	rcu_read_lock();
> (...snipped...)
> 	ret = set_task_ioprio(p, ioprio);
> (...snipped...)
> 	rcu_read_unlock();
> (...snipped...)

Oops, my tool does not handle SYSCALL_DEFINE3()...
Sorry for my incorrect report.


Best wishes,
Jia-Ju Bai

