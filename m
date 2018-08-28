Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 517C1C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 080122088E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:12:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="D44USRBZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 080122088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbeH1VEy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 17:04:54 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:50690 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbeH1VEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 17:04:53 -0400
Received: by mail-it0-f68.google.com with SMTP id j81-v6so3754882ite.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 10:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1fw+sFVg6zxjhVWrF8aKzxHnK7ZTx5DnchdlgWbz8jY=;
        b=D44USRBZDZm3DZon/S92dAaX1oAF7G7Dtd2dykLRSTTZAisyg4etra5GiCndvblnmk
         amz4lFwLsF18jDUuETIV9ADB0th9Y3ezOczQevEOl/n77qv+wPQnzqeaaMmpnPkGUPWn
         4IC4pUc0i0IFVeiypFB2wqkHXkjqT1jwkcOPt9tOqt/cP3U2Ibof2okcX9XkkscQIQNW
         PeKi/DUpoZc22rWZWpXCTnSK/i5Px4+g/7LgHyvLylK8ynLwRI8ezk2wMKYD5euU7DZf
         oFBgRJVXhNVj7Z5XYsrvNSNIgLcCLXAC1GtcvEkPFJOrvAJmkzS1C0NlFj2m6cGNCBuS
         C//Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1fw+sFVg6zxjhVWrF8aKzxHnK7ZTx5DnchdlgWbz8jY=;
        b=cfgqYXwljOa6i34HRjiaD/l7xgtHOXf2ErOwbQ/jWpWEHga6Uf0uKQD6kqLLoMUJEP
         PcEkPywuQo/Cxu05+may4qUEgHIbNaW9xccEnMO4/Uz3epLQK60S7D5Vw9Wnlz8ml+cK
         AcITGVmblwsJoMjRSUmN14IjK5YQP9eH1KAzHNxyFX9M+oFh9i+fHhxay1SdJbeXD4Lp
         7yPJjCFmPIkuiBY+Gz83uvc1F+xlPRzftg3YCZYk5HaHzWe4KiORHjNDQgEpwz4PLbOB
         5wN1q9zziEt11YbGVM1EfHIIHmGEkJFa3XkgvLlm6dmHyEnw0Xwm2WD8nH96tFTR7YC2
         evhQ==
X-Gm-Message-State: APzg51DFF7dwbHf7ZrzoSE5yr0nsKYrC/79lFfHw0RJuCH6ZhokiOXXy
        2iZjlmxIJNwib65eGz3EfwjyUQ==
X-Google-Smtp-Source: ANB0VdalKUSXIP7fatTVVVPGtjZlMz45gxp3arE4GGm/QBJFFOO7VWp2NgQiJE/jK2F3xlx1sXvcnA==
X-Received: by 2002:a02:b459:: with SMTP id w25-v6mr2188584jaj.32.1535476336448;
        Tue, 28 Aug 2018 10:12:16 -0700 (PDT)
Received: from ?IPv6:2620:10d:c081:1131::1205? ([2620:10d:c090:180::1:e62f])
        by smtp.gmail.com with ESMTPSA id g10-v6sm736188iob.88.2018.08.28.10.12.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 10:12:15 -0700 (PDT)
Subject: Re: [PATCH] Revert "blk-mq: issue directly if hw queue isn't busy in
 case of 'none'"
To:     Ian W MORRISON <ianwmorrison@gmail.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kashyap.desai@broadcom.com, loberman@redhat.com, osandov@fb.com,
        hch@lst.de, bart.vanassche@wdc.com, hare@suse.de,
        ming.lei@redhat.com, Adrian Hunter <adrian.hunter@intel.com>
References: <20180828154727.3589-1-ianwmorrison@gmail.com>
 <211633e2-a812-d489-e11c-c3f271c465fc@kernel.dk>
 <CAFXWsS_661mkZa1iYEs+8-O-fdFF6bEcqtZrNBzVaNthT2U46w@mail.gmail.com>
 <1cbdba28-3ff5-2bbe-a2cf-b533249c6970@kernel.dk>
 <CAFXWsS82zi7w81-=4ALwMiFm9iQd=NgF3sSBLfvNdU2czEzxwg@mail.gmail.com>
 <853d7213-c6ce-5de9-6c83-806c3b8f18ca@kernel.dk>
 <CAFXWsS_xOKTJk87vQSESQNfdwY1TU0jjS4twEg_+yF3pqbKQ3g@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <702eb090-2bf4-69d1-bfb6-afdca4ba5c5f@kernel.dk>
Date:   Tue, 28 Aug 2018 11:12:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAFXWsS_xOKTJk87vQSESQNfdwY1TU0jjS4twEg_+yF3pqbKQ3g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/28/18 11:01 AM, Ian W MORRISON wrote:
> On Wed, 29 Aug 2018 at 02:13, Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 8/28/18 10:10 AM, Ian W MORRISON wrote:
>>> On Wed, 29 Aug 2018 at 02:09, Jens Axboe <axboe@kernel.dk> wrote:
>>>>
>>>> On 8/28/18 10:07 AM, Ian W MORRISON wrote:
>>>>> On Wed, 29 Aug 2018 at 01:48, Jens Axboe <axboe@kernel.dk> wrote:
>>>>>>
>>>>>> On 8/28/18 9:47 AM, Ian W MORRISON wrote:
>>>>>>> Kernel oops when booting on Bay and Cherry Trail devices
>>>>>>> such as Intel Compute Stick. Bisected as:
>>>>>>>
>>>>>>> commit 6ce3dd6eec11 ("blk-mq: issue directly if hw queue isn't busy in case of 'none'")
>>>>>>>
>>>>>>> This patch reverts the above commit.
>>>>>>
>>>>>> Did I miss the posting of that oops? Just curious where this is
>>>>>> going wrong. Not adverse to reverting, but I'd like to try to
>>>>>> understand the issue first.
>>>>>>
>>>>>> --
>>>>>> Jens Axboe
>>>>>>
>>>>>
>>>>> I've not been able to capture it however manually transcribing what is
>>>>> on the screen:
>>>>>
>>>>> mmc0: Got data interrupt 0x00000002 even though no data operation
>>>>>
>>>>> followed by:
>>>>>
>>>>> mmc0: sdhci: ============= SDHCI REGISTER DUMP ==============
>>>>>
>>>>> Do you want any specific register value or should I transcribe each
>>>>> (as I am working from an image taken at boot)?
>>>>
>>>> Just take a picture of the screen, that should be good enough.
>>>>
>>>> --
>>>> Jens Axboe
>>>>
>>>
>>> Attached as requested.
>>
>> Can you see if this patch helps?
>>
>> https://marc.info/?l=linux-mmc&m=153485326025301&w=2
>>
>> --
>> Jens Axboe
>>
> 
> I confirm that the above patch works with commit 6ce3dd6eec11
> and removes the need for reverting it on eMMC based devices.
> 
> Tested on Bay Trail, Cherry Trail (both now working) and Kaby Lake
> (not affected) devices.

Great, thanks for testing. Adrian, when is this going upstream?

-- 
Jens Axboe

