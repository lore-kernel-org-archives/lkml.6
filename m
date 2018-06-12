Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 7018FC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25732208B7
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="BAnHsZ06"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25732208B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934505AbeFLQWs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 12:22:48 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:34304 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933693AbeFLQWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 12:22:47 -0400
Received: by mail-io0-f196.google.com with SMTP id e15-v6so83105iog.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 09:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=r/qp76db4bObpVGxzAg5VlXRgTR1rLK2DbFKk0DUPMU=;
        b=BAnHsZ06ERHTPhjoHZd0QQ+T2Vciz6fRKjbWSgHWXveTW7XeSm+32MHNBgZGO/Le2Q
         LFBlLRuG838R5YwdHZm2M5vyal2TIeZ08U8bWhfaxG0pVEos/F+jSO/MiE/EFciC8Ojr
         W8pw8LzY8weGYDgFTdhOpfMloob4vO1+kKdXmTju3kN7Fy2ExX8hovoTyAx2LtKVVd8s
         iR78LyAZnnf6uqwooTBLbDd6+cnEkDSS2HqyaVF2YfHdzQtjSxmvbuCICl8zAc7dv9Us
         +TdFcj5ntBRVhOU91gPA/dXJJepfZnl15gGQo1546L+SUbAVh6HClc9otnjOYqiGH1xM
         DNSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r/qp76db4bObpVGxzAg5VlXRgTR1rLK2DbFKk0DUPMU=;
        b=Qy51KusXtOWa/YunV6V4LAuIoJtSmn8bgMdv6dEJqNP3Cx0l8LSXpvdv9TzkSenKqp
         jdZ1Bei9OBT6FvyOzXGFXP3Ck8ubiK7DFy1mTSCeCnQ8oXru6KdCGjAUAAXt8GWnwxf5
         O7oZpjoGsMWJwvAm5SIw5b4X2AEMJ9wIN5ErZUjDTvdwmZg8qr+36XjCfv1DKiJN+GAO
         C2HiRiTn/PasnmSdHqdcJn3BGEY3gVh6odoTBm/+aBHipp10mzmNAN3IyYVF/AVjZmrx
         RT/05NYdWm4OEQekzj/8SPMr6bpXeZC2NDaIpmORnWLQ0DmFAizQhrIAFew8Bg/gEIUe
         eQJg==
X-Gm-Message-State: APt69E1pKbm3yXvb6VhgTrolf7NI+p0mQXSOX9rqgy2gglJS/NZlWU1X
        BEF330fmrcGpiqHqzSXAVGuWXw==
X-Google-Smtp-Source: ADUXVKI7giRoAgVQl6Fj9+HwqfMAsWcHJVxLc+HTyRzaPJt/KvffbF5GjoXqkT+E2wbXZjORKzF4oQ==
X-Received: by 2002:a6b:6e0e:: with SMTP id d14-v6mr1147674ioh.57.1528820566371;
        Tue, 12 Jun 2018 09:22:46 -0700 (PDT)
Received: from [192.168.1.212] (107.191.0.158.static.utbb.net. [107.191.0.158])
        by smtp.gmail.com with ESMTPSA id 80-v6sm507152itk.12.2018.06.12.09.22.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jun 2018 09:22:45 -0700 (PDT)
Subject: Re: Hard lockup in blk_mq_free_request() / wbt_done() / wake_up_all()
To:     Chris Boot <bootc@boo.tc>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
References: <9788e0e6-a448-bf85-1f41-88f42dc0071d@boo.tc>
 <ac2c7156-f405-4047-564d-816159d5968b@kernel.dk>
 <7080a91c-8d9a-6305-2b67-dc27a374327a@boo.tc>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d8ba8949-259a-c0c0-d476-710bcf69c266@kernel.dk>
Date:   Tue, 12 Jun 2018 10:22:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <7080a91c-8d9a-6305-2b67-dc27a374327a@boo.tc>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/12/18 10:19 AM, Chris Boot wrote:
> On 12/06/18 17:09, Jens Axboe wrote:
>> On 6/12/18 9:38 AM, Chris Boot wrote:
>>> Hi folks,
>>>
>>> I maintain a large (to me) system with 112 threads (4x Intel E7-4830 v4)
>>> which has a MegaRAID SAS 9361-24i controller. This system is currently
>>> running Debian's 4.16.12 kernel (from stretch-backports) with blk_mq
>>> enabled.
>>>
>>> I've run into a lockup which appears to involve blq_mq and writeback
>>> throttling. It's hard to tell if I've run into this same thing with
>>> older kernels; I'm trying to track down a deadlock but so far I've been
>>> fairly certain that involved the OOM killer, but this doesn't seem to.
> [snip]
>>
>> Hmm that's really weird, I don't see how we could be spinning on the
>> waitqueue lock like that. I haven't seen any wbt bug reports like this
>> before.
>>
>> Are things generally stable if you just turn off wbt? You can do that
>> for sda, for instance, by doing:
>>
>> # echo 0 > /sys/block/sda/queue/wbt_lat_usec
>>
>> It'd be interesting to get this data point. Eg leave blk-mq enabled, and
>> then just disable wbt.
> 
> Hi Jens,
> 
> Thanks for the speedy response. I'll see if I can get that tested soon;
> if the system is stable without blk_mq I can see the users wanting to
> keep it that way for a while. I'll let you know.

Understandable. I just get suspicious of the general state of the system,
if it's locking up there. Could be a hardware issue, or a bug in some
other area that's messing things up. I have wbt running on literally
hundreds of thousands of boxes and haven't seen a lockup like this.

>> Is anything disabling wbt in the system otherwise?
> 
> Not that I'm aware of, no.

OK, just wanted to rule out something related to the shutdown path
racing with IO.

-- 
Jens Axboe

