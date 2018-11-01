Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1753FC6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 15:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C28F52082E
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 15:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lFD7w06d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C28F52082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbeKBA7l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 20:59:41 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37777 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727996AbeKBA7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 20:59:40 -0400
Received: by mail-lj1-f193.google.com with SMTP id c4-v6so18498616lja.4;
        Thu, 01 Nov 2018 08:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8QV1rRGD5z9KHxGTbGjJ7FsI1kGriDbSQ1hXAvqLolI=;
        b=lFD7w06dF72k6QzUKBaMNXWH/IQCQSCLheAKXRc06PoOItT9U/GU9bR2FWM+bgdqVX
         T56bAXcmTr1I5+EqvBxv7wzQ4CYrsf1obHudSuvdFQyNEc+q/UJeHmzHJh9q6GhDvBoK
         hCf6ZhHA3ZxlnkeBnMxhNMxCzT8gbldponakybtRMIAq8XrHLqtaw8WHSjoI8iO/T22D
         8ffBqJ6mwyeXY32QzvnpfjV9aK1Awx1teI62HIrlJbv7zQJGJcogyYeSbdt3KYfVZFZA
         BlZcb/1db1ca+cm3t/Cb7256hYbGfsBQY3/qbExIfDLTe4zKGb5gF1ORNCkmKBjfVJCk
         Vqzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8QV1rRGD5z9KHxGTbGjJ7FsI1kGriDbSQ1hXAvqLolI=;
        b=mto3xZ4i3ksFiZEyz0jKMm0dGDQacDoA2ImhEzIdvj/i8lo4KklFdLcWeJ3XyHWAqJ
         LEaHcj7Khd4CBWFu5tpNKs5zk0EZPiSD8KFdQRMoMthiCVsneErjT5qLQPlj4E5AUn8c
         XQMUShFwMgukIkYdWVljM8zD6EW3N27uwzaX5vrdcGa+2ERf8g7L/5XnwJapXmjxkOo9
         ZJR/ivXu5MYBs8sosrCxHpFPKyrmCgM5SEITx5jyLvRUc5hkIrMBLhIJjN1X5W1v2/xx
         0PaumGxnUELdKNO3eQGl/ZyLlGNlH3sNnu/tXdJeRFjWzx4WlIuygMooOLFGDY7KlhHf
         xa+A==
X-Gm-Message-State: AGRZ1gJHh45i/+NHGEOI44MpKYr+UJueWwluIo/090Hf80LTl3t5eevw
        rKNJQvlU+SPrvc2xrbAoz8g=
X-Google-Smtp-Source: AJdET5flN5tCH0lcdByhjC8oyML4ntiCOyXTXo17xsanGhoRcEEaPAByQkX+exGbMWMtXFh96utBGg==
X-Received: by 2002:a2e:9715:: with SMTP id r21-v6mr3892456lji.30.1541087765665;
        Thu, 01 Nov 2018 08:56:05 -0700 (PDT)
Received: from ?IPv6:2001:14bb:52:7be:f0bf:dd2d:f008:5213? (dmkd798g-7z2-yccwcp-4.rev.dnainternet.fi. [2001:14bb:52:7be:f0bf:dd2d:f008:5213])
        by smtp.gmail.com with ESMTPSA id h63-v6sm1840103lji.88.2018.11.01.08.56.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 08:56:05 -0700 (PDT)
Subject: Re: [PATCH V5 0/5] KVM: X86: Introducing ROE Protection Kernel
 Hardening
To:     Ahmed Soliman <ahmedsoliman0x666@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        nathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        kvm@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?6rmA7J246rK4?= <ovich00@gmail.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        nigel.edwards@hpe.com, Boris Lukashev <blukashev@sempervictus.com>,
        Hossam Hassan <7ossam9063@gmail.com>,
        Ahmed Lotfy <A7med.lotfey@gmail.com>,
        Mohamed Azab <mazab@vt.edu>
References: <20181026151223.16810-1-ahmedsoliman0x666@gmail.com>
 <1b3eb10e-c492-dc77-cbe6-3a3e692326d7@gmail.com>
 <CAAGnT3ao2YugWW_1TuZw4+OiLQsBYLXtcYjARagZ3pGwFhvGZg@mail.gmail.com>
From:   Igor Stoppa <igor.stoppa@gmail.com>
Message-ID: <2e91fc33-9601-b562-0fc5-4dc8756face4@gmail.com>
Date:   Thu, 1 Nov 2018 17:56:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAAGnT3ao2YugWW_1TuZw4+OiLQsBYLXtcYjARagZ3pGwFhvGZg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Ahmed,

On 01/11/2018 01:21, Ahmed Soliman wrote:
> Hello Igor,
>> This is very interesting, because it seems a very good match to the work
>> I'm doing, for supporting the creation of more targets for protection:
>>
>> https://www.openwall.com/lists/kernel-hardening/2018/10/23/3
>>
>> In my case the protection would extend also to write-rate type of data.
>> There is an open problem of identifying legitimate write-rare
>> operations, however it should be possible to provide at least a certain
>> degree of confidence.
> 
> I have checked your patch set. In our work we were originally planning to do
> something similar to write_rare just so we can differentiate between memory
> chunks that may be modified and those that will be set once and never modify.
> I see you are planning to do a white paper too, actually we are doing
> an academic
> paper based on our work. If you would like to collaborate, so that ROE
> and write_rare
> would integrate well from the beginning, we will be glad to do so.

The offer is very kind, thanks a lot.
I will contact you in private.

--
igor
