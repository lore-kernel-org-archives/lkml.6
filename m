Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D777FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 01:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D7802087D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 01:44:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ll5cwrXE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D7802087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbeJJJDz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 05:03:55 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38886 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbeJJJDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 05:03:54 -0400
Received: by mail-pf1-f194.google.com with SMTP id f29-v6so1776018pff.5;
        Tue, 09 Oct 2018 18:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UIwuO1iQ1UnlhTigru+YF5Zj5IJBd91tuQ6yzwAPkKc=;
        b=Ll5cwrXEPJ/1Nwtuu1dw4D7IOJT0vsECoJmmruiVQ9OA0+S0BCA9z/Bm2mgtTa6eHI
         RXrGuj1TQR38Ebcuubzpy/Lfm2oh3Xzp8L/gmkSGttAoD9ulRglBZm1+bwoz20XhRP0x
         TmKNj3X6npu1as44JH1Ha8SafHOli9b/2QZSsq1AMQb6fLvriCOvUkXZDiJAW9+uTiS5
         UEFWKtt23vyv5u+RusAmQu1xnXR6xn9JNLXMJaTKNxVy4Lx94l7qCe6SzgYzvb4xA/u0
         iUNQ7J2SwfPWuTFaNZRpkBIa4aEBT40ZAlDYj/Or/s8b9ly0V5sKz+j5g2K3jMPiN0Ip
         bYZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UIwuO1iQ1UnlhTigru+YF5Zj5IJBd91tuQ6yzwAPkKc=;
        b=SX2g99n0nisXQRQgNUHQPDnqDfhDZATTUErKF7NjwT1CQfJtAneoB+MNIN1VTAW/3X
         xvQiX/TVbJkpttIx6Upd0FYlrHTemut3yj5x3dWLyY/qjyy+SuaFcmX1hAeROXIn/7TZ
         AATZle1VGJMwMiLWDsallZ4XQfQfN7gpDE+2BbiaT45md3CN+1+1ic2X1ANK4fkCxS9+
         P4xspTTVOgwJYeLpiQeCIiFThPDI3mvzfBKvBWBfniMOguAcgqZXJ59n30lviiGH3P2a
         Pzcodzppi2zeDg2ClcU7w5fByI/WoQLADk/d3mIITu5jYVN3re0bBfIycps5VSU1SkaT
         JF2g==
X-Gm-Message-State: ABuFfoivcfQFsEIZZusDV6vm+PpXvPB8ygN3f/AWzy+z9BfADc4Qo5vk
        ce3xlc+IBSDIKAAc9DEwIPenwakL
X-Google-Smtp-Source: ACcGV61XCOktYnDQUmCpwbuLLaLlNqQKk2zqVixryQSWtAvMm+Gmy5cL8Qw0rCoBq5QfiNGgQTPTHw==
X-Received: by 2002:a62:1bce:: with SMTP id b197-v6mr32940710pfb.102.1539135847670;
        Tue, 09 Oct 2018 18:44:07 -0700 (PDT)
Received: from [192.168.86.235] (c-67-180-167-114.hsd1.ca.comcast.net. [67.180.167.114])
        by smtp.gmail.com with ESMTPSA id m10-v6sm21958533pgp.94.2018.10.09.18.44.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 18:44:06 -0700 (PDT)
Subject: Re: [PATCH net-next] tcp: forbid direct reclaim if MSG_DONTWAIT is
 set in send path
To:     Yafang Shao <laoar.shao@gmail.com>,
        Eric Dumazet <edumazet@google.com>
Cc:     David Miller <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <1539086718-4119-1-git-send-email-laoar.shao@gmail.com>
 <1539086718-4119-2-git-send-email-laoar.shao@gmail.com>
 <CANn89iL1BMCx3Mbsj3TijR3Srjji95q86px0k98r7JYJbwLzcw@mail.gmail.com>
 <CALOAHbBwGAqia_2xJSNkaX7TzSPN89bRz71qHRH43FtbwNTP6w@mail.gmail.com>
 <CANn89iKe4vETuo-FBZ8ZrovJGiimBbhbzBnbqawX_h0LA+8PoA@mail.gmail.com>
 <CANn89i+-g5DEnrv0DSCsMq3fXo35mAaOmXvf1Tr22Ybif1OV0Q@mail.gmail.com>
 <CALOAHbBKabLHkLk4SEU8cRV3JZoTbe9TUiLd9RCp2nOx7Y0fPA@mail.gmail.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <1bda85f1-e369-b95e-6f50-a7f795634d03@gmail.com>
Date:   Tue, 9 Oct 2018 18:44:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CALOAHbBKabLHkLk4SEU8cRV3JZoTbe9TUiLd9RCp2nOx7Y0fPA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/09/2018 06:30 PM, Yafang Shao wrote:
> On Tue, Oct 9, 2018 at 11:38 PM Eric Dumazet <edumazet@google.com> wrote:
>>
>> On Tue, Oct 9, 2018 at 7:58 AM Eric Dumazet <edumazet@google.com> wrote:
>>>
>>
>>> We do not add bloat in the kernel if no application is ever going to
>>> use it, especially in the TCP fast path.
>>>
>>
>> BTW, are you willing to change all memory allocations in the kernel as well ?
>>
>> Let say an application is using a system call providing a pathname
>> (open(), stat(), ...), how this system call
>> is going to ask the kernel for no direct reclaim ?
>>
>> Even allocating a socket with socket() or accept() has no ability to
>> avoid direct reclaim.
>>
>> So tcp_sendmsg() is only the tip of the iceberg.
> 
> If we can really find a solution that is good enough to hanlde direct
> reclaim in tcp_sendmsg,
> we could also implement it in other syscalls.
> Unexpected latency is hateful.

We have thousands of other places in the kernel, I want to find a generic solution,
not patch all the places one by one.

So come back when you have something more generic, and once applications have a way
to handle gracefully (without calling sendmsg() in infinite loop ...)
to these memory allocation issues.

How is EPOLLOUT going to be generated ?
