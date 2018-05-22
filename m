Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752675AbeEVDag (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 23:30:36 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:54051 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751271AbeEVDac (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 23:30:32 -0400
Subject: Re: [PATCH] bpf: check NULL for sk_to_full_sk()
To: Eric Dumazet <eric.dumazet@gmail.com>, <ast@kernel.org>,
        <daniel@iogearbox.net>
References: <20180521075558.11968-1-yuehaibing@huawei.com>
 <5490b571-7881-c5eb-6acf-8f45634cd2b1@gmail.com>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
From: YueHaibing <yuehaibing@huawei.com>
Message-ID: <297885c2-2132-b4a7-e53f-85c82caee95a@huawei.com>
Date: Tue, 22 May 2018 11:29:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <5490b571-7881-c5eb-6acf-8f45634cd2b1@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/5/21 23:17, Eric Dumazet wrote:
> 
> 
> On 05/21/2018 12:55 AM, YueHaibing wrote:
>> like commit df39a9f106d5 ("bpf: check NULL for sk_to_full_sk() return value"),
>> we should check sk_to_full_sk return value against NULL.
>>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>  include/linux/bpf-cgroup.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
>> index 30d15e6..fd3fbeb 100644
>> --- a/include/linux/bpf-cgroup.h
>> +++ b/include/linux/bpf-cgroup.h
>> @@ -91,7 +91,7 @@ int __cgroup_bpf_check_dev_permission(short dev_type, u32 major, u32 minor,
>>  	int __ret = 0;							       \
>>  	if (cgroup_bpf_enabled && sk && sk == skb->sk) {		       \
>>  		typeof(sk) __sk = sk_to_full_sk(sk);			       \
>> -		if (sk_fullsock(__sk))					       \
>> +		if (__sk && sk_fullsock(__sk))				       \
>>  			__ret = __cgroup_bpf_run_filter_skb(__sk, skb,	       \
>>  						      BPF_CGROUP_INET_EGRESS); \
>>  	}								       \
>>
> 
> Why is this needed ???

BPF_CGROUP_RUN_PROG_INET_EGRESS is called in ip_output

I just misunderstood, sorry for noise.
> 
> 
