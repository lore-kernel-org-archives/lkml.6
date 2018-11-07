Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2425C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 20:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A56FF20818
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 20:51:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LhB52KcJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A56FF20818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbeKHGXr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 01:23:47 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:32937 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbeKHGXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 01:23:46 -0500
Received: by mail-lf1-f67.google.com with SMTP id i26so12531852lfc.0;
        Wed, 07 Nov 2018 12:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JXE+oj1dK2zsJGBS6SPC0YF5lcXtCoHawI4SwCGgKPo=;
        b=LhB52KcJcvblFoN7sMHXMJ8nn0xcjGbNIuzapL2EvgCDgtZjEVbjCJw7l9GvuJtgEz
         Ha67zdSw2yg/XqQf5eI4qnMXsXtmT7h++Q7haSQkGbBj8SSazriuKF/xdrFLb6k0sfzZ
         8FNtGtQLjMPWPfNqncHvwEWdU+YUyYBrwkChnfT9UIXuZ6Z0JwMnjQ3Vjw/ADpWnGlhU
         YjXGR1IL60y7zRVLb4FUNAdJ3a1e5YJSTa4wfKLj9UktYF0w6L/WcEAKZVqJINYyxj3B
         mzDgPzylRlhxitIIelwu47ERWhVu8NAvZ0tDskiaiV+igexhosd4+785fuI7etF8vZC4
         eZTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JXE+oj1dK2zsJGBS6SPC0YF5lcXtCoHawI4SwCGgKPo=;
        b=HYfN3OXF6M1rxeQg2GecTpO2+S+igBbPJfHPFLOVrZn/LivBHxsrbEQnhIDjEgnWbu
         MEhM4MaPvxENjTjWYzcUrNNAm76q+U1VoOU9D8BjeAkXVoXBYlcVuhjLfqCxlLIulBTw
         4aMB0ic078wCOPGC0jLikglsQGLaBL2sxh1mm9OcdU8gwjvwpBYrbUU+BLaAM0wfNttR
         bXB9LICHKFM+0A7xWn5UkqxDu+CvY+YdTL/Pgd0Ep1Zx0BOuATYGnGUnJNjmuTy+5BiE
         SFP+BeZPTmR7o2m/HTJDpqQgjUROwIUqWfZI0lFQH2Vfu+64jYZ+BKQFJ428emJfFPyz
         5caQ==
X-Gm-Message-State: AGRZ1gIEsakWxPzhdPm4vbPirxX5XfSSyMjHAZrLa5+wp5c/Uw39to9u
        6AC9iGOXge4twHFBAoaOkAQ=
X-Google-Smtp-Source: AJdET5cKEVwpHiDh1GCxS4do+PQHkj4mLi6qqxKSv2DpAYt2eqVX1lidJVRyz/YchG9KsW7p3Oc0yw==
X-Received: by 2002:a19:914b:: with SMTP id y11mr1016480lfj.98.1541623899155;
        Wed, 07 Nov 2018 12:51:39 -0800 (PST)
Received: from [192.168.1.18] (dnl153.neoplus.adsl.tpnet.pl. [83.24.93.153])
        by smtp.gmail.com with ESMTPSA id k21-v6sm289842ljc.15.2018.11.07.12.51.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 12:51:38 -0800 (PST)
Subject: Re: [PATCH 01/24] leds: class: Improve LED and LED flash class
 registration API
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Linux LED Subsystem <linux-leds@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh@kernel.org>, Daniel Mack <daniel@zonque.org>,
        Dan Murphy <dmurphy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleh Kravchenko <oleg@kaa.org.ua>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Simon Shields <simon@lineageos.org>,
        Xiaotong Lu <xiaotong.lu@spreadtrum.com>
References: <1541542052-10081-1-git-send-email-jacek.anaszewski@gmail.com>
 <1541542052-10081-2-git-send-email-jacek.anaszewski@gmail.com>
 <CAMz4kuJrfCfe7xJptVU_EGa-GM0-pfMaH2xb8+BksEia9W=bEw@mail.gmail.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <92792704-1017-f2dc-1b2f-c2b0cf540b4f@gmail.com>
Date:   Wed, 7 Nov 2018 21:51:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAMz4kuJrfCfe7xJptVU_EGa-GM0-pfMaH2xb8+BksEia9W=bEw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolin,

Thanks for the review. Will address the remarks in a v2.

On 11/07/2018 07:55 AM, Baolin Wang wrote:
> Hi Jacek,
> 
> On 7 November 2018 at 06:07, Jacek Anaszewski
[...]
> 
> It can work well for SC27XX LED, FWIW you can add my tested tag.
> Tested-by: Baolin Wang <baolin.wang@linaro.org>
> 

-- 
Best regards,
Jacek Anaszewski
