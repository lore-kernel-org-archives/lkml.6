Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E57C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 21:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91796208A2
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 21:05:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sX9qks+D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91796208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933308AbeGIVFN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 17:05:13 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:45478 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932956AbeGIVFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 17:05:10 -0400
Received: by mail-pl0-f66.google.com with SMTP id a17-v6so740867plm.12;
        Mon, 09 Jul 2018 14:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vogJWLkZ8uTQdxWCnFB526P8k/3T5qBRpwxjQW/KKMA=;
        b=sX9qks+D2JDty+50cGz1JoK3Qggv1rEts3GW/25IZooy3NSe/MMNEk8Z5mItaHmXEX
         ZtWMzvrDsPz+7mRYJcgCoymK1YiuSAgebVSSyn1lQxlNRP8dR8LQGUuSzg9d0R7s69qa
         akT3VtTGO6la2jV7+EzWY2ixySKgtyYHslqg5IogmnUMmnADQ7XUdznp8YQr3/cYttXB
         3ToQdl0MOw8Q590zCx91SAbfyWogMC0R08KS/JNzN4NVffC5KeTwvn+U1uLsMvaXrrCT
         740o12mNcVMwimRwbLDSj7Qx9uRBvxD8JeHwkG7vZewz92J3r+zsvpZIs3dTfzTf3px/
         rqfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vogJWLkZ8uTQdxWCnFB526P8k/3T5qBRpwxjQW/KKMA=;
        b=iokZ4CfOHVS6xIxNoCBV6eft7GkYeqEH92TGsIHY7PryFkxQ1Nhvw8k+dMyBt+ASbn
         Br2hQgLJvjUtBnbOOs72VTg/5Nkb1xuu2SnJxgvdz6dI3YFHsyYtus3EQO8O301Q3QpA
         TNsqIDfN0KJDQbPkV4bkO/cNz04WrZ/BmUW4UoYYxT8KVRdtkpVc8ozwrpUuJ/uxsZ4f
         JR4HQ/8k5rNEe8ja9WRSzDl7tvZvnLTZNIvMlNCaep2EPjU84mXggOH7+kyn09zcmi6W
         jBdY1QzV6ziDTnauORStWspeS/0Ml1oAqoR6tgE4KXxCzruSwd7I2iypik6KXXxTY0Zh
         PkPg==
X-Gm-Message-State: APt69E0ITiAuL4w2NTDaRBGCdSLxB65aZrqhu+TlGW7lXZSF4xnXx/XP
        HCnQLMv8z5AXQTGt74A9HuE=
X-Google-Smtp-Source: AAOMgpeqiG2y9nmeC+TlX+uZyPq9b0y9SI0FdD+3TNfyZoXish/ac7FEijD6nybie8KGSlvCoJoyzw==
X-Received: by 2002:a17:902:7043:: with SMTP id h3-v6mr22057652plt.269.1531170310435;
        Mon, 09 Jul 2018 14:05:10 -0700 (PDT)
Received: from ?IPv6:2620:15c:2c1:200:55c7:81e6:c7d8:94b? ([2620:15c:2c1:200:55c7:81e6:c7d8:94b])
        by smtp.gmail.com with ESMTPSA id v30-v6sm40565432pgn.80.2018.07.09.14.05.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 14:05:09 -0700 (PDT)
Subject: Re: INFO: rcu detected stall in llcp_sock_sendmsg
To:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+e9f364d3b15ce41d8451@syzkaller.appspotmail.com>,
        Samuel Ortiz <sameo@linux.intel.com>,
        David Miller <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev <netdev@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
References: <0000000000000cc1f0057096efe6@google.com>
 <CACT4Y+Zc+UKpGwEEMfKOsZ1s+AAFYFrVmjO0-u7NNjODRiJ7tg@mail.gmail.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <6e2e4cfa-2cde-ec28-933d-1ee17c8b1da9@gmail.com>
Date:   Mon, 9 Jul 2018 14:05:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+Zc+UKpGwEEMfKOsZ1s+AAFYFrVmjO0-u7NNjODRiJ7tg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/09/2018 01:50 PM, Dmitry Vyukov wrote:
> On Mon, Jul 9, 2018 at 10:34 PM, syzbot
> <syzbot+e9f364d3b15ce41d8451@syzkaller.appspotmail.com> wrote:
>> Hello,
>>
>> syzbot found the following crash on:
>>
>> HEAD commit:    1e4b044d2251 Linux 4.18-rc4
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=1414c2c2400000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=25856fac4e580aa7
>> dashboard link: https://syzkaller.appspot.com/bug?extid=e9f364d3b15ce41d8451
>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>>
>> Unfortunately, I don't have any reproducer for this crash yet.
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+e9f364d3b15ce41d8451@syzkaller.appspotmail.com
> 
> Looks like the problem is actually in nfc, so +nfc maintainers.

Note this issue was discussed before, maybe we should patch NFC without waiting for nfc maintainer.

----------------------------------------------------

On 06/25/2018 10:12 PM, Sergey Senozhatsky wrote:
> On (06/26/18 07:07), Dmitry Vyukov wrote:
> [..]
>>>  #include <net/nfc/nfc.h>
>>> @@ -755,7 +756,8 @@ int nfc_llcp_send_ui_frame(struct nfc_llcp_sock *sock, u8 ssap, u8 dsap,
>>>                 pdu = nfc_alloc_send_skb(sock->dev, &sock->sk, MSG_DONTWAIT,
>>>                                          frag_len + LLCP_HEADER_SIZE, &err);
>>>                 if (pdu == NULL) {
>>> -                       pr_err("Could not allocate PDU\n");
>>> +                       pr_err_ratelimited("Could not allocate PDU\n");
>>> +                       cond_resched();
>>>                         continue;
>>>                 }
>>
>>
>> But this thread is still in an infinite (unkillable?) loop? If yes, we
>> are waiting for the next syzbot report 
>
> The loop is still infinite, correct, but we have a preemption point now.
> Sure, net people can come with a much better solution, I'll be happy to
> scratch my patch.
>

This can not be the right solution, think about current thread being real time,
cond_resched() might be a nop.

We should probably not loop at all, or not use MSG_DONTWAIT.

(And remove this useless "Could not allocate PDU" message)

NFC maintainers should really take a look at this.


