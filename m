Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C22CC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 17:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 088E12151C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 17:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ehott7HA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 088E12151C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbeHXUwt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 16:52:49 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:35410 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727635AbeHXUwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 16:52:49 -0400
Received: by mail-io0-f194.google.com with SMTP id w11-v6so7737904iob.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 10:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gRkYXRRWU+MJKFUoTWQ1aVKdyHPeViwNia0ZJBTqx6A=;
        b=ehott7HAhiGN7rNHL9Sp7S+SdL+gakiau0LwEuhDPsZt0woJs7pb+WNWyOJnE7bIZM
         g9AxNRzDoUfMiyXwebinj/Y+kMhW+eAjg/sYsWP1EwkRqp08Etw4aCeSnMQJYqkj8iww
         YEUNATCvj8+DzqUHJlHumprUKjnT7bQgPN4Ws3OOv6BJzSTwwN1b6Hx6SZKdvDD6gMeb
         QKwSTau1eWzLiqgQyRrJp1QRypKyGiAEeiB7mJhR94Lf8gkCL0b5ZA/0YMfWIRZIRzJh
         Vr/nSCUTcfv/Xo+K0LMEh6P7ZLi4MvDo3tk2hD6L1lWDQTB0gktOP+uH06Fm8/34CV37
         dldQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gRkYXRRWU+MJKFUoTWQ1aVKdyHPeViwNia0ZJBTqx6A=;
        b=EG23Bn+IHJWNjSbwFK5Cy4Zhp9DjlSuZ2Lkj/E6aVg7FLOaC4ziJHjRyM80ptCSaPD
         tHzdf7NfsPxDGMd0fJt8WpA7yg0coUNedKC7SAgyYqAaS7N6236rDbDFDnlVTtNe0BUL
         Z5fzqKe+QetdRW6ERTmk0rA6PCn2VfM/L3NrLyPE5QDhhWc63UwCEzIuuyyb+gq7qZfz
         PS6szfcIvB+6bY0RSNSX34ccHFa/FJWVV1vGuYuRKxjkUZyh4HwqyCIaKJuYM+PVChM6
         xzuMkWXlIqXknWmXwoxQBjS4g8fVV20dn9OAckqAzuytiWOd5AjxFkg/UyD5CVga+Anb
         xmGQ==
X-Gm-Message-State: APzg51Dcn7w2gzZ3Mpf5Ib3uDCrRSXyWWCQP2fUHk+lcM9SloUGayKz3
        297PwJRFDGcORCQ9F+Ma5TYR8A==
X-Google-Smtp-Source: ANB0VdZZZNZ5WkeOcoUsdgB+cRTxoVGYSpN5ey7YRQGZ6aRGt5Aw6xW5/rvKBrEcVfrVrj/4NYsuXw==
X-Received: by 2002:a6b:1505:: with SMTP id 5-v6mr2062333iov.56.1535131036026;
        Fri, 24 Aug 2018 10:17:16 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id v5-v6sm2791916ioe.61.2018.08.24.10.17.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Aug 2018 10:17:14 -0700 (PDT)
Subject: Re: [PATCH] blk-wbt: get back the missed wakeup from __wbt_done
To:     Eduardo Valentin <eduval@amazon.com>
Cc:     "jianchao.wang" <jianchao.w.wang@oracle.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anchal Agarwal <anchalag@amazon.com>,
        Frank van der Linden <fllinden@amazon.com>
References: <1535029718-17259-1-git-send-email-jianchao.w.wang@oracle.com>
 <809b2243-7a76-3d8a-5d1b-b6b9d9712f41@kernel.dk>
 <d28bca3a-196d-1520-35cf-bec1e1872d34@oracle.com>
 <1f2d5ab0-2322-56b7-3544-3cf733a22dd8@kernel.dk>
 <2f83f994-2734-17b2-3c74-b6869ba18184@kernel.dk>
 <20180824171439.GA12587@u40b0340c692b58f6553c.ant.amazon.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <40137009-76ed-d48b-758e-d09283305fb7@kernel.dk>
Date:   Fri, 24 Aug 2018 11:17:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180824171439.GA12587@u40b0340c692b58f6553c.ant.amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/18 11:14 AM, Eduardo Valentin wrote:
>> +	if (lock) {
>> +		spin_unlock_irq(lock);
>> +		io_schedule();
>> +		spin_lock_irq(lock);
>> +	} else
>> +		io_schedule();
> 
> Nitpick but, shouldn't this look like:
> 
> +	if (lock) {
> +		spin_unlock_irq(lock);
> +		io_schedule();
> +		spin_lock_irq(lock);
> +	} else {
> +		io_schedule();
> +	}

Depends on who you ask... I prefer the former.

> And another random though, it would be good to have some sort of
> tracing of this.

wbt does have tracing, but we've never had tracing on the sleep/wakeup
parts. But that's pretty much completely orthogonal to the issue, that
should be done as a separate patch, if useful.

BTW, I've now tested this and it seems to work fine for me.

-- 
Jens Axboe

