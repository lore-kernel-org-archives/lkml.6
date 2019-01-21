Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C51FC619C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 19:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 343CF20823
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 19:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTGtSAiX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbfAUTiT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 14:38:19 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36749 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727580AbfAUTiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 14:38:19 -0500
Received: by mail-lf1-f67.google.com with SMTP id a16so16329338lfg.3;
        Mon, 21 Jan 2019 11:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=K45KNT2BXKPdOXBvmDl4VEhz8izFu4wrl7totuxIN7Q=;
        b=aTGtSAiXCdtT0n76417Pa2o2buTER4gnAYb3uc5P31uAjB9DSgC25pnL8vwhzX7UBP
         jS+pbjYNmtRTASt3CnEWGMqDTKbRxz4ktMMiCC7+c2rH+bb/c4P9IpMu6Jjv0TJgpY2q
         grQ766Eb7l8TmBCZnVYspPDSU3CIEhm/tKz4HM/vGihnEVmQj9drduvhP15iL3Ukalwc
         VkaJ8JpYbcVT6iNyuQsegKjRpJoMl3/BvhcVua2C1uXpOaNTwX4uPAk8x8F8I09J+mQ2
         lLOJlrabM5moe6F8D1+hfTPsps3Y44WWvLXJZlpO+IDz1qa7NvT9s5jqK7aNRpE1+Mig
         5L6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K45KNT2BXKPdOXBvmDl4VEhz8izFu4wrl7totuxIN7Q=;
        b=rRdNNvpFdMv6ebh0KhIxhMR1ZdD8HP2LmUfnmKJmP89ioGAoHmzB1LpKoqu1w0zgIg
         Wr3sMOTxxaEJvoU4pHjk/uern68D02/VxmVEJuNUbe7QYy08vqSaFUatXwHDDwMLpEyo
         y4Cj2XjEgCQ58HFjpHKGf3CHVswS1JwAtCv+1EGLRfWVJC75bHUI0WDll8kmQ00a7FSS
         rUMx0NwB1jg36djTX4AxFlMVli2CoeQfu7tWbS+o+VC4yv3J2IHYj5S+j3S+fB00n/60
         P5Zq7V8abUbSo4MwB6Q6rvWonCrGMPgzoXbh5PqSwp8dwNL+yQ75iFr4TIB30ogl8c2e
         VdOw==
X-Gm-Message-State: AJcUukclHZGlNNfCw86QHf4pwdnLLAPvsI54MpyTQi9CkdaMS3PhtY+W
        ZT33/mwWUYU/ZVuEZzc2Sk4=
X-Google-Smtp-Source: ALg8bN5YvmcwnK4D3EL7oy568H8KZAWJanqK4TaxIGlD+2/Ke3hwop8IWVM3tkSFYXWIbqKtqo0zuw==
X-Received: by 2002:a19:aace:: with SMTP id t197mr18577449lfe.7.1548099496355;
        Mon, 21 Jan 2019 11:38:16 -0800 (PST)
Received: from [192.168.1.18] (dqe155.neoplus.adsl.tpnet.pl. [83.24.164.155])
        by smtp.gmail.com with ESMTPSA id s17sm2672918lfk.9.2019.01.21.11.38.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 11:38:15 -0800 (PST)
Subject: Re: RGB LED class Re: [PATCH v2 2/2] leds: lp50xx: Add the LP50XX
 family of the RGB LED driver
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Dan Murphy <dmurphy@ti.com>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dachaac@gmail.com, robh+dt@kernel.org
References: <20190114211723.11186-1-dmurphy@ti.com>
 <20190114211723.11186-2-dmurphy@ti.com>
 <ce911fdf-c7c2-63e8-5c7a-b0be965ab69b@gmail.com> <20190115222223.GA17363@amd>
 <79394d17-3124-75b2-ccac-dc1046499d14@ti.com> <20190116105537.GA1803@amd>
 <86299268-3202-814a-134b-04bd2170faab@ti.com>
 <8dfa2854-2814-6874-ab8e-1858e9a18acf@gmail.com> <20190118000235.GB27661@amd>
 <61fa89eb-c12e-8f9c-9457-9d6d17ba7717@gmail.com> <20190119213629.GA3654@amd>
 <9d2e0220-69f0-faaa-adb9-13d905f9c51d@gmail.com>
Message-ID: <e03a96ea-6597-936e-59e0-a9cd7df30525@gmail.com>
Date:   Mon, 21 Jan 2019 20:38:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <9d2e0220-69f0-faaa-adb9-13d905f9c51d@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/20/19 4:30 PM, Jacek Anaszewski wrote:
> On 1/19/19 10:36 PM, Pavel Machek wrote:
>> Hi!
[...]
>> I want to make sure userspace understands this has linear relation to
>> output power. I'd like to avoid mentioning color because there power
>> output is not linear with "RGB"
>>
>>> s/pwm/color/
>>
>> s/pwm/power/ would work for me.
> 
> Power implies physical units. I'd prefer "intensity".

Hmm, intensity_channels does not look too informative...

OK, so let's stick to power_channels, at least for time being.
Maybe some better ideas will have appeared before the final
solution is merged.

-- 
Best regards,
Jacek Anaszewski
