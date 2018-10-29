Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C3BC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 17:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FE9F204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 17:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="tbphMG1w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FE9F204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbeJ3B70 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 21:59:26 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:51119 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbeJ3B7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 21:59:25 -0400
Received: by mail-it1-f193.google.com with SMTP id k206-v6so10459065ite.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 10:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7cuKxCqQLZBKvX1GlPgGI3QC2sw/jzQVWli7UvMuorA=;
        b=tbphMG1wJtJF5WdTXCXp5XvUTN2gpS+zrl0v3jJ9HLLfj4LykTOhC5ywwiIiXBJQTS
         ETNC5u1Sj7xtcYYz0Fa+azovg2L81Z6eOvAazEUTUSZeMFBQeoaO2veHoBdhNmHig0Xl
         x9iQg+j8V/y6ZFgjmBygvfPwaFEb9Qz38i/G9D6iJC3b5dx99HzQzRPwjXlju2XXc2zG
         fKIF8Uxqgo4APZZVH/TQb5gSdcs3vAYCJx8KoA0YorbnysGJK99NOc0TXo0KWMvvrYfp
         mMuYSKN85wOihGPYBqMo22W0K7t3UVGpPlPAQtq0loCIQUctv4FB416fcDb9prCcpJy+
         uNuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7cuKxCqQLZBKvX1GlPgGI3QC2sw/jzQVWli7UvMuorA=;
        b=UN+zftytYUvGjwe45LON4jHqbgokDpQ42Zh15Z8wDLsBC+8yTIqKzLR0m4FlFoxXWY
         Enq7Qhrmefw3Xmwo9Ffm8aQ5S8syo0qR7PRzZR9KerhyLJhhLa2oND/8trGztNkOuQCT
         II9QTasLgkaG3bmpEj9y/PvBAmEC4Bdu77GXMRzzVvL+yD1LjD5f4t5rZWUHd0zSsDVL
         hmkRRYQ7QyVAuyZi9th6tOKt2g8sJKPUwl6SwwEhEizMcKaLm0kd2hJrT4LWAA82ayjR
         f0mZIrfGMhJmWrizgduRMfFjQgxI45kJoTq5WpQChyKmoA2yt51x2/gKuThjEwhQpV6E
         mRsA==
X-Gm-Message-State: AGRZ1gLo8z5S3bwBpq5lr39SLyyX1pqPpwAa+OuSq1niRWAa5fkSnzZI
        6Gdvi310Tw9VVhYuNWvxKG+2+DZL8QU=
X-Google-Smtp-Source: AJdET5ecSMIQh7X1ECJ4rlUxskMQhDnaLJysLAdFjMfZWiP4RTOW8jd6GtPDPK3kByWZkbaWAk047Q==
X-Received: by 2002:a02:94d:: with SMTP id f74-v6mr11118587jad.85.1540832995175;
        Mon, 29 Oct 2018 10:09:55 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id j19-v6sm7249562itj.31.2018.10.29.10.09.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 10:09:53 -0700 (PDT)
Subject: Re: [PATCH 11/14] irq: add support for allocating (and affinitizing)
 sets of IRQs
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20181029163738.10172-1-axboe@kernel.dk>
 <20181029163738.10172-12-axboe@kernel.dk>
 <alpine.DEB.2.21.1810291805540.5984@nanos.tec.linutronix.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a4f13bb3-80e4-14ad-3631-8fd9a06a67d5@kernel.dk>
Date:   Mon, 29 Oct 2018 11:09:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1810291805540.5984@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/29/18 11:08 AM, Thomas Gleixner wrote:
> Jens,
> 
> On Mon, 29 Oct 2018, Jens Axboe wrote:
> 
>> A driver may have a need to allocate multiple sets of MSI/MSI-X
>> interrupts, and have them appropriately affinitized. Add support for
>> defining a number of sets in the irq_affinity structure, of varying
>> sizes, and get each set affinitized correctly across the machine.
>>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: linux-kernel@vger.kernel.org
>> Reviewed-by: Hannes Reinecke <hare@suse.com>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> This looks good.
> 
> Vs. merge logistics: I'm expecting some other changes in that area as per
> discussion with megasas (IIRC) folks. So I'd like to apply that myself
> right after -rc1 and provide it to you as a single commit to pull from so
> we can avoid collisions in next and the merge window.

That sounds fine, thanks Thomas!

-- 
Jens Axboe

