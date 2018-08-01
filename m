Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B58C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 06:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FDBF20894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 06:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OP5RRBIe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FDBF20894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387501AbeHAIjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 04:39:14 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34037 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729769AbeHAIjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 04:39:14 -0400
Received: by mail-wm0-f65.google.com with SMTP id l2-v6so12961205wme.1;
        Tue, 31 Jul 2018 23:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NwrwcPx58+mEgOZArBazvzm27ZRT3n+zaP777BUUAuc=;
        b=OP5RRBIeft1UeGP3zUgaEIntAJhSAqy2QPys5kJITsdm1kT9txynOqSpWMQv510Rjw
         FqGoEHzwg6ep1zOmS9PMcPfHjX7Ba5M9hP7CqfeN1U/liuCcyecOt4XfDJ6ANjklqcoH
         CZgTJ32ntJuyeyJMXXMM46ge4nKRiJJ1dXrz/CjNGlQtXRnBimy6ds8XvkyalRs7wQwP
         t5Vy684ZM7bU5BO5G2ZeuAGNgbtivntIQao89i/AX8JR1qWUQCAthvV5slMbsmcPiuGR
         npmpCCXrp9RKGy9BVT837mB7eSaMbkGZmIcg3nURweg5TVtV7qAm2OIgYPQqWBXVvEJM
         X7eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NwrwcPx58+mEgOZArBazvzm27ZRT3n+zaP777BUUAuc=;
        b=a7Lfsd0AfeeOSHAdiYjsy0w7VKZb5Hl6YoROYg87beR6c+/i3fMchi1Nt700y8kete
         bidglV6nm5QEQYdBTFEmg1jOnHkStjIQmjlauwqS9cMNvggGy7boF5rqr+EKIp7aOlXf
         xxQnA3wAt4GjFVx+O11Qs/192k8IkZJAoCqUvKLtI57cYehWoDbOkkzxxAlmYYg4ZNuv
         VuP+3sOgjZgSz/VLd3B+UkHt2JR8vMdo0TBV7pyeY1mdIUNvXbZtwt1RUgwmI4uqg0G7
         2KSxppEFbbHmLXAlgcoA+iFOyoIpmR75jb/4xBKlH51JDZHA51f3YDeNYeuBCEOuDMf/
         51MA==
X-Gm-Message-State: AOUpUlFn5lcbqvGFoelJsBhIXW/00Z3TlD95ilx23Rq2AGjUI2pJ48k2
        9guxVQmBsOS3563PmMLBfMs=
X-Google-Smtp-Source: AAOMgpewxsOxdbSB125ty1f8CIVcscNKTUVxhXmQAR4vmOx9FKeye4NongzHdZxUl24q8yFFHdVDZQ==
X-Received: by 2002:a1c:7408:: with SMTP id p8-v6mr1724178wmc.118.1533106502610;
        Tue, 31 Jul 2018 23:55:02 -0700 (PDT)
Received: from [134.60.170.20] (eduroam170-020.wlan.uni-ulm.de. [134.60.170.20])
        by smtp.gmail.com with ESMTPSA id p25-v6sm2317533wmc.29.2018.07.31.23.55.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 23:55:02 -0700 (PDT)
Subject: Re: [PATCH v6 0/4] IR support for A83T
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     mchehab@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        wens@csie.org, linux@armlinux.org.uk, sean@mess.org,
        p.zabel@pengutronix.de, andi.shyti@samsung.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
References: <20180731092258.2279-1-embed3d@gmail.com>
 <20180731123452.74jyxc4q3ewig35z@flea>
From:   Philipp Rossak <embed3d@gmail.com>
Message-ID: <92b74230-285e-74c3-c89a-e194a8eabc52@gmail.com>
Date:   Wed, 1 Aug 2018 08:55:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180731123452.74jyxc4q3ewig35z@flea>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,
I will fix this today.

Philipp

On 31.07.2018 14:34, Maxime Ripard wrote:
> On Tue, Jul 31, 2018 at 11:22:54AM +0200, Philipp Rossak wrote:
>> This patch series adds support for the sunxi A83T ir module and enhances
>> the sunxi-ir driver. Right now the base clock frequency for the ir driver
>> is a hard coded define and is set to 8 MHz.
>> This works for the most common ir receivers. On the Sinovoip Bananapi M3
>> the ir receiver needs, a 3 MHz base clock frequency to work without
>> problems with this driver.
>>
>> This patch series adds support for an optinal property that makes it able
>> to override the default base clock frequency and enables the ir interface
>> on the a83t and the Bananapi M3.
> 
> Once the minor comment on patch 2 has been fixed,
> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
> 
> Maxime
> 
