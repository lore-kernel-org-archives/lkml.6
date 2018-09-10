Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1040BC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD50D20866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jSXTqMPV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD50D20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbeIJMrc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 08:47:32 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34956 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbeIJMrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 08:47:31 -0400
Received: by mail-wm0-f65.google.com with SMTP id o18-v6so20386034wmc.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 00:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6A1tFdCVNhN8Bf2/8522/65gR4zta7XMrZct/IY0Pz4=;
        b=jSXTqMPVGWLDSwtMYEP1nhs+6xm2vp1ZO7ReLIW7svi7YZeGikVoxE0uyfY3xupnxw
         6FuoPGGEpQ7q1Bs3uxCXZQD2B57M9r6xbi6bh86wzFDmDQuoUFVn0GhF7J0r/MEov1VC
         iGyHn0z4tRTHzIhtyMa7DJ6I2yamvVJFBikGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6A1tFdCVNhN8Bf2/8522/65gR4zta7XMrZct/IY0Pz4=;
        b=AMetCENeaHwhbMSiNciMaPzCYkdIdoNSD7oRDPtG6K+kX1hiawTAA36WVmnxBRrnjL
         wLsicGNj6UenyUwbAoFN+X9Dkp9NtbRqQvqkg/8xp1dLZ9tlSvs4IJUsQMSNHIMsFvq2
         cLzAH6sYkjzzrQzxbGeb7wjK4kAkpwMKBRWeJ1XaKPmqnxycROva0D9WxPgNpraKkpbF
         CE82ZfEgkuoeaVre6jyIXGwavXbUQrVoTFGFuQ5BzxQtg8ll6eu/maE8caW4OJaSu102
         ExIFx/cxWM0NZ9+fGROP/q4rtRw0pBGAnFS2WJfCyDyl8lgAIxwBMfZioCDaRCxzL+Y2
         nJbA==
X-Gm-Message-State: APzg51Cl9y+BhJTy+6LLV0fmT2fWfOTx8WVmMDML0yY4p5evwC9Q9aUc
        kzE8UC+yLH1KQ+msbG5L06bfDQ==
X-Google-Smtp-Source: ANB0VdbIbyB0UdmjyYb/7pmIjhAWVuuEORSjXyvrisvJjLZ/3hcu8YQQGxr8CXrMoFoUS2VvWaRTgA==
X-Received: by 2002:a1c:3545:: with SMTP id c66-v6mr12319942wma.120.1536566085688;
        Mon, 10 Sep 2018 00:54:45 -0700 (PDT)
Received: from [192.168.0.18] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id d22-v6sm35578030wra.80.2018.09.10.00.54.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 00:54:45 -0700 (PDT)
Subject: Re: [PATCH v2 00/16] nvmem: rework of the subsystem for non-DT users
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
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <da9556fd-0022-8e6a-12b4-cc3babbae5b0@linaro.org>
Date:   Mon, 10 Sep 2018 08:54:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180907100750.14564-1-brgl@bgdev.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/09/18 11:07, Bartosz Golaszewski wrote:
> Next three patches improve the framework by adding a notifier chain
> for future use and fixing the issue with nvmem device names.
> 
> Finally we add support for cell definitions, cell lookups and make
> DT systems resolve the nvmem cells during provider's registration.
> 
> Last patches just use the SPDX license identifiers and make the
> naming convention for some arguments more consistent.
Please send separate series for fixes and things that do not depend on 
this new apis or Order/place them at the end of the series.

This can help reviewer when there is large number of patches in series 
with unrelated subject.

-s-rini


