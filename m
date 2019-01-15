Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC2C3C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 18:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8CCB20675
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 18:38:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RUxRMQr9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388853AbfAOSiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 13:38:51 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43484 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731562AbfAOSiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 13:38:51 -0500
Received: by mail-pf1-f195.google.com with SMTP id w73so1704356pfk.10
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 10:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=97c/zbrw1lhcEERw30xzUHLfl5pE9GsPK0D13XdTJ+I=;
        b=RUxRMQr9niVCS7FqPd1EeHuMGOj++UoxghdNhFwQoK61MYDvGL1W+o7FDyynGA4uB+
         cGRsf3RSvMywZ5X3Askc9GSPH2zkmtNcbGtUsGXNH3skNZJAvkq6AovPRQRBX3niAF2n
         YJ3zdFCYKuN1u8BUGs2OR9PYow2iEo7PQwTm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=97c/zbrw1lhcEERw30xzUHLfl5pE9GsPK0D13XdTJ+I=;
        b=IJyj70FKy4wRr/mAbImVwDWFzy5pwHmGY5uT+Fxji6waPee/vIbAF0Y6zDDW8dF9J3
         dnrMz8d/mwXQ3oToQYci5jbHSPENTy5BaxjTsxcKDQtJ++LNbSrnTlY2KRFxT2d+HboB
         FCSiagycmWUD2UeTQTO/jCgGPvDkqlYWQvk7KR4smErj3xQsaYvmRP7qlciZfAogyh7u
         x743f8fLZjNzrjml81s0DEHy76YktP6UMpfisJZs3SYnVKPGvZnS14p85j30M2qUWWXW
         YtNwD08CM9AEPWJcXN2ZX7xNTccQ1Urg4iageNOmjAitfmLcOGczuaJk5ot8FapQ07/4
         eakg==
X-Gm-Message-State: AJcUukepgqLMJ3ejqXNjrXT/2hb252IuWZe3gxG9rXlXga5XCdyLa0b1
        aLky7lKEpqC7G481KkSA74C7Ig==
X-Google-Smtp-Source: ALg8bN5MbkIZ6FO8aMgGfxg1wMMefpb1tC22HTWimEPKeYoORKaKBTqiaV5uGrenAPKFDX+6ZOeWVA==
X-Received: by 2002:a63:790e:: with SMTP id u14mr5020354pgc.452.1547577530420;
        Tue, 15 Jan 2019 10:38:50 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id z14sm4097830pgv.47.2019.01.15.10.38.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 10:38:49 -0800 (PST)
Date:   Tue, 15 Jan 2019 10:38:06 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jeffrey Hugo <jhugo@codeaurora.org>
Cc:     balbi@kernel.org, andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kishon@ti.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 5/6] usb: dwc3: qcom: Add support for MSM8998
Message-ID: <20190115183806.GG28907@builder>
References: <1547483838-5482-1-git-send-email-jhugo@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547483838-5482-1-git-send-email-jhugo@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 14 Jan 08:37 PST 2019, Jeffrey Hugo wrote:

> Add a MSM8998 specific DT compatible so that we can properly bind to the
> device and enable the USB controller.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
> ---
>  drivers/usb/dwc3/dwc3-qcom.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
> index a6d0203..184df4d 100644
> --- a/drivers/usb/dwc3/dwc3-qcom.c
> +++ b/drivers/usb/dwc3/dwc3-qcom.c
> @@ -595,6 +595,7 @@ static int __maybe_unused dwc3_qcom_runtime_resume(struct device *dev)
>  static const struct of_device_id dwc3_qcom_of_match[] = {
>  	{ .compatible = "qcom,dwc3" },
>  	{ .compatible = "qcom,msm8996-dwc3" },
> +	{ .compatible = "qcom,msm8998-dwc3" },
>  	{ .compatible = "qcom,sdm845-dwc3" },
>  	{ }
>  };
> -- 
> Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
> Qualcomm Technologies, Inc. is a member of the
> Code Aurora Forum, a Linux Foundation Collaborative Project.
> 
