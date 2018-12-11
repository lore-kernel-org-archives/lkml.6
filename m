Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6617CC67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 271BB2084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="DbZQIeBI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 271BB2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbeLKVl2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 16:41:28 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42541 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbeLKVl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 16:41:28 -0500
Received: by mail-pg1-f194.google.com with SMTP id d72so7252892pga.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 13:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=wLmfRRpGm8OQwzZMpIjCWXzWNSEb0sSFR83YS20A7ZU=;
        b=DbZQIeBI4bKM/Eqg5O8yvEv/qlQidA73+LIb5KiqyaFvU3k4eUvOf1ulljmvquESph
         zaSQapj6dvFTIeF3w96X1j2y6hO0lNCQZp5JdTkv6JoBqEHzeOZKqiMRUUk2hwGtUBlE
         6oOllnl1wqyYAr+mAWO/ehPo8xJu1Je6Z5mrE2Q6k0pfAR8sjGb1598/CM+2ZnEDYcPp
         ikukw1u1UZUHP9r0GZ9sGHr8iTVxMlk2OdP/M5YpNhm5BxBjc7fRLHvWhIZ6WLA+WmVz
         vPle+/qB8CY6qYBFsbz5uSzcrwqHZ/8g3bzK1HwFQ3/IPR/9S87CoVk+KD5uW+d5/hKY
         Eryg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=wLmfRRpGm8OQwzZMpIjCWXzWNSEb0sSFR83YS20A7ZU=;
        b=dTAxrYaiGcAJDX5bMqY96+Xf3ImHvOY6QUZt2O0WcQqZL1o5b6BUgx/sp97cwPztXd
         m6s1LGvR/Df+zExHBn30QX8x2NLQD60H3pwB6jccCMz2oJHi0m2J+2EPcou4A/koClQc
         n/1jLLBIX6ucNWFSne0Agej+1YWauJiBsLdXmVgB67RyDlJN5vwGdeHY5xQo5mp/xT6V
         XgXWKGqKGWJvm/IfDmfMb/HOKqxALW0bRoasIMJ6rxOcHKrWGOIM+k5B9MXt5EuPzMhB
         z6Ci6yzFAW9BUkAnX3w/ve7eWUZkUHF/Us4RH18lTefbnoVnkdE1v7CkPvnln7sUhqvP
         iQeA==
X-Gm-Message-State: AA+aEWYRf9knpHfAGrZlEEolz0nL23W2mv9yZBGWXB7nIsTffxSFr/4B
        ZG/y5jzoXhU+rZiGpxoDo9ag0w==
X-Google-Smtp-Source: AFSGD/X6fCwrJ1Kh7+GgtXBy0eyCgJgbd8l0hcVMS0AaBoLGN6q/G75KWd93FvwlDcct51dMiJniIg==
X-Received: by 2002:a63:fc05:: with SMTP id j5mr16393089pgi.434.1544564486767;
        Tue, 11 Dec 2018 13:41:26 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id d21sm17066002pgv.37.2018.12.11.13.41.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 13:41:25 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Wolfram Sang <wsa@the-dreams.de>, Jian Hu <jian.hu@amlogic.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Carlo Caione <carlo@caione.org>, Rob Herring <robh@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        linux-amlogic@lists.infradead.org, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 0/2] i2c: meson: add support for Meson G12A SoC i2c controller
In-Reply-To: <20181211203652.rogajl4ajwu7cs6f@ninjato>
References: <1543489197-183181-1-git-send-email-jian.hu@amlogic.com> <8a6a204b28523e5a181f9e85dda18fade76a26a3.camel@baylibre.com> <b2bceaf4-92ce-92a4-c382-713d29ae3b70@amlogic.com> <20181211203652.rogajl4ajwu7cs6f@ninjato>
Date:   Tue, 11 Dec 2018 13:41:25 -0800
Message-ID: <7hsgz3u4fu.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wolfram Sang <wsa@the-dreams.de> writes:

>> I am okay if it is reasonable below in file
>> arch/arm64/boot/dts/amlogic/meson-g12a.dtsi. I2c controller node just uses
>> axg's compatible.
>> 
>> 			i2c0: i2c@1f000 {
>> 				compatible = "amlogic,meson-axg-i2c";
>
> Actually, you should have
>
> 	compatible = "amlogic,meson-g12a-i2c", "amlogic,meson-axg-i2c";
>
> in the DT to have support for future SoC specific additions. And then,
> patch 1 is needed.
>
> Or do you handle this differently? I'd think this is DT standard.

It's a DT standard *if* there are actual hardware differences.  In this
case, the IP block is identical, so there are no driver changes.

We prefer to add a new compatible if and when there are actual
driver/hardware changes.

Kevin
