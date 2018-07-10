Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25BC5C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 04:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5D6A20873
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 04:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LzaerX+P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5D6A20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751250AbeGJE2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 00:28:47 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:32932 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750865AbeGJE2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 00:28:40 -0400
Received: by mail-pf0-f195.google.com with SMTP id b17-v6so15194060pfi.0;
        Mon, 09 Jul 2018 21:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cP4wYknh8kkQInUrimmkNujkT+c71le9gpScFcfvpCk=;
        b=LzaerX+PEZL8r+Ls/jROezZ3qyEc4YbOxoD4kQ34EvbrGFD4lx/RMFLoWerATaHl8B
         x/JzGemjyj8y2agKdot0p5BzhIaT3x20noaeKLKCNMnDIOk1/gCLf907GgxUHXtpkkNO
         Ir+7XmOOWAsEIY4q13tHC57Zik4wgJbD0oiPgdA5Kk21kn7zwktBXX0G+OoXIa6XbK6i
         6wq+Dhv0oA0ePTNpV5whs83xlyeFno5ME8l84L4KuC7ZEoAio7QrbOt5yHiJ5UClwcXZ
         d+MQWVUGMJ5/Rv+FHo9y+FOQL4LoMMuPwCRv35ZAY6f31PeQfqIoaGCiOp2balf5+1CD
         xhvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cP4wYknh8kkQInUrimmkNujkT+c71le9gpScFcfvpCk=;
        b=D0rsTikRdKTRTZk50rCPu6y3EXQsGVNRul1kMADg+3ehyTIJ6uOwuPF7ZRByP0D0Za
         1AEqQeXeRrS9icIeN72dVr5F0A0hW2mZDfDezBVWB33whhls1HszASCODd+BKygk7gTb
         5Q855RiKviKUPKgMux6vFGlz0yBlIHQ35drDwojAc7KNzvYCIp3LavrHrV+P0Ab1yBzN
         TlwFQv7iB9z2Yc7nsbD63YSqEdbVvE+QcVLrjJiIoEsB3/FnZ/VaMHF9Xba/AQwMMrgb
         JTsWlpVIOjwwwPFQVaBPGQo8S7puGwKBPj9I7yOn6+XsNnkTaqyPUi8dB0aPKpN8Y159
         QaAg==
X-Gm-Message-State: APt69E1yAoVE4NpwKnymQWDDceYFf4CqxNFTWcehw7rBqX7HtdDhAeH4
        F099AdJLlSoMAymIOTMqVOzOyZuw
X-Google-Smtp-Source: AAOMgpcYF/qtcQ6/DA2N7ub58bB8lyBhKt9cXhBus+bJWzlQwEiQJ5R3d9RJpnaJ7m3ZPyxCPLMf7Q==
X-Received: by 2002:a63:5350:: with SMTP id t16-v6mr20026993pgl.196.1531196919279;
        Mon, 09 Jul 2018 21:28:39 -0700 (PDT)
Received: from [192.168.0.77] ([211.196.191.92])
        by smtp.gmail.com with ESMTPSA id i12-v6sm23939218pgd.87.2018.07.09.21.28.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 21:28:38 -0700 (PDT)
Subject: Re: [PATCH] samples/bpf: Fix tc and ip path in xdp2skb_meta.sh
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180709150418.32034-1-treeze.taeung@gmail.com>
 <20180709174029.3c05e750@redhat.com>
 <30be797e-e247-1b34-6607-0f0fd3b898fd@gmail.com>
 <20180709212003.10b8e490@redhat.com>
