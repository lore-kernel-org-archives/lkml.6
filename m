Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 533C6C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 16:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9AF920893
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 16:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="H6QYq6Ci"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9AF920893
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbeH1UGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 16:06:17 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:54128 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726975AbeH1UGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 16:06:17 -0400
Received: by mail-it0-f67.google.com with SMTP id p79-v6so3459704itp.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 09:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=d/aQU3gGWveB4HYm0LC4xcMyn1mht7hnjC3otT8TcE0=;
        b=H6QYq6Ci39eCdlt9VxkUsT6znYjDbdJZ3XHOxaDTQK0i1dIYH5IV8DmduCJW4u5kJZ
         goA99tReOGpdMg9wEmHgh+uB/x4PFwptUVkqti8k4etSeAotLrrEEnKjMafAAp22bwJ1
         fuzLSwTm8Zb5M0LH3DVuFyFmFE8yEhhsPioJ1E1E99+tYuGzxMCCG8XvbX6ByqzFeHz4
         9QVOysSq4K39lRy+pwzV+mbafA5Idm7gRKvhVJjUDrJ+czfWcqwIDzIourt7Ec3v7d3Y
         Iiu4It1IjLVykieW19LWRIXsczdkXCBXHkFo8BO//6Wg7HXzak7qx6YZiRlSrzlYH4kq
         /bNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d/aQU3gGWveB4HYm0LC4xcMyn1mht7hnjC3otT8TcE0=;
        b=PZmebnQcX2Bf4Dw1UbJwlxAm9OpwEqK2sP+ah9nfQBlmf2pp+xfWFi+eZIW3iE7Pd7
         EC2YKdbpbg49gYbqjvglzD9BhTApdGK7MVSOnwiH1FAhn2PPCXDMDNtgNDV2qqNx8A8K
         RFGQSQySYhzr47VZaBvQJcn48u0+rFQaS08kSRdRhLnH6aIuF0lwakxnzrGwdtQxsfnE
         RO1msDgTcVa1oBWO3OYFrgXWsInzsbTzFChTaV3qpFuOKnaNuAb1UtT2o65hTsd3o4nz
         qj3izy7kB0kf3nFqeiPgar6rcIQVakokThOHue+oac7+yGPdpKEARup4Z4nrZoj80SiD
         AQ2Q==
X-Gm-Message-State: APzg51CWYyvgu4iyEaDnHWDZu2PbdBBN7IL3VbX3Mv5+ykMl0ZRvauTb
        CGUvTikxy/h99+SV1T0kj+Sq64u62O8=
X-Google-Smtp-Source: ANB0VdYpFX4Wox2wsejsZ8BRLqzTyKBBWmOCsBa3xWXgLTopiSWslUKQBDcuo/diThDCGlDK6lRZgw==
X-Received: by 2002:a24:9787:: with SMTP id k129-v6mr2129967ite.51.1535472833632;
        Tue, 28 Aug 2018 09:13:53 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id n198-v6sm893770itn.36.2018.08.28.09.13.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 09:13:51 -0700 (PDT)
Subject: Re: [PATCH] Revert "blk-mq: issue directly if hw queue isn't busy in
 case of 'none'"
To:     Ian W MORRISON <ianwmorrison@gmail.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kashyap.desai@broadcom.com, loberman@redhat.com, osandov@fb.com,
        hch@lst.de, bart.vanassche@wdc.com, hare@suse.de,
        ming.lei@redhat.com
References: <20180828154727.3589-1-ianwmorrison@gmail.com>
 <211633e2-a812-d489-e11c-c3f271c465fc@kernel.dk>
 <CAFXWsS_661mkZa1iYEs+8-O-fdFF6bEcqtZrNBzVaNthT2U46w@mail.gmail.com>
 <1cbdba28-3ff5-2bbe-a2cf-b533249c6970@kernel.dk>
 <CAFXWsS82zi7w81-=4ALwMiFm9iQd=NgF3sSBLfvNdU2czEzxwg@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <853d7213-c6ce-5de9-6c83-806c3b8f18ca@kernel.dk>
Date:   Tue, 28 Aug 2018 10:13:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAFXWsS82zi7w81-=4ALwMiFm9iQd=NgF3sSBLfvNdU2czEzxwg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/28/18 10:10 AM, Ian W MORRISON wrote:
> On Wed, 29 Aug 2018 at 02:09, Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 8/28/18 10:07 AM, Ian W MORRISON wrote:
>>> On Wed, 29 Aug 2018 at 01:48, Jens Axboe <axboe@kernel.dk> wrote:
>>>>
>>>> On 8/28/18 9:47 AM, Ian W MORRISON wrote:
>>>>> Kernel oops when booting on Bay and Cherry Trail devices
>>>>> such as Intel Compute Stick. Bisected as:
>>>>>
>>>>> commit 6ce3dd6eec11 ("blk-mq: issue directly if hw queue isn't busy in case of 'none'")
>>>>>
>>>>> This patch reverts the above commit.
>>>>
>>>> Did I miss the posting of that oops? Just curious where this is
>>>> going wrong. Not adverse to reverting, but I'd like to try to
>>>> understand the issue first.
>>>>
>>>> --
>>>> Jens Axboe
>>>>
>>>
>>> I've not been able to capture it however manually transcribing what is
>>> on the screen:
>>>
>>> mmc0: Got data interrupt 0x00000002 even though no data operation
>>>
>>> followed by:
>>>
>>> mmc0: sdhci: ============= SDHCI REGISTER DUMP ==============
>>>
>>> Do you want any specific register value or should I transcribe each
>>> (as I am working from an image taken at boot)?
>>
>> Just take a picture of the screen, that should be good enough.
>>
>> --
>> Jens Axboe
>>
> 
> Attached as requested.

Can you see if this patch helps?

https://marc.info/?l=linux-mmc&m=153485326025301&w=2

-- 
Jens Axboe

