Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 572D4C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 22:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D4D820643
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 22:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551133922;
	bh=iJLUtAnJFOQvpqGCa5/ZAFM+F3obArf2W+xuR9Z7nkw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ux54fa7rE0PSkg28X0Kgn+dUYII5KFWs7Ea4pU84gRsoPvsBFjGrvi+iaTkw0Csw1
	 eJLJjQ3gFrETTwQ92I1OJ2rCNE3vDkfMlx9FIRqIIdN7GZ20QA7NVTzidRy88voTkM
	 I7lh4zizZEPa1ddnFlwCrmmLhr32SSPP2UdeMYwI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbfBYWcA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 17:32:00 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42759 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbfBYWcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 17:32:00 -0500
Received: by mail-oi1-f196.google.com with SMTP id s16so8688498oih.9;
        Mon, 25 Feb 2019 14:31:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=y2dqisaRlFk1QP8IkTSZ0gpEqnu+txPcSevzKKdpivU=;
        b=nSfJRqRJkUrgEN3eD0FRPPGtmoy3wR468VWbJzFkDZIxRLJjr2S+t4lH4sRKp6liak
         kv+kRnGfZqjbnht3qbTzifpliETBBd8Gj+3kUFOXz9fSuDM7m/UleHPuK/voRq9A0MPQ
         qEtoe4a+cF5VjOZxXF68xg4tk4l4ePRFlOYiNvMxEU1hkyNER7+QPR6/5mBicyoJ1/+r
         O/NlGiDyQFEiZ/DxsyabH2hTT1YrRMFkbLf/i8BLicnkpJkRZYfHvu9HetzvUVfSiAn9
         EaZ8o/DC/Qu7/J9elelePmEe5BDJFXOWpPvzGadl6yTJLJVzDWfntFfHU6+yunUS3em3
         7IAA==
X-Gm-Message-State: AHQUAua3dw+j18DTcfxiMOkk0mDTNhCa5KKxhIcqaa9GbJRCmtmqqKMa
        vG52TgMD267MEoFxFEs4sQ==
X-Google-Smtp-Source: AHgI3IYgbuxAgrPaTX4IDeMjRnTWgochW2I7Wgk8TVJmdrpgElp50LlP6YJUIxCu3cQYEcY4d+1/pg==
X-Received: by 2002:aca:b208:: with SMTP id b8mr445197oif.40.1551133919539;
        Mon, 25 Feb 2019 14:31:59 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e89sm7088869otb.30.2019.02.25.14.31.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Feb 2019 14:31:58 -0800 (PST)
Date:   Mon, 25 Feb 2019 16:31:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v1 20/24] dt: thermal: tsens: Add bindings for qcs404
Message-ID: <20190225223158.GA7289@bogus>
References: <cover.1549525708.git.amit.kucheria@linaro.org>
 <3f5a9282e815d2244b633a65e126494d23c16a7a.1549525708.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f5a9282e815d2244b633a65e126494d23c16a7a.1549525708.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  7 Feb 2019 16:19:38 +0530, Amit Kucheria wrote:
> qcs404 uses v1 of the TSENS IP block. Create a fallback DT property
> "qcom,tsens-v1" to gather common code
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  .../devicetree/bindings/thermal/qcom-tsens.txt     | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
