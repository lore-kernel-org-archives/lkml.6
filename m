Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 783B6C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46E8F217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550507714;
	bh=ZXxP/GJFShnByg76GNDSgCDDeZ0s7cUIZeTZmpRcWWU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LcDDf3rLfCN4DivnHNgiNzVeSEA7DirfCxQb0eNThuvnSyYYNmUta63grcWEgLpLA
	 UQz2WErEy05uOSxw8NfIepK6zx4DtvN0Ahm0dHHdUp6TwUAN9ZzX3pDgw0zr/TgMkN
	 GuLzVLEERjEEAFdoBZYJPrFxnpZsrldZKz3pow4g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389532AbfBRQfM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 11:35:12 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40954 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732547AbfBRQfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 11:35:09 -0500
Received: by mail-ot1-f65.google.com with SMTP id s5so29253636oth.7;
        Mon, 18 Feb 2019 08:35:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3PFGDgi5xcJ65mW9sWl3moTVi3+lSPbNDNK8uZoVHZ0=;
        b=BRn0T0UH3fr3jzFkC0MVr5k3//K0oD2fkvjE8XF9EcyzE95JEexIlBqZ64ozrXrtsV
         CH6K8awYUV4/ZLBUskRcPYRVXYRtgQ/DydDrKSi2Fx4JqqarDVuKLsofH19qtSiFDYCI
         hyeX4dqa/mvcBRi+SbiYsh5Lylqg4LtRMO3zafBhpwH5CseQ0/j5LPoTsPwe4EWsADTo
         XcD0HrqcsbM6y9AfnLg6UmdZCJlJuN654/XGXsv4Cb2VJdPs2/Q3IkJi9YgY5KD7GuGt
         tcQCa7n/9p5fw5yG5CCxlh3Og69aPfg9urCmPXFUI7rABpCdZoQTZq8tQrB/jZY1EKRe
         MIUg==
X-Gm-Message-State: AHQUAuYowxuWzUNsobWB2g9RDCZHJp17K19Mnfmo9ChILy/Of9/paQzA
        YWX9OAOxxedarKM3ncEt5w==
X-Google-Smtp-Source: AHgI3IbVcXIfWZ9k++U7Eiqax8/gQ5zmyZgjyinNninLCDxGArJVziNbUh88j8q+Hx2FFQ4YCiuU4Q==
X-Received: by 2002:aca:f389:: with SMTP id r131mr15083335oih.58.1550507708104;
        Mon, 18 Feb 2019 08:35:08 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b20sm4917857otp.59.2019.02.18.08.35.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 08:35:07 -0800 (PST)
Date:   Mon, 18 Feb 2019 10:35:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v6 01/11] dt-bindings: mfd: add DT bindings for max77650
Message-ID: <20190218163507.GA16551@bogus>
References: <20190214140022.19201-1-brgl@bgdev.pl>
 <20190214140022.19201-2-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214140022.19201-2-brgl@bgdev.pl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Feb 2019 15:00:12 +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Add a DT binding document for max77650 ultra-low power PMIC. This
> describes the core mfd device and the GPIO module.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  .../devicetree/bindings/mfd/max77650.txt      | 46 +++++++++++++++++++
>  1 file changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/max77650.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
