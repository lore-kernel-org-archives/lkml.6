Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BBCC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 21:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C40BE21901
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 21:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545945835;
	bh=0puQwOxsMqA5HUttoY/QSjCzD09b1JelHDXmB2lYxOo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1j+6Wa4xCHQd4DIaJwuSTzQEwaWmIKUW7QX9AgEsj7AWl1poqFkbfOjFX1cHBdZDN
	 jDfqPl0otwl3a8EORpABkxWLUgLVbO4nhdsDV0MzwjWZLpxFPbGQl6u/dMdKSF+gXn
	 i7bAaMLOf52cGlbG0Oyv5wmcxvXqe/qPvvPWiQjs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730302AbeL0VXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 16:23:55 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:38415 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728503AbeL0VXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 16:23:54 -0500
Received: by mail-it1-f196.google.com with SMTP id h65so25121338ith.3;
        Thu, 27 Dec 2018 13:23:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=74+/qhizl9e0eC5TtLwm5CZFDAH2Cr4HHQICLk8u2vE=;
        b=UtMZP9d469RKPpfk1+hb2y2+FqHNTGjDY7VapSdD8GrXmO2JtoflK3DxjN91LpoQ/Y
         crh+njI4UBOpHN/6N4S7pHBvqVYPZwAWf/sjMNwoEDTiSkdpmBR9akU5UFWhjJZZc8u4
         1FWB+tY9sU9zHqsQwa/XVGyFDYsJM2artpxqSL3iq9gHsOnRJppzZgCqrMnLAQtlaRm1
         VuIIhS99VoDUtp9lLUtoOj2MRSyvRyhqJP1YHJieng/o4vhSxFgUI3fPcLt/iyoX6Uy2
         JFxr4/0ik/zCldlnznAz28ghszV2B98zkEyjfIria3fDza3w+oZ0umrbVadWVoKTopGH
         MUIA==
X-Gm-Message-State: AA+aEWYboMDRzeuaZQOqjB0SXw6fiqEzI8/XzNhf+nyBkb3BqL+q6CF3
        oL32+/EUAocCzNLdvtGj1g==
X-Google-Smtp-Source: AFSGD/XMFzpAFuOvFDjBH3jB+nK3QhZa9uNQuqLvxFwlD3Ppm+X+5g++Jibi03S+k9W1Ga6YC+HKNw==
X-Received: by 2002:a02:85ae:: with SMTP id d43mr16705834jai.70.1545945832469;
        Thu, 27 Dec 2018 13:23:52 -0800 (PST)
Received: from localhost ([24.51.61.172])
        by smtp.gmail.com with ESMTPSA id z133sm14255846itb.36.2018.12.27.13.23.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Dec 2018 13:23:51 -0800 (PST)
Date:   Thu, 27 Dec 2018 15:23:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, robh+dt@kernel.org,
        andy.gross@linaro.org, david.brown@linaro.org,
        dianders@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, tsoni@codeaurora.org,
        clew@codeaurora.org, akdwived@codeaurora.org, mark.rutland@arm.com,
        linux-remoteproc@vger.kernel.org, evgreen@chromium.org,
        briannorris@chromium.org, sricharan@codeaurora.org,
        Sibi Sankar <sibis@codeaurora.org>
Subject: Re: [PATCH v3 5/8] dt-bindings: remoteproc: qcom: Fixup regulator
 dependencies
Message-ID: <20181227212350.GA26216@bogus>
References: <20181226125229.20149-1-sibis@codeaurora.org>
 <20181226125229.20149-5-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181226125229.20149-5-sibis@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Dec 2018 18:22:26 +0530, Sibi Sankar wrote:
> Fixup regulator supply dependencies for Q6V5 MSS on MSM996 SoCs.
> 
> Fixes: 9f058fa2efb1 ("remoteproc: qcom: Add support for mss remoteproc
> on msm8996")
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
> 
> v3:
>   * Fixup dt-binding documentation as suggested by Doug
> 
>  .../bindings/remoteproc/qcom,q6v5.txt         | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