From:   Taeung Song <treeze.taeung@gmail.com>
Message-ID: <0c986522-e841-f460-125e-4db06f8547a7@gmail.com>
Date:   Tue, 10 Jul 2018 13:28:34 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180709212003.10b8e490@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/10/2018 04:20 AM, Jesper Dangaard Brouer wrote:
> On Tue, 10 Jul 2018 02:44:06 +0900
> Taeung Song <treeze.taeung@gmail.com> wrote:
> 
>> Hi Jesper Dangaard Brouer,
>>
>> On 07/10/2018 12:40 AM, Jesper Dangaard Brouer wrote:
>>> On Tue, 10 Jul 2018 00:04:18 +0900
>>> Taeung Song <treeze.taeung@gmail.com> wrote:
>>>    
>>>> The below path error can occur:
>>>>
>>>>     # ./xdp2skb_meta.sh --dev eth0 --list
>>>>     ./xdp2skb_meta.sh: line 61: /usr/sbin/tc: No such file or directory
>>>>
>>>>     # which tc
>>>>     /sbin/tc
>>>>
>>>> So use 'which' command instead of absolute path of tc and ip
>>>>
>>>> Fixes: 36e04a2d78d9 ("samples/bpf: xdp2skb_meta shows transferring info from XDP to SKB")
>>>> Cc: Jesper Dangaard Brouer <brouer@redhat.com>
>>>> Signed-off-by: Taeung Song <treeze.taeung@gmail.com>
>>>> ---
>>>>    samples/bpf/xdp2skb_meta.sh | 4 ++--
>>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/samples/bpf/xdp2skb_meta.sh b/samples/bpf/xdp2skb_meta.sh
>>>> index b9c9549c4c27..67cf7b5f336d 100755
>>>> --- a/samples/bpf/xdp2skb_meta.sh
>>>> +++ b/samples/bpf/xdp2skb_meta.sh
>>>> @@ -16,8 +16,8 @@
>>>>    BPF_FILE=xdp2skb_meta_kern.o
>>>>    DIR=$(dirname $0)
>>>>    
>>>> -export TC=/usr/sbin/tc
>>>> -export IP=/usr/sbin/ip
>>>> +export TC=`which tc`
>>>> +export IP=`which ip`
>>>
>>> This is not a good solution, as 'which' can return something else.
>>> E.g. on my system I've aliased 'tc' to 'sudo tc', and `which tc` returns:
>>>
>>> $ which tc
>>> alias tc='sudo tc'
>>> 	/usr/bin/sudo
>>>
>>> The easiest solution is to simply do:
>>>
>>>    export TC=tc
>>>    export IP=ip
>>>
>>> The more fancy solution is to allow callers to redefine $IP and $TC:
>>>
>>> [ -z "$TC" ] && TC=tc
>>> [ -z "$IP" ] && IP=ip
>>>    
>>
>> Yep, you are right, I'll change it.
>>
>>> And then you should also fix the use of 'basename', see below patch...
>>>    
>>
>> I thought it'd be fine to leave 'basename' as it is,
>> because if callers redefine TC=/home/taeung/tc and give
>> the options --verbose or --dry-run, 'basename' can more tidily show outputs.
> 
> The 'basename' does not work correctly if e.g. TC='sudo tc'.
> 
> Below output is with 'basename' removed, else it would say "sudo qdisc del ..."
> 
> TC='sudo tc' IP='sudo ip' ./xdp2skb_meta.sh -v --dev mlx5p1 --dry-run
> # Device set to: DEV=mlx5p1
> # Dry-run mode: enable VERBOSE and don't call TC+IP
> sudo tc qdisc del dev mlx5p1 clsact
> sudo tc qdisc add dev mlx5p1 clsact
> sudo tc filter add dev mlx5p1 ingress prio 1 handle 1 bpf da obj ./xdp2skb_meta_kern.o sec tc_mark
> # Flush XDP on device: mlx5p1
> sudo ip link set dev mlx5p1 xdp off
> sudo ip link set dev mlx5p1 xdp obj ./xdp2skb_meta_kern.o sec xdp_mark
> 
> 

Oops, right. I missed the alias case.

>> But it seems to be trivial, I'll resend this patch as v2 based on your
>> comment !
> 
> Thx, already ACKed it :-)
> 

--
Thanks a lot !

Taeung
