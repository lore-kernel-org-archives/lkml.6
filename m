Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x2259ORcp7JODaxk9oxio7ipUc6qGqhDHYmznV3x6TUQlRa5398DUO9TFSdxsmx7nqQ5ql7Aw
ARC-Seal: i=1; a=rsa-sha256; t=1519853329; cv=none;
        d=google.com; s=arc-20160816;
        b=SavR9g38SLmV9w7auwWHBEuLWl8myPOxm7Q01nQpiYkM/9fdQ06fBtykkP5bbsk9M2
         IV5KvPoZQh3dxWa519eh7ugw//ksQK5iTDMz7mTHJlFOvQDAfzjtYc2aGt/JCAuFqA8M
         jWMs2hOBcZczQKwb7uD+7gO7Fzn1qqBGVDYwZs/si0r93cyAU76YaLIZY8bFEbet3MkJ
         Iv5u6dTXBmuU8gkGIMnD5DynDkvDn2hfbNJr0IdFU6LXuWxTFas4cs+wt0hgf7Qf082A
         95co5YTi5CzgBX9I19ZDMm5UP3ooIJUa5zu0NyDYaadzp59Ae7205MgZBmioFCOVWbqu
         sZmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding
         :content-language:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:to:subject:dkim-signature
         :arc-authentication-results;
        bh=BzEXug4sfJzH1fqJoBw6o7AnvKHWfomAWCl2ZxrWgzg=;
        b=vY5dbK0RsZxMuZ3IiTE5R8UWFgh2lp3oVyi2GLB70ZzdIN6OEk4TxORMzbo+3YMv7w
         BLiZzS9Znfp+hi07jA0qmEr6AD/aNdbMm+iyARHX6zmU/Oj0W8JRUJF6CcwD1W1cD8vV
         9TfPKgIw8EVCTd95+7FPWQ1PC6vDvIig6HuJmlc3oyOYTWZ4II28zj8lsAAl9ZWAiGoJ
         U3cw0zVYMmokUnRCfRdTJ5trJy9iOhJy7sKD2kY+ohQ+11jsBNzm0M05wcFqL8L9DHe5
         upuJnXoQBAs9+2OrZf+DDc7xeHteEvszzqUSUwRN05qV2L3n7j3f/r9fBUEdNulhySS0
         FwkQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@oracle.com header.s=corp-2017-10-26 header.b=Kq2SX6mQ;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@oracle.com header.s=corp-2017-10-26 header.b=Kq2SX6mQ;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934797AbeB1V2t (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Wed, 28 Feb 2018 16:28:49 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:56626 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933745AbeB1V2r (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Feb 2018 16:28:47 -0500
Subject: Re: [PATCH] selftests/bpf: Add bpf_probe_read_str to bpf_helpers.h
To: Daniel Borkmann <daniel@iogearbox.net>, ast@kernel.org,
        shuah@kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1519778024-3113-1-git-send-email-tushar.n.dave@oracle.com>
 <1d72361e-e8a7-38e0-16db-ade3f658ce92@iogearbox.net>
From: Tushar Dave <tushar.n.dave@oracle.com>
Message-ID: <f7ff30a7-888f-bb3c-b6b5-48c82d5b0c08@oracle.com>
Date: Wed, 28 Feb 2018 13:28:16 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1d72361e-e8a7-38e0-16db-ade3f658ce92@iogearbox.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8818 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802280260
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593681724365410647?=
X-GMAIL-MSGID: =?utf-8?q?1593681724365410647?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 02/28/2018 08:57 AM, Daniel Borkmann wrote:
> Hi Tushar,
> 
> On 02/28/2018 01:33 AM, Tushar Dave wrote:
>> Using bpf_probe_read_str() from samples/bpf causes compiler warning.
>> e.g.
>> warning: implicit declaration of function 'bpf_probe_read_str' is invalid in C99
>>        [-Wimplicit-function-declaration]
>>          num = bpf_probe_read_str(buf, sizeof(buf), ctx->di);
>>                ^
>> 1 warning generated.
>>
>> Add bpf_probe_read_str() to bpf_helpers.h so it can be used by
>> samples/bpf programs.
>>
>> Signed-off-by: Tushar Dave <tushar.n.dave@oracle.com>
> 
> In general no objections to it, but it would need an in-tree
> user first:
> 
> $ git grep -n bpf_probe_read_str tools/
> tools/include/uapi/linux/bpf.h:596: * int bpf_probe_read_str(void *dst, int size, const void *unsafe_ptr)
> $
> 
> Why not adding this along with a sample?
Okay, I will send new patch along with new sample or add usage of
bpf_probe_read_str() in one of our exiting sample :)

Thanks.
-Tushar
PS: adding correct mail-list this time linux-kselftest@vger.kernel.org
> 
> Thanks,
> Daniel
> 
