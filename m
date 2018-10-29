Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DFE0C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 16:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3337A20657
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 16:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="GcDfEmUv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3337A20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbeJ3Bk3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 21:40:29 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:38271 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727744AbeJ3Bk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 21:40:29 -0400
Received: by mail-it1-f193.google.com with SMTP id i76-v6so10229061ita.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 09:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=MNP0Ji5hx1fLDqnrLxMt3OpOCGMoTWvvqZgFRozELw8=;
        b=GcDfEmUvl4hE7YTXBfX+vD0f6ZV3wj5rogT4ANQNJMRSn8HXIAk+8I9APoGHM+J17Q
         EZjnAUxf2Y3Tku2px/FOkJiPrEdmN+vpnzOVlYkeHpVsvLVvjbcXuUgc38e1lvsVgvGY
         HBBH/VlL7UfhWKiRHv7ttSOU9O3BvmblLp1Y6d2D6qCX8H5rEJdCTJgDSHCod+8m7+p5
         3xl+DYW4oZlsIyx/S0lS0uutklO+ouH4S+sBkXEodpcEdMflktEij1LpmLeBzp8fAYq1
         KlHZmncevZqgiI/g8yBjncSROgWwmKOfALMRVuv8ZDrZqFVO+9B/Z1kWxJ7XmywtZZ3H
         I3JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MNP0Ji5hx1fLDqnrLxMt3OpOCGMoTWvvqZgFRozELw8=;
        b=rbwH8VJIfbx5Cr86dMdF7LIoUWwu0IC/Y4R0BsaW7OKlz7eXYbyjZypbgIfdnEuNUz
         xNg7XevBx6v3E0wg7ohVseBO5D6zhCQg3pnlS2UH7Rnp+5RsM2czoZY/9bNsZiuD/wOu
         NtqurQ3wjlQ/iN7cw3ZiVtGvNmxPu04E4yvKDLu4S9vm7YZQK14c1KhDzC3VEMWWLwhl
         It0xpBQDIlMLHoTzGJ0t+aXYZ6GsJAUELYh5UQos+F0167C5ZCjiqp1hFMexqyKbpkxq
         1tTKW0z3RQm1tAw6+yLulX3zwb8js0j3bm4Gyeu5NRA8hxLHsszvRG30FGpYD1kpMS8E
         Uxug==
X-Gm-Message-State: AGRZ1gLFFpVca1M4sfPmm6Vv0DAHNFpcCaMfRDTjUwlc0JQqc42m7gN2
        oaw9wYZGNnb83YT5tk3/tk+hsjAS0bQ=
X-Google-Smtp-Source: AJdET5ecQvPU5qK8gvn9gw09mXmH8cIBAC1BJ2jJVTybJbqoDffnlfP6uFp5mZS0twi09nt4cHTTAg==
X-Received: by 2002:a05:660c:383:: with SMTP id x3mr9637413itj.121.1540831863873;
        Mon, 29 Oct 2018 09:51:03 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id f10-v6sm6732153ioq.59.2018.10.29.09.51.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 09:51:02 -0700 (PDT)
Subject: Re: [PATCH 01/14] blk-mq: kill q->mq_map
To:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181029163738.10172-1-axboe@kernel.dk>
 <20181029163738.10172-2-axboe@kernel.dk> <1540831588.196084.54.camel@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f0a96403-df1a-6151-166c-a4b82f678234@kernel.dk>
Date:   Mon, 29 Oct 2018 10:51:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1540831588.196084.54.camel@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/29/18 10:46 AM, Bart Van Assche wrote:
> On Mon, 2018-10-29 at 10:37 -0600, Jens Axboe wrote:
>> It's just a pointer to set->mq_map, use that instead.
> 
> Please clarify in the patch description that the q->tag_set assignment
> has been moved because this patch makes it necessary to have that pointer
> available earlier such that it is clear that that move is intentional.
> Anyway:
> 
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>

Good point, I'll improve the verbiage in the commit message. Thanks.

-- 
Jens Axboe

