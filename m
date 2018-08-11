Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26664C46460
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 05:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B43AC223E6
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 05:02:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SvciDqjc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B43AC223E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbeHKHfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 03:35:06 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:45754 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbeHKHfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 03:35:06 -0400
Received: by mail-ua1-f66.google.com with SMTP id k8-v6so4086569uaq.12;
        Fri, 10 Aug 2018 22:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZC8+1yclx5WDaSPytBCKjdTzkJ9PyCnM2cGCx68V9F8=;
        b=SvciDqjcf/LasIuocpLlDc6+UH+0MkbdhUkqTPjZfA0lv1fTr6v+3DCH6KvmEpvZsR
         N7Ff62udRQPezz0fzsfRaOoIaPI7EOnyPFJYvhVsYstTSoX4bajSM+6KaBTczRlUZ+Xp
         wdhpXz97yeTVHeH7naiYfwxpbBGqERwpk+oXinCwwmGXOPzxVYD5B47CSpGgy6zw/69V
         kAGOJGZLjk6ScN4dD1m70N1HCxH5otiOFlOECHqm0G7EjtZqJR0aKT7Yvjzhd48ihBYK
         RdH3punV7Uv3QgC5qlm4NxC6JHnzHHGmGNd6cP1kUgkUOCQJUllBI9xVefrHA6rwmn3N
         Saaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZC8+1yclx5WDaSPytBCKjdTzkJ9PyCnM2cGCx68V9F8=;
        b=YI+sr3cZoe8KlScRsNf1ZuRH1uGuFpmxP86h4selC1r/mleX+zqHehGeLHSzYZHsfz
         0jJoF269I6idqyHSa2YY9T19KJrWkFODrS53acrLitbqankJ4+R70731NtHPiK1pfRWj
         gUY4fs4O+504kfxlu1W21xAU2BGjAUZclwsUMEI/s4pqO0tsH1tJdCC8hNe3tvJFOkbx
         nTfKSBXfEMpNx7OSiTK14L8XrynZ+hxTYN3rPJAHLigpvrreqD2ZmfIvUBTk8Jpwu1TY
         kN+kfl4fwK4rQoQvd1bhte0LZkh4Tn1vqV6lCZpTKmmIRVgNNWTY88ryIB+kuzFY3bBL
         MEEA==
X-Gm-Message-State: AOUpUlGozgSHhzblPzvO4xwPQzJuDhur7d9oF29m8hPKXPtoqS80rHhP
        hQ50W0Ch3LofT73XZdTAJ7nuVKfpaiIyZUwDZZY=
X-Google-Smtp-Source: AA+uWPzDjibaRT8H0rjI8nAKsh22zUNwbaDcaOxzKJgYRqeklM3kxNALHud/1DNKGowi2i2sw5EhU+2vd8wEe7Wueyo=
X-Received: by 2002:ab0:1c1a:: with SMTP id a26-v6mr6228724uaj.142.1533963733777;
 Fri, 10 Aug 2018 22:02:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:7f52:0:0:0:0:0 with HTTP; Fri, 10 Aug 2018 22:01:33
 -0700 (PDT)
In-Reply-To: <4f9a083d-1498-8cfb-b54c-614abccb193e@gmail.com>
References: <65830741-bf35-4d32-e365-c32fc17c25cb@gmail.com>
 <97aa2e6b-1863-f123-af2c-24a2e6333ba5@iogearbox.net> <4f9a083d-1498-8cfb-b54c-614abccb193e@gmail.com>
From:   Y Song <ys114321@gmail.com>
Date:   Fri, 10 Aug 2018 22:01:33 -0700
Message-ID: <CAH3MdRWBrEfapBMkK9sOa-e_bBZzdkcxhioEHJoZ31hF6XXuxQ@mail.gmail.com>
Subject: Re: [BUG] bpf: syscall: a possible sleep-in-atomic-context bug in map_update_elem()
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 6:57 PM, Jia-Ju Bai <baijiaju1990@gmail.com> wrote:
>
>
> On 2018/8/10 22:22, Daniel Borkmann wrote:
>>
>> On 08/10/2018 04:07 PM, Jia-Ju Bai wrote:
>>>
>>> The kernel may sleep with holding a rcu read lock.
>>>
>>> The function call paths (from bottom to top) in Linux-4.16 are:
>>>
>>> [FUNC] kmalloc(GFP_KERNEL)
>>> kernel/kthread.c, 283: kmalloc in __kthread_create_on_node
>>> kernel/kthread.c, 365: __kthread_create_on_node in kthread_create_on_node
>>> kernel/bpf/cpumap.c, 368: kthread_create_on_node in __cpu_map_entry_alloc
>>> kernel/bpf/cpumap.c, 490: __cpu_map_entry_alloc in cpu_map_update_elem
>>> kernel/bpf/syscall.c, 724: [FUNC_PTR]cpu_map_update_elem in
>>> map_update_elem
>>> kernel/bpf/syscall.c, 723: rcu_read_lock in map_update_elem
>>>
>>> Note that [FUNC_PTR] means a function pointer call is used.
>>>
>>> I do not find a good way to fix it, so I only report.
>>> This is found by my static analysis tool (DSAC).

Maybe your static analysis tool have false positives in this case?

>>
>> Thanks for the report Jia-Ju! In the map_update_elem() from syscall
>> path there's a check map->map_type == BPF_MAP_TYPE_CPUMAP, where we
>> call the cpumap's map->ops->map_update_elem() while /not/ being under
>> rcu_read_lock() as in other cases, so looks okay to me. Could you point
>> out the case for being under rcu_read_lock() more specifically which
>> the tool found?
>
>
> Thanks for your reply :)
> My tool cannot accurately track the case of map->map_type at present...
>
> According to my code review, there is a indeed check on line 697 in
> Linux-4.16:
>     else if (map->map_type == BPF_MAP_TYPE_CPUMAP) {
>         err = map->ops->map_update_elem(map, key, value, attr->flags);
>         goto out;
>     }
> But there is a call to map->ops->map_update_elem() that is under
> rcu_read_lock on line 724:
>         rcu_read_lock();
>         err = map->ops->map_update_elem(map, key, value, attr->flags);
>         rcu_read_unlock();
>
> So I think if map->map_type is not equal to BPF_MAP_TYPE_CPUMAP,
> map->ops->map_update_elem() can still be called under rcu_read_lock, is it
> right?

map->ops->map_update_elem() can be called under rcu_read_lock(), but
since it is not type cpumap, the function should not be cpu_map_update_elem().
Could you double check your static analysis tool?

>
>
> Best wishes,
> Jia-Ju Bai
