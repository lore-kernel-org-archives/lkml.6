Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C168CC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F82620989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548862981;
	bh=gDMKV8j2KfSo5hcMhcNt/HfD9/TRWVMNpTVCFGOBak4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vRTFpt9+84QuyYW0S2aa3hg4TLOsKBFaUzTVcnmc3QEzFeJrW6dTrq5MnP4HmBz+Q
	 wkAhFslp5IXMt2OEo+7rdQM96w9JSkqwDlb/Eu0Ghd1kmFVTuajDO0Xjyqkqr7Ov2h
	 q+YO+EkR6p/naovvV+MgFFNiTVywohQR2NFPk9M0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731536AbfA3Pm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 10:42:59 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44178 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729755AbfA3Pm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 10:42:59 -0500
Received: by mail-ot1-f68.google.com with SMTP id g16so17456149otg.11;
        Wed, 30 Jan 2019 07:42:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dPqZEMJw5cB8zPRb7QEMBKK1fjbxjFRkq/X59AUH1Ew=;
        b=PWRZmuDGMjTsR3XlcoqQVlao88pnu6NgiwMgFVUycJFhiz5tFhZHy2DjiQYbAoOTZa
         Ux/FpslA6RYUHTge0LjKA2insYQUqORYSh75nrMGZGfpd37OC17c7CjBlzP9tJ4YfKfH
         mliIOx4A/nay5ldyKnZJLy8us32Sh6VDD7jegtWqtjoeLoB2b2tOLofCFWMunmF0RiVU
         FmVphuGaSbKYyQmqIOzuAJcLE/5ZMmpj3DD641I1pknBvRoe1LE6eXJ2X69g58i5M+oN
         lpRpdFaErNNlxTI9fFkcgTEHIbciP8wJ7dym3GnCbvnmHEb1yd7s9sGadQWdAJsx8u18
         OFPw==
X-Gm-Message-State: AHQUAuYyBMteJJwXGdmsNZgBDSf9vPnHKAXW59SR3ddLoib3l74VvXMQ
        GzDS6S2tNFIVStRK2ZYTPQ==
X-Google-Smtp-Source: AHgI3IYN0gNbQz+3+m18kilPwPqpTRjPci7Qc6UXkSV4VMTzCpfVDU3sTUhq3vEO7IHw7oWvSmXQaQ==
X-Received: by 2002:a9d:5e8c:: with SMTP id f12mr4093033otl.343.1548862978278;
        Wed, 30 Jan 2019 07:42:58 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x127sm760422oia.20.2019.01.30.07.42.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 07:42:57 -0800 (PST)
Date:   Wed, 30 Jan 2019 09:42:57 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jeffrey Hugo <jhugo@codeaurora.org>
Cc:     mark.rutland@arm.com, balbi@kernel.org, bjorn.andersson@linaro.org,
        andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: usb: Add support for msm8998
Message-ID: <20190130154257.GA15568@bogus>
References: <1548106307-4762-1-git-send-email-jhugo@codeaurora.org>
 <1548106366-5042-1-git-send-email-jhugo@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548106366-5042-1-git-send-email-jhugo@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 02:32:46PM -0700, Jeffrey Hugo wrote:
> msm8998 USB has a dwc3 controller just like the existing sdm845 support.
> 
> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  Documentation/devicetree/bindings/usb/qcom,dwc3.txt | 1 +
>  1 file changed, 1 insertion(+)

You missed my R-by.
