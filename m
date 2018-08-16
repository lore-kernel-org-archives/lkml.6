Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1AC0C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 19:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A14CE2147A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 19:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="zUNDbP4m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A14CE2147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726288AbeHPWMI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 18:12:08 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:41516 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbeHPWMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 18:12:07 -0400
Received: by mail-io0-f196.google.com with SMTP id q4-v6so4770992iob.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 12:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JC+UVoXhXaaYQ+xpSZnODh+SvO+nh4B1OD/uPQfQhgA=;
        b=zUNDbP4merDmu13RdbWKCH+MoVdZmapy/I819/Zqv2iP6bVj8Bl/9kAotd1jsXw28z
         E6qTsNSypNYFqzQ+tWH0GQ9PlZAc68STot4t1n/QtIAZOyUfXd7ViHjeSMNJARIBZvuu
         XEzH854moqrxdd1RvoEC0fkhi0qAqt7cYr6YGwrTUxV14sskPrIGT3IL10xEQONGP2aH
         /iDMMsfhJ+fynvxK4IUTy8kcO+ZLR4/adJ5R0n/UbRsH8w8pO+K960jsr0dKQKTE2Unt
         f/UIMTQCGko/v8DE9lJyWs6WJN60jxffdUeYeaKRDNVlAj6PjWgsItVWj46ZxvAL82mq
         xrIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JC+UVoXhXaaYQ+xpSZnODh+SvO+nh4B1OD/uPQfQhgA=;
        b=Blqf1/s428fk+aia7aedwumskQw3lL2MPyGDdWC++jzlI5QdWEPpismkeqZ5TGrFwS
         s+yVIUfNJZZMIDsdUXEKQRd75rP4/KkiL4W0TgS+/MNowylLrvWxw5kBkmjUVimBRkWp
         QHGOEn1+EtG2Cm1bg6TaKwTCFdtQVjB2Zti/yKKpwNqCrvh27YJBu7mGtSUZTDXkHHdg
         nmPZKPH2c/HfgtBSwInhd7b8YXDTJzBMPozRmTf5Hmvi+uyguK7CbbsWxJhjJkvX4Gzu
         nKWzlcEV3S28dC6yyTPqrAQnsXDpFKoTwk46cUHM8BAEsi6TevjfeUjaPnlM+3rrd+f2
         tmKg==
X-Gm-Message-State: AOUpUlGF3KCfGZ/zHGm/ZsVFg70mrXdkIu/9qz5oeIdZa4vAq89cOlmV
        EFbprGPi7n7tPqW7ZM331mMPlw==
X-Google-Smtp-Source: ANB0VdZEnsVeKISnJ+RZCFhqJpsAV/zEyZRNqQHkdBAIo0Op9gmJ9nsBtyh3kwWmR/cHI2w5iNUmbA==
X-Received: by 2002:a6b:249:: with SMTP id 70-v6mr978206ioc.123.1534446711720;
        Thu, 16 Aug 2018 12:11:51 -0700 (PDT)
Received: from [192.168.1.212] (107.191.0.158.static.utbb.net. [107.191.0.158])
        by smtp.gmail.com with ESMTPSA id z195-v6sm61732ioe.38.2018.08.16.12.11.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Aug 2018 12:11:50 -0700 (PDT)
Subject: Re: [PATCH] block, bfq: return nbytes and not zero from struct cftype
 .write() method
To:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        Paolo Valente <paolo.valente@linaro.org>
Cc:     linux-block@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Arianna Avanzini <avanzini.arianna@gmail.com>
References: <f574e019-00f2-96c3-fc32-541c6584ca96@maciej.szmigiero.name>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <19c68f93-017d-cda1-632f-039ca3ca0158@kernel.dk>
Date:   Thu, 16 Aug 2018 13:11:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <f574e019-00f2-96c3-fc32-541c6584ca96@maciej.szmigiero.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/15/18 3:56 PM, Maciej S. Szmigiero wrote:
> The value that struct cftype .write() method returns is then directly
> returned to userspace as the value returned by write() syscall, so it
> should be the number of bytes actually written (or consumed) and not zero.
> 
> Returning zero from write() syscall makes programs like /bin/echo or bash
> spin.

Applied, thanks.

Just a heads-up that gmail thinks your email is spam.

-- 
Jens Axboe

