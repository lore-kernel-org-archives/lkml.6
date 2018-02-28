Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x227TrA1xMRZlR7WX+i2Xdx+x3vcqeggBQB6cM04IPwPHE+baOJklXPIzBwKkpYa+HR48fvHl
ARC-Seal: i=1; a=rsa-sha256; t=1519853524; cv=none;
        d=google.com; s=arc-20160816;
        b=RyRenD3j+e1xU9kpGTh89zf5g7jMzJG5YgQX0Umy0dNLeD4r462wjglFpUe9lH1mej
         M46nWgL0zEMuwR3XIzqajX8u5jn/uYKPuQFiM23JQ6OI1ih9fsFTKmiU/yQ0hnXtJBm0
         3Kyrl2b0Fi2ibZzg2EVaibHPaNnntilPjAW1883QjhilNipfDvabtR+1RYsPjjqHF1Jc
         Ea4NYSQK5+qNjbovxoLzK0N71Z1SfrB+qzHYigHHnWvJXf+N+kCqk7uKYc35NjTs312/
         uz3DwdX/NBuY+TgdbMwPwJl3MS5dTX9T1aSnf+Y3t0hUpJbDOKMu+oQ+RuVwvLBXNiL1
         Zizw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding
         :content-language:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:to:subject:arc-authentication-results;
        bh=w8/OjG84632wdzzvmfO+lEk/0EZWUvJ9g0JmCRGKJW4=;
        b=Wz8vzlMGnQU6HkMops22fNKX8eaWlyac7s3Oj9N4yMUely4ErmpgjiVTtCIvi8c54D
         buA8BbdYvtgl/7rJh66XPP/8s3IWhqh1iHuusPkpgWu4xcYXjOnevG1fZKbzo+IU2F06
         cE7v4jQulP8TqiitFO8eU8NEHGg15H6Tp2ZbgGV95Hk42RKcN9xZpCZWem8Qiy7j6M3h
         yut8LjcCiMo8o4mgztwPUrd6h3phaxPvQtej2OjT+EMSogJa4/ahkueHwrMYTePR33sg
         3Flr1+3Y+dd2ZGcW8PXgFH1ZamqJwx6q8gr3dkn/nYB/5LKmtWY4+MqAROab/PeB2K/L
         tEjg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935083AbeB1Vbm (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Wed, 28 Feb 2018 16:31:42 -0500
Received: from www62.your-server.de ([213.133.104.62]:58395 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934866AbeB1Vbk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Feb 2018 16:31:40 -0500
Subject: Re: [PATCH] selftests/bpf: Add bpf_probe_read_str to bpf_helpers.h
To: Tushar Dave <tushar.n.dave@oracle.com>, ast@kernel.org,
        shuah@kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1519778024-3113-1-git-send-email-tushar.n.dave@oracle.com>
 <1d72361e-e8a7-38e0-16db-ade3f658ce92@iogearbox.net>
 <f7ff30a7-888f-bb3c-b6b5-48c82d5b0c08@oracle.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <916737aa-6b2b-b207-a1ed-4751c8deca3b@iogearbox.net>
Date: Wed, 28 Feb 2018 22:31:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <f7ff30a7-888f-bb3c-b6b5-48c82d5b0c08@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593681724365410647?=
X-GMAIL-MSGID: =?utf-8?q?1593681928914219920?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/28/2018 10:28 PM, Tushar Dave wrote:
> On 02/28/2018 08:57 AM, Daniel Borkmann wrote:
>> Hi Tushar,
>>
>> On 02/28/2018 01:33 AM, Tushar Dave wrote:
>>> Using bpf_probe_read_str() from samples/bpf causes compiler warning.
>>> e.g.
>>> warning: implicit declaration of function 'bpf_probe_read_str' is invalid in C99
>>>        [-Wimplicit-function-declaration]
>>>          num = bpf_probe_read_str(buf, sizeof(buf), ctx->di);
>>>                ^
>>> 1 warning generated.
>>>
>>> Add bpf_probe_read_str() to bpf_helpers.h so it can be used by
>>> samples/bpf programs.
>>>
>>> Signed-off-by: Tushar Dave <tushar.n.dave@oracle.com>
>>
>> In general no objections to it, but it would need an in-tree
>> user first:
>>
>> $ git grep -n bpf_probe_read_str tools/
>> tools/include/uapi/linux/bpf.h:596: * int bpf_probe_read_str(void *dst, int size, const void *unsafe_ptr)
>> $
>>
>> Why not adding this along with a sample?
> Okay, I will send new patch along with new sample or add usage of
> bpf_probe_read_str() in one of our exiting sample :)

Sounds great, the latter is totally fine as well. :-)

Thanks,
Daniel
