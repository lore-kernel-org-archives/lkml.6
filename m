Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E4BC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4F492070C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="twmr9wVT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfAGJdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 04:33:49 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42959 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbfAGJdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 04:33:49 -0500
Received: by mail-pg1-f194.google.com with SMTP id d72so20490407pga.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 01:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Nk2Qy/+XQYcpf4X35TxFVKv8dV0ICO38mKcBHjIKky0=;
        b=twmr9wVTIbWw+SHdz7XbTEAmB0m7+zqpJm8MdXsO7hILlmMKRW6pZRIik1fr0cfA/H
         TFWd4jRqG4JaN+1cpIKag+leyRubwBB7LMUoQZRxsTs+SPuMyQbKDUVxES9ZTKRjDSMV
         KiLS3pwCmqiv9KCW21PrTXl5F0HdOQc391+YtAJbL+tzNScO10Qj6YleT8avbTUmuR1l
         ULx0Ifkpa/1Vi9XPBjCZzxZIvQ9WFs4cF3VtLaGp9aBWsSlCoKBs9oemlF2U9Bj2REPK
         RlIanfCgYISoZMrLA0KWNYakPb3Oh//112GgZszb7LA06uzxzXp0Ik2Ksh+L41Fqydiy
         BF9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Nk2Qy/+XQYcpf4X35TxFVKv8dV0ICO38mKcBHjIKky0=;
        b=HiviV6hVn7Qutg3OvGnodyZ0ujvAWvjjlimy/bacn1+ms6WDkmdkAkahYf01d/WZn6
         kCdeXFC4mVzXbJ7H6b/mvUc1Q8DXumycqMDlIRn1nKtVU7DleHbFqYEKiP5d5yBqsSM+
         ojkTmOk8krTpmh7iG4WfJ1GX/8qIBHbwxoLs6OaiMCgbGVvkmxUFzUpuT4ltL6/Y4vNk
         nVSMeujiDoZ5t2WntwVJW36YXPe/2a4NvUmOl/D4Wt4faya5Eg8XnBQL0Xe+p17gYnMc
         W4GwaBdgvyS7CSsEvnoq0t5HBJUvCZUUqyG3sYTmkCdPOPJG84mVM29bRw2711vrAJyv
         bS0A==
X-Gm-Message-State: AJcUukeYi0dzbA0U0F3WbJVua/X4Gr+0znUknBRwTN6Qu4BW0GPG0eFy
        yz9rt9LzA7UghVgj6li5LlE4ziG0
X-Google-Smtp-Source: ALg8bN74maiyDwMjYB/QFkG9VyEqNsa3fDl3tQT/fH+Lkinp3OkR2ao87R9/7X5mH/CxPQLzSKJVjQ==
X-Received: by 2002:a65:4784:: with SMTP id e4mr10117472pgs.12.1546853628294;
        Mon, 07 Jan 2019 01:33:48 -0800 (PST)
Received: from ?IPv6:2402:f000:1:1501:200:5efe:166.111.71.59? ([2402:f000:1:1501:200:5efe:a66f:473b])
        by smtp.gmail.com with ESMTPSA id g136sm105215924pfb.154.2019.01.07.01.33.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 01:33:47 -0800 (PST)
Subject: Re: [BUG] char: pcmcia: a possible concurrency double-free bug in
 rx_alloc_buffers()
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     arnd@arndb.de, viro@zeniv.linux.org.uk,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <76309f04-b1e1-11d3-b77f-962bf50c5be2@gmail.com>
 <20190107085724.GC26384@kroah.com>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <1a20e64b-7e2f-9ea1-657d-b0b997092738@gmail.com>
Date:   Mon, 7 Jan 2019 17:33:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20190107085724.GC26384@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/1/7 16:57, Greg KH wrote:
> On Mon, Jan 07, 2019 at 04:12:22PM +0800, Jia-Ju Bai wrote:
>> In drivers/char/pcmcia/synclink_cs.c, the functions mgslpc_open() and hdlcdev_open() can be concurrently executed.
>>
>> hdlcdev_open
>>    startup
>>      claim_resources
>>        rx_alloc_buffers
>>          line 2641: kfree(info->rx_buf)
>>
>> mgslpc_open
>>    startup
>>      claim_resources
>>        rx_alloc_buffers
>>          line 2641: kfree(info->rx_buf)
>>
>> Thus, a possible concurrency double-free bug may occur.
> Wait, are you sure those really are the same structure, and that those
> two functions can be called at the same time?  That is a tty and a
> network device, are they both created at the same time or does opening
> one create the other?

hdlcdev_open() is assigned to "hdlcdev_ops.ndo_open".
mgslpc_open() is assigned to "mgslpc_ops.open".
They are indeed assigned to the fields in different data structures.

**** For hdlcdev_open() ****
In hdlcdev_init():
     dev->netdev_ops = &hdlcdev_ops;
     rc = register_hdlc_device(dev);
Thus, hdlcdev_open() can be called after "register_hdlc_device(dev)".

hdlcdev_init() is called by mgslpc_add_device(), which is called by 
mgslpc_probe().
mgslpc_probe() is assigned to "mgslpc_driver.probe".

In synclink_cs_init():
     rc = pcmcia_register_driver(&mgslpc_driver);
Thus, mgslpc_probe() can be called after 
"pcmcia_register_driver(&mgslpc_driver)".

As a result, hdlcdev_open() can be executed in synclink_cs_init().

**** For mgslpc_open() ****
In synclink_cs_init():
     tty_set_operations(serial_driver, &mgslpc_ops);
     rc = tty_register_driver(serial_driver);
Thus, mgslpc_open() can be called after 
"tty_register_driver(serial_driver)".

As a result, mgslpc_open() can be executed in synclink_cs_init().

**** For hdlcdev_open() and mgslpc_open() ****
Because mgslpc_open() and hdlcdev_open() can be both executed in 
synclink_cs_init(), I think they can be concurrently executed.


>
> It's not obvious in looking at the code if this really is the same
> structure or not, how did your tool figure it out?

My tool uses the data structure field "info->rx_buf" in the code, so it 
cannot very accurately figure it out.

According to my code review, hdlcdev_open() and mgslpc_open() both call 
"startup(info, tty)", and rx_alloc_buffers() calls kfree(info->rx_buf).
Thus, an important thing is that whether the variable "info" in 
hdlcdev_open() and mgslpc_open() can be the same?
I find this code in hdlcdev_open():
     /* arbitrate between network and tty opens */
     spin_lock_irqsave(&info->netlock, flags);

Thus, the variable "info" in hdlcdev_open() and mgslpc_open() can be the 
same, and "info->rx_buf" in the two calls to kfree() can be the same.

To fix this bug, I think we can reuse the spinlock "info->netlock" to 
protect the function startup() in hdlcdev_open() and mgslpc_open().
But in rx_alloc_buffers(), there are kmalloc(GFP_KERNEL) and 
kzalloc(GFP_KERNEL).
If we reuse the spinlock, we also need to change GFP_KERNEL to GFP_ATOMIC.
What is your opinion?


Best wishes,
Jia-Ju Bai
