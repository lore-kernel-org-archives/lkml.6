Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA050C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 22:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85F7A21928
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 22:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IC5nHjRR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392120AbeLUWGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 17:06:44 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35605 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390529AbeLUWGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 17:06:44 -0500
Received: by mail-pl1-f195.google.com with SMTP id p8so3075666plo.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 14:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=K/q9v1nxOdyWPHNY2DLT7Xv6QLj4BD4gn6w4Py16aVU=;
        b=IC5nHjRR8+OH01uaHKwPuHGF85xVatogvAHszqlsN5OHW7A2Fx5Hj2au4mmJx/Ewtb
         Kr5qA9MfxRq+/ZUqsoINNSM2JBuwr/IZD9F8RJj/owyqXIzYPUKII/XCUGTqQuTgw+Wt
         Su6cQqrJd3h8G8N25xcQkrzcyX/0W5q8obQGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K/q9v1nxOdyWPHNY2DLT7Xv6QLj4BD4gn6w4Py16aVU=;
        b=qqj0JiliFbxYGPP6nIgqraBEdEbDLtzcndgxMh048ElGHjf4zi0c5Rq7HlfCs9H10b
         VigT+D0yb0o/3SDaTg5CxJZ6GW/4mRYrnRwgKTuiPdC4WBzyuEDzr85hTFLPNUp0+ZMv
         TWeZtOR7JIU+f3TOVd0jNWqBhDzqhhYmRvp25cTzD1XpRCmYmxfthGb4wQaOzru+Rgm0
         7WOgsam25xuAOv1iA3p71D1BYY4gLRfuZf6fi7si5rFTQCulPuwSYv1OW6w9wIxcgWlC
         xAUryVQzj0mxFp8Rg1Eo/QMOR/HQqDa3tnyj+5pYinpKhIlKUzPtbGg0Lfqe9ptJC2b6
         C2Kw==
X-Gm-Message-State: AJcUukfi9lIYgKL/ocComtKAEVsubANeTYSEti3qkvCqhcFRKT1xLUZL
        HVGcFbDTZxdHFOMoJbHpfrSEvw==
X-Google-Smtp-Source: ALg8bN60iiB/Y55psq5JfrelxFZ36Tal0JOeetSEru9e1N2pHZM+rPIQ0BU6hqIb/2yJmAEeCpNCKA==
X-Received: by 2002:a17:902:2a0a:: with SMTP id i10mr4148274plb.323.1545430003467;
        Fri, 21 Dec 2018 14:06:43 -0800 (PST)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id r66sm36157546pfk.157.2018.12.21.14.06.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Dec 2018 14:06:42 -0800 (PST)
Date:   Fri, 21 Dec 2018 14:06:40 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Evan Green <evgreen@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        Brian Norris <briannorris@chromium.org>,
        Ben Chan <benchan@chromium.org>, linux-arm-msm@vger.kernel.org,
        David Brown <david.brown@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] soc: qcom: rmtfs-mem: Make sysfs attributes
 world-readable
Message-ID: <20181221220640.GC9704@minitux>
References: <20181221201001.160613-1-evgreen@chromium.org>
 <20181221201001.160613-3-evgreen@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181221201001.160613-3-evgreen@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 21 Dec 12:10 PST 2018, Evan Green wrote:

> In order to run an rmtfs daemon as an unprivileged user, that user would
> need access to the phys_addr and size sysfs attributes. Sharing these
> attributes with unprivileged users doesn't really leak anything
> sensitive, since if you have access to physical memory, the jig is
> up anyway.
> 
> Make those attributes readable by all.
> 
> Signed-off-by: Evan Green <evgreen@chromium.org>
> Reviewed-by: Brian Norris <briannorris@chromium.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
> 
> Changes in v2: None
> 
>  drivers/soc/qcom/rmtfs_mem.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/soc/qcom/rmtfs_mem.c b/drivers/soc/qcom/rmtfs_mem.c
> index 99a1363ece254..815c11aeceb93 100644
> --- a/drivers/soc/qcom/rmtfs_mem.c
> +++ b/drivers/soc/qcom/rmtfs_mem.c
> @@ -45,9 +45,9 @@ static ssize_t qcom_rmtfs_mem_show(struct device *dev,
>  			      struct device_attribute *attr,
>  			      char *buf);
>  
> -static DEVICE_ATTR(phys_addr, 0400, qcom_rmtfs_mem_show, NULL);
> -static DEVICE_ATTR(size, 0400, qcom_rmtfs_mem_show, NULL);
> -static DEVICE_ATTR(client_id, 0400, qcom_rmtfs_mem_show, NULL);
> +static DEVICE_ATTR(phys_addr, 0444, qcom_rmtfs_mem_show, NULL);
> +static DEVICE_ATTR(size, 0444, qcom_rmtfs_mem_show, NULL);
> +static DEVICE_ATTR(client_id, 0444, qcom_rmtfs_mem_show, NULL);
>  
>  static ssize_t qcom_rmtfs_mem_show(struct device *dev,
>  			      struct device_attribute *attr,
> -- 
> 2.18.1
> 
