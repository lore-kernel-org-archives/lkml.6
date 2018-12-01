Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B427CC64EB4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 18:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80CB42082F
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 18:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="GEto1Qx2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80CB42082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725762AbeLBFv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 00:51:59 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45782 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbeLBFv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 00:51:59 -0500
Received: by mail-pg1-f196.google.com with SMTP id y4so3901225pgc.12
        for <linux-kernel@vger.kernel.org>; Sat, 01 Dec 2018 10:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8TPks8/DpMNtGOQ+S/XT9p0zAfiBQN/YGPGFhuwiXk0=;
        b=GEto1Qx2ozvGdjwzP8yJn7gU4xp1MAAIMn7BZKp996ruvP4jN4sr8BtKelniluZ0jh
         8Pt4HTRxKciv7oFBShbbh1BoNnznM1qFaGc5nJVJfVsP+jZTrI8FIWz4LREnEngCCksq
         4iuZ2CSYKvuAiNOBH1FVY61uSH45Zag832PdmlW5+giTHL8bx7cGWPzuH8FE9ngswg9c
         GPUQFuLTrZ8/ntydPCMG6PO9GOgbnvyOWEYbbyq4u5L2lULOWoGnClqsrl9BGjUvuN62
         8IeR8iVOtZtCfyI9bvBYfiUXdHOlpCChATx9PfAqqkNbrRqMm9Zi5q4lDWFjn4kNdBO0
         fAWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8TPks8/DpMNtGOQ+S/XT9p0zAfiBQN/YGPGFhuwiXk0=;
        b=gvkl4FtENhbAdX6+BXf3+2B/oqjCeEcDJevzxA9GAjbWc6MMzMVd+yJq9nRVUlCNNk
         Mbj2XAZ9ds4A4X6Kloe94SlNsNqzeyvRugIzGgjmrkNT2iU4f+3yFQrJpsWSd1JUHsC5
         pbTNyhlptOs1YIAmWmO0YdYbOXpkQ2XPjXNyUVparI03RmfsMbLhSdolgAPOpI660C7v
         peV6BKtdv6AdEXaXO0B35ykt1Q7CatT7QcGChfOEGbduTNXc6wcbTPLiJx4PGaAZuXlU
         QtP08hev936c+CwtSzJWSQG1dxVi9Hgrt1vh4AeMlANjLlV5/O1WPX0TZTyS4XvB0oAp
         Zahg==
X-Gm-Message-State: AA+aEWZ4BNLOEfBElQJDekNpSkpcxiLRMx/aedeONCyThBONuzJDFp0F
        W0dWSAidMY4xwrs5PE0/x+5Zlg==
X-Google-Smtp-Source: AFSGD/VarwMzaZ3g1E7m0PCpObZib75NXDeDSS2w+eaF1luR4uDwS5mKsAe9i1Uy6Y1/YRwJuWiH3w==
X-Received: by 2002:a65:5a8e:: with SMTP id c14mr8444610pgt.137.1543689531625;
        Sat, 01 Dec 2018 10:38:51 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id g15sm43045678pfj.131.2018.12.01.10.38.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Dec 2018 10:38:50 -0800 (PST)
Subject: Re: [PATCH v2] block: Change to use DEFINE_SHOW_ATTRIBUTE macro
To:     Frank Lee <tiny.windzz@gmail.com>
Cc:     ed.cashin@acm.org, philipp.reisner@linbit.com,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-block@vger.kernel.org, josh.h.morris@us.ibm.com,
        pjk1939@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        drbd-dev@lists.linbit.com, nbd@other.debian.org
References: <20181201142414.7766-1-tiny.windzz@gmail.com>
 <5682c419-9e44-10ed-6a2e-286e6f5c5def@kernel.dk>
 <CAEExFWtJEJwgGR3gqfHDXw-c4nyA7dkQTd9fkzVsht=ROmfgMQ@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <92334639-9d34-5e6a-2c43-945a20077394@kernel.dk>
Date:   Sat, 1 Dec 2018 11:38:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAEExFWtJEJwgGR3gqfHDXw-c4nyA7dkQTd9fkzVsht=ROmfgMQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/18 11:31 AM, Frank Lee wrote:
> On Sun, Dec 2, 2018 at 2:11 AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 12/1/18 7:24 AM, Yangtao Li wrote:
>>> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
>>>
>>> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
>>> ---
>>> changes in v2:
>>> -Modify some function names to avoid compilation errors
>>
>> The fact that your previous patch didn't even compile doesn't fill me
>> with a lot of confidence in the amount of diligence and testing
>> you apply to your patches.
>>
>> Why would you send something out that you didn't even compile?
>>
>> --
>> Jens Axboe
>>
> These changes are the same and only require a small change.
> Most of the changes are fine, so it's a bit negligent.

When someone is sending a patch for inclusion, at the very minimum
I expect it to have been compiled, and preferably tested too. Doesn't
matter how small the change is, even a one-liner should go through that.

That said, I'm not a huge fan of changes like this. It completely
hides what is going on for someone reading the code, and it's not
like there's a win on code size for example. The only win seems to
be that driver writes can't mess it up, which is a nice benefit.

-- 
Jens Axboe

