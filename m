Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82684C46460
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 02:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A830216F9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 02:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJxd3e07"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A830216F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbeHMF2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 01:28:47 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43770 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbeHMF2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 01:28:47 -0400
Received: by mail-pf1-f194.google.com with SMTP id j26-v6so6991094pfi.10;
        Sun, 12 Aug 2018 19:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=paGM/ud2yD4rfZafqMldUHK2rdIiO/acUnYq7yhjIyk=;
        b=cJxd3e07wTNsGIyNT94s5K2pJfcJKLk3e9pgHahzVn/J8bbG9aP9Qj9lqBs9lpNwvA
         8mkaoHt7VFYOzoDTXAy7HZxJX0xV0h6FU+HMgJQ76m8RaFZMYZ9YJ2jABfOEPm1HdBER
         fE2IX5zPoiWGmX/YNVCVuJi2h6Tu59nVplZ8cFx/KWJp+CpykduEEjj0hVic0p+DKora
         fF8nt/iiklfAQKaeHZg5AQyRanLSs/mwcjboPUbUKG+cg59kQmfopTFbTgKtAW/ucTx5
         h/VdFVHnytZb0WkFrx72UV2MRr9C5GZDlOmKlTrStKzL7k65DqDHAtTy52gTotRI2FK7
         uLcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=paGM/ud2yD4rfZafqMldUHK2rdIiO/acUnYq7yhjIyk=;
        b=GdAc4Ckn2U7FLduF+t1mv0xLDg5B/s0soblXT1318tZUGiqPT4KAloSqK07CQXt6xH
         bTB2hAViIEjqJOBC5PUmTpEmuEH7sgMoRIpEuJjS/MuehLH2//kcDx05CPE3MtV29tH3
         5DuNdCgHUafvlnoawX/uPt7cTe6BjSyJrg+KFG9iXqQXrKFBE/XQPv8Wq1mRlSw9w0Re
         8bYlEFOiDdW7tPoFtzWDAL5pmUqn5fU7nbIBrVSf+k+e6KOPOLvPUQOOalMfGL3EJJU5
         T/G48NfC9aWeiaAEOxosczfP8DO7CVozgFkLaZn5nIdzVMa4olucTzo/2dGgZaTsZKqo
         +NzQ==
X-Gm-Message-State: AOUpUlGO4iiig4FUvRADJFkuiHxUsofxZ5I3U6O94oE7pH/5bjZ7zZJb
        QS5pAHBWJgqZ1lTrUzJxKOU=
X-Google-Smtp-Source: AA+uWPyesjfFbQVysfF/89mdiC/CYlFRc6jWn3nS/PcxSHBBROqWFOHeM/JGxQ5u/UB0hpIbFIJj1A==
X-Received: by 2002:a63:5964:: with SMTP id j36-v6mr15521846pgm.222.1534128518137;
        Sun, 12 Aug 2018 19:48:38 -0700 (PDT)
Received: from ?IPv6:2402:f000:1:1501:200:5efe:166.111.71.57? ([2402:f000:1:1501:200:5efe:a66f:4739])
        by smtp.gmail.com with ESMTPSA id f19-v6sm26228706pfd.147.2018.08.12.19.48.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Aug 2018 19:48:37 -0700 (PDT)
Subject: Re: [BUG] bpf: syscall: a possible sleep-in-atomic-context bug in
 map_update_elem()
To:     Y Song <ys114321@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>
References: <65830741-bf35-4d32-e365-c32fc17c25cb@gmail.com>
 <97aa2e6b-1863-f123-af2c-24a2e6333ba5@iogearbox.net>
 <4f9a083d-1498-8cfb-b54c-614abccb193e@gmail.com>
 <CAH3MdRWBrEfapBMkK9sOa-e_bBZzdkcxhioEHJoZ31hF6XXuxQ@mail.gmail.com>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <d960a614-a1e2-3961-69b8-c44201adccdf@gmail.com>
Date:   Mon, 13 Aug 2018 10:48:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <CAH3MdRWBrEfapBMkK9sOa-e_bBZzdkcxhioEHJoZ31hF6XXuxQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/8/11 13:01, Y Song wrote:
> On Fri, Aug 10, 2018 at 6:57 PM, Jia-Ju Bai <baijiaju1990@gmail.com> wrote:
>>
>> On 2018/8/10 22:22, Daniel Borkmann wrote:
>>> On 08/10/2018 04:07 PM, Jia-Ju Bai wrote:
>>>> The kernel may sleep with holding a rcu read lock.
>>>>
>>>> The function call paths (from bottom to top) in Linux-4.16 are:
>>>>
>>>> [FUNC] kmalloc(GFP_KERNEL)
>>>> kernel/kthread.c, 283: kmalloc in __kthread_create_on_node
>>>> kernel/kthread.c, 365: __kthread_create_on_node in kthread_create_on_node
>>>> kernel/bpf/cpumap.c, 368: kthread_create_on_node in __cpu_map_entry_alloc
>>>> kernel/bpf/cpumap.c, 490: __cpu_map_entry_alloc in cpu_map_update_elem
>>>> kernel/bpf/syscall.c, 724: [FUNC_PTR]cpu_map_update_elem in
>>>> map_update_elem
>>>> kernel/bpf/syscall.c, 723: rcu_read_lock in map_update_elem
>>>>
>>>> Note that [FUNC_PTR] means a function pointer call is used.
>>>>
>>>> I do not find a good way to fix it, so I only report.
>>>> This is found by my static analysis tool (DSAC).
> Maybe your static analysis tool have false positives in this case?
>
>>> Thanks for the report Jia-Ju! In the map_update_elem() from syscall
>>> path there's a check map->map_type == BPF_MAP_TYPE_CPUMAP, where we
>>> call the cpumap's map->ops->map_update_elem() while /not/ being under
>>> rcu_read_lock() as in other cases, so looks okay to me. Could you point
>>> out the case for being under rcu_read_lock() more specifically which
>>> the tool found?
>>
>> Thanks for your reply :)
>> My tool cannot accurately track the case of map->map_type at present...
>>
>> According to my code review, there is a indeed check on line 697 in
>> Linux-4.16:
>>      else if (map->map_type == BPF_MAP_TYPE_CPUMAP) {
>>          err = map->ops->map_update_elem(map, key, value, attr->flags);
>>          goto out;
>>      }
>> But there is a call to map->ops->map_update_elem() that is under
>> rcu_read_lock on line 724:
>>          rcu_read_lock();
>>          err = map->ops->map_update_elem(map, key, value, attr->flags);
>>          rcu_read_unlock();
>>
>> So I think if map->map_type is not equal to BPF_MAP_TYPE_CPUMAP,
>> map->ops->map_update_elem() can still be called under rcu_read_lock, is it
>> right?
> map->ops->map_update_elem() can be called under rcu_read_lock(), but
> since it is not type cpumap, the function should not be cpu_map_update_elem().
> Could you double check your static analysis tool?

Thanks for your reply :)

I have checked the code again, and find that my report is not correct here.
It is because that my tool does not handle the context of function 
pointer assignment.


Best wishes,
Jia-Ju Bai
