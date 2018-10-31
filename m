Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 965E8C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 14:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 460F42054F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 14:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="BqwCWo+Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 460F42054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729517AbeJaXTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 19:19:51 -0400
Received: from mail-it1-f180.google.com ([209.85.166.180]:51088 "EHLO
        mail-it1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729472AbeJaXTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 19:19:51 -0400
Received: by mail-it1-f180.google.com with SMTP id k206-v6so18491896ite.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 07:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=czt9T3gy1xdYwI6weJ5FwsSvqVgvS2GsTy3C7tzr9B0=;
        b=BqwCWo+Q77vKn/NiPO6cE0yB5hT5MWHPgchNn+oT4Kp2aLiBhlf98S2RfbIaxM1n5j
         J3H97uXADnBP0Akb05BttuEUArsmbxTG8HM55MTpkPWD7heJlB9Cn/dbo6UuECxZAe+m
         +XsQLfo1YvrCzWJr8so+naXPI+2fmStNX9fFiTVdGoHeseBAqRmr/jlfZm4DAMCb3v9X
         /sX6irqPsDEXKUrj8JpR1wXnoUSU0wD96I8YwQk8ia26ii7N/3DzsmI8hep3V+vzDYQy
         HF+6pmdd4yJjsh8lKp0LcbAlXXvCP5zSueWY3iozKWMRh23AVdIquOHaQRXHJf2kWu92
         Z90g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=czt9T3gy1xdYwI6weJ5FwsSvqVgvS2GsTy3C7tzr9B0=;
        b=ThOMgXYP3UsedTYqIhXdJbbX9JlGfPL0rrAM4wxj/0WgopV7jgzbfrEGXHH+0A+0av
         v6zOyMjSiE8DQa/1K840mARn4LgiMal/pWJ0mOUKoIUur28Ln6iN409zPHnH6QaXyWrR
         29Q0IgAL1QRrX4GdX8+ybcP96EsBQpeOkgKGQTzdmDI1G/DNd9CEQGk4lQwkljZIiAiQ
         ebEN1m2iFOrgTL45NJLOKsOEWkIV/GmF8iZ1LBg/EVWXJhTNQRmZNoBE4sOjCYL72U+U
         7wA2OHl4RtlYh7GliYZa1O2UMEkaXenjsK20SJBox1lWg+uhW/6lP0p5ey0Qs5XRUNEL
         lqmQ==
X-Gm-Message-State: AGRZ1gIPgvKEJPUPiLE3qY7DeCTNGctSVUl5QES9wh2YnB0NFvreYp5e
        yjfcYV6X5sFq0w35sOMBv9ucRClmCwI=
X-Google-Smtp-Source: AJdET5evN2Bj6vrZ4BMrfY8mpO5HrqiMDpgBSaHOpB4d1QxDd9GLXwwV9p9F+gU4n29vZHwJF3JJjw==
X-Received: by 2002:a02:4ac1:: with SMTP id s62-v6mr2448522jad.44.1540995696552;
        Wed, 31 Oct 2018 07:21:36 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id a15-v6sm9381371itc.3.2018.10.31.07.21.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 07:21:35 -0700 (PDT)
Subject: Re: [PATCH 06/16] blk-mq: add 'type' attribute to the sysfs hctx
 directory
To:     Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20181030183252.17857-1-axboe@kernel.dk>
 <20181030183252.17857-7-axboe@kernel.dk>
 <2d858eb1-56d6-5c3e-7c7e-9e36b1ad04fc@grimberg.me>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a7dc22ab-73b5-f869-07b5-51ddf7d795dd@kernel.dk>
Date:   Wed, 31 Oct 2018 08:21:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <2d858eb1-56d6-5c3e-7c7e-9e36b1ad04fc@grimberg.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/18 6:53 PM, Sagi Grimberg wrote:
> 
>> It can be useful for a user to verify what type a given hardware
>> queue is, expose this information in sysfs.
> 
> I assume the user is expected to understand the meaning of the
> enumeration it sees in accessing this field correct?
> 
> Would be nice to output some meaningful string but I'm not
> yet sure how to do that, but would be nice...

The type is driver private, there's no specific meaning associated
with the type. We could make it output a string provided that
the driver had a way to query it. For now I think the type is
enough, it'll allow you to see which ones are different.

> Other than that,
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

Thanks

-- 
Jens Axboe

