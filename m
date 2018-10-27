Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A545C46475
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 13:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE28B20843
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 13:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qF0XvMxT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE28B20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbeJ0WYj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 18:24:39 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:45230 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728017AbeJ0WYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 18:24:39 -0400
Received: by mail-wr1-f43.google.com with SMTP id n5-v6so3975873wrw.12;
        Sat, 27 Oct 2018 06:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UN3h7nC82PwDaRFXBFnkSbvb1TjSk1c3rjcKaGmWBfU=;
        b=qF0XvMxTnVsHM3whCTESKd+ytuBum7VeLwyuDZsPek+NmY5km00IpHm85zEEOeZhmy
         N7uFlWnU+rBytgvqsDdw0d0IccEh/AFQAjhM6+s2l7uujeEDyf486H1tMhuarEqHRE2g
         eS3ZXjoMmSzXKaIgxiMcNDZ9vjitqCn6HTVIYhlh64NOKHR63rQFLZ5dheJ4LtOQmEvh
         t6T/e/AyP4ZJsXpf7ssnND0f72WoE8bPMQbxa59QG3ZY17DnCGbiUlkuyhUV/LN2+mgk
         RBG159muTUk27NJ9Jc2PaYzeadZBKoOvcRAuGTM0fOssj2NaB+uoVOQGshzAfYPI8pyv
         eKFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UN3h7nC82PwDaRFXBFnkSbvb1TjSk1c3rjcKaGmWBfU=;
        b=Jxk/lR8pTo7CN2N01arOkhFCPq5n8on78QKoc7gyyqWU3sbPkU1z/RCHlHyVCQ6CyR
         KIrUeQG0xfOkG/R9rA9zjdwY/LC+0HlLVrtUlxz8b8MSp1DT+bV7HGRN8rFysmCSG3Wf
         mW0SvskmAq4Swv6KVCYGsIvyIOnfrS5cOq0pEOn98j+dqV7tKfus+Be3HSY5OwnRng62
         jR1lCod+Vx4xD0UdaQxZ+URyj+5ymganA8QafiNJTcgGstVJ2GemIqM0KQvZExSeR5fl
         Apw0lPtNWllITp3yHg/BbS8GyNte70it3KHo2PFq/Vv3ZpQXWVz4yq0GFD7H5DrsxZag
         3oOg==
X-Gm-Message-State: AGRZ1gJdA+0YSTsD2/JtpY6cQ1hjLy1w/NoesSkeUvAKeMMATP+jVjfy
        r+9QZSfWpl+LWy5r+wGkmPVjnMSm
X-Google-Smtp-Source: AJdET5cP6CNsh1vtSfoKvCX4V5mFYNkcyXCQJ9rtHNeuEoSvlc0uHOuskWUQrO0Vi2/WOBjrHIYv6g==
X-Received: by 2002:adf:b743:: with SMTP id n3-v6mr9160081wre.274.1540647814847;
        Sat, 27 Oct 2018 06:43:34 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bd4:3f00:c5da:f6c3:bd43:4458? (p200300EA8BD43F00C5DAF6C3BD434458.dip0.t-ipconnect.de. [2003:ea:8bd4:3f00:c5da:f6c3:bd43:4458])
        by smtp.googlemail.com with ESMTPSA id r143-v6sm1640781wmg.14.2018.10.27.06.43.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Oct 2018 06:43:34 -0700 (PDT)
Subject: Re: CAKE and r8169 cause panic on upload in v4.19
To:     Oleksandr Natalenko <oleksandr@natalenko.name>,
        Dave Taht <dave.taht@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@toke.dk>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        =?UTF-8?B?SmnFmcOtIFDDrXJrbw==?= <jiri@resnulli.us>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        linux-kernel@vger.kernel.org
References: <61d09f0db41f269cc9ee13dd68a5c285@natalenko.name>
 <fbd7f0b8-10c8-be17-fce6-327a95d8ea2e@gmail.com>
 <CAA93jw7xoaokrN4oGAyqh6JHAn8nJpUpp_wj-iy+GWNoV-ipNA@mail.gmail.com>
 <b80e6819da8ea74f18b6ec0aaf9128fa@natalenko.name>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <1beabdd3-dbac-de8a-07b0-d0788b1dbc38@gmail.com>
Date:   Sat, 27 Oct 2018 15:43:28 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <b80e6819da8ea74f18b6ec0aaf9128fa@natalenko.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.10.2018 22:54, Oleksandr Natalenko wrote:
> Hi.
> 
> On 26.10.2018 22:25, Dave Taht wrote:
>> Can you repeat your test, disabling gro splitting in cake?
>>
>> the option is "no-split-gso"
> 
> Still panics. Takes a couple of rounds, but panics.
> 
> Moreover, I've stressed my HTB setup like this too for a longer time, and it panics as well. So, at least, now I have a proof this is not a CAKE-specific thing.
> 
> Also, I've stressed it even with noqueue, and the panic is still there. So, this thing is not even sch-specific.
> 
> Next, I've seen GRO bits in the call trace and decided to disable GRO on this NIC. So far, I cannot trigger a panic with GRO disabled even after 20 rounds of speedtest.
> 
> So, must be some generic thing indeed.
> 
In net-next there's the following patch which mentions in the
description that it "eliminates spurious list pointer poisoning":
992cba7e276d ("net: Add and use skb_list_del_init().") 
And spurious list pointer poisoning is what we see here (IMO).

As an idea this patch and a8305bff6852 ("net: Add and use skb_mark_not_on_list().")
from net-next could be applied on top of 4.19. Would be curious
whether it fixes the issue.
