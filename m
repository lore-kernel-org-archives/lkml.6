Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA74C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 21:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B34120870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 21:16:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QtsO0r9G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfAVVQD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 16:16:03 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44568 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbfAVVQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 16:16:03 -0500
Received: by mail-oi1-f193.google.com with SMTP id m6so18677438oig.11
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 13:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RMc0v2LH6oxy7Huklc+Law+4SeWhGACTij/rztzUOAw=;
        b=QtsO0r9GXX+pQJzYH55kQ+th9CY+rc1dMgBlbhYcNbDD3grW9ewZm2DrcvK1b/yY7L
         n3CpyNMLgp2eFhZVpYcqnbInijxYjbEGT3ugwIPFz63tXsq8Juw7LVwa4r6qAnpPcShn
         IZHGP5I5AKUNDZHMFTtXgmybYFQBYqLAN1EEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RMc0v2LH6oxy7Huklc+Law+4SeWhGACTij/rztzUOAw=;
        b=a8VxiA+ySch4Jj/A64Qoghfi+HAr9FSETIE1dD3uhIucj5cZ73ckTGCoZxLmEyDKSp
         sMFgiG42gSnc0ODDoITYqVZfNEmygMZSg419yHxGrHHif/JMqcpg5yoxgeb963+soKJ3
         azGpf7gPJpkc+M6vilHe6/6XxmPCkOUS1LhcNj9N9+WXNkCWed/kWG21nUQzKmBHHad8
         yoJkpW9zTdGo6GJD4ouviiJQFn/452xYuSveS9ScBvQIQ6UQO4ocgDpSZOp9J0ObgJsZ
         LeVdEEoRz5OerI0+yBtn891j0EvlJjU9fuSnp9biatp9H+YiplcqZ5b75SDRA3Yo3dWJ
         pJ5w==
X-Gm-Message-State: AJcUukeEd7IFE0GteDFVPKdMVCT8DXtcsVoQ7xMJOqbP+q0rqEV2o7rW
        jUov5j15wC2FLDTBd2CJxcvc0w==
X-Google-Smtp-Source: ALg8bN5VeGZgmf3i/9U9b4wI0QLK3xjbXA8TWXny9xUS+vsddHR5EayKBTji1jX+n9uy9r2gO9abAw==
X-Received: by 2002:a54:4f86:: with SMTP id g6mr9100032oiy.205.1548191762445;
        Tue, 22 Jan 2019 13:16:02 -0800 (PST)
Received: from localhost (107-207-74-175.lightspeed.austtx.sbcglobal.net. [107.207.74.175])
        by smtp.gmail.com with ESMTPSA id v1sm7300462otq.80.2019.01.22.13.16.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 13:16:01 -0800 (PST)
Date:   Tue, 22 Jan 2019 15:15:58 -0600
From:   Andy Gross <andy.gross@linaro.org>
To:     Jeffrey Hugo <jhugo@codeaurora.org>
Cc:     mark.rutland@arm.com, balbi@kernel.org, bjorn.andersson@linaro.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v3 2/3] usb: dwc3: qcom: Add support for MSM8998
Message-ID: <20190122211558.GB30582@hector.attlocal.net>
References: <1548106307-4762-1-git-send-email-jhugo@codeaurora.org>
 <1548106388-5079-1-git-send-email-jhugo@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548106388-5079-1-git-send-email-jhugo@codeaurora.org>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 02:33:08PM -0700, Jeffrey Hugo wrote:
> Add a MSM8998 specific DT compatible so that we can properly bind to the
> device and enable the USB controller.
> 
> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
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

Reviewed-by: Andy Gross <andy.gross@linaro.org>
