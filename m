Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7F2C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E14B821523
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MYSxP4i2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E14B821523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388248AbeIUArk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 20:47:40 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43332 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388121AbeIUArk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 20:47:40 -0400
Received: by mail-pl1-f196.google.com with SMTP id 38-v6so4778572plc.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 12:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=d/ds6XXVbU7LG6V22VtK+bCzTdiW/in0CTxPfsTzDls=;
        b=MYSxP4i2o+/P5LRi7vjnhAOaMOdvZv44lU7uijk50J0ynTIPtHTByYqgWIYPoBOYAF
         Ep0UzQ0Ajr0aKOh9g9rBISH0fh3kRLZ4wgmoQIC4Ed7/1ZchCINOCDjv6LwaEevB/LDa
         LPB4GHLaNg/d+J5F1YGCJDCqVlT/HYOBUaI0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d/ds6XXVbU7LG6V22VtK+bCzTdiW/in0CTxPfsTzDls=;
        b=S8uG5AINkq8Voudw2h1RJXLoAZKFDlO+taMNZwTpFZSyherSkqxP3Li5mJuDckpQ02
         x26JwQL3+/WDHXPA21f/mT/Aq47xo+6JbBpfVYZs93NTU5eomHDQq6M+nWOwO+0Zkazw
         FwXbicLnWNYIykxgJR/ARnaM0yt+Tttbl8Dgme86GWknx/59WVwkBUfyVRbPnEs5Hgo6
         UDNVlX77Xis4xBrP0vmNby4lHrjXFsH7yqUGeFNsQUx1n8e3o4WDvAdsrwi2qntNnUIV
         sbBDcuSgKml3dqNX34VgbH5L34UyvLrpAaIOAMiMWhwxQFbWYXMgYyDhxaYKJ9icEcQf
         /T7A==
X-Gm-Message-State: APzg51Be2n+Had5ZlN1bsQCNI6wyOFcFr+EzyaPiL5ElEz9nFRxnsxO/
        cxgKzI5In6pJtwlSS8/TxIlQhQ==
X-Google-Smtp-Source: ANB0VdavZD6bgET78GG3Tb9bA3fHqgBm4RoCGQ0L/zwy/yGsoTSXoXOvHmXM7R2EuCMzrbUmq11W2A==
X-Received: by 2002:a17:902:47c2:: with SMTP id d2-v6mr41236445plh.317.1537470165422;
        Thu, 20 Sep 2018 12:02:45 -0700 (PDT)
Received: from localhost ([209.121.128.187])
        by smtp.gmail.com with ESMTPSA id f6-v6sm29832300pgf.52.2018.09.20.12.02.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 12:02:44 -0700 (PDT)
Date:   Thu, 20 Sep 2018 12:02:43 -0700
From:   Andy Gross <andy.gross@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, rnayak@codeaurora.org,
        linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        edubezval@gmail.com, smohanad@codeaurora.org,
        dianders@chromium.org, mka@chromium.org,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-soc@vger.kernel.org
Subject: Re: [PATCH v3 00/16] Another round of tsens cleanups
Message-ID: <20180920190243.GF19253@hector.localdomain>
References: <cover.1536744310.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1536744310.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 03:22:45PM +0530, Amit Kucheria wrote:
> This is another series of tsens cleanups before we add interrupt support. This applies on top of 4.19-rc2.
> 
> Patches [1-6] can directly be applied by Eduardo.
> Patches [9-16] can directly be applied by Andy.

Eduardo,

I ACKed the DTS patches for this.  Can you take 9-16 along with the 1-6 through
your tree?

Thanks,

Andy
