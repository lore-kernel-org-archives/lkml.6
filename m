Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D4D2C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C25EB20865
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:28:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C25EB20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbeIJVXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 17:23:17 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:32844 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728164AbeIJVXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 17:23:17 -0400
Received: by mail-oi0-f67.google.com with SMTP id 8-v6so41373924oip.0;
        Mon, 10 Sep 2018 09:28:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Dk6AEdIML5zjHTM+F9H7HY+ujDJKpFJin6Qq/5l7ea4=;
        b=rbKm9YcuE3o5/rioohDIgqCez08BsJDcGeQwsMYs2qLl/vqJLvrYCcki0wpQnz/1Xr
         kV9lp0fcxcbbPWmVG9bwMX8FdZe7KwI5tWeEYTPk3+lSEd4sF47vB7OaiNSODlXWBXNa
         nBXWsIWv00reukQWfivk611t7WbIQ7UmfI781A56Ta/jleBNWk2ZrkbdwSH+s8uyifN7
         9kwusmcZ2daQ90957MFxMpNmjVvlaMmFMvwRDsrgTzQnmPm1UzUZVmCmIQw8jBG6E2yw
         AgkaMxSpqz2xvjyEuUWSUiEqIMuLv1Zr+OolE0I9kMR439tel7vTdwyEC6NpB7nlTyrg
         CocQ==
X-Gm-Message-State: APzg51AyEn8tQA7gQbfPAuXjCe4napTT4aJls9xTXKiBUvqI0dMRiH4L
        wbM64+9LchF7kqeWUv8Syg==
X-Google-Smtp-Source: ANB0VdbBlXKZfXShd6+ayP1004+J8Rt4tVlE5VfCRmLRG1HAhywCRW5FvSGwbq5On0mz2UiWQSntAQ==
X-Received: by 2002:aca:3507:: with SMTP id c7-v6mr24490209oia.46.1536596904387;
        Mon, 10 Sep 2018 09:28:24 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k85-v6sm49792440oiy.2.2018.09.10.09.28.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 09:28:23 -0700 (PDT)
Date:   Mon, 10 Sep 2018 11:28:22 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lina Iyer <ilina@codeaurora.org>
Cc:     marc.zyngier@arm.com, bjorn.andersson@linaro.org, sboyd@kernel.org,
        evgreen@chromium.org, linus.walleij@linaro.org,
        rplsssn@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, rnayak@codeaurora.org,
        devicetree@vger.kernel.org, andy.gross@linaro.org,
        dianders@chromium.org
Subject: Re: [PATCH v3 2/5] dt-bindings: pinctrl: add wakeup capable GPIOs
 for SDM845
Message-ID: <20180910162822.GA5636@bogus>
References: <20180904211810.5506-1-ilina@codeaurora.org>
 <20180904211810.5506-3-ilina@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180904211810.5506-3-ilina@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2018 at 03:18:07PM -0600, Lina Iyer wrote:
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
>  .../bindings/pinctrl/qcom,sdm845-pinctrl.txt  | 104 +++++++++++++++++-
>  1 file changed, 101 insertions(+), 3 deletions(-)

As I also mentioned in v2. Please add acks/reviewed-bys when posting new 
versions.

Rob
