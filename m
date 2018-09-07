Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C57CEC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73FD92075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="wfrJ5bR3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73FD92075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbeIGWQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 18:16:43 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:36507 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbeIGWQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 18:16:43 -0400
Received: by mail-it0-f67.google.com with SMTP id u13-v6so20870511iti.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 10:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IIVOPw0IT7dO2RNQN5S2lfVSdkqKlRPxxf7kzVHADsM=;
        b=wfrJ5bR3uRHTPfI9NLfLqTEZg7wuNlbzhwSVfbIUbYZjC4PVl7GbWT1CtAyFEucjAh
         Ftl6VavFNXiI8EbAxAOOiYc/WHoz9NK97Lw7IwPzkCzeul/lle/Nc0wuecH0Tw4gGo7z
         AyC2MfLLHqwXpMJ2/a8UVV7gPYVPCcMk02t5cG1amOdVmk6xa8Cs04AMYsEmzzKiKJYH
         czzo3hcZaFT3QYosTsNrXuMbS8ESxfww4123BjFJNIJWEoV4tmKy5ZdDbjIKfJU43iup
         FbIu/+60vHemSq+rLa+df7QNNznj9ScFc+djJ7+xSX9MGg16KB6QnV3Dn6UnPxDoTTRq
         45Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IIVOPw0IT7dO2RNQN5S2lfVSdkqKlRPxxf7kzVHADsM=;
        b=ud77UMiU8ON+GbJ9Kf5lULjpY3uQixQ/Iyk+mUEvpjC2cVylXcWdy50/Q+Ecaat7ex
         j10iMVH4GsZl2o+7ZDt3sLZD6wVgOJYyYAhWgRWW+/bPJb0y+iLDfLMntTZl9Vz9rpbo
         aj6KQpjYi/vlZUs0yWmTdCbp4vt7QuxSSnHJGv+n1kl5eCyPAXRyisd5mSqGka5fJbAW
         9vvk7k517qx5w9H3An8SUeCh76cEH6Ik4DixbbTrTHA8PMi8FTtRv9nE8VKWDTjWexLB
         pWX6njA1e7pT55DQ4r6fcPf4KWQXehB46cacGeaTMzHjfCdUUrjwhHqGEoeA4cGDJ/iS
         ks9w==
X-Gm-Message-State: APzg51AVSfz3BE787w56QApXggOV/NNlYWdcO3qESk7W/r74OsP+9w88
        V/eThZLWK3nabuffQngK265Y0H8WH7c=
X-Google-Smtp-Source: ANB0VdYGJVTn/hS4joix6l+u96RZ9MJJVpNdqEdLnr9Kfx30N3q82nuQoykvCKAK77Y5PRpT7/enzg==
X-Received: by 2002:a24:14d8:: with SMTP id 207-v6mr7600424itg.41.1536341684111;
        Fri, 07 Sep 2018 10:34:44 -0700 (PDT)
Received: from [192.168.1.212] (107.191.0.22.static.utbb.net. [107.191.0.22])
        by smtp.gmail.com with ESMTPSA id i2-v6sm2589500ioh.80.2018.09.07.10.34.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 10:34:42 -0700 (PDT)
Subject: Re: [PATCH] block: umem: replace spin_lock_bh with spin_lock in
 tasklet callback
To:     jun qian <hangdianqj@163.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180907172720.48621-1-hangdianqj@163.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <530bb11e-30a2-6088-913a-5edee1d5d63c@kernel.dk>
Date:   Fri, 7 Sep 2018 11:34:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180907172720.48621-1-hangdianqj@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/7/18 11:27 AM, jun qian wrote:
> As you are already in a tasklet, it is unnecessary to call spin_lock_bh.

Looks good to me, applied.

-- 
Jens Axboe

