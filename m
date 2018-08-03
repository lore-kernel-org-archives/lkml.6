Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9380BC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 12:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E264D2170D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 12:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="VLg4a+d2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E264D2170D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731503AbeHCOvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 10:51:47 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36208 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728872AbeHCOvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 10:51:47 -0400
Received: by mail-lj1-f196.google.com with SMTP id u7-v6so4869330lji.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 05:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Hv1x/SsSItU2ufYaIhQ85U/ElGEeIXqD6BxNAVHhVe4=;
        b=VLg4a+d2IOpjDFwEjsuprBLP0VtLTzk6LKGnMPwoaNRTrAtA6veML2NwPkb87D/C3c
         am3+K1q8EmndcEf/uYHKSFVi8XB0tmm86JtRPZ3fI8w9qE0w4CI5dsuH0BX2+10A3JLv
         hKJyby1CTFOnhzZodH8uP1nQvcPtI/d76vTlh4Dh7pp6rwPhSCsbirboGak9M9imn54v
         jNjqLoRvjbCpMyn500/FmG6cHSevxfBx9XjZ1CChKDm/pNW5ZVPcysqz2h6scSqk5BQc
         srxtFBM2qR/1v/mWmQLI9g8EC+czLmYsa8izlw8tEdG5zxzNh3VStPaKcaG5xQLfkS80
         Im9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Hv1x/SsSItU2ufYaIhQ85U/ElGEeIXqD6BxNAVHhVe4=;
        b=PVY6AYJLmBhpCdcjPmmJg5o6F3XWLCEgAu0G5vLu6vhUNt0emlV/IdOK6S8NF86fBt
         BHlpr666bJTQK+EOgAo4gODTZ+KZA+a5Rujus+c9t7Js6lgxlud7f3xzkzcgdjEldk2N
         qCYB/TT5Z4JP5UFWwQWSHpgWuQBLkpWTFwHKVkswcHVZpmfuXedSdru796zNp/1FyXaI
         Xw3kaWdIu85RuixV6UPrM/N9SfvERwsvhtZNaZDJsSM3UlXuTRasgeG/iw57z+37CNwm
         hs90379CuDg3BFqAJ9fn+jJtc5QU9yoMUEAvZ9lXFbmIEKubPuhm3bHl+KQb1GChCgkT
         UEBg==
X-Gm-Message-State: AOUpUlEvgJSDGxomxXCkk0mkqSZ0kiw5ErZDx6phqrY4Gzvl6DuySVOi
        ofOU3z9zGrpchLH3Bc1ke3b7Mr2anPo1qg==
X-Google-Smtp-Source: AAOMgpdVRniYStXA8lagUaRdzt9sGqZl/Af5/mmjVg8KrfwjEOcHDIG/hiI9PU3j4ubmzLkBBDIrQw==
X-Received: by 2002:a2e:458b:: with SMTP id s133-v6mr5285797lja.151.1533300932687;
        Fri, 03 Aug 2018 05:55:32 -0700 (PDT)
Received: from [192.168.0.10] (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.googlemail.com with ESMTPSA id 20-v6sm893035ljs.32.2018.08.03.05.55.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Aug 2018 05:55:31 -0700 (PDT)
Subject: Re: [PATCH] lightnvm: pblk: remove unnecessary drive version check
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
To:     javier@cnexlabs.com
Cc:     igor.j.konopko@intel.com, marcin.dziegielewski@intel.com,
        hans.holmberg@cnexlabs.com, hlitz@ucsc.edu,
        youngtack.jin@circuitblvd.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180802205841.22039-1-mb@lightnvm.io>
 <4382FFAE-0602-4A16-8120-E930141606ED@cnexlabs.com>
 <130c689a-723f-a32a-96e3-a7a59ff6b7b8@lightnvm.io>
Message-ID: <ef8cd1ac-623b-96ed-1a7f-3e390fcc51d5@lightnvm.io>
Date:   Fri, 3 Aug 2018 14:55:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <130c689a-723f-a32a-96e3-a7a59ff6b7b8@lightnvm.io>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2018 02:39 PM, Matias Bjørling wrote:
> On 08/03/2018 02:18 PM, Javier Gonzalez wrote:
>>> On 2 Aug 2018, at 22.58, Matias Bjørling <mb@lightnvm.io> wrote:
>>>
>>> The nvme driver checks for 1.2 and 2.0 compatibility. If an unsupported
>>> version is reported, the device will not be initialized.
>>>
>>> Signed-off-by: Matias Bjørling <mb@lightnvm.io>
>>> ---
>>> drivers/lightnvm/pblk-init.c | 8 --------
>>> 1 file changed, 8 deletions(-)
>>>
>>> diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
>>> index 537e98f2b24a..e9e2fedff387 100644
>>> --- a/drivers/lightnvm/pblk-init.c
>>> +++ b/drivers/lightnvm/pblk-init.c
>>> @@ -1202,14 +1202,6 @@ static void *pblk_init(struct nvm_tgt_dev 
>>> *dev, struct gendisk *tdisk,
>>>     pblk->state = PBLK_STATE_RUNNING;
>>>     pblk->gc.gc_enabled = 0;
>>>
>>> -    if (!(geo->version == NVM_OCSSD_SPEC_12 ||
>>> -                    geo->version == NVM_OCSSD_SPEC_20)) {
>>> -        pblk_err(pblk, "OCSSD version not supported (%u)\n",
>>> -                            geo->version);
>>> -        kfree(pblk);
>>> -        return ERR_PTR(-EINVAL);
>>> -    }
>>> -
>>>     if (geo->version == NVM_OCSSD_SPEC_12 && geo->dom & NVM_RSP_L2P) {
>>>         pblk_err(pblk, "host-side L2P table not supported. (%x)\n",
>>>                             geo->dom);
>>> -- 
>>> 2.11.0
>>
>> The same comment goes for this patch. pblk does support 2.0 and 1.2
>> today, but it is not guaranteed it will support a new revision straight
>> away. So I think that a check wither here or through the .capabilities I
>> proposed on the other patch is necessary.
>>
> 
> Works for me. I'll send another patch that enables pblk target to tell 
> which version it supports.

On second thought. The idea is that pblk will not have to think about 
1.2/2.0. The core will expose a general address format, etc., such that 
pblk doesn't have to be complicated by that.

I am working on the various pieces and moving them to core. The patch 
may have gone out a bit early. I will send this again when the 1.2/2.0 
conversions have been applied.
