Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5963C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A55E32184D
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="aA0lz5/x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbfA2SHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 13:07:10 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38976 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727498AbfA2SHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 13:07:09 -0500
Received: by mail-wr1-f66.google.com with SMTP id t27so23133603wra.6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 10:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=NzDwDEgriwmCgRdcqLB9TL0tXHCXXVwXdPshYo2uub4=;
        b=aA0lz5/x4LFTqvA60ICnNMJoFbk39uJ7CnhkZYJOeb9pQcko04r2z8ek1EemQ/H7N1
         DUy0xRc7jeRdHJ/xh9wTj7kiZJdPNZElsZ+V07PNmqaHMoiEAZWO87U+2K8Bn7EV5FNE
         EuNgYshQBkNbbhTeKx0AOFK14Sx+r4G5w2+vPjpDkom9sVzpOEYuftscHANqhnIZHD1f
         xE8AtWvmRK1TYVbQ703NIGgw2zlj0baGYtivZ1NNsOVe2lQC2bE+f6p5ZsdwaBx9tAXK
         Z1pjWLVPX6Yy1lQ4iKc9hLMDuVYXAKSJEyAnugeho9MU9xZ4hnlFr29Rhmq27UR21i8k
         a3rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=NzDwDEgriwmCgRdcqLB9TL0tXHCXXVwXdPshYo2uub4=;
        b=Xvg/WYqBQ7yXSJT9RXkESWhT/tcJGAbS/XSS4D6YSk6vXnfsgio6fvd3G78Iv2DO5s
         UzAdXEoxYxHIfumXHsBfC6wpzfXndQjjeBqeAyShQmoNAuM6Usf4y0e/+04jr0j6oY/v
         xkhvdz5EgV7aQx/VNa0q1fLf1X2iI4QnRBzNx6xgqPqeK1SyubYfosRys2sYxVcc9lSV
         9Jxz9OuOIneBholf3Jx9A6blrdEXcy3LAcbmNnqrkaNWqq8PIfnsL8kHSokI3HTUcX2V
         2C4s79Y1VMtvMAuv4uSYIiETrSH0msvf6L4pvHWqbHL9Jxf8SdU+yVFzRAYbukOOKEXP
         +0nw==
X-Gm-Message-State: AJcUukdYEt0C9ocmwTlbWH6fv+pK7bXKfu2HyoGXfgxVxhNT7vJype+k
        HwiQOlbojqLaXefatifnT/2FmQ==
X-Google-Smtp-Source: ALg8bN5xbEoQ1ihFND9bwxaeig6iPfJJ+zuvOJCox2vVkZ+I7GSjseFGt4qud2fkXGXnmTOQMBeqZw==
X-Received: by 2002:a05:6000:108d:: with SMTP id y13mr25818527wrw.135.1548785227162;
        Tue, 29 Jan 2019 10:07:07 -0800 (PST)
Received: from boomer.baylibre.com ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.gmail.com with ESMTPSA id j33sm192878674wre.91.2019.01.29.10.07.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 29 Jan 2019 10:07:06 -0800 (PST)
Message-ID: <f85275321c93c00494c82a8af19a70c229887944.camel@baylibre.com>
Subject: Re: [PATCH 04/14] clk: meson: move MESON_GATE to clk-regmap.h
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Date:   Tue, 29 Jan 2019 19:07:01 +0100
In-Reply-To: <154878509992.136743.15892625146758066106@swboyd.mtv.corp.google.com>
References: <20190128180430.28689-1-jbrunet@baylibre.com>
         <20190128180430.28689-5-jbrunet@baylibre.com>
         <154878509992.136743.15892625146758066106@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.4 (3.30.4-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-01-29 at 10:04 -0800, Stephen Boyd wrote:
> Quoting Jerome Brunet (2019-01-28 10:04:20)
> > Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> > ---
> 
> And also make clk-regmap.c a module? Having any commit text would be
> good.

Stephen, 

As stated in the cover-letter, this patch (and several others) is meant to be
squashed with patch 14 of this series, keeping commit text of patch 14.

Details are provided in both the cover letter and patch 14

> 


