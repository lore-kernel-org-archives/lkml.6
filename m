Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45266C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 132F121736
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550508374;
	bh=eqsId/OK+VlIKdF3LFs5zis7SQlmLtl9muLmB3wljzU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Jr434FC6k20U5dPw5DdL/aqZoMUu/jUyfud6IJke5ARtowUUdNP4/K3R3Suf07V0C
	 AtlZx2mWVal1Z3mdilf6focGe+vIVDfTP4akGgEidLcJQ5AXZpannsRhDM40qDGeX2
	 gfX7yLDYlvQ1DNmSFTxS7ErZ3IRdOdTlBA8rcMlE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390130AbfBRQqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 11:46:11 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42414 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731585AbfBRQqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 11:46:11 -0500
Received: by mail-ot1-f66.google.com with SMTP id i5so29280692oto.9;
        Mon, 18 Feb 2019 08:46:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1pB+kd9kPsoPu+0PZ/6uERp37dnafLQ9czcFpu+3E54=;
        b=et2AwFvyJyyupSinUjxXT43Rrij4M3YMlGni1/+DU0C0PbyK4Z9UZD7MkvZNinULcF
         E8RHuRHa8XaVVRpFo7SuIZjRC9Vks0eme0TwEphrnnuj4eJOkgoklVpwivOet4QTNSCJ
         N3xpkZw2S4bn+tcLo7pXKXV2qXwh0i4DbY+lpB+jEKUExszknQI4y0D97DoBl19jYHKg
         CGg24JiiK81YY49sE6lpU3AHQVSl4fBxFAg3JY1NTtLgStPkbPQxjCbbvugEKYesSRUT
         m/7iL6afastX4iWoU960X9cF95Fx3qKkNoRF9bM9AjH0z3bdbAW6JjAh6ZhgfAZZEM55
         pgpQ==
X-Gm-Message-State: AHQUAuZRTULG5TSgUM+4sALESEdtyknmIsOPV1zxbi3L4UOVgQE50M4C
        6ErEJLjxxy7AUqEZVftj9Q==
X-Google-Smtp-Source: AHgI3IaPhio2Z5Z0HIlrJVwOEzy8R4oA9FoihKKFFa2nNeU1n/uSFKnnSAzI5qnN5ynzv/EYxWzjnA==
X-Received: by 2002:a9d:4e10:: with SMTP id p16mr4425800otf.65.1550508370538;
        Mon, 18 Feb 2019 08:46:10 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n8sm5848662otl.40.2019.02.18.08.46.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 08:46:09 -0800 (PST)
Date:   Mon, 18 Feb 2019 10:46:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Pawel Laszczak <pawell@cadence.com>
Cc:     devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
        felipe.balbi@linux.intel.com, mark.rutland@arm.com,
        linux-usb@vger.kernel.org, hdegoede@redhat.com,
        heikki.krogerus@linux.intel.com, andy.shevchenko@gmail.com,
        robh+dt@kernel.org, rogerq@ti.com, linux-kernel@vger.kernel.org,
        jbergsagel@ti.com, nsekhar@ti.com, nm@ti.com, sureshp@cadence.com,
        peter.chen@nxp.com, kurahul@cadence.com,
        Pawel Laszczak <pawell@cadence.com>
Subject: Re: [PATCH v4 1/6] dt-bindings: add binding for USBSS-DRD controller.
Message-ID: <20190218164609.GA2649@bogus>
References: <1550173514-23573-1-git-send-email-pawell@cadence.com>
 <1550173514-23573-2-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550173514-23573-2-git-send-email-pawell@cadence.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Feb 2019 19:45:09 +0000, Pawel Laszczak wrote:
> This patch aim at documenting USB related dt-bindings for the
> Cadence USBSS-DRD controller.
> 
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> ---
>  .../devicetree/bindings/usb/cdns-usb3.txt     | 30 +++++++++++++++++++
>  1 file changed, 30 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/cdns-usb3.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
