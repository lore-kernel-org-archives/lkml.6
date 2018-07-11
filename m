Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA438C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 18:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B72B20C51
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 18:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="vk4YEuC7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B72B20C51
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387598AbeGKSgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 14:36:24 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:43905 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732344AbeGKSgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 14:36:23 -0400
Received: by mail-io0-f195.google.com with SMTP id y10-v6so10246800ioa.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 11:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6FilDyLQp/MqXWuT6iuBp6uGjzNadJKP5A/dM5n24/8=;
        b=vk4YEuC7aFug0hIA7rrYfbtCvoNw9W8vGaBM3FoJAZ0JGnTAKVg/G30XkFXJxprC3M
         CB1PTWKbnNlj7/W4MksXH/nuXnoXdBbYegh5H0RyHZljoNev3YjtVMmeWA3QHzgkAQy7
         JtDVzqn0TkWYJZMV65iDaef2UE4RkhupsXuoUvcxN+1AfbfHeG2hifMzM4FGjcfIZ3XP
         haSrzK/5gPpCUhHhSFT/w+Jb8CYTuGbur2gyHqy9GSf1U2WWZG0pKcnNbiuVJTuqP7fl
         KSrL4NQWqj0TthT1KYfLYfgycErqBtlVmgw4WtuIw+0OKCW9mFMWPaRn8AmxT5Ta8W4O
         vL8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6FilDyLQp/MqXWuT6iuBp6uGjzNadJKP5A/dM5n24/8=;
        b=m1PA92im6MNNjIYhzTvZgRw/YhsEW06ZTlnxrA4+8SPOVi+gIpqDBkrE6ii4PDoacE
         QFU8DpNuAA8O5rFoPWP8cpUn36Zb3RsmHjE+4l9Dqlr1EAdQ4unkG2o+xI0351ibHaiJ
         0utS9tOZJO44STWBLFwx9qEJbnsTIDoQNl9/gY0d3NbIvrJ0ItEYmehGdfChWUdJBm6L
         ahT4POTrgdutDUiiJSE0mJ2NXM/HbeNyE93JHjSSplL8mNFejdYv0A/8wbZzOPaEikuG
         uRoaPud+ZPkipl+/7HGOfPm7CHJ19a6DL7bztEjZGEXUxdwvm+EKMauKAAaGm0SjY68r
         IWGg==
X-Gm-Message-State: AOUpUlHUpcnPQrQAbvdVsTrq2JQwZJHqaqxwMeYO6UJ4bn+7a9OMrxG3
        xrtwwnjQtoqWs6Euh84bKGruVg==
X-Google-Smtp-Source: AAOMgpfsyad9tm1pRLFWrm1RMsPaG1IHMethd1JtpoUomeKgvcI9px72X8cdYXwPb39JA/ndgv+vWg==
X-Received: by 2002:a6b:8e49:: with SMTP id q70-v6mr364088iod.516.1531333849600;
        Wed, 11 Jul 2018 11:30:49 -0700 (PDT)
Received: from [192.168.1.212] (107.191.0.158.static.utbb.net. [107.191.0.158])
        by smtp.gmail.com with ESMTPSA id x137-v6sm11162145iod.69.2018.07.11.11.30.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 11:30:48 -0700 (PDT)
Subject: Re: [PATCH 02/12] blk: use for_each_if
To:     Tejun Heo <tj@kernel.org>, Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Shaohua Li <shli@fb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>
References: <20180709083650.23549-1-daniel.vetter@ffwll.ch>
 <20180709083650.23549-2-daniel.vetter@ffwll.ch>
 <20180711164058.GC72677@devbig577.frc2.facebook.com>
 <20180711164536.GD72677@devbig577.frc2.facebook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <965184f9-e5ed-3c8b-bfd7-a033a252371b@kernel.dk>
Date:   Wed, 11 Jul 2018 12:30:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180711164536.GD72677@devbig577.frc2.facebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/11/18 10:45 AM, Tejun Heo wrote:
> On Wed, Jul 11, 2018 at 09:40:58AM -0700, Tejun Heo wrote:
>> On Mon, Jul 09, 2018 at 10:36:40AM +0200, Daniel Vetter wrote:
>>> Makes the macros resilient against if {} else {} blocks right
>>> afterwards.
>>>
>>> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
>>> Cc: Tejun Heo <tj@kernel.org>
>>> Cc: Jens Axboe <axboe@kernel.dk>
>>> Cc: Shaohua Li <shli@fb.com>
>>> Cc: Kate Stewart <kstewart@linuxfoundation.org>
>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> Cc: Joseph Qi <joseph.qi@linux.alibaba.com>
>>> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
>>> Cc: Arnd Bergmann <arnd@arndb.de>
>>
>> Acked-by: Tejun Heo <tj@kernel.org>
>>
>> Jens, it'd probably be best to route this through block tree.
> 
> Oops, this requires an earlier patch to move the for_each_if def to a
> common header and should be routed together.

Yeah, this is a problem with the submission.

Always (ALWAYS) CC folks on at least the cover letter and generic
earlier patches. Getting just one patch sent like this is mostly
useless, and causes more harm than good.

-- 
Jens Axboe

