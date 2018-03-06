Return-Path: <kernel-hardening-return-12152-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELuMmJK/lU0U20tnvCkbsOuJTNQqcqfGGpGnSsSDAIN5PwfgvnjRwHFKdYwTHKLExS7WDA/r
ARC-Seal: i=1; a=rsa-sha256; t=1520356137; cv=none;
        d=google.com; s=arc-20160816;
        b=lj4WaHpOwmvr3K9c7Ou0mOG/vAfDWf6IZmHRzEtIBKb9T3U9lwKc1kd9YW7wyAI/DT
         4lTgVCs/K3jXnTNIeq3SspJVR7RMqq5qr2W37BwwJlVGuY3vhxQiYn+1klFZCr9LBomz
         rlr0Vy3brxIducCqHYVCj8KG5Do5i2WfK6KR7e7Iy2TySUUTzOVoqcF1ClxjiEx/uNyb
         A8omoDDXtJFm/Il6j7S2ht631IfzD0IW0wF7hjrpfDVjlsCgpEjAsuwwfEY9zbQjcZi3
         zUMIoqCfXDVJw2ncrPjNsei/bF5Igeuk+jmzZztHp39qwxZ/a/+WrlAAkFoXxFeaKV7p
         6Y7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=aAcLK1x/oceKFh+9o6qTLj0vQN72rvwl2Gj3RuMPqOM=;
        b=E4gdN0agh4XlUrX1l3S4Nl6LxSoh+u0grc5sGss53iVdLI41PBIojTGAHIWPlqDRDr
         rzJIkyVxKX8P5cSyCl0kLUOlUddjAgh/Npa/64P9EakSKtGp8BIrJmTl6cpoCfTf2JOJ
         n+X3RMMxIpc1P9oKUDytP9bG72iKEfxq1TnS8Tut1qKEzMqZDV0kerFaYIwzV5pBbzrU
         /NC5oIhisXjojw/UEkJG8Uo7OHeXzQfyOwMPNJExfDIGcH3ECbffucJahLCIlcJgB1wA
         5AAbGrBfkCSM6z5g8szCFfdNAEW8oi4uZ0BTD7fQNCAI6fn8BhcFTnCWbtmkmYnP1780
         fNYg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=TwGmFmcF;
       spf=pass (google.com: domain of kernel-hardening-return-12152-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12152-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=TwGmFmcF;
       spf=pass (google.com: domain of kernel-hardening-return-12152-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12152-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH 6/7] lkdtm: crash on overwriting protected pmalloc var
From: J Freyensee <why2jjj.linux@gmail.com>
To: Igor Stoppa <igor.stoppa@huawei.com>, david@fromorbit.com,
 willy@infradead.org, keescook@chromium.org, mhocko@kernel.org
Cc: labbott@redhat.com, linux-security-module@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 kernel-hardening@lists.openwall.com
References: <20180223144807.1180-1-igor.stoppa@huawei.com>
 <20180223144807.1180-7-igor.stoppa@huawei.com>
 <1120e8fd-2f48-5b1f-7072-9bd8e2b82fbf@gmail.com>
Message-ID: <679444bd-7b41-4fb0-d7ba-98ed86da86c5@gmail.com>
Date: Tue, 6 Mar 2018 09:08:30 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1120e8fd-2f48-5b1f-7072-9bd8e2b82fbf@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593203814128727346?=
X-GMAIL-MSGID: =?utf-8?q?1594208957004508212?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 3/6/18 9:05 AM, J Freyensee wrote:
>
>>   +#ifdef CONFIG_PROTECTABLE_MEMORY
>> +void lkdtm_WRITE_RO_PMALLOC(void)
>> +{
>> +    struct gen_pool *pool;
>> +    int *i;
>> +
>> +    pool = pmalloc_create_pool("pool", 0);
>> +    if (unlikely(!pool)) {
>> +        pr_info("Failed preparing pool for pmalloc test.");
>> +        return;
>> +    }
>> +
>> +    i = (int *)pmalloc(pool, sizeof(int), GFP_KERNEL);
>> +    if (unlikely(!i)) {
>> +        pr_info("Failed allocating memory for pmalloc test.");
>> +        pmalloc_destroy_pool(pool);
>> +        return;
>> +    }
>> +
>> +    *i = INT_MAX;
>> +    pmalloc_protect_pool(pool);
>> +
>> +    pr_info("attempting bad pmalloc write at %p\n", i);
>> +    *i = 0;
>

Opps, disregard this, this is the last series of this patch series, not 
the most recent one :-(.



> Seems harmless, but I don't get why *i local variable needs to be set 
> to 0 at the end of this function.
>
>
> Otherwise,
>
> Reviewed-by: Jay Freyensee <why2jjj.linux@gmail.com>
>
