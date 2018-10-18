Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED823ECDE3D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 00:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA04D21470
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 00:38:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA04D21470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbeJRIgw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 04:36:52 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44701 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726644AbeJRIgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 04:36:52 -0400
Received: by mail-ot1-f66.google.com with SMTP id p23so28081045otf.11;
        Wed, 17 Oct 2018 17:38:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fbUGO/MpLvaNZayhZDrcUBZwBkzGqdyAp27ZxJmaXeQ=;
        b=EjMJJAUt0Jn3hdSodHr/rzvGj3CmxA//TlZVsyVxMHZ6nz+SJ0zzmMgmgatmT8yL2i
         DvODCm+fDJ3/d34mtXoh9RExHMIilgz0if2L37D0RFyDLQtN10KJQ+2GSpAQPDQZbkmw
         B5uIYpuTGucgiycPQ5qq6/xxLjO990oY0ntuYDO9cwuqIuvZDUC2OsUrevppgBUB76ie
         wM6qsuvdAYcR0sVW8PYwLHcjpZLw34/mn788G0mDmX/eY9C6USu1TFd6mLJDze60W1bj
         1B0Zkysui/3WGjBmtR+ZzqCmOXcuu26kf3WjBIx6wfzOKDofoyFIQ99vjg7m7Vn7bMLH
         F1rg==
X-Gm-Message-State: ABuFfogro2jTzYAWNjNmLIYtT7epkUVyo+GJA5fvyx5QnJ/AAH4vonK9
        Foqi98CMpjEPh4jy37EY2w==
X-Google-Smtp-Source: ACcGV60ZkmEpMiCfYOt+AbpAdiEQIbD0L7wi2JhOZt6VV2e0dcE0H6RJ0lMhFasL5yJ26A2Rqea64g==
X-Received: by 2002:a9d:1ea5:: with SMTP id n34mr17526280otn.160.1539823114925;
        Wed, 17 Oct 2018 17:38:34 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 84-v6sm5350402oid.42.2018.10.17.17.38.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 17:38:34 -0700 (PDT)
Date:   Wed, 17 Oct 2018 19:38:33 -0500
From:   Rob Herring <robh@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Can Guo <cang@codeaurora.org>, evgreen@chromium.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, sayalil@codeaurora.org,
        Varadarajan Narayanan <varada@codeaurora.org>,
        asutoshd@codeaurora.org, Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] dt-bindings: phy-qcom-qmp: Fix several mistakes from
 prior commits
Message-ID: <20181018003833.GA573@bogus>
References: <20181012213632.252346-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181012213632.252346-1-dianders@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Oct 2018 14:36:32 -0700, Douglas Anderson wrote:
> Digging through the "phy-qcom-qmp" showed me many inconsistencies
> between the bindings and the reality of the driver.  Let's fix them
> all.
> 
> * In commit 2d66eab18375 ("dt-bindings: phy: qmp: Add support for QMP
>   phy in IPQ8074") we probably should have explicitly listed that
>   there are no clocks for this PHY and also added the reset names in
>   alphabetical order.  You can see that there are no clocks in the
>   driver where "clk_list" is NULL.
> 
> * In commit 8587b220f05e ("dt-bindings: phy-qcom-qmp: Update bindings
>   for QMP V3 USB PHY") we probably should have listed the resets for
>   this new PHY and also removed the "(Optional)" marking for the "cfg"
>   reset since PHYs that need "cfg" really do need it.  It's just that
>   not all PHYs need it.
> 
> * In commit 7f0802074120 ("dt-bindings: phy-qcom-qmp: Update bindings
>   for sdm845") we forgot to update one instance of the string
>   "qcom,qmp-v3-usb3-phy" to be "qcom,sdm845-qmp-usb3-phy".  Let's fix
>   that.  We should also have added "qcom,sdm845-qmp-usb3-uni-phy" to
>   the clock-names and reset-names lists.
> 
> * In commit 99c7c7364b71 ("dt-bindings: phy-qcom-qmp: Add UFS phy
>   compatible string for sdm845") we should have added the set of
>   clocks and resets for "qcom,sdm845-qmp-ufs-phy".  These were taken
>   from the driver.
> 
> * Cleanup the wording for what properties child nodes have to make it
>   more obvious which types of PHYs need clocks and resets.  This was
>   sorta implicit in the "-names" description but I found myself
>   confused.
> 
> * As per the code not all "pcie qmp phys" have resets.  Specifically
>   note that the "has_lane_rst" property in the driver is false for
>   "ipq8074-qmp-pcie-phy".  Thus make it clear exactly which PHYs need
>   child nodes with resets.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>  .../devicetree/bindings/phy/qcom-qmp-phy.txt  | 31 ++++++++++++++-----
>  1 file changed, 23 insertions(+), 8 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
