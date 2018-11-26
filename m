Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D0FC43610
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 18:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 961FF2086E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 18:58:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 961FF2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbeK0Fxz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 00:53:55 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45780 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbeK0Fxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 00:53:52 -0500
Received: by mail-ot1-f67.google.com with SMTP id 32so17629317ota.12;
        Mon, 26 Nov 2018 10:58:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t8f6S9I1BuJkxO9QEyeI2RVkWM5DKRaf0svOTyuKTDc=;
        b=IczNff/B9iwHPGuByhVVZ87RJ1wRx0VLbCV4InmRQEVdYTEd1n5nqnfbYybUbz0OkS
         slYhdidznri+lTZB6WXpL6pYfOkR8negPPZcVd2Bw1tjVRzxQ25QenN7V5YQdpk4uUVS
         msA+oEWz/wQKRn/2dl/O6k0mHRTSaiJKO6vmhaOqT46MiqBoE1pdRIHBgRFVhs/90xBB
         JzmhDn3+HXZ+ZUgaeomf+7F2hSnMr6tn+9svs4LwOOpCiRAfTMc79J0WX6ww/Cqcgrae
         JJmBiFSvI4790nXX1toAQwTANpQkeBSyear7fE+oLpQ9sUvqwzIr5KGJmf06clrrKBC0
         1Hgw==
X-Gm-Message-State: AA+aEWYPWFeFDE3MtDuanimB79MxNwhaMVbzI8iSlP7xCQay1t36vU3u
        cLsIetT0bRRrTdMAVtbCog==
X-Google-Smtp-Source: AFSGD/Vk2GQaAgZ5yCNEYt7kh+IzwZ6q/vIfazWms65FHxNwnDgBZhd+nlnxCOxaEz3IG4bEpK7qPw==
X-Received: by 2002:a9d:52a0:: with SMTP id f32mr13209806oth.6.1543258729960;
        Mon, 26 Nov 2018 10:58:49 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t8sm1228543otp.69.2018.11.26.10.58.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 10:58:49 -0800 (PST)
Date:   Mon, 26 Nov 2018 12:58:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Taniya Das <tdas@codeaurora.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org,
        Taniya Das <tdas@codeaurora.org>
Subject: Re: [PATCH v10 1/3] dt-bindings: clock: Update GCC bindings for
 protected-clocks
Message-ID: <20181126185848.GA4853@bogus>
References: <1542873221-13693-1-git-send-email-tdas@codeaurora.org>
 <1542873221-13693-2-git-send-email-tdas@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542873221-13693-2-git-send-email-tdas@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Nov 2018 13:23:39 +0530, Taniya Das wrote:
> Add protected-clocks list which could used to specify the clocks to be
> bypassed on certain devices.
> 
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/clock/qcom,gcc.txt | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
