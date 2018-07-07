Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5473C6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 03:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CE3721E25
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 03:23:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W9BhpTMK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CE3721E25
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932942AbeGGDW4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 23:22:56 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:42194 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932713AbeGGDWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 23:22:51 -0400
Received: by mail-io0-f193.google.com with SMTP id r24-v6so12518649ioh.9
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 20:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zIcH6RsX7uPocR+BriY98E7D8LuhySRc0eg+4miwd4I=;
        b=W9BhpTMK1BQpZDZfJxRWmB0QJUa976Jfa5JDvCOBC2FIAJW0poxl1cUYHBU5NRFybC
         xx+AKZ83Tc1yNcNjbhWqxamwq6cf7XZmCkTCOFg1V6OJHmOprWG+SjFDf4qEeMRWyUR1
         8ayPjzrnDtMyqa7g/nyYrtksSSrFxYc27vXXp/ZXxaucrd+/ORjhzrN6ji0ROeV1bzXy
         yz/B0e0JfzjgwYVqWOjHdgCiV/Qunhv2JoDxRRyNueCnVAoh/usoVqte4IeCI2PhDPhL
         nAD7EqLXgxQqMYDPsZyC4aAcOkwH7qwYgls6YfnQ+AYOTgjWh8rMxXsMBmHklIp1oFn1
         4TEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zIcH6RsX7uPocR+BriY98E7D8LuhySRc0eg+4miwd4I=;
        b=Ryoy12dy06RLpJBxxfmHzQK1ptXSbZwK5o9x+CCiAEDKVTfWCdtNPsHEuoxDkz7vcw
         /A2lZQ688UZlo2VH2w1W0jqvjugBIBNnw208QStwM4gdXTCCg2pRX57RCy7u5vWS0zFA
         +qSVdLJthuWhASxRNkfND6vs2oe8hJ7i7kIDY1B5f8vCPsY69r3EB/Nqxy6rv+4E7x6c
         7TZsRc7U0mfHUlkCFtYjo5+Yd3H9bjXs3x61RjTR5GnvPVlFwgCZS2tY5G9jVdqYUmXp
         p4a7m9S8YyaCgzA8xQWzIoXRakCgU8wCyIaIWmz776YbjwCzTnWY6e46b5Hhp8INld3T
         Nrkg==
X-Gm-Message-State: APt69E1+4K09j5xDPogitfKEKxRlSwTIjo/j1AZcom5Lbyk5IuBIll47
        Jlrka55slFZRf58s7tLf22HvOQifEmetT3oQnumDCA==
X-Google-Smtp-Source: AAOMgpcux0+h9cS6g6qHnikozwIHxdnUDbxNVeWeroXziuz5AGB42ArdmEoeFK6kKKY1SB3dS91RNOBkgdtQigmMsQ4=
X-Received: by 2002:a6b:b010:: with SMTP id z16-v6mr10432121ioe.206.1530933770354;
 Fri, 06 Jul 2018 20:22:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:ba01:0:0:0:0:0 with HTTP; Fri, 6 Jul 2018 20:22:49 -0700 (PDT)
In-Reply-To: <20180707025426.ssxipi7hsehoiuyo@ast-mbp.dhcp.thefacebook.com>
References: <20180707015616.25988-1-dancol@google.com> <20180707025426.ssxipi7hsehoiuyo@ast-mbp.dhcp.thefacebook.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Fri, 6 Jul 2018 20:22:49 -0700
Message-ID: <CAKOZuevB9vq5n8s_oc923pwaAhU-_MCQwdCWLmO12h2D==PDCA@mail.gmail.com>
Subject: Re: [RFC] Add BPF_SYNCHRONIZE bpf(2) command
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Joel Fernandes <joelaf@google.com>, ast@fb.com,
        linux-kernel@vger.kernel.org, Tim Murray <timmurray@google.com>,
        daniel@iogearbox.net, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 6, 2018 at 7:54 PM, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> On Fri, Jul 06, 2018 at 06:56:16PM -0700, Daniel Colascione wrote:
>> BPF_SYNCHRONIZE waits for any BPF programs active at the time of
>> BPF_SYNCHRONIZE to complete, allowing userspace to ensure atomicity of
>> RCU data structure operations with respect to active programs. For
>> example, userspace can update a map->map entry to point to a new map,
>> use BPF_SYNCHRONIZE to wait for any BPF programs using the old map to
>> complete, and then drain the old map without fear that BPF programs
>> may still be updating it.
>>
>> Signed-off-by: Daniel Colascione <dancol@google.com>
>> ---
>>  include/uapi/linux/bpf.h |  1 +
>>  kernel/bpf/syscall.c     | 14 ++++++++++++++
>>  2 files changed, 15 insertions(+)
>>
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index b7db3261c62d..4365c50e8055 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -98,6 +98,7 @@ enum bpf_cmd {
>>       BPF_BTF_LOAD,
>>       BPF_BTF_GET_FD_BY_ID,
>>       BPF_TASK_FD_QUERY,
>> +     BPF_SYNCHRONIZE,
>>  };
>>
>>  enum bpf_map_type {
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> index d10ecd78105f..60ec7811846e 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
>> @@ -2272,6 +2272,20 @@ SYSCALL_DEFINE3(bpf, int, cmd, union bpf_attr __user *, uattr, unsigned int, siz
>>       if (sysctl_unprivileged_bpf_disabled && !capable(CAP_SYS_ADMIN))
>>               return -EPERM;
>>
>> +     if (cmd == BPF_SYNCHRONIZE) {
>> +             if (uattr != NULL || size != 0)
>> +                     return -EINVAL;
>> +             err = security_bpf(cmd, NULL, 0);
>> +             if (err < 0)
>> +                     return err;
>> +             /* BPF programs are run with preempt disabled, so
>> +              * synchronize_sched is sufficient even with
>> +              * RCU_PREEMPT.
>> +              */
>> +             synchronize_sched();
>> +             return 0;
>
> I don't think it's necessary. sys_membarrier() can do this already
> and some folks use it exactly for this use case.

True --- implementation-wise, today. The point of the patch is to sort
out contractual guarantees. membarrier isn't documented to have the
BPF_SYNCHRONIZE effect right now, although it does. If we want to
extend membarrier's contract, great, but that might make it more
expensive than necessary for callers who, well, just want a memory
barrier. It's worthwhile to have a dedicated BPF command for this
task, especially considering the simplicity of the implementation.
