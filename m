Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E46F2C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 21:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA3DB20825
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 21:41:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA3DB20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387940AbeKFHD3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 02:03:29 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37217 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387580AbeKFHD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 02:03:29 -0500
Received: by mail-ot1-f66.google.com with SMTP id 40so9288267oth.4;
        Mon, 05 Nov 2018 13:41:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tX1gw49d9m2uCXaNY0+2gUAbIMYbTyC0HGJrZ2UVEb4=;
        b=Yl4I/xu2zjrdmjxfxNbNpA5ZlXsaHjlNb5tDhgNc5hZDx4GJg07n/JHn6LNfeUgtyN
         FuxL79oDRZxu2ObeVbiGB6y1ArIB84QgCk0PTRkhn62xQhvNTV92aQAtUUeMzHvaI9X+
         6528EMCA2NTz5V2TdF2/mooLMHFWQ27ZrPSDS9XtUwyU2CeMsZtnrqrGlmXhvmEOnetT
         WT2/MC2Xe3xuafNl42PcWWguCmG8C98KQPVq0pBJ+QplVQmUyQyqAvT9/F9ad7mvhwB8
         kZZrR/+r5zMn/sDxM+elMINT+DOlLNJSbNrerLmIv3xqO/M5lX3gDN4fcCesuGG/6O9E
         KmYA==
X-Gm-Message-State: AGRZ1gKXED4wbTwbBCSh0tPqivUVAbt/B0KSVbnCh0JzzGIdtP9rnJsK
        3B3DUqu6KuGpMWCVbpkznUylWuw=
X-Google-Smtp-Source: AJdET5fy5S7IhGhGOjGxUcftKQPK/aguKjzokXSOuxylcwOlQ7B5XakvtkgI0aQG8/EdhGGglPscbA==
X-Received: by 2002:a9d:4c88:: with SMTP id m8mr2701318otf.360.1541454105068;
        Mon, 05 Nov 2018 13:41:45 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r15-v6sm2961196oie.31.2018.11.05.13.41.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 13:41:44 -0800 (PST)
Date:   Mon, 5 Nov 2018 15:41:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alan Douglas <adouglas@cadence.com>
Cc:     kishon@ti.com, linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        Alan Douglas <adouglas@cadence.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: phy: Document cadence Sierra PHY
 bindings
Message-ID: <20181105214143.GA13336@bogus>
References: <1541003646-26637-1-git-send-email-adouglas@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541003646-26637-1-git-send-email-adouglas@cadence.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Oct 2018 16:34:06 +0000, Alan Douglas wrote:
> Add DT binding documentation for Sierra PHY.  The PHY supports
> a number of different protocols, including PCIe and USB.
> 
> The PHY lanes may be configured as single or multi-lane links.
> Each link is treated as a separate sub-node.  For example, if
> there are 4 lanes in total the first 2 might be configured as
> a multi-lane PCIe link while the other two are single lane
> USB links, and in this case there would be 3 sub-nodes.
> 
> There are two resets for the PHY block (one for APB register
> access, one for the PHY link) and separate resets for each
> link.  For multi-lane links, the reset corresponds to the
> reset line on the master lane, the resets on other lanes
> have no effect.
> 
> Signed-off-by: Alan Douglas <adouglas@cadence.com>
> ---
>  .../devicetree/bindings/phy/cdns-sierra-phy.txt    | 68 ++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/cdns-sierra-phy.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
