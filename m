Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9400C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72E71206BB
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hYXtK9Zl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72E71206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbeIJMYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 08:24:52 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45330 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727695AbeIJMYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 08:24:52 -0400
Received: by mail-wr1-f66.google.com with SMTP id 20-v6so20704264wrb.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 00:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=K1BwdsWG2TSk7pkeDKq5qPR33FfXQX6y4y5RQS/I9J0=;
        b=hYXtK9Zl9kl1UkbQVOXoPnK1dFhhjv8H6JHOs0ddVJcXHpYahTG3whlw0eTUZ5DJHa
         ysvEEZMSub7oFG9OEEGjB8n2i2yoK6dYT3OMus09hDiygTHeDY5/Jjo+l2Rwe3Pm3SPS
         PFORrKWvXKg4to5I+AGAzmeFXDoYWXy1BzJZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K1BwdsWG2TSk7pkeDKq5qPR33FfXQX6y4y5RQS/I9J0=;
        b=itjfAJRIf4qveM3aXWYSpWqNR0PHBOVOw+Ah9MZBTckKrsMmS9b28FV/KiEFw7OHkh
         3RxEInf8ojMK7c0ga2WXPCOkwCrnX4s1WbLASRAVeoS86OLS/M5CCIcHzxJlAnRwVPc4
         tGlPtWo6v9wEv8lNTAxTgFQTSqBE1EcfV0NU3LXGQbhgrM4iLfZpmkGrpHdM+v6/1m80
         dfchI4mZ/NcPSlrf8fCNJ+32Dg1PcU5My830xvXA2w1JiOKxUUAA5PObGVvFEGLfM4l7
         gJj5+M3jhfrZn04mCF1yG0QcoDiaSNeAWU/v4ufM5Vb3JftEcZn/d7453r+PqjVJqq2U
         TvJw==
X-Gm-Message-State: APzg51An+gbWE11VIf3902VmSRLADfpfSoZ/ytXMddEefqfc0Ccg9poE
        IOwkO6Pbc9LAiGsgGTjq2iy66w==
X-Google-Smtp-Source: ANB0Vda+rSSYDfauCyP2UinNXT4qNHnDWsATex0lqj+ZiD+SUnU27kE3JMVgwXZLCehj5DH3JXGNcw==
X-Received: by 2002:a5d:4cc8:: with SMTP id c8-v6mr14347391wrt.210.1536564731229;
        Mon, 10 Sep 2018 00:32:11 -0700 (PDT)
Received: from [192.168.0.18] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id f6-v6sm16617454wrr.68.2018.09.10.00.32.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 00:32:10 -0700 (PDT)
Subject: Re: [PATCH v2 01/16] nvmem: remove unused APIs
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        "David S . Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        David Lechner <david@lechnology.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, Alban Bedel <albeu@free.fr>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20180907100750.14564-1-brgl@bgdev.pl>
 <20180907100750.14564-2-brgl@bgdev.pl>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <c0b0c411-65f6-62f9-6d6d-2884e5a17250@linaro.org>
Date:   Mon, 10 Sep 2018 08:32:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180907100750.14564-2-brgl@bgdev.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/09/18 11:07, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Remove all APIs dealing with nvmem_cell_info. There are no users and
> this part of the subsystem will be reworked.
> 
> This patch temprarily disables support for non-DT users.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>   drivers/nvmem/core.c           | 212 ++-------------------------------
>   include/linux/nvmem-consumer.h |  26 ----
>   include/linux/nvmem-provider.h |  13 --
>   3 files changed, 12 insertions(+), 239 deletions(-)

This looks totally un-necessary, Other patches in this series adds them 
back.. Consider updating these in those respective patches.!



-srini
