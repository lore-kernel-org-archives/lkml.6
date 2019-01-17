Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F5EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 04:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F856205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 04:24:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="REmL71B7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbfAQEYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 23:24:47 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42493 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727984AbfAQEYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 23:24:46 -0500
Received: by mail-pf1-f195.google.com with SMTP id 64so4155135pfr.9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 20:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LczuEYmuaLHA/7vIySBvq2q/+lPHXR36z4WzTXSZUyw=;
        b=REmL71B7VwgSd6d/OCCatYrhafLkZvXkU87EOoV9jgMHW3Zhzdsyw9U3LtgwjWY7G4
         AK3SQHcJyUBYhWEpHAa1gxcmrz4QziXFUQRv+IPYq78DPzs/paGboWaaFZeldrC5M9ny
         cazDtwsU0gkN0uer6xEpElLnzhV9X215ebqjQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LczuEYmuaLHA/7vIySBvq2q/+lPHXR36z4WzTXSZUyw=;
        b=DxvcDlAZU/9ZHpH6yTM9FqdDG2gdmgaUOo1EF+KTYRjcihkyA1oTJG8BDfJUhdnbEb
         r7xB5GpleTNOnGVNKZTDRdJNam7TuCPlXUOwBaJ7Pert+1uT4XtYELpt3OYOSYg3/zda
         wNrykN2saayfmopdV8taa10Wd5bXMc4qRNxtsHcz7OaAw5T1OtfqmymNGXCRmUs8WOS9
         nD85OI+OtbhKbIYbuXyEku/iPoAqkdj5Lk1rahEwrYL5i9anrEICKNZRWVYh1N0pMHIq
         9W8iFNUFGn7N7HJkb4aeSyVXc9yhzCOyPiV0Z5K6M3MJyZVgFUcx6BShs/DPDHVqQCix
         8Mbw==
X-Gm-Message-State: AJcUukcZeb4tpBpS9bq9wh/X7uAIXk/2EDaY6sjWSEc4Eeksg0MNdyZx
        yhwr6dMaj6ueIFdOIr/N4do3zw==
X-Google-Smtp-Source: ALg8bN4A2SSNvnR071hX4ti74242nNHv7s/yuntJrzUOQmbVNCz781p2FMaGluNOF7VjNUPbKzapQw==
X-Received: by 2002:a62:31c1:: with SMTP id x184mr13732571pfx.204.1547699085328;
        Wed, 16 Jan 2019 20:24:45 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id d18sm452616pfj.47.2019.01.16.20.24.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 20:24:43 -0800 (PST)
Date:   Thu, 17 Jan 2019 09:54:41 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>, rjw@rjwysocki.net,
        ulf.hansson@linaro.org, andy.gross@linaro.org, robh@kernel.org,
        sboyd@kernel.org, collinsd@codeaurora.org, mka@chromium.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, henryc.chen@mediatek.com
Subject: Re: [PATCH v11 0/9] Add power domain driver for corners on
 msm8996/sdm845
Message-ID: <20190117042441.it4pt7z3ur3bgk37@vireshk-i7>
References: <20190110040209.6028-1-rnayak@codeaurora.org>
 <20190110063323.ltmqkl2xl4nhccvq@vireshk-i7>
 <20190116055238.GD25927@tuxbook-pro>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190116055238.GD25927@tuxbook-pro>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-01-19, 21:52, Bjorn Andersson wrote:
> On Wed 09 Jan 22:33 PST 2019, Viresh Kumar wrote:
> 
> > +Rafael
> > 
> > On 10-01-19, 09:32, Rajendra Nayak wrote:
> > > Changes in v11:
> > > * Updated opp-level binding description based on feedback
> > > from Viresh
> > > * Other minor fixups in 'PATCH 2/9'
> > 
> > >  Documentation/devicetree/bindings/opp/opp.txt |   3 +
> > >  .../devicetree/bindings/power/qcom,rpmpd.txt  | 145 +++++++
> > >  arch/arm64/boot/dts/qcom/msm8996.dtsi         |  34 ++
> > >  arch/arm64/boot/dts/qcom/sdm845.dtsi          |  51 +++
> > >  drivers/opp/core.c                            |  18 +
> > >  drivers/opp/of.c                              |   2 +
> > >  drivers/opp/opp.h                             |   2 +
> > >  drivers/soc/qcom/Kconfig                      |  18 +
> > >  drivers/soc/qcom/Makefile                     |   2 +
> > >  drivers/soc/qcom/rpmhpd.c                     | 402 ++++++++++++++++++
> > >  drivers/soc/qcom/rpmpd.c                      | 317 ++++++++++++++
> > >  include/dt-bindings/power/qcom-rpmpd.h        |  39 ++
> > >  include/linux/pm_opp.h                        |   7 +
> > >  13 files changed, 1040 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/power/qcom,rpmpd.txt
> > >  create mode 100644 drivers/soc/qcom/rpmhpd.c
> > >  create mode 100644 drivers/soc/qcom/rpmpd.c
> > >  create mode 100644 include/dt-bindings/power/qcom-rpmpd.h
> > 
> > Rafael/Ulf: Who should pick this series ? Should I take this via OPP
> > tree ?
> > 
> 
> Given that the weight of the patches lies in arm-soc area it could be
> favourable to just take them that way, with the one opp-patch carrying
> your (Rafael's?) ack.
> 
> If you prefer otherwise, I suggest that we take patch 6 and 8 (the two
> dts patches) through arm-soc and you merge the rest in your tree.

Okay, take it via arm-soc. I will ask for a branch later on if I find
more patches going for the OPP core this cycle.

-- 
viresh
