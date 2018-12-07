Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB44EC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92C902081C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544203792;
	bh=BLexHCYz4pBzxyxdemxwsOWWmC/HaTcBelUZ2W0n0Ts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VH6FYwUXjBSsy4bCd7xbkbyo0tyGDj+S10Gx9h6prT1FgbrOPDxSgrseM8Ak+JnqW
	 OM68R+qy6Xmoxqh8zdXBgW2N/dBqYYHu4r7bYlL0CPjR1ojTD4iIMXNnj4z+EPlm9p
	 pXInxa2gbhoHbfQENCukfz+mLMv12DakjJ/DvBs4=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92C902081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbeLGR3v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 12:29:51 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41763 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbeLGR3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 12:29:51 -0500
Received: by mail-oi1-f195.google.com with SMTP id j21so3972361oii.8;
        Fri, 07 Dec 2018 09:29:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bPaVo2XfsSQt1zFEhTcHpr1vCcX3L+Bd4NRKaFBxT4c=;
        b=oQ8sXQxf2iPoIH+rqF0H3iO1Y2ObX6tvghz9FhQq5Kby0Dl6eqxGmttBjI4VXRv5OJ
         H9bil4ZrU8nwFLoPohR3Nep9yGjsD+OTvBXJdqldSvZjAj0+7suPw9W8bByOOq57gcMC
         iAHE9csYISAC485vr/E+B5kuq3bL7+jHZdSGiA7MatMWyjo+lELeh+g/YYVWVlIYsWnz
         xlBGU1HhX4NvIF1DscSu9avDPvYmbrzqbh8U5jugk3NzAnJQeC8l3vg8xiZQZkBOz9Vp
         9aX4P+9IkhAUhLRGOUaW1UFpq2/f7vOOW1J0U7/hyM4sZn+rQSQujyrPe0ycB/y/vMb0
         E5Zw==
X-Gm-Message-State: AA+aEWaNjveO5M0F8lTeqtYbXIU+9axgAoTB6NsDojMMYXnfnqjBC88b
        SkpqxsAajwCI+kawo++3vu+4e+c=
X-Google-Smtp-Source: AFSGD/WCJj5YH724MQ04xFAlfeNHAJR6nT5+TJAXSXGX1UMTdtNYqrPHMpN9uZ7WyVCDMhiz/wtpqw==
X-Received: by 2002:aca:f244:: with SMTP id q65mr1652384oih.50.1544203790270;
        Fri, 07 Dec 2018 09:29:50 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x9sm1618353otq.73.2018.12.07.09.29.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Dec 2018 09:29:49 -0800 (PST)
Date:   Fri, 7 Dec 2018 11:29:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     robh@kernel.org, viresh.kumar@linaro.org, sboyd@kernel.org,
        andy.gross@linaro.org, ulf.hansson@linaro.org,
        collinsd@codeaurora.org, mka@chromium.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: Re: [PATCH v5 1/8] dt-bindings: opp: Introduce qcom-opp bindings
Message-ID: <20181207172948.GA4284@bogus>
References: <20181204052119.806-1-rnayak@codeaurora.org>
 <20181204052119.806-2-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181204052119.806-2-rnayak@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  4 Dec 2018 10:51:12 +0530, Rajendra Nayak wrote:
> On Qualcomm Technologies, Inc. platforms, an OPP node needs
> to describe an additional level/corner value that is then communicated
> to a remote microprocessor by the CPU, which then takes some
> actions (like adjusting voltage values across various rails)
> based on the value passed.
> 
> Describe these bindings in the qcom-opp bindings document.
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  .../devicetree/bindings/opp/qcom-opp.txt      | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/opp/qcom-opp.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
