Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3351C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 22:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D82A21874
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 22:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546035430;
	bh=ydEmOQRfeug/ZinUrNYylwMhaJbSiRVv41v6wUAkxBA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=d7t7qbNLHTx4jk4lJlebI5MvbUhX6Iwpgtz1mg521TOvBPtYOeRwnImnYMvtYpfot
	 OVkrzTsGMxlPDUq0mMzgxAd3BQ+GVAdjMP08rFh+oPiGjeLsNdurkpQ4MAersIt7cM
	 YIA+ElUZiXPwK78Xfxtr/WIeYzQovSu4bkLsUnXw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbeL1WRJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 17:17:09 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:54703 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726931AbeL1WRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 17:17:08 -0500
Received: by mail-it1-f196.google.com with SMTP id i145so30039815ita.4;
        Fri, 28 Dec 2018 14:17:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ELwny4XXqIBcibhPWNnRqMYHSeYAKc1cUy7LGHMC+ak=;
        b=rvfdWalb9V1oZzfRAw8rj1gqnpkgCQ6meJJm6BUVneB4wOhYsRFF2WQXTwsTjXnBOn
         pZxSLusY45/CNRla+Xl0szUotbtOMJLsZzDcy0qyFejPiB1WojsmMmL5y4vYlsNetLWk
         W8ShSnu8lFMdEvoeyHnXNJgXNqNpC6tPh0DXZ2yjD5zpJKYqw5w4SwNaCkD1yF6/6CUW
         2e8GDNZfb8ifQQHpiQTHp2hzSCpOOzRCoBo8/kPHF1iCn8ysz2dPilYo6uiwgK+M1I4H
         meonuOCTeFrNUGLXAfCD+cIH85HnjkfmB2vy5SrYq2UsYPiWv9/eJqz/Okp78b60Ipta
         ofdw==
X-Gm-Message-State: AJcUukcjN4ypKGVb7rwueS5oY88+Y59ityKkdM0g4Pb9rnwfQIxVKLpR
        kBGSAjNGh6VWYXKHgWDUsg==
X-Google-Smtp-Source: AFSGD/Wm/UnCK4Yq5b0h+OKMWV4hGpTxENVsnGof50orFxRieCjyvZuwfuxYrZuu3qBkZk3u414yXQ==
X-Received: by 2002:a24:2543:: with SMTP id g64mr18996787itg.163.1546035427848;
        Fri, 28 Dec 2018 14:17:07 -0800 (PST)
Received: from localhost ([24.51.61.172])
        by smtp.gmail.com with ESMTPSA id m2sm18154576iol.75.2018.12.28.14.17.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Dec 2018 14:17:07 -0800 (PST)
Date:   Fri, 28 Dec 2018 16:17:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, andy.gross@linaro.org,
        briannorris@chromium.org, akdwived@codeaurora.org,
        clew@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-arm-msm-owner@vger.kernel.org, ohad@wizery.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        Sibi Sankar <sibis@codeaurora.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: remoteproc: qcom: Add firmware
 bindings for Q6V5
Message-ID: <20181228221706.GA22610@bogus>
References: <20181228044819.5697-1-sibis@codeaurora.org>
 <20181228044819.5697-2-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181228044819.5697-2-sibis@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Dec 2018 10:18:18 +0530, Sibi Sankar wrote:
> Add optional "firmware-name" bindings for Q6V5 MSS and PAS based
> remoteprocs. For Q6V5 MSS/PAS the two/one relative firmware
> paths/path are to be listed respectively. Fallback to the default
> images for mba/modem for Q6V5 MSS or the default Hexagon image
> for Q6V5 PAS if the "firmware-name" binding is not present.
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/remoteproc/qcom,adsp.txt | 6 ++++++
>  Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt | 7 +++++++
>  2 files changed, 13 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
