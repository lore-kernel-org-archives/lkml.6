Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC67FC5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 17:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA1D5208A2
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 17:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t3jU1c8e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA1D5208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934240AbeGIRoO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 13:44:14 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33952 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933804AbeGIRoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 13:44:12 -0400
Received: by mail-pg1-f193.google.com with SMTP id y5-v6so1402420pgv.1;
        Mon, 09 Jul 2018 10:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=L+Y/GFRzPYSt8CrIWdWa8PLNUTtrkN4+807ODuqdxTg=;
        b=t3jU1c8eZfI5lTzwQjJVcm/K6SAtLplrcGlYoIo7E3UqV6Y121RoXc2sYJCOjWrZ3a
         UOVuzvrSd3TumyVsOgw3kZr1Fvz6Ryl62WFc9KHp2qRzlXPqSY1FD3ps4JkJU4biv5fN
         kJg0zAg4ma7zRwjpvKP1Q3PNO0qoANUHk/N7nPYWRPfDqdF94NK8cV6dqGyHMKb/Z2+U
         rC92Gpgw1nfPh/pMzd63XlKDdz+T0MrThtX6OW/07MUMYRUU9KSqyPQ9eSi9nQfWrsEN
         VIaOgBweIFogs5E4rWaMjCQx3RJR3JbF56ciIJ8S6JOIjzU2l/SXND745KsxEnCxVbdz
         eLLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L+Y/GFRzPYSt8CrIWdWa8PLNUTtrkN4+807ODuqdxTg=;
        b=Kuw9hGH7AhwL8JlFszB6xPz7WyAKBzqPIT1/gJyVmrpiJwL0q9cI6YSuyrZGxXAtmg
         vOxfTEMPsrCZWVZj01N3S4NBRvtK1WfpBhoi5GNrNB0oKsvi6XunE+exAUZiVrLOW9UG
         99ZtH9reaRMLUobLoZXLQ5zT87AgSAXK+5NxMR3vkH3ZnDoqZg5pAV5KsgC0A2RBeBhw
         jE0D+w3kf1V9KqXkXBqlCJX+FioT/DH5vvorh8enEQQkrMkH/35Rm/ONnv+NsM9RBs1f
         8lF/rm0sSPwGaP3UDkm69PhmnbHQNTvjakE0L5OpqSGxGaH3T+/FX5BNuNHnrAWzOlJO
         rj8w==
X-Gm-Message-State: APt69E0mFpelFvxYCdMYMZddL7LvtQfn2vKWuAiCFJgIjKIIrZ7nLD3J
        W9ZvXIKtTk3j1S9+yk+7oifaGIUR
X-Google-Smtp-Source: AAOMgpdni0b0OSp0ISBI/+BS7/vjDocQC5YPYs0P9tcVjU2oBHzz3uZQb4e3um0WbpxlutNvKFc31Q==
X-Received: by 2002:a63:4106:: with SMTP id o6-v6mr20087866pga.453.1531158251041;
        Mon, 09 Jul 2018 10:44:11 -0700 (PDT)
Received: from [192.168.0.77] ([211.196.191.92])
        by smtp.gmail.com with ESMTPSA id m21-v6sm21100191pgv.27.2018.07.09.10.44.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 10:44:10 -0700 (PDT)
Subject: Re: [PATCH] samples/bpf: Fix tc and ip path in xdp2skb_meta.sh
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180709150418.32034-1-treeze.taeung@gmail.com>
 <20180709174029.3c05e750@redhat.com>
From:   Taeung Song <treeze.taeung@gmail.com>
Message-ID: <30be797e-e247-1b34-6607-0f0fd3b898fd@gmail.com>
Date:   Tue, 10 Jul 2018 02:44:06 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180709174029.3c05e750@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jesper Dangaard Brouer,

On 07/10/2018 12:40 AM, Jesper Dangaard Brouer wrote:
> On Tue, 10 Jul 2018 00:04:18 +0900
> Taeung Song <treeze.taeung@gmail.com> wrote:
> 
>> The below path error can occur:
>>
>>    # ./xdp2skb_meta.sh --dev eth0 --list
>>    ./xdp2skb_meta.sh: line 61: /usr/sbin/tc: No such file or directory
>>
>>    # which tc
>>    /sbin/tc
>>
>> So use 'which' command instead of absolute path of tc and ip
>>
>> Fixes: 36e04a2d78d9 ("samples/bpf: xdp2skb_meta shows transferring info from XDP to SKB")
>> Cc: Jesper Dangaard Brouer <brouer@redhat.com>
>> Signed-off-by: Taeung Song <treeze.taeung@gmail.com>
>> ---
>>   samples/bpf/xdp2skb_meta.sh | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/samples/bpf/xdp2skb_meta.sh b/samples/bpf/xdp2skb_meta.sh
>> index b9c9549c4c27..67cf7b5f336d 100755
>> --- a/samples/bpf/xdp2skb_meta.sh
>> +++ b/samples/bpf/xdp2skb_meta.sh
>> @@ -16,8 +16,8 @@
>>   BPF_FILE=xdp2skb_meta_kern.o
>>   DIR=$(dirname $0)
>>   
>> -export TC=/usr/sbin/tc
>> -export IP=/usr/sbin/ip
>> +export TC=`which tc`
>> +export IP=`which ip`
> 
> This is not a good solution, as 'which' can return something else.
> E.g. on my system I've aliased 'tc' to 'sudo tc', and `which tc` returns:
> 
> $ which tc
> alias tc='sudo tc'
> 	/usr/bin/sudo
> 
> The easiest solution is to simply do:
> 
>   export TC=tc
>   export IP=ip
> 
> The more fancy solution is to allow callers to redefine $IP and $TC:
> 
> [ -z "$TC" ] && TC=tc
> [ -z "$IP" ] && IP=ip
> 

Yep, you are right, I'll change it.

> And then you should also fix the use of 'basename', see below patch...
> 

I thought it'd be fine to leave 'basename' as it is,
because if callers redefine TC=/home/taeung/tc and give
the options --verbose or --dry-run, 'basename' can more tidily show outputs.

But it seems to be trivial, I'll resend this patch as v2 based on your 
comment !

Thanks,
Taeung

