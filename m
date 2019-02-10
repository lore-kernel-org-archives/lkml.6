Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18DD9C282CC
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 15:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA56820844
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 15:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="mfTqsZGI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfBJPu7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 10:50:59 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44071 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbfBJPu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 10:50:56 -0500
Received: by mail-pl1-f194.google.com with SMTP id p4so4070047plq.11
        for <linux-kernel@vger.kernel.org>; Sun, 10 Feb 2019 07:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=u99vCrxZVjq6IAIyJDVCFPZjEfk9fl7g5jyYQ73Sl6o=;
        b=mfTqsZGIGgRsiENXLeo/CEc3yhJ23to80nt3IGw2u5hdZ0N+hks6d+7Ajat1H9XAIy
         3pdxzh9S/9mk2CfOCDnmF5POXVifwcLj/HQXy1C9fWqUQLMiXYH1+eUeFyYviDSeVR6C
         pJtSq4zRKrnjBzsEtPtKFHhE56mkjiDeexih2IpI77jansNDVebTFfpNN87o3D09k5+U
         kcWgzl8+zMf0c4WyaCvxrOCqw8pFiRkcD0d6UBUrcDpguTaVLHIuN9ISAeeLdZcblR0e
         dN5J+rfREfVlu5nqehYG8devKJ0XifZv2yp1f5GmAB43dj34dB1Ykj8q05A6DKiQJT3d
         qMFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u99vCrxZVjq6IAIyJDVCFPZjEfk9fl7g5jyYQ73Sl6o=;
        b=ahPNH2N4RggkD1/IvXDbvwBnaUedbHP4LP94c23cTWHBUL10IAj7MIpPxiLdTV/wF9
         x75f8MMS8p4rwsrizk79xCVmGQHx3G1dVNbWJJYIRt8s2iCQR3r+HZOQ4zTu9ocPuxy/
         OpdjKoA7YDXeBRNKrdWODrYvnPS70Ro654UZctP9kGtt9oqwbyBOWQblFaABC4Kk9avf
         E/A1d/V7q7sailMhA+IZFc2TdmsZrO4Ip1l3agwOP8PcrbQchm8c3Wq52V/0LJ5WRaRu
         R2dD5FXfZiju17gWoQ40aEvMQGLXRdfNj6mULT0BGHLSVliqFFhjcjnIYjCSWCqI8xab
         Qlsw==
X-Gm-Message-State: AHQUAua8C892EKxW7jPILXnOaX2DdlWiH4gIs9muRDiIy2Ulpg9LpMGK
        h1KfxbpunsROKZbXAoAu+QYaAg==
X-Google-Smtp-Source: AHgI3IbGHP6t7A7zZPwI7XVGvbmETeO2TqmM1z1kHcsOyKC9z/K+aM2A+wumQO2XTTJHojyFxCR9hQ==
X-Received: by 2002:a17:902:2e03:: with SMTP id q3mr25513080plb.330.1549813855552;
        Sun, 10 Feb 2019 07:50:55 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id v13sm10543835pff.20.2019.02.10.07.50.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Feb 2019 07:50:54 -0800 (PST)
Subject: Re: [PATCH] blk-sysfs: Rework documention of __blk_release_queue
To:     Marcos Souza <marcos.souza.org@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>
References: <20190131011139.2264742-1-marcos.souza.org@gmail.com>
 <02fcaaa4-3667-7144-5ca2-4e5346380439@gmail.com>
 <813bdf91-83de-332d-5d6b-2287039578b5@kernel.dk>
 <CAH0vN5JF6p0B+uO2CQ-+Bv_cEtBRtWdpLJHD9mYAf3Ht2GncdA@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9d1b596a-e5c6-6ad4-0a03-789bddb3d090@kernel.dk>
Date:   Sun, 10 Feb 2019 08:50:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAH0vN5JF6p0B+uO2CQ-+Bv_cEtBRtWdpLJHD9mYAf3Ht2GncdA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/10/19 8:44 AM, Marcos Souza wrote:
> 
> 
> On Sun, Feb 10, 2019, 13:23 Jens Axboe <axboe@kernel.dk <mailto:axboe@kernel.dk> wrote:
> 
>     On 2/9/19 11:34 AM, Marcos Paulo de Souza wrote:
>     > Ping :)
>     >
>     > On 1/30/19 11:11 PM, Marcos Paulo de Souza wrote:
>     >> The Notes section of the comment was removed, because now
>     >> blk_release_queue can only be executed from blk_cleanup_queue (being
>     >> called when the q->kobj reaches zero), and also blk_init_queue was removed
>     >> in a1ce35fa4985.
>     >>
>     >> Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com <mailto:marcos.souza.org@gmail.com>>
>     >> ---
>     >>  This is basically a v2 of https://lkml.org/lkml/2019/1/14/1098
>     >>
>     >>  But, I tried to describe when this function is called, removing redundancies.
>     >>  Maybe it would be better placed in blk-core.c, where the q->kobj is initialized
>     >>  with blk_queue_ktype (which .release pointer points to blk_release_queue)?
>     >>
>     >>  block/blk-sysfs.c | 19 +++++++------------
>     >>  1 file changed, 7 insertions(+), 12 deletions(-)
>     >>
>     >> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
>     >> index 590d1ef2f961..d4dea9179fa6 100644
>     >> --- a/block/blk-sysfs.c
>     >> +++ b/block/blk-sysfs.c
>     >> @@ -817,21 +817,16 @@ static void blk_free_queue_rcu(struct rcu_head *rcu_head)
>     >>  }
>     >> 
>     >>  /**
>     >> - * __blk_release_queue - release a request queue when it is no longer needed
>     >> + * __blk_release_queue - release a request queue
>     >>   * @work: pointer to the release_work member of the request queue to be released
>     >>   *
>     >>   * Description:
>     >> - *     blk_release_queue is the counterpart of blk_init_queue(). It should be
>     >> - *     called when a request queue is being released; typically when a block
>     >> - *     device is being de-registered. Its primary task it to free the queue
>     >> - *     itself.
>     >> - *
>     >> - * Notes:
>     >> - *     The low level driver must have finished any outstanding requests first
>     >> - *     via blk_cleanup_queue().
>     >> - *
>     >> - *     Although blk_release_queue() may be called with preemption disabled,
>     >> - *     __blk_release_queue() may sleep.
>     >> + *     This function is called when a block device is being de-registered. The
> 
>     unregistered
> 
>     >> + *     process of releasing a request queue starts with blk_cleanup_queue, which
>     >> + *     set the appropriate flags and the calls blk_put_queue, that decrements
> 
>     s/the/then
> 
> 
> Thanks foe the review. Do you want me to send a v2?

Yes please.

-- 
Jens Axboe

