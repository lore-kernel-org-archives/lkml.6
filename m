Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B05EC3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 21:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B070420857
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 21:15:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dkSHfsQM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B070420857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933317AbeGHVP2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 17:15:28 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39257 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933148AbeGHVP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 17:15:26 -0400
Received: by mail-wr1-f66.google.com with SMTP id h10-v6so8908660wre.6
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jul 2018 14:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=u4iDFOBdH/xGuGM0j4jxCyd+6vGT20VEAbJiL7ijdvo=;
        b=dkSHfsQMQL5xzV7VK3sSdG/nU4XuqCDrgTGyqYWs0XjB6I8Y5l93fUlwRsDjhEyyXN
         176H2rllkM+Z2/xo0Vy1SrsDDzT/b/0nQcLE2j3Ricam9qYGvxQte37r6pzo8uof3IgT
         SqL8RoU793xVABsyPcTZ11ArBdGnhe+8ir8j0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u4iDFOBdH/xGuGM0j4jxCyd+6vGT20VEAbJiL7ijdvo=;
        b=jJ8N4H+tsiOzufjaSDh7lznonEqBXV00UEDku84yXtYwklaplsMBLzMZIxx7SkrXsx
         vx460MBmpAQr5NgLSGXLdgvZGY7ahu6730l0oas/+5PSLjg4P8Lm9fmjFBgKzACF0I0K
         HZXbdydas1e/WmfQk6t/3QbNHlWCoIZsMCk1M2bEMH3mUq78PgNao/DKx86k21cQDXgd
         AgLIM9Y31T6gPJegzUYuU10oloYZoXgoT7MxhwHxAeV8gXicwx35RMQEM7cil7CVF/0d
         bE61vq07018BjsPoGoDoiJCylp3wOjuHczDXqewbRvI2y0MwHkDMQHIdlXYNHHzZ9o69
         Tfag==
X-Gm-Message-State: APt69E0xKWIQX3VSOSr9HN83u9VOme6GZbRhBag+grgy+4S8vTnSfOut
        0CwD+N7ZowQlX33+L0F2xPcEzJlsKE8=
X-Google-Smtp-Source: AAOMgpdKpaPZN5rvKYAUyrmEUJ61IX5DJcLeUsqG5mXdVID9L1O4yfTE/WESrn/r43bqSDajBVWOdQ==
X-Received: by 2002:adf:a094:: with SMTP id m20-v6mr12512637wrm.125.1531084525131;
        Sun, 08 Jul 2018 14:15:25 -0700 (PDT)
Received: from ?IPv6:2001:41d0:fe90:b800:c46d:3743:7ce4:952b? ([2001:41d0:fe90:b800:c46d:3743:7ce4:952b])
        by smtp.googlemail.com with ESMTPSA id q17-v6sm16223808wrr.7.2018.07.08.14.15.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Jul 2018 14:15:24 -0700 (PDT)
Subject: Re: [PATCH] arm64: hikey960: update idle-states
To:     leo.yan@linaro.org, Vincent Guittot <vincent.guittot@linaro.org>
Cc:     xuwei5@hisilicon.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1530860246-29072-1-git-send-email-vincent.guittot@linaro.org>
 <20180708140157.GA28878@leoy-ThinkPad-X240s>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <948f033f-aef2-4d6c-170d-a1ff2113f258@linaro.org>
Date:   Sun, 8 Jul 2018 23:15:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180708140157.GA28878@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo,


On 08/07/2018 16:01, leo.yan@linaro.org wrote:

[ ... ]

>> A simple test with a task waking up every 11,111ms shows improvement:
> 
> Should s/11,111ms/11.111ms ?

Actually the French notation is ',' for decimal :)

English and French are inverted.

For example one million is noted:

French  : 1.000.000 (or 1 000 000)
English : 1,000,000

And one milli is noted:

French  : 0,001
English : 0.001

:)

  -- Daniel

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

