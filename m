Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D54C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7D9220989
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544050511;
	bh=H3Z5G8ZMI3ywm3yt6Uo8VDJBcOiFEdk3OcURVqI/NCQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ssshM1xB/TwzXqyMn44r3/lvSfwxp0vKfye25Ljk6kiOkQi6KfuGlGPhx3ktjX2Ha
	 aBL5tk5F5uxeFW4dgbpqf0rT3zYwIbvw//uOoBak1ujn9SNQNEItnrdZVtQwpsghEs
	 IpdFV8uoGbsbzcEyXc57soEvMYkM+B84N8ZwLlKA=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7D9220989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbeLEWzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 17:55:09 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45656 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727660AbeLEWzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 17:55:09 -0500
Received: by mail-ot1-f65.google.com with SMTP id 32so20240631ota.12;
        Wed, 05 Dec 2018 14:55:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=558k9VEmBpYta/bZuurC2Tbr0vkgp+1zi46hpryEk8g=;
        b=pE4dstomyHgpnvZGY1GRXGOPi3D4ehMii/EUKl941KGHQVieIPx6gaa/riNArl8NNU
         VUe6KXAAoATJIaPF4k3SRFAHjlXOxe7KeMEvKTpgUTzmyq/Xjd033axGJ/430KER1PlH
         j90+aJ7OOheWYNusNsETezAEUA/P7S70WiDRmKeSxo8dh+K/LNBOs1r7wyJ0Pc41SUVh
         wWLo1uynhg1rdtQdMi7BqzDicOs5JivJhwDm1U9Usu3tS2MRMexxtqqgeWT0Lfs4s0AY
         VA3x9Yd7sZHi5Hq9ASa4nBTdM1HYVdm3KZ5rSWCqr8Yy27O9oHdOrOM/t9D5UDZMRNZ8
         hBMQ==
X-Gm-Message-State: AA+aEWZEn+nUwIIb7X/6i9WIMGWRl45uBjA8dyPD9IhVt6TVK73VuDLs
        mjA21X0gJUo2LDjHj4MIww==
X-Google-Smtp-Source: AFSGD/U0ZAsbGP4jreS/aymymgHPlrS+UUjYHO0SyQrwaXMw2OxIHPRkklUiKRDVKjGDVL67b0I5RQ==
X-Received: by 2002:a9d:19e8:: with SMTP id k95mr15701281otk.209.1544050507745;
        Wed, 05 Dec 2018 14:55:07 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v1sm7969760otq.80.2018.12.05.14.55.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 14:55:06 -0800 (PST)
Date:   Wed, 5 Dec 2018 16:55:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, robh+dt@kernel.org,
        andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        tsoni@codeaurora.org, clew@codeaurora.org, akdwived@codeaurora.org,
        ohad@wizery.com, mark.rutland@arm.com,
        linux-remoteproc@vger.kernel.org,
        Sibi Sankar <sibis@codeaurora.org>
Subject: Re: [PATCH] dt-bindings: remoteproc: qcom: Add power-domain bindings
 for Q6V5
Message-ID: <20181205225506.GA5884@bogus>
References: <20181120210828.12590-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120210828.12590-1-sibis@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Nov 2018 02:38:28 +0530, Sibi Sankar wrote:
> Add power-domain bindings for Q6V5 MSS on SDM845 SoCs.
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
> 
> Add dt-binding corresponding to https://patchwork.kernel.org/patch/10586893/
> (remoteproc: q6v5: Add support to vote for rpmh power domains)
> 
>  .../devicetree/bindings/remoteproc/qcom,q6v5.txt      | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
