Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 088F4C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6D0320866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WjMmdMTo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6D0320866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbeIKUne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 16:43:34 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36863 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbeIKUnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 16:43:33 -0400
Received: by mail-wr1-f67.google.com with SMTP id e1-v6so17503380wrt.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 08:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=xjbuaZlOAtzXSHM/rXc7srrzXgEnVzGz3HK5KoAcxkE=;
        b=WjMmdMToLmIyUnD1AR64hsm+hQV+xNE/Fd58bQoZ8nzEdjRm6JuwVc4eqR+f/4Hwjs
         Y/7Huoy4EoxAq2AsvipUEuDKfNwcm9+TJcrnxFZcbCJ6dx4faqqfMUpvUTNgzSTgYIdO
         DvIfe+d0reKtNGFBTrYkmeAyi0nBPgIYsVUsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=xjbuaZlOAtzXSHM/rXc7srrzXgEnVzGz3HK5KoAcxkE=;
        b=FNCilzatsSXIaMwgLnB3+Tpuy3C1U+Uh3UjBNp5yue90m/zbncg3wOJGHs1z+A/ASU
         NgXjGGYco2z4Oyanv3WYx7oJt4aVWButmtfnESYAhHP25/FBnAonYVFbWo1jvP6dmAp9
         LsQTe05wzmI2BUwCgYzGIMHn1CK3vjqhUlUH+SmjbJtDRE+CyjynhjrFIjWQVEttwHMW
         RJkUHW3LYVuZxL/s4kSeTn9dcJ5EgLbR1w/wNWTlvVM/KkCpbWtfsdesKtDSM5eOssLK
         tHUm0olhcP/+Ah4lcHxeg8SL7dkmHKBgRxFe8Hph65rakVL999ZirCBVzFezucCrpAx+
         hIVw==
X-Gm-Message-State: APzg51CsvnCccBdDeiyuwqqGYiFAZ0N24B5t2qikI5VwmFqzpT1PKZ1K
        I2G5n317sw7IUHbyg4uporT6cg==
X-Google-Smtp-Source: ANB0Vda6uIZU0Zn/IAArdUbbipJS7G9sm2v1QDes3iOYkEjsff47A3gh5NdUD9tjNgTxYe7sOYaZKQ==
X-Received: by 2002:adf:9c12:: with SMTP id f18-v6mr20141800wrc.93.1536680620094;
        Tue, 11 Sep 2018 08:43:40 -0700 (PDT)
Received: from dell ([2.27.167.7])
        by smtp.gmail.com with ESMTPSA id u4-v6sm12807569wro.47.2018.09.11.08.43.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 08:43:39 -0700 (PDT)
Date:   Tue, 11 Sep 2018 16:43:37 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: [GIT PULL] Immutable branch between MFD and RTC due for the v4.20
 merge window
Message-ID: <20180911154337.GB4185@dell>
References: <20180909204858.4257-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180909204858.4257-1-alexandre.belloni@bootlin.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Lee,
> 
> If that is ok with you, I would like to take this patch through the RTC
> tree. So I can have a follow up patch removing rtc_device_register().

Your wish is my command!

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-rtc-v4.20

for you to fetch changes up to 9612f8f503804d2fd2f63aa6ba1e58bba4612d96:

  mfd: menelaus: Fix possible race condition and leak (2018-09-11 16:40:21 +0100)

----------------------------------------------------------------
Immutable branch between MFD and RTC due for the v4.20 merge window

----------------------------------------------------------------
Alexandre Belloni (1):
      mfd: menelaus: Fix possible race condition and leak

 drivers/mfd/menelaus.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
