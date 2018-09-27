Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF6ACC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A2BF21547
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aDrBj2HX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A2BF21547
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbeI0VGx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 17:06:53 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]:38614 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727199AbeI0VGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 17:06:53 -0400
Received: by mail-wm1-f46.google.com with SMTP id z16-v6so6284859wmi.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 07:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=eRTLY5Yx7x5cRvL/8fy2/lYPeIFGs01AgY9JRkmBGVs=;
        b=aDrBj2HXLVtWbZ5ESPdxiZTgb0B+v4reTWoEaNuVTCdMFZ6UrQLZCoQwSXoPAbCRmo
         eGOXL6yhAiPtrNsYY24JC0pRxFc+TYjertXe1YqZ7b8aDxinIKX5An+SxhtCxw+EQzxe
         OlQwQ1uZc8U1lEKPi5noXqSD9EzfKdJM9lUPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=eRTLY5Yx7x5cRvL/8fy2/lYPeIFGs01AgY9JRkmBGVs=;
        b=uHzbaT5ZBLBxVnOkax0/ehu7CddFd2zoAo8hU0dkaFBSdAdZ8i6CgUhht3vc4ZMjur
         0GFirY1gK8mPC2l7/UJHmDWtxyMZD6OcV/8v4v7GHz8igjKOR8GsDm8DwNfS+hb13kgc
         o5H+U3QKE8CcfDWOextmbAc6TzgW3kEaVhQ1YQyWVtw/jwzA36QQs6H0FPOXKvcD4iy3
         EDuPLPGR/v5qQpNuCjZ4Ut+z7KamjLc/OkouXIIW8N25xym2EPqG6RPYlkcZzcvoQyBz
         ZWdb99U5QrCr/Re3NnMbjgxICgnCD/UPIZ8UIy+rKxFPljOHF/Wir9pO78bV0tTesG+o
         2lMA==
X-Gm-Message-State: ABuFfojG1sCek1ntzjXXP9Xp3lBac5dvfcPwSOQGrnm8R6LOkic4oGN9
        5h5iv4J28JK8vKhxucHvflpeuw==
X-Google-Smtp-Source: ACcGV63LhYyZTPMWgEW142byICZW2Acv/rtpKP2dvxt8cgGMZBsJzyfEbLzl/v2TKO23QOWpsSTkuA==
X-Received: by 2002:a1c:8682:: with SMTP id i124-v6mr7886430wmd.77.1538059694876;
        Thu, 27 Sep 2018 07:48:14 -0700 (PDT)
Received: from [192.168.0.41] (30.216.136.77.rev.sfr.net. [77.136.216.30])
        by smtp.googlemail.com with ESMTPSA id b22-v6sm2622695wme.48.2018.09.27.07.48.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 07:48:13 -0700 (PDT)
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] clocksource 4.19 fix-2
Message-ID: <ea561d6f-22f8-b1f7-a063-d559900a9004@linaro.org>
Date:   Thu, 27 Sep 2018 16:48:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Thomas,

I miss this patch since 4.17, I thought it went through tip/timers/urgent.

 - Fix smatch potential leak report (Alexandre Belloni)

Thanks

  -- Daniel


The following changes since commit 4451d3f59f2a6f95e5d205c2d04ea072955d080d:

  clocksource/drivers/fttmr010: Fix set_next_event handler (2018-09-24
06:13:31 +0200)

are available in the git repository at:

  https://git.linaro.org/people/daniel.lezcano/linux.git
clockevents/4.19-fixes

for you to fetch changes up to 52bf4a900d9cede3eb14982d0f2c5e6db6d97cc3:

  clocksource/drivers/timer-atmel-pit: Properly handle error cases
(2018-09-27 12:01:45 +0200)

----------------------------------------------------------------
Alexandre Belloni (1):
      clocksource/drivers/timer-atmel-pit: Properly handle error cases

 drivers/clocksource/timer-atmel-pit.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

