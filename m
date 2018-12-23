Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD3D8C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 03:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A946E218D9
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 03:50:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393105AbeLWDux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 22:50:53 -0500
Received: from gateway34.websitewelcome.com ([192.185.150.114]:47267 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391500AbeLWDux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 22:50:53 -0500
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id 101F940D515
        for <linux-kernel@vger.kernel.org>; Sat, 22 Dec 2018 21:50:52 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id aumygwbKCiQeraumyg1RrE; Sat, 22 Dec 2018 21:50:52 -0600
X-Authority-Reason: nr=8
Received: from [189.250.106.44] (port=55714 helo=[192.168.43.131])
        by gator4166.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gaumx-002px3-DX; Sat, 22 Dec 2018 21:50:51 -0600
Subject: Re: [PATCH] net: core: Fix Spectre v1 vulnerability
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     David Miller <davem@davemloft.net>, ast@kernel.org,
        daniel@iogearbox.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20181221204901.GA30045@embeddedor>
 <20181222.150722.1493687829239836271.davem@davemloft.net>
 <20181222235952.keue7a336sg7jfim@ast-mbp.dhcp.thefacebook.com>
 <20181222.184051.718127928973898182.davem@davemloft.net>
 <e1c8e69b-3417-6176-6b49-1b7a23febb21@embeddedor.com>
 <20181223030039.wrpytx7pwfcljdjm@ast-mbp.dhcp.thefacebook.com>
 <37df17ba-7fcf-ab04-fe9a-d2a6fc5b6b9c@embeddedor.com>
Message-ID: <08d2491d-5c09-7073-a651-0eed8302a63b@embeddedor.com>
Date:   Sat, 22 Dec 2018 21:50:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <37df17ba-7fcf-ab04-fe9a-d2a6fc5b6b9c@embeddedor.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.106.44
X-Source-L: No
X-Exim-ID: 1gaumx-002px3-DX
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.43.131]) [189.250.106.44]:55714
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 17
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexei,

On 12/22/18 9:37 PM, Gustavo A. R. Silva wrote:
> 
> 
> On 12/22/18 9:00 PM, Alexei Starovoitov wrote:
>> On Sat, Dec 22, 2018 at 08:53:40PM -0600, Gustavo A. R. Silva wrote:
>>> Hi,
>>>
>>> On 12/22/18 8:40 PM, David Miller wrote:
>>>> From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
>>>> Date: Sat, 22 Dec 2018 15:59:54 -0800
>>>>
>>>>> On Sat, Dec 22, 2018 at 03:07:22PM -0800, David Miller wrote:
>>>>>> From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
>>>>>> Date: Fri, 21 Dec 2018 14:49:01 -0600
>>>>>>
>>>>>>> flen is indirectly controlled by user-space, hence leading to
>>>>>>> a potential exploitation of the Spectre variant 1 vulnerability.
>>>>>>>
>>>>>>> This issue was detected with the help of Smatch:
>>>>>>>
>>>>>>> net/core/filter.c:1101 bpf_check_classic() warn: potential 
>>>>>>> spectre issue 'filter' [w]
>>>>>>>
>>>>>>> Fix this by sanitizing flen before using it to index filter at 
>>>>>>> line 1101:
>>>>>>>
>>>>>>>     switch (filter[flen - 1].code) {
>>>>>>>
>>>>>>> and through pc at line 1040:
>>>>>>>
>>>>>>>     const struct sock_filter *ftest = &filter[pc];
>>>>>>>
>>>>>>> Notice that given that speculation windows are large, the policy is
>>>>>>> to kill the speculation on the first load and not worry if it can be
>>>>>>> completed with a dependent load/store [1].
>>>>>>>
>>>>>>> [1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2
>>>>>>>
>>>>>>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>>>>>>
>>>>>> BPF folks, I'll take this directly.
>>>>>>
>>>>>> Applied and queued up for -stable, thanks.
>>>>>
>>>>> hmm. what was the rush?
>>>>> I think it is unnecessary change.
>>>>> Though fp is passed initially from user space
>>>>> it's copied into kernel struct first.
>>>>> There is no way user space can force kernel to mispredict
>>>>> branch in for (pc = 0; pc < flen; pc++) loop.
>>> The following piece of code is the one that can be mispredicted, not 
>>> the for
>>> loop:
>>>
>>> 1013         if (flen == 0 || flen > BPF_MAXINSNS)
>>> 1014                 return false;
>>>
>>> Instead of calling array_index_nospec() inside bpf_check_basics_ok(), I
>>> decided to place the call close to the code that could be 
>>> compromised. This
>>> is when accessing filter[].
>>
>> Why do you think it can be mispredicted?
>>
> 
> Beause fprog->len comes from user space:
> 
> bpf_prog_create_from_user() -> bpf_check_basics_ok()
> 
>> I've looked at your other patch for nfc_sock_create() where you're 
>> adding:
>> + proto = array_index_nospec(proto, NFC_SOCKPROTO_MAX);
>>
>> 'proto' is the value passed in _register_ into system call.
>> There is no need to wrap it with array_index_nospec().
>> It's not a load from memory and user space cannot make it slow.
>> Slow load is a necessary attribute to trigger speculative execution
>> into mispredicted branch.
>>

I think I know where the confusion is coming from. The load you talk 
about is the firs load needed in the following code:

if (x < array1_size) {
   v = array2[array1[x]*256]
}

This is array[x]

In this case, that first load needed would be:

1101: switch (filter[flen - 1].code) {

or

1040: const struct sock_filter *ftest = &filter[pc];

The policy has been to kill the speculation on that first load and not 
worry if it can be completed with a dependent load/store. As mentioned 
in the commit log.

Thanks
--
Gustavo
