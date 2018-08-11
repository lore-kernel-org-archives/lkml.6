Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23AE1C46464
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 01:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B689722430
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 01:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lb+Pljyu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B689722430
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbeHKE3v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 00:29:51 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43486 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbeHKE3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 00:29:51 -0400
Received: by mail-pg1-f194.google.com with SMTP id a14-v6so5132189pgv.10;
        Fri, 10 Aug 2018 18:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=K2jIqV8xfVmkkWKsr+88KOuhCmC/IfMhUr/uObbpy3o=;
        b=lb+PljyuSPtQq+sPM+dQ0lrp7mouRpXSdpJm6WDW+TkOaEeKVSiBkWE0P6rCLCfkB/
         ZVKH6zwww4SibgyVPlGBHzpyHmothxj/3NplNo7nFhsb4tOsSBBSGJhP4V0wQEF1cCFH
         xIeMrFJ8zvXxUzTzJJaGLpOYTOJEUyPYKlvAMYCZu/6eT465op0pWQsRw1uN4kLSq1Mq
         EPT9IF5Kkj6ZdN1oRI60NSSuFK3A6IWpPGUQ2fHIP2UJxCeq+QlV4lody2t8UHtR7ogB
         NIhGeExsckGwag14HhmxR7GAe5rEJsxIcX5FiDNgErXJVJK8VJEafEV7I5LGYP7ne6Hg
         wveA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=K2jIqV8xfVmkkWKsr+88KOuhCmC/IfMhUr/uObbpy3o=;
        b=D6GVEQzsWgM7XwwWKsCCx+qP00lCBk+lqQ5vFVoQQf7GaydbButYE0YFwQEDzUfd0c
         ONwuqcHloy62ssED7bVE9r4js79UJ39VNUJHCVJ3cwGcLpxEhAPcbEHeQPMU7/yvxsQC
         2QkE7cek8kMLl7c0DeohOKUXTbKw9Gps8quBGKcdlJL/hMKWMKLevSTBwnmDx6k4xjAR
         lidfU6d7ajnAJJDr2zUK04+mCcyYi7cIfpu2m/sZ+4U1ZfTiDEwJzzGtFP9PY4ynJ5iC
         Ykw2FAxQOzRVYpEqmKoWIF4lwXAiWnimojKEsX07evAn1R1I6OLd97SQkse9ApC9GpTk
         V/1Q==
X-Gm-Message-State: AOUpUlH9HQP/g6j+FIVf5cE7SAbtUfwpQIT8FyDVzBnLU8eJ0sXUjtkB
        Xp6UCoQRZH6twKRHPAJoMDQ=
X-Google-Smtp-Source: AA+uWPytfvhKdzF+w5eVRdaY8rzwa4XO5IL38IVQAvHOM0Qb4d4u+aMLKIFujvTEcvhPrQb81Qi4Eg==
X-Received: by 2002:a62:c8c2:: with SMTP id i63-v6mr9442325pfk.73.1533952647155;
        Fri, 10 Aug 2018 18:57:27 -0700 (PDT)
Received: from ?IPv6:2402:f000:1:1501:200:5efe:166.111.71.51? ([2402:f000:1:1501:200:5efe:a66f:4733])
        by smtp.gmail.com with ESMTPSA id u2-v6sm13705773pfn.59.2018.08.10.18.57.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 18:57:26 -0700 (PDT)
Subject: Re: [BUG] bpf: syscall: a possible sleep-in-atomic-context bug in
 map_update_elem()
To:     Daniel Borkmann <daniel@iogearbox.net>, ast@kernel.org
Cc:     netdev@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        brouer@redhat.com
References: <65830741-bf35-4d32-e365-c32fc17c25cb@gmail.com>
 <97aa2e6b-1863-f123-af2c-24a2e6333ba5@iogearbox.net>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <4f9a083d-1498-8cfb-b54c-614abccb193e@gmail.com>
Date:   Sat, 11 Aug 2018 09:57:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <97aa2e6b-1863-f123-af2c-24a2e6333ba5@iogearbox.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/8/10 22:22, Daniel Borkmann wrote:
> On 08/10/2018 04:07 PM, Jia-Ju Bai wrote:
>> The kernel may sleep with holding a rcu read lock.
>>
>> The function call paths (from bottom to top) in Linux-4.16 are:
>>
>> [FUNC] kmalloc(GFP_KERNEL)
>> kernel/kthread.c, 283: kmalloc in __kthread_create_on_node
>> kernel/kthread.c, 365: __kthread_create_on_node in kthread_create_on_node
>> kernel/bpf/cpumap.c, 368: kthread_create_on_node in __cpu_map_entry_alloc
>> kernel/bpf/cpumap.c, 490: __cpu_map_entry_alloc in cpu_map_update_elem
>> kernel/bpf/syscall.c, 724: [FUNC_PTR]cpu_map_update_elem in map_update_elem
>> kernel/bpf/syscall.c, 723: rcu_read_lock in map_update_elem
>>
>> Note that [FUNC_PTR] means a function pointer call is used.
>>
>> I do not find a good way to fix it, so I only report.
>> This is found by my static analysis tool (DSAC).
> Thanks for the report Jia-Ju! In the map_update_elem() from syscall
> path there's a check map->map_type == BPF_MAP_TYPE_CPUMAP, where we
> call the cpumap's map->ops->map_update_elem() while /not/ being under
> rcu_read_lock() as in other cases, so looks okay to me. Could you point
> out the case for being under rcu_read_lock() more specifically which
> the tool found?

Thanks for your reply :)
My tool cannot accurately track the case of map->map_type at present...

According to my code review, there is a indeed check on line 697 in 
Linux-4.16:
     else if (map->map_type == BPF_MAP_TYPE_CPUMAP) {
         err = map->ops->map_update_elem(map, key, value, attr->flags);
         goto out;
     }
But there is a call to map->ops->map_update_elem() that is under 
rcu_read_lock on line 724:
         rcu_read_lock();
         err = map->ops->map_update_elem(map, key, value, attr->flags);
         rcu_read_unlock();

So I think if map->map_type is not equal to BPF_MAP_TYPE_CPUMAP, 
map->ops->map_update_elem() can still be called under rcu_read_lock, is 
it right?


Best wishes,
Jia-Ju Bai
