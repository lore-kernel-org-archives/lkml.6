Return-Path: <kernel-hardening-return-11962-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELs+WXOaHhh6pTPbSub3uGvX783I4dBRYngLjuU8UJ88GR6W+BzaIE2BWDdrSPUrTSpLd8+k
ARC-Seal: i=1; a=rsa-sha256; t=1519667225; cv=none;
        d=google.com; s=arc-20160816;
        b=s46XqGAyUj1HwEbNRpAtTDcrKNikxZo+1tKgeaKLfmuh1OasJnWkqT/t5FJTUTVAKK
         pJeIIEOUsCWplaY8nu2dKphYLO5r/p2V2rPZwAeqA9VlDTxwCIC5QCmdhfYfSs4VuyNd
         +xl/ckRyPV6pdThIiuZB/UpUKulud07vDgYQs0NIWQ5gO+CAH25jJXHWPK9hGOBNgreb
         AJPOlzpdUCFh/ZFE3Hm6+u2/G6T4h/Nlk7OLNeFvYhUqxEmX0AEwrnS7LsPEIClRR4Xd
         pXVOGNpqjWQU58QF5L7dpprIjqKAsWPhqrp7csG7SvnJxeJzz+Mz19fMMaNwYlFSwQmu
         vIdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=nVbAUwazUbr7/WFT1NDpU5+gY/zXvSRbpNtb9FqU4Eo=;
        b=tbvyrTW78oDPw4oWPjI/rLbjU0RO2EqTd44ih1r+CCVzjaCPfrN5Z8FA3fhVNNJX+1
         hJ3v0kj4Eb61KbkcnO+yFSmwRz3KYIu0a1wdpg5rCPQLA7KsfDFl06ZLU7MEjx+UEhzU
         j8vWEQaUaJxXbwGc+0Y8ZCItRZ9MJqRzP03asKhabhL4ytoo5Cyz5sIrHfECTMq1BLNh
         iCiM6WKKxEsJfrltUtLbS3MFrrLiNjs6J0OIg+NhO9jistl8ehGJrT+Yc5z+Cxm6wBi6
         psi8+BMt+hMRDGptNUNl8zsA5qMoe/ySIH7n87v9nybiDcC3LeBTB0NX6B73DqTRQh+E
         qgpA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Z43xaUJT;
       spf=pass (google.com: domain of kernel-hardening-return-11962-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11962-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Z43xaUJT;
       spf=pass (google.com: domain of kernel-hardening-return-11962-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11962-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH 2/7] genalloc: selftest
To: Igor Stoppa <igor.stoppa@huawei.com>, david@fromorbit.com,
 willy@infradead.org, keescook@chromium.org, mhocko@kernel.org
Cc: labbott@redhat.com, linux-security-module@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 kernel-hardening@lists.openwall.com
References: <20180223144807.1180-1-igor.stoppa@huawei.com>
 <20180223144807.1180-3-igor.stoppa@huawei.com>
 <76b3d858-b14e-b66d-d8ae-dbd0b307308a@gmail.com>
 <a7b47f45-5929-ae07-1a10-46a02f6db078@huawei.com>
From: J Freyensee <why2jjj.linux@gmail.com>
Message-ID: <45087800-218a-7ff5-22c0-d0a5bfea5001@gmail.com>
Date: Mon, 26 Feb 2018 09:46:43 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <a7b47f45-5929-ae07-1a10-46a02f6db078@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593203665689840629?=
X-GMAIL-MSGID: =?utf-8?q?1593486580969867918?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 2/26/18 4:11 AM, Igor Stoppa wrote:
>
> On 24/02/18 00:42, J Freyensee wrote:
>>> +	locations[action->location] = gen_pool_alloc(pool, action->size);
>>> +	BUG_ON(!locations[action->location]);
>> Again, I'd think it through if you really want to use BUG_ON() or not:
>>
>> https://lwn.net/Articles/13183/
>> https://lkml.org/lkml/2016/10/4/1
> Is it acceptable to display only a WARNing, in case of risking damaging
> a mounted filesystem?

That's a good question.  Based upon those articles, 'yes'.  But it seems 
like a 'darned-if-you-do, darned-if-you-don't' question as couldn't you 
also corrupt a mounted filesystem by crashing the kernel, yes/no?

If you really want a system crash, maybe just do a panic() like 
filesystems also use?
>
> --
> igor
