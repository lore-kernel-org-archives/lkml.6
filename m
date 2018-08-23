Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D9FC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 19:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48BE921564
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 19:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tuu9R4Q7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48BE921564
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbeHWWiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 18:38:01 -0400
Received: from mail-oi0-f46.google.com ([209.85.218.46]:36501 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbeHWWiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 18:38:01 -0400
Received: by mail-oi0-f46.google.com with SMTP id r69-v6so10570119oie.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 12:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:reply-to:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ymxvm2UqAuKTNoLNJhrRHrcuAckMWIowYGkWldv05vE=;
        b=tuu9R4Q7DCO90j3c15Nce61N6gMASit5655qOXb3912bvGNdWWG85/O8YjX1Xn9IOt
         wTu6S4TZT941BZsflAF1/sFq3UUc9HSLCKOVoLMJB6av9gMkIMxzMDSY5ZmbhPNb7r88
         OTfNwHmcr1kUIINSs/UdjC2YddPZtvDc0aZwEoERiD9EFFJhUQc5baLPgVFX8ywsavh0
         xZbRQGG25Ojmie9xaABBJqwH5ndKs6hxjusJuo/4spKAs8CHGyHWp13tH40k1zXqf30W
         UqPrz6GdVk1MzxQvLVA1xoTfLd+vT1bWagOyj949q+oTU8PWH3JcqPRe8iTAob5TAqnz
         iavg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=ymxvm2UqAuKTNoLNJhrRHrcuAckMWIowYGkWldv05vE=;
        b=oNdakvwltO78tK2TznefW935+kR8bIhr9Y3TQLwsCDDd46ELIwAig6fYCn1DJGEogo
         SIajJGjaCS0dGRzHx1Z5J+u6l9j5AR29/RwX3n6ut9dS6IlghIozEweAaKTm8ZiMlmIi
         6SUF5kdj3nPkg2IG8VbqR5t5AmRFXjH9Wr/R5C4pez4AKYTQTIWl3qlU9NhEAy8rCHBg
         OqSeWxhy5FG8XJJH/yO9FNSV1MAGNLlr58CE5vJYnYuvnU4pYFtgrzGeazJz5Tbia7e+
         rrj7SpVckj+AMX2hk2JBfvt0BrHBvjOg6oLnn+1MviBKb2Kq0ystfO7ve0Nx7SNz0h/0
         C/PA==
X-Gm-Message-State: APzg51AghkfTdIehnAfqGni+S9sZ/qRU+Sv6DPF16x/jPwJDskp/SdFu
        j/T6omLEHkCmy0sRSzmaLQ==
X-Google-Smtp-Source: ANB0VdYrSpim1FEZLdcwxBUzIQUFpMOqOVg9Zudoue4XwtRAu71FHB3BtCH5JnJP/OGuy+wvHmgr9g==
X-Received: by 2002:aca:d7c1:: with SMTP id o184-v6mr10069363oig.347.1535051216491;
        Thu, 23 Aug 2018 12:06:56 -0700 (PDT)
Received: from serve.minyard.net ([47.184.170.128])
        by smtp.gmail.com with ESMTPSA id k85-v6sm9868851oiy.2.2018.08.23.12.06.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Aug 2018 12:06:55 -0700 (PDT)
Received: from [IPv6:2001:470:b8f6:1b:a11a:38c7:7111:773f] (unknown [IPv6:2001:470:b8f6:1b:a11a:38c7:7111:773f])
        by serve.minyard.net (Postfix) with ESMTPSA id 43660675;
        Thu, 23 Aug 2018 14:06:24 -0500 (CDT)
Reply-To: minyard@acm.org
Subject: Re: [RFC] IPMI state machine regression
To:     Andrew Banman <abanman@hpe.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        justin.ernst@hpe.com, rja@hpe.com, frank.ramsay@hpe.com,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20180821221443.hhgcnzw6xttaih3i@linux-tqvx.americas.hpqcorp.net>
 <a72a169e-ce1b-500c-7910-b400c7842033@acm.org>
 <20180822162352.q7qc2udqabbqxdya@linux-tqvx>
 <a3b0e765-24e5-781b-218d-abcb16030e99@gmail.com>
 <20180823165231.2v3oq2nifbudy6ub@linux-tqvx.americas.hpqcorp.net>
From:   Corey Minyard <minyard@acm.org>
Message-ID: <8bbf7912-3dbd-8cb9-8fc3-c919f98033ac@acm.org>
Date:   Thu, 23 Aug 2018 14:06:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180823165231.2v3oq2nifbudy6ub@linux-tqvx.americas.hpqcorp.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/23/2018 11:52 AM, Andrew Banman wrote:
>
>> I don't have any real hardware with a BT interface, just the one in qemu,
>> but I've never seen it there.
>>
>> It actually looks like the state machine is working ok.  But the BMC is
>> responding to a "Get Device ID" command with:
>>
>>     Recv::  1c 08 d5
> That completion code is spoofed in after bt_start_transaction when bt->state
> is in WR_CONSUME. This is pretty visible from the message trace, but here
> is another with an explicit debug printk (below).
>
> Maybe I'm totally reading this wrong, but I think that err gets passed
> on to the upper layer:
>
> 	start_transaction: return 0xD5 -> return_hosed_msg -> deliver_recv_msg
> 		-> ipmi_smi_msg_received

Ah, yes, you are right.  I didn't write the BT state machine, so I'm not 
terribly
familiar with how it works.  I'm pretty sure the author is no longer 
with HP.

>
> [  120.367379] BT: IDLE [ ] TO=5000000 - 0
> [  120.367384] BT: CAP_BEGIN [ ] TO=5000000 - 0
> [  120.376634] **Timer: 1534434704.376633453
> [  120.376646] BT: XACTION [ ] TO=5000000 - 92000
> [  120.376683] BT: WR_BYTES [ ] TO=4908000 - 0
> [  120.376995] BT: WR_CONSUME [ H2B ] TO=4908000 - 0
> [  120.377025] Send:  18 08
> [  120.377027] **Enqueue: 1534434704.377028726
> [  120.377028] **Start2: 1534434704.377029859

So what appears to be happening is that the BT state machine sends the
BT capabilities commands to the BMC.  While this is going on the upper
layer sends a messages, but the state machine can't send because it's
in the middle of another operation.

The "device" in qemu is almost instantaneous, so you would never
see it there.

So this is almost certainly due to the timing and messaging changes.
in the upper layer.  Another step may be necessary in initialization
to allow this to happen.

Let me poke at this a bit and I'll send another patch.

Thanks,

-corey

> # Added DBG # [  120.377028] bt_start_transaction returned IPMI_NOT_IN_MY_STATE_ERR 0xd5
> # Added DBG # [  120.377030]  18
> # Added DBG # [  120.377030]  08
> # Added DBG # [  120.377030]
> [  120.377061] BT: WR_CONSUME [ ] TO=4908000 - 0
> [  120.377137] BT: RD_WAIT [ ] TO=4908000 - 0
> [  120.377140] Recv::  1c 08 d5
> [  120.377156] Send:  18 01
> [  120.377161] **Enqueue: 1534434704.377161047
> [  120.377164] **Start2: 1534434704.377164751
> # Added DBG # [  120.377165] bt_start_transaction returned IPMI_NOT_IN_MY_STATE_ERR 0xd5
> # Added DBG # [  120.377166]  18
> # Added DBG # [  120.377167]  01
> # Added DBG # [  120.377168]
> [  120.377226] BT: RD_WAIT [ ] TO=4908000 - 0
> [  120.377237] Recv::  1c 01 d5
> [  120.377242] ipmi_si IPI0001:00: IPMI message handler: device id demangle failed: -22
> [  120.377252] ipmi_si IPI0001:00: Unable to get the device id: -5
> [  120.377252] ipmi_si IPI0001:00: Unable to register device: error -5
>
>

