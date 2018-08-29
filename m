Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F2AC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 00:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6482F205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 00:25:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6482F205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbeH2ETq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 00:19:46 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:33143 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbeH2ETp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 00:19:45 -0400
Received: by mail-oi0-f66.google.com with SMTP id 8-v6so6178086oip.0;
        Tue, 28 Aug 2018 17:25:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b1Lh2bmeUCjRDTOE89zXro+k/Q/Oqj4Yv8wI5F1KBs8=;
        b=ZZDt8Trz8Cb9L9jFFnYOv7gCfB35SmmUgpmB11ZgqIAgX3DnCsGV9sN/HjnOORowrh
         Dw1XUr4Ope3gaA7CQk6bhxZG1DTuJ7JyrgLLnInobeV9fIeLD08BHvuHGb6wnH0k3Tq8
         znYnI/36SdAJWLPuu/XuXx9XuDVsp2BJDnR4IVt0lplqbrQjQh6vjAJN7p9Hi+oPnjNu
         cxzhMY2dqGmSo5CbQiS9Q2r7V/owNeK/WGnDATeRnHO5hhv1AK+U945Y0Tnza1CGu8f9
         31TMxPm9bIfsRZ/nyWl97Mua84beJXb2Zn0UG3/T/tA1uCsOw0KQfu8W3d3h/UWCDLE8
         WkXQ==
X-Gm-Message-State: APzg51B/RM3yiibyUHqblXDIkE6qwX49tJutRMDWX4JUTwx0ZcdfQd8J
        zmgjFLh1LvVvGb9Mjx8t9g==
X-Google-Smtp-Source: ANB0VdYjDpXlFo8ltIQu+G5aAEGt83evG/AbgsPxO+3TThORYQ9R1HHXs7cPZBeWMuOprUaZrzuMFA==
X-Received: by 2002:a54:4805:: with SMTP id j5-v6mr492190oij.210.1535502336868;
        Tue, 28 Aug 2018 17:25:36 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i3-v6sm1271749oiy.12.2018.08.28.17.25.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 17:25:36 -0700 (PDT)
Date:   Tue, 28 Aug 2018 19:25:35 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dilip Kota <dkota@codeaurora.org>
Cc:     swboyd@chromium.org, broonie@kernel.org, mka@chromium.org,
        dianders@chromium.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org,
        Girish Mahadevan <girishm@codeaurora.org>
Subject: Re: [PATCH V3] spi: spi-geni-qcom: Add SPI driver support for GENI
 based QUP
Message-ID: <20180829002535.GA4224@bogus>
References: <1535107336-2214-1-git-send-email-dkota@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535107336-2214-1-git-send-email-dkota@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 04:12:15PM +0530, Dilip Kota wrote:
> From: Girish Mahadevan <girishm@codeaurora.org>
> 
> This driver supports GENI based SPI Controller in the Qualcomm SOCs. The
> Qualcomm Generic Interface (GENI) is a programmable module supporting a
> wide range of serial interfaces including SPI. This driver supports SPI
> operations using FIFO mode of transfer.
> 
> Signed-off-by: Girish Mahadevan <girishm@codeaurora.org>
> Signed-off-by: Dilip Kota <dkota@codeaurora.org>
> ---
> Addressing all the reviewer commets given in Patchset1.
> Summerizing all the comments below:
> 
> 	MAKEFILE: Arrange SPI-GENI driver in alphabetical order
> 	Kconfig: Mark SPI_GENI driver dependent on QCOM_GENI_SE
> 	Enable SPI core auto runtime pm, and remove runtime pm calls.
> 	Remove spi_geni_unprepare_message(), spi_geni_unprepare_transfer_hardware()
> 	Remove likely/unlikely keywords.
> 	Remove get_spi_master() and use dev_get_drvdata()
> 	Move request_irq to probe()
> 	Mark bus number assignment to -1 as SPI core framework will assign dynamically
> 	Use devm_spi_register_master()
> 	Include platform_device.h instead of of_platform.h
> 	Removing macros which are used only once:
> 	        #define SPI_NUM_CHIPSELECT     4
> 	        #define SPI_XFER_TIMEOUT_MS    250
> 	Place Register field definitions next to respective Register definitions.
> 	Replace int and u32 declerations to unsigned int.
> 	Remove Hex numbers in debug prints.
> 	Declare mode as u16 in spi_setup_word_len()
> 	Remove the labels: setup_fifo_params_exit: exit_prepare_transfer_hardware:
> 	Declaring struct spi_master as spi everywhere in the file.
> 	Calling spi_finalize_current_transfer() for end of transfer.
> 	Hard code the SPI controller max frequency instead of reading from DTSI node.
> 	Spinlock not required, removed it.
> 	Removed unrequired error prints.
> 	Fix KASAN error in geni_spi_isr().
> 	Remove spi-geni-qcom.h
> 	Remove inter words delay and CS to Clock toggle delay logic in the driver, as of now no clients are using it.
> 	Will submit this logic in the next patchset.	
> 	Use major, minor and step macros to read from hardware version register.
> 
>  .../devicetree/bindings/soc/qcom/qcom,geni-se.txt  |   2 -

Please split to a separate patch and explain why you are removing 
spi-max-frequency?

>  drivers/spi/Kconfig                                |  12 +
>  drivers/spi/Makefile                               |   1 +
>  drivers/spi/spi-geni-qcom.c                        | 678 +++++++++++++++++++++
>  4 files changed, 691 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/spi/spi-geni-qcom.c
