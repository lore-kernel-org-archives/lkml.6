Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01022C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 16:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 937EB2098B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 16:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b2pF6sCR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 937EB2098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbeHWTx1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 15:53:27 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:44476 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbeHWTx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 15:53:27 -0400
Received: by mail-oi0-f68.google.com with SMTP id l82-v6so4676249oih.11
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 09:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=T/DKCj82GMPz4bjnxiL+eCtF/Q+MtoRU9c0rSF8wyLo=;
        b=b2pF6sCRqeK2lICe8fA517Eb1/5ZfDKu3BjFTF2DXQKrqt6C5ZXWwsko66utaQ4RTL
         X9MMQYNJMKVL4irbeyHOsadoZ2wTSYSckj0jN3QXj+uoW1vZjXpCiKwY661k9CZfOGY7
         /MqWy5WaCQ5Woo1xSenuKN09g1XxW5WEL/1A0AxjhmEi8UAGaeIwdRxCNT8ckN1lfLnk
         hrlYfhsl7vK5MRrNHK4HUlgkKvQQaI+QmDaqYEFdoZjW2n2GtWcBs66XnuiV4BLINbEm
         XUZICUFtPfettEqId6IXIhJlQUAFgXSbwV5RmnHPiuRTBANTNwd1dnVRLKXIAGc8gaxz
         mixw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=T/DKCj82GMPz4bjnxiL+eCtF/Q+MtoRU9c0rSF8wyLo=;
        b=s5tLdCJEoLNXhEhhvKfrNSEfg1eH4QAgHyLSg+3YOddj27y9s/WQAArhFw+5X8xLe0
         sqxKcmkmXYVuQlP3rnMFKhM6jD7hAzH646b3JKmivgYvxT60RVJ7oiJ4nSHu37a15wH7
         XYVuV4EWkeV//kR9LrVv8wFJMUuJYAiSVD4F0F4610rgoiFABqewSfUNqkA1W/yPgLQS
         HcYmmzu5VYGLTgv4dBtXzkE8kWQGkXFmRpUCMijdrWUuYWO722fNpHMqK1/LBJRHndIV
         nKDt6iwH0XR5xuoltI0OXqq5QUeFF0PrbVu6BmntDGSBkx8jrHDKKCGizRIT+lospn3P
         +2qQ==
X-Gm-Message-State: APzg51Dgm80VFXrWzeNgQZfl0cuBVGl1hcBfeYiL91yn88tH8V5Wo5YO
        78VvGebkpWvRJjWMwxto0onWCzU=
X-Google-Smtp-Source: ANB0VdYdl2CJm5pUrjxMyNx5VIHxm0tCzJN1dgn3qn2dEQ6NtS/RoUdP5INHmVicZompUa2Xd3cyCQ==
X-Received: by 2002:a54:4f94:: with SMTP id g20-v6mr8481461oiy.130.1535041380095;
        Thu, 23 Aug 2018 09:23:00 -0700 (PDT)
Received: from [192.168.27.3] ([47.184.170.128])
        by smtp.gmail.com with ESMTPSA id n131-v6sm2631214oia.17.2018.08.23.09.22.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Aug 2018 09:22:58 -0700 (PDT)
Reply-To: minyard@acm.org
Subject: Re: [RFC] IPMI state machine regression
To:     Andrew Banman <abanman@hpe.com>, Corey Minyard <minyard@acm.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        justin.ernst@hpe.com, rja@hpe.com, frank.ramsay@hpe.com,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20180821221443.hhgcnzw6xttaih3i@linux-tqvx.americas.hpqcorp.net>
 <a72a169e-ce1b-500c-7910-b400c7842033@acm.org>
 <20180822162352.q7qc2udqabbqxdya@linux-tqvx>
From:   Corey Minyard <tcminyard@gmail.com>
Message-ID: <a3b0e765-24e5-781b-218d-abcb16030e99@gmail.com>
Date:   Thu, 23 Aug 2018 11:22:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180822162352.q7qc2udqabbqxdya@linux-tqvx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/22/2018 11:23 AM, Andrew Banman wrote:
> On Wed, Aug 22, 2018 at 11:14:52AM -0500, Corey Minyard wrote:
>> On 08/21/2018 05:14 PM, Andrew Banman wrote:
>>> Dear IPMI supporters,
>>>
>>> We observe a window in IPMI BT's opportunistic get capabilities request,
>>> wherein GET_DEVICE_GUID and GET_DEVICE_ID requests may start while the BT state
>>> machine is in WR_CONSUME. Following this, the 0xD5 error code is forced in
>>> bt_start_transaction, IPMI fails to initialize, and the interface is torn down.
>>> There is no mechanism to retry bringing up the interface in open() /dev/ipmi.
>>> This leaves IPMI hosed until you reload modules. Looks to happen after we call
>>> schedule().
>> When was the latest kernel where this worked properly?  Also, what hardware
>> is this?
> This is UV4.
>
> First known bad commit, but I am not sure if the timing issue predates
> it:
>
> commit aa9c9ab2443e3b9562c6c7cfc245a9e43b557d14
> Author: Jeremy Kerr <jk@ozlabs.org>
> Date:   Fri Aug 25 15:47:24 2017 +0800
>
>      ipmi: allow dynamic BMC version information
>
> Hits less frequently with older kernels so I didn't see it until
> recently when it became more frequent.

Ok, that's for the crash, which makes sense.  But that's an easy problem 
to fix.
I would like a "Tested-by" on that, if you get to test it, though I was 
able to
simulate various failures there to test it out.

So reading between the lines ("more frequent") I'm guessing that this still
happened with older kernels, but is becoming annoying with newer kernels.
I would guess recent changes causes it to happen more often due to changes
in the way the upper layer interacts with the lower layers, you will 
have more
messages at startup, and the timing is somewhat different.

The BT code itself hasn't changed much in over 10 years.  Nothing that
looks like it would cause an issue like this.  So I would guess this is an
issue that has been around for a while.

I don't have any real hardware with a BT interface, just the one in qemu,
but I've never seen it there.

It actually looks like the state machine is working ok.  But the BMC is
responding to a "Get Device ID" command with:

    Recv::  1c 08 d5


That's an error response with D5, which is "Cannot execute command.
Command, or request parameter(s), not supported in present state."
That's an error response from your BMC.  That particular command
shouldn't ever respond with that error, so I think the bug here is
with your BMC.

-corey


