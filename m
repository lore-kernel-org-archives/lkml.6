Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC307C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 22:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9248C20878
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 22:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547244613;
	bh=CTwh986xrYwvX1z2sLKznCslmWecH7/dZjC43uA2aww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nWQDDuCEbJ7698pm5uDnlvbHQ67uOLIzGrMkMGw/dTQWKOLIsWoKXmQjfm7zwYB2e
	 XBCfN7T96zZZ9kY1XLOmzqAYaqjqyflFEmUpB04LaMJF6xABXdP1a1oAldjdiOGkkJ
	 4HMAk1glMBhV4SE070K+reI0YNkZXHN3YEA0MNt0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbfAKWKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 17:10:13 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42214 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbfAKWKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 17:10:12 -0500
Received: by mail-oi1-f195.google.com with SMTP id w13so13437053oiw.9;
        Fri, 11 Jan 2019 14:10:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MTIx6gC/08kpHr+63+39PYHbfQ88igAZbpZN9F5Ippk=;
        b=knWiJWzXR3+bsW5SCEnWPCEFkbXRqNLwezbF98T41AINB1TUhzC0xZjtHh4RynMlJ1
         9H5yZIN1ynWbcrtV1NVpPx269R70stcl9rW7Urq3TIUDqq3+BbHrSDNIed6OOr0JTSWW
         cNfAhCe1YIcR5sjrRw8BDOxbaSLa9nxVgQOGbw60L9Qfk7dDq4egkrJsrRsb+cl9FB5p
         VJcTmZinNqmHU/hHykDvIBQOzWjv9Zh5EEBs/cXwDzG/NHZJwzHDMHr/i1OY8jagx42+
         jULl4BtQ79NV9YerOKh65QMGexd8nJY6j1paP3pnoHF4sl9+0HgliSPHTVJ3yE4gr7Q9
         kF7Q==
X-Gm-Message-State: AJcUukfFba7HOvCVXSYeJ1cqaLYjfkUeUKhNm/XW+0ETU2AJEAox0Y3M
        a/KokW4UxacxUSzs+SPcvJ/ia1LCUA==
X-Google-Smtp-Source: ALg8bN6oQLCMLlu7wjKGGENubM25iIhkG9PEDYBKP7qf4/mERj63emRc9okIlJr3YFsVAN6MC0kUEQ==
X-Received: by 2002:aca:4f16:: with SMTP id d22mr9878027oib.255.1547244611749;
        Fri, 11 Jan 2019 14:10:11 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 75sm76099850otc.67.2019.01.11.14.10.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 14:10:11 -0800 (PST)
Date:   Fri, 11 Jan 2019 16:10:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Arun Kumar Neelakantam <aneela@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/7] dt-bindings: soc: qcom: Add AOSS QMP binding
Message-ID: <20190111221010.GA25365@bogus>
References: <20190106080915.4493-1-bjorn.andersson@linaro.org>
 <20190106080915.4493-2-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190106080915.4493-2-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  6 Jan 2019 00:09:09 -0800, Bjorn Andersson wrote:
> Add binding for the QMP based side-channel communication mechanism to
> the AOSS, which is used to control resources not exposed through the
> RPMh interface.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Changes since v1:
> - Don't describe power-domain as a separate child node
> 
>  .../bindings/soc/qcom/qcom,aoss-qmp.txt       | 57 +++++++++++++++++++
>  include/dt-bindings/power/qcom-aoss-qmp.h     | 15 +++++
>  2 files changed, 72 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.txt
>  create mode 100644 include/dt-bindings/power/qcom-aoss-qmp.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
