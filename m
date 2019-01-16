Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8111AC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 05:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48B8920840
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 05:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OGuJ4UBE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732909AbfAPFwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 00:52:45 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44783 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732862AbfAPFwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 00:52:45 -0500
Received: by mail-pf1-f193.google.com with SMTP id u6so2484674pfh.11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 21:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=P21gRR8x3ZE6C2Jq8UOx/FjA7qlS5/69mleApLaVCB0=;
        b=OGuJ4UBE9p+x1gIHOPrb3Y/sXLVljLSy8/xV3nKWMMw3oTlAc+o+5ofMRIkDFz+aib
         Oaj6lNv+0Lzg5pNubLkTP006ZJtVq4+i0LD7QXLnSJH5hoXWwlbl/GzWy2mAzfdkLClX
         9GkyZ+zBqrLkkuhGMVg64sR0kaNPwY4cVPtZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=P21gRR8x3ZE6C2Jq8UOx/FjA7qlS5/69mleApLaVCB0=;
        b=eSrtXSTEaHEov053Og3QvsQleD8lJ0rXHxSPLu9CXECGvfm3YJflf69zSQrENfSsiJ
         rP1zdMxHdwcmlrR3vlI4JlEKb8xjx5xwz2XHuHL6nZSTLBpfx4etHC1TysuEMDM3k3NI
         w/fCy6JokyIcgnl+P8J9MOQjmOlTIDeQeAS8eWR6sAYYYonAkdhT8RwY4PbgVGPFdCvV
         z8tztWgJecm5wLau1ZCGUooxJ5b1jhVrhhzCtNwfZnJ9jT6VymIeQL9V4ckLbrvv6NmL
         6nGkXtje14NM5Df+DU24cik+Cq5EpoPyfiwcWGdYctv84AfHu6JOzK6zF63TzOeBn2Kg
         xEiw==
X-Gm-Message-State: AJcUukeEIic2cbjmFHc/OYyoUqh2CPhsX2ggB4Cco+mDbAh6pIvE3r7Y
        uDxRBPn6xjMqOrXgiaAUUTXS6Q==
X-Google-Smtp-Source: ALg8bN4f17iIEhKWmqEA4ppMjVbVtI6r9WVCtpUxGH7cbNyfO5TeOcDVet8eLbRh2Vc4tx7kt9AMGw==
X-Received: by 2002:a63:5518:: with SMTP id j24mr7171358pgb.208.1547617963534;
        Tue, 15 Jan 2019 21:52:43 -0800 (PST)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id z8sm5588332pgg.62.2019.01.15.21.52.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 21:52:42 -0800 (PST)
Date:   Tue, 15 Jan 2019 21:52:38 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>, rjw@rjwysocki.net,
        ulf.hansson@linaro.org, andy.gross@linaro.org, robh@kernel.org,
        sboyd@kernel.org, collinsd@codeaurora.org, mka@chromium.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, henryc.chen@mediatek.com
Subject: Re: [PATCH v11 0/9] Add power domain driver for corners on
 msm8996/sdm845
Message-ID: <20190116055238.GD25927@tuxbook-pro>
References: <20190110040209.6028-1-rnayak@codeaurora.org>
 <20190110063323.ltmqkl2xl4nhccvq@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110063323.ltmqkl2xl4nhccvq@vireshk-i7>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 09 Jan 22:33 PST 2019, Viresh Kumar wrote:

> +Rafael
> 
> On 10-01-19, 09:32, Rajendra Nayak wrote:
> > Changes in v11:
> > * Updated opp-level binding description based on feedback
> > from Viresh
> > * Other minor fixups in 'PATCH 2/9'
> 
> >  Documentation/devicetree/bindings/opp/opp.txt |   3 +
> >  .../devicetree/bindings/power/qcom,rpmpd.txt  | 145 +++++++
> >  arch/arm64/boot/dts/qcom/msm8996.dtsi         |  34 ++
> >  arch/arm64/boot/dts/qcom/sdm845.dtsi          |  51 +++
> >  drivers/opp/core.c                            |  18 +
> >  drivers/opp/of.c                              |   2 +
> >  drivers/opp/opp.h                             |   2 +
> >  drivers/soc/qcom/Kconfig                      |  18 +
> >  drivers/soc/qcom/Makefile                     |   2 +
> >  drivers/soc/qcom/rpmhpd.c                     | 402 ++++++++++++++++++
> >  drivers/soc/qcom/rpmpd.c                      | 317 ++++++++++++++
> >  include/dt-bindings/power/qcom-rpmpd.h        |  39 ++
> >  include/linux/pm_opp.h                        |   7 +
> >  13 files changed, 1040 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/power/qcom,rpmpd.txt
> >  create mode 100644 drivers/soc/qcom/rpmhpd.c
> >  create mode 100644 drivers/soc/qcom/rpmpd.c
> >  create mode 100644 include/dt-bindings/power/qcom-rpmpd.h
> 
> Rafael/Ulf: Who should pick this series ? Should I take this via OPP
> tree ?
> 

Given that the weight of the patches lies in arm-soc area it could be
favourable to just take them that way, with the one opp-patch carrying
your (Rafael's?) ack.

If you prefer otherwise, I suggest that we take patch 6 and 8 (the two
dts patches) through arm-soc and you merge the rest in your tree.

Regards,
Bjorn
