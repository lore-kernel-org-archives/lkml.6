Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_DBL_ABUSE_MALW autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F5D3C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AC6620867
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bxs4XHPX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AC6620867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731109AbeITWdW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 18:33:22 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37231 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbeITWdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 18:33:22 -0400
Received: by mail-pg1-f196.google.com with SMTP id 2-v6so4709117pgo.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 09:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4sF7YlJC4fYWgII/0k7DZ1sn29lkoXrp7mBq9adGUx8=;
        b=bxs4XHPXOkY6AjMkmwmRQqarBu8shKucrwaFb24mPGAMzguw85yxQpnDO8sXhK8u2a
         r6sy3uS6yGLmx5gXhwj8Q3Mymti489v7C1Iwtt6oFm4IABCoa7o/MlZGe0vr+t7vKfeZ
         vbRxKz5+V8J4/5WrTAzj7MJYivTb+o38wyPcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4sF7YlJC4fYWgII/0k7DZ1sn29lkoXrp7mBq9adGUx8=;
        b=SBfZlg++Ht+yukuwoU0Uf3pC3UmiT5XjvoE7NJSUWD3qydr9KgRKUljX7KxSM+h9Fm
         q75xMctQHCIgkmb+ZKkbqypivZXRKM0PbYs7ZBPHaucixtpx90SZasjZ4fH1EjbI/Oko
         oAEfYVGq4XwjqzfBZBCjDRWo0bEsPLWbnbAv4RJBDXImwlG/y+e1Wfk5kmgxry9Qnl3A
         qMMq49g7CiZYMOMZ3j0mHZ3K3QXx9u5TIWQ7vugVnJdpsUQq+zFMlfkaxV0/rCCt02cE
         2iBUHHw3Gr+DNyM2qEZe/V+C9Kj7zycctwBibrxyLQQ8c6mOSjGQ2pAMiRmQKsxzemYR
         2dwA==
X-Gm-Message-State: APzg51Ctr3bOrlijd8kyfAF3lQIpRL+2SFLubIYvIOJ1jVhNDAcKZMSH
        mhB09DgB7NR7uuw30mLhKoku3g==
X-Google-Smtp-Source: ANB0VdaQK/ACpuGMKA2LVYnXaisj4YIIhkPEbJT3dVR9QyQRQnLTK/XGMFsaxc5wgXstls+6U96ADw==
X-Received: by 2002:a63:165f:: with SMTP id 31-v6mr16781439pgw.103.1537462139272;
        Thu, 20 Sep 2018 09:48:59 -0700 (PDT)
Received: from [10.21.2.196] ([209.121.128.187])
        by smtp.googlemail.com with ESMTPSA id d22-v6sm60043211pfm.48.2018.09.20.09.48.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 09:48:58 -0700 (PDT)
Subject: Re: [RESEND PATCH v3 0/3] sh: make early_platform code
 SuperH-specific
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        David Lechner <david@lechnology.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Peter Rosin <peda@axentia.se>, Jiri Slaby <jslaby@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Johan Hovold <johan@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>
References: <20180827090651.25062-1-brgl@bgdev.pl>
 <CAMRc=McWre+5PRuozF69YKONvzy4X31=MzZim-QjhaAZ9iAVTw@mail.gmail.com>
 <9963d3f3-ba14-0d18-d669-53fc79b783c2@linaro.org>
 <CAMRc=MeC8gwEpjNf5AEX4oocHYv8c_CJXkCDMM9CQvaqxrbdXQ@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <0622b4da-20d3-5f05-5774-85c1dbabe00e@linaro.org>
Date:   Thu, 20 Sep 2018 18:48:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAMRc=MeC8gwEpjNf5AEX4oocHYv8c_CJXkCDMM9CQvaqxrbdXQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/2018 18:19, Bartosz Golaszewski wrote:
> 2018-09-20 18:09 GMT+02:00 Daniel Lezcano <daniel.lezcano@linaro.org>:
>> On 20/09/2018 15:00, Bartosz Golaszewski wrote:
>>
>> [ ... ]
>>
>>> Ping for 4.20. This is the third release cycle I'm trying to get this
>>> merged and there never were any objections.
>>
>> Thanks for the heads up, it is in the pipe.
>>
> 
> I guess you mean only the clocksource patch?


I meant it is in the pipe of things to review :)


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

