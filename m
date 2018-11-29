Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79FAC43610
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A990421479
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lh+KkjOW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A990421479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389461AbeK3Bh6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:37:58 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44578 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389434AbeK3Bh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:37:56 -0500
Received: by mail-wr1-f67.google.com with SMTP id z5so2106278wrt.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 06:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tHrKSnc7J5qK0yIWFzgy4Ix1kkOX9LQDjsBQSyxBRjg=;
        b=Lh+KkjOW332DXgkl/9gAxBUJYmxG0bDGu89sCapf8NeMVV4rCE7k06ZX89y46fQiUW
         UTXHDG1LPeGU0/tM37gTx5vX6sQvwdycT1fqdKmb4V1LmnBcEFuTgNcmjngThMjhXEs+
         C2cioifZniO/gQ6ua1uA8dYhAhiPsBfFaGx0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tHrKSnc7J5qK0yIWFzgy4Ix1kkOX9LQDjsBQSyxBRjg=;
        b=Z+BhJbwq1DaoS9bkPi2q5j1sEZ2Pfvf+En4HAgaw7bg0sOruEhNREJAeJGEcHSZp+k
         5/6AiiMHv2Oan/Wd+un9qE5z9Xpu9lzLY887rIKmty8lzH+oAexFUVrfUcBzVWlnFIsg
         AX/WZn2+h4tXJG0UXiYq0TN46BbiW1PA4SUCzSNkT9V2ll1wiUJCVDE104K/pklz3ME6
         9IfOvNAtWTI0RAtDuxahM23nhOkZrXez04696qaJCMWfynjlENSAd+RfBnoTrOGsQNug
         cIuQ+pavXg6ypXyKJMaNPagUa/gC2xahCVFato2Jr5F11f3rW4FSeZ4ThpWJfB6xmCul
         CZ1w==
X-Gm-Message-State: AA+aEWaUfN3cqUezt766Q+hFJPcHfxijSzc1VNHcVLgjiOfhFTImRHL5
        WLzAWnzYVs6UbtWikIDi3OvaKQ==
X-Google-Smtp-Source: AFSGD/WFv1BmOkoj/lK8MWTDcy58DXLkQEBeDogc1WvXULs7FLFrPxWkvd6gCK4HyDuardeFSeZ/iw==
X-Received: by 2002:adf:e18d:: with SMTP id k13mr1692981wri.36.1543501942012;
        Thu, 29 Nov 2018 06:32:22 -0800 (PST)
Received: from [192.168.86.29] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id e8-v6sm4816656wmf.22.2018.11.29.06.32.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 06:32:21 -0800 (PST)
Subject: Re: [PATCH v2 01/25] nvmem: add new config option
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        "open list:MEMORY TECHNOLOGY..." <linux-mtd@lists.infradead.org>,
        Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20181113140133.17385-1-brgl@bgdev.pl>
 <20181113140133.17385-2-brgl@bgdev.pl>
 <CAMRc=MeRJ60gcYz00C828PBqnEdC-9onOKOadfackdzHiC1WOA@mail.gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <b8f08722-d3d5-6ddf-5845-15eb5079094c@linaro.org>
Date:   Thu, 29 Nov 2018 14:32:20 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAMRc=MeRJ60gcYz00C828PBqnEdC-9onOKOadfackdzHiC1WOA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> Hi Srinivas,
> 
> if there are no objections - can you Ack this patch for Greg to pick
> up into char-misc?

Patch is fine for me. I normally send all the nvmem patches just before rc5.

--srini
> 
> Bart
> 
