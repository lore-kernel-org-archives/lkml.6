Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD10C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50B5B2086C
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:16:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="va8SpPi5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729464AbfAaPQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 10:16:41 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41564 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbfAaPQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 10:16:41 -0500
Received: by mail-lj1-f194.google.com with SMTP id k15-v6so2982999ljc.8;
        Thu, 31 Jan 2019 07:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=g2Bddw9yWGmXhFqz/7OEXh1b72pF6L3F5FhPW/3Gc6s=;
        b=va8SpPi5jIw1gDmJWbSDlmWtPmvQ4OyEHSbss3ud7DJYxhTKxQ5t8cKY28SZrXknb2
         JjvCly82ecf0/D4q2816fxxQfEiY33zbEPPo2gLTCvS1lq1j5s565TQ06+VCus6LpGGn
         8H92j2PIQUzhm3ulPkh7RAy774YO8FQ0weEvBFn0452FncLyVCOEE/+5fTVThu/cOIyf
         w1mtGqo1SZhvlYnTLMXwaxw03F5akSD5iUYtkQfoTgZCQ+/7qMfFi0XMijAhB3YWgrP6
         5usLi50tvSR8wEIT40z7SHeBIQIv7h44bcI5T6etvWj5H2qHsTY3xnPnBOp/i7Txn/xt
         X/DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g2Bddw9yWGmXhFqz/7OEXh1b72pF6L3F5FhPW/3Gc6s=;
        b=HjUc3L4S7j5gAue3YpTqOPV0EibE/h2jhLvMZa8tAIR69hv2E5rjHxrS95KXvltkFk
         FL7SgJGcPGmtgZCKikrV9/YTAwRbIRTSqVMzBJww0gC//sraz+jUb57iYIoEm8Wd/U/7
         Pz+laB9Jd7aVMreWeDCgKUf9jBeKORY/RqSFe/26lvUnsug1nuFmdhEVSpzjwMKms/q5
         4TMzxoYTxwgouPcWHf97UeiTWrCYtrOvQEZfENbIF20ok28kO7vS/Aqse74mV30ZK3v/
         qWPC5ij+4mQ9KoMxWl1wnknu41X1OtgOOhEkDGK6HHEH6D/ssJPIpLIrJVWNW6AhYicJ
         ORtQ==
X-Gm-Message-State: AJcUukfMNc92kEjuOVI98dsoLEgAJM3qFFvAjqXsCKPHgzuyC40v+ijf
        ddF6N4hlKLXezwa05SAPXYdsDJ1l
X-Google-Smtp-Source: ALg8bN5Ywi9qWSO1NiN83R12MyxkyBFZER50ni4BuMH6z8x3vAsons15IIwes1ECi6qOhmUTeUydlA==
X-Received: by 2002:a2e:681a:: with SMTP id c26-v6mr28122170lja.175.1548947798135;
        Thu, 31 Jan 2019 07:16:38 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id p77-v6sm927119lja.0.2019.01.31.07.16.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 07:16:37 -0800 (PST)
Subject: Re: [PATCH V8 2/5] i2c: tegra: Add Bus Clear Master Support
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        mkarthik@nvidia.com, smohammed@nvidia.com, talho@nvidia.com
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org
References: <1548915387-28826-1-git-send-email-skomatineni@nvidia.com>
 <1548915387-28826-2-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <5aacf5c7-13bb-c8ae-d8f2-259b0c3f3c81@gmail.com>
Date:   Thu, 31 Jan 2019 18:16:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1548915387-28826-2-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

31.01.2019 9:16, Sowjanya Komatineni пишет:
> Bus clear feature of tegra i2c controller helps to recover from
> bus hang when i2c master loses the bus arbitration due to the
> slave device holding SDA LOW continuously for some unknown reasons.
> 
> Per I2C specification, the device that held the bus LOW should
> release it within 9 clock pulses.
> 
> During bus clear operation, Tegra I2C controller sends 9 clock
> pulses and terminates the transaction with STOP condition.
> Upon successful bus clear operation, bus goes to idle state and
> driver retries the transaction.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  [V5/V6/V7/V8]: Same as V4
>  [V4]: Added I2C Bus Clear support patch to this version of series.
> 
 
I haven't checked all of the bits in this patch, but at least -EAGAIN should work as expected on older Tegra's:

Reviewed-by: Dmitry Osipenko <digetx@gmail.com> 
