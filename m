Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29FF8C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 20:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEA2120856
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 20:23:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEA2120856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbeH2ARE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 20:17:04 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:46878 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbeH2ARE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 20:17:04 -0400
Received: by mail-oi0-f68.google.com with SMTP id y207-v6so5165937oie.13;
        Tue, 28 Aug 2018 13:23:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KXPB/W45KcL4R7WD/t3e2hQkvVv3pgDJ8PZmQsjRltg=;
        b=hpMqx+1CQ9cOkEbJTmlhGMPtYDSv+Xj9zQzuzihdPG77mC1PlG7nxvpuSrAQxiSywK
         Wh4n9tzmn8SCgZpd33G/6jBysQb/HFSMv/IgjdhbSmQLKGEvn3dPm9i+M825f3wjWU/T
         KRrhlDf46dSZajzgN3oN6yGDW9f6nF6Arie6wpBI8xOOScc1kZ03DeVMpgKA1iB09F/8
         Ye61FvbnQ72C2w9l0egONSnpcH0q/E4h2BWJaACHEON2X7uW5TTbB86kLE1P/gYMaL8u
         yOYUPRVVFqETbxGqeGjF4Aix5isK/ZD83lYQST/RWmHO26I0soqLKr0TwZgM2AUUrfoz
         1KQA==
X-Gm-Message-State: APzg51AAWqGKv3uGJDpAy4/rM0bzbIUvcRXd1YxQ9gQQlF0O0SVJXhYS
        4CQ+F+4DXx2pJkuWrC8YvQ==
X-Google-Smtp-Source: ANB0Vdbis7ATQfoiyxA8RyQCRQMI/LMxH44dVhyXUB6GC1dDPASyuwViMha2oLE4GhrE4CM1HhpK0Q==
X-Received: by 2002:aca:ab0c:: with SMTP id u12-v6mr2347205oie.143.1535487826943;
        Tue, 28 Aug 2018 13:23:46 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w13-v6sm1647725oiw.51.2018.08.28.13.23.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 13:23:46 -0700 (PDT)
Date:   Tue, 28 Aug 2018 15:23:45 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lina Iyer <ilina@codeaurora.org>
Cc:     marc.zyngier@arm.com, bjorn.andersson@linaro.org, sboyd@kernel.org,
        evgreen@chromium.org, linus.walleij@linaro.org,
        rplsssn@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, rnayak@codeaurora.org,
        devicetree@vger.kernel.org, andy.gross@linaro.org,
        dianders@chromium.org
Subject: Re: [PATCH v2 2/5] dt-bindings: pinctrl: add wakeup capable GPIOs
 for SDM845
Message-ID: <20180828202345.GA18349@bogus>
References: <20180824200157.9993-1-ilina@codeaurora.org>
 <20180824200157.9993-3-ilina@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180824200157.9993-3-ilina@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 02:01:54PM -0600, Lina Iyer wrote:
> Update the documentation to use interrupts-extended format for
> specifying the TLMM summary IRQ line that is requested from GIC and the
> PDC interrupts corresponding to the wakeup capable GPIOs.
> 
> Update the example to show PDC interrupts for the wakeup capable GPIOs
> for SDM845.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> ---
> Changes in v2:
> 	- Fix PDC IRQ number in example
> 	- Describe IRQ trigger type in example
> ---

Please add acks/reviewed-bys when posting new versions. These changes 
look trivial enough to have kept my R-by.

>  .../bindings/pinctrl/qcom,sdm845-pinctrl.txt  | 104 +++++++++++++++++-
>  1 file changed, 101 insertions(+), 3 deletions(-)
