Return-Path: <kernel-hardening-return-12489-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvwL+YXyL4YcdL7QJ0VRfjcBea5gJ5d9l2JFzO0YZtnt7WYTbrR7lvwWZJ4jutPY63wTfY6
ARC-Seal: i=1; a=rsa-sha256; t=1520911788; cv=none;
        d=google.com; s=arc-20160816;
        b=WNTZ8utzpOpprg56dJ493RvV2GpEBNpmNpJGUEeXlIyj3cAnb7YrDONCuGT0IXzdrp
         xAHR6Gu9IIjJEGj8EixBa4Esn8Ev9XXfDnqCMoZnzQSqgokTfabbeZKKqKqptU+nCHWh
         gd0BsKfVCb4a8VZoXUqkSbBF4BMj5+5/CEpnONaW2GXX19RzRbt6oDJGj6TvVOry6Vve
         IWRQmjBHA9I5VPgVvzWk9SFs/n74rNsZ6j3aRyhF3J3V5oCB0EFalfGQzpDaKy3jlBO+
         hoOTl4l6ro7ZyDLDtAcqj/O+7h9zV9/zG2nvJKfqcRS/FH8IKr1KYN9R6Llq0MpAQxAd
         JIUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=rn08xU4C4rwXf9aAndFEnFU07f9zloI8P4hhbroCyvI=;
        b=fovrdVOwLRCvSwWLwbvAdC1HWVp2EdGGhrR7cWRvs1ck/AQ9jPksuOrmVZ3/twXhnR
         d3rRYu+AqA9RrLGZoS0Hybsgsc9EJoCzNBGh19d9IFNpqhsBvnJC4JBFjIgddVC0ZB9b
         oWIJUrSoIaXn/InQoq0bj5jCgWDLxEIPQnn/H7ho6bykDx0ItsF2OANJ4xfA0hTb1yP4
         kA/Isaybx0fCotMjDmb6chQfqycdLKbhqzwr/UOKWkyFgXPJRZcI0Qh+WDyAW4vFA3DN
         waS6XyGmbngaC1y64ruDsPSxYnVc1Ax1w5gQLnXUqW2SlKz5spbbTPMCCOt+Qe/G8Vqb
         Dinw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12489-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12489-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12489-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12489-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH] video: fbdev: via: remove VLA usage
To: Emil Velikov <emil.l.velikov@gmail.com>,
 Eric Engestrom <eric.engestrom@imgtec.com>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 linux-fbdev <linux-fbdev@vger.kernel.org>, Kees Cook
 <keescook@chromium.org>, kernel-hardening@lists.openwall.com,
 "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
 ML dri-devel <dri-devel@lists.freedesktop.org>,
 "Gustavo A. R. Silva" <garsilva@embeddedor.com>
References: <20180308173949.GA19305@embeddedgus>
 <20180309105940.22hd2uy2mv7wahzb@imgtec.com>
 <CACvgo5278SmXfV0jfrMu=Ba6gf7rRXzNduNX+D270fGUFQcZdQ@mail.gmail.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <8e3b270d-b615-e58c-fd6e-f677e7e892e8@embeddedor.com>
Date: Mon, 12 Mar 2018 22:29:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CACvgo5278SmXfV0jfrMu=Ba6gf7rRXzNduNX+D270fGUFQcZdQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - lists.openwall.com
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.175.117.58
X-Source-L: No
X-Exim-ID: 1evacy-003Cfk-KV
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.66]) [189.175.117.58]:44204
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 26
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594392120539391557?=
X-GMAIL-MSGID: =?utf-8?q?1594791599138589819?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 03/09/2018 05:02 AM, Emil Velikov wrote:
> On 9 March 2018 at 10:59, Eric Engestrom <eric.engestrom@imgtec.com> wrote:
>> On Thursday, 2018-03-08 11:39:49 -0600, Gustavo A. R. Silva wrote:
>>> In preparation to enabling -Wvla, remove VLA usage.
>>>
>>> Also, fixed as part of the directive to remove all VLAs from
>>> the kernel: https://lkml.org/lkml/2018/3/7/621
>>>
>>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>>
>> Sorry for my reply on v1, I missed that Emil already replied to another
>> post of the same patch (side note on that, making use of `-vX` and
>> `--in-reply-to` helps track the evolution of patches)
>>

Yep. I know. It is just that some people prefer vX in a new thread. 
Anyway, I will take this into account for the next time.

>> This looks good to me:
>> Reviewed-by: Eric Engestrom <eric.engestrom@imgtec.com>
>>
> Same here
> Reviewed-by: Emil Velikov <emil.velikov@collabora.com>
> 
> -Emil
> 

Thanks for reviewing it, guys.
-- 
Gustavo A. R. Silva
