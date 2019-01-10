Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5854CC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 06:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22959206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 06:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ilOAtAOS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbfAJGd1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 01:33:27 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34024 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbfAJGd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 01:33:27 -0500
Received: by mail-pf1-f193.google.com with SMTP id h3so4879461pfg.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 22:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dIGR4nQtfCyexaxuETlFVgQ64BQRNnT7/dEmu1yGC6U=;
        b=ilOAtAOSHBaV8lPNi0cb6T3TLwOFJbVHQsjfiiiO0hM0UI/+DprC08QwkB6EqqD2vi
         jzk5vj6LcqxEBAFyvYUTKkvZyhBVziiUGLWTbkiK2T8etTNWn8taYFtcPl/gVNIiQJr+
         FDacwUoFt+8X0xvs+tN0EOKRUGVr/zQpHmndY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dIGR4nQtfCyexaxuETlFVgQ64BQRNnT7/dEmu1yGC6U=;
        b=Pn6SnVBeK/1NHi64lk5VH/Bsg2MzOahXGq+pAbLD+/rTeQfv1Cpx9gklnn5y9S6hAP
         jJ3nwC0aPhzE8KiONWgtN27fzWD+qIBJ86jzq7zmjogCODMZ29b6OC51BLX+jrV5Cq0c
         ICnSOgLRGyBgE5qUrEqaupEqWLYJ6WsZw/UYd+XYDhBl3yltHmJSJHrJ1RHUWF/mqS6v
         0ueah9rrxt5csDgcVbaOLxmnSou75rZqoQtLu3kznQ2PN51tw4+5bW2lt2FYVuCfgawZ
         ttGbvguIEhL1V/yU5SEVF9NO0FQwgQDjXGfQxhdvZpH+xBbvQAJF0QFoywSR1Jz7DQa6
         PxUQ==
X-Gm-Message-State: AJcUukdcJZ7VbRtaYCOfmhy89GNfJgKoM4+ZYbzLaqoutfx1jLXCd0SM
        vL1sfAT5wP8S7FHWbsyKMmDZIg==
X-Google-Smtp-Source: ALg8bN64e5CL5IWvIs+cBjui438EzcrLKjyowUVI4+OZyMZEtU7uYo6AMAMQk1yimv3/k1luYK6XzA==
X-Received: by 2002:a65:500c:: with SMTP id f12mr8163994pgo.226.1547102006672;
        Wed, 09 Jan 2019 22:33:26 -0800 (PST)
Received: from localhost ([122.166.131.155])
        by smtp.gmail.com with ESMTPSA id m85sm121578248pfj.171.2019.01.09.22.33.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 22:33:25 -0800 (PST)
Date:   Thu, 10 Jan 2019 12:03:23 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>, rjw@rjwysocki.net,
        ulf.hansson@linaro.org
Cc:     andy.gross@linaro.org, robh@kernel.org, sboyd@kernel.org,
        collinsd@codeaurora.org, mka@chromium.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, henryc.chen@mediatek.com
Subject: Re: [PATCH v11 0/9] Add power domain driver for corners on
 msm8996/sdm845
Message-ID: <20190110063323.ltmqkl2xl4nhccvq@vireshk-i7>
References: <20190110040209.6028-1-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110040209.6028-1-rnayak@codeaurora.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Rafael

On 10-01-19, 09:32, Rajendra Nayak wrote:
> Changes in v11:
> * Updated opp-level binding description based on feedback
> from Viresh
> * Other minor fixups in 'PATCH 2/9'

>  Documentation/devicetree/bindings/opp/opp.txt |   3 +
>  .../devicetree/bindings/power/qcom,rpmpd.txt  | 145 +++++++
>  arch/arm64/boot/dts/qcom/msm8996.dtsi         |  34 ++
>  arch/arm64/boot/dts/qcom/sdm845.dtsi          |  51 +++
>  drivers/opp/core.c                            |  18 +
>  drivers/opp/of.c                              |   2 +
>  drivers/opp/opp.h                             |   2 +
>  drivers/soc/qcom/Kconfig                      |  18 +
>  drivers/soc/qcom/Makefile                     |   2 +
>  drivers/soc/qcom/rpmhpd.c                     | 402 ++++++++++++++++++
>  drivers/soc/qcom/rpmpd.c                      | 317 ++++++++++++++
>  include/dt-bindings/power/qcom-rpmpd.h        |  39 ++
>  include/linux/pm_opp.h                        |   7 +
>  13 files changed, 1040 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/qcom,rpmpd.txt
>  create mode 100644 drivers/soc/qcom/rpmhpd.c
>  create mode 100644 drivers/soc/qcom/rpmpd.c
>  create mode 100644 include/dt-bindings/power/qcom-rpmpd.h

Rafael/Ulf: Who should pick this series ? Should I take this via OPP
tree ?

-- 
viresh
