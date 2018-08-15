Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE1AC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EC1421531
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:26:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EC1421531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbeHOXUO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 19:20:14 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:37315 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727981AbeHOXUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 19:20:13 -0400
Received: by mail-it0-f67.google.com with SMTP id h20-v6so3682957itf.2;
        Wed, 15 Aug 2018 13:26:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fMRxdPGL/eNOrqCVQ0s2L9bqqocnj5pCLbb6DgqbFYs=;
        b=h6CpYaZWLfWYqWfT0jkU9Wt03BkLDKcOJcKi4S/y+kWw0ApPx7PfhMjIN0Hl7nXX74
         YVVyKnSWvAQS6NFR6rQ1rf/dYWaocAqZ/zrfUMRqw81rOX1QdSnBcm4SeaWHQfU2AUhO
         FlyfphbMxOvXT5jOecEYuYT2RLf/pAX0Y0eoBBGbjLMPns3FNxqBeU1qj860T5yRSTiU
         w1vHaa9kV6zKoUU5mzvpxQUGqDYk0xLhZTdJrTsPxlRy97j//tfh6YwpUxZZKmGuSrRc
         zR3Q8lzRGfn7AB+iDnE9DMGF5FuFTKBFn5YX7R21Ojca/z+j9ReiD7dki8b0SH06iUx5
         2waA==
X-Gm-Message-State: AOUpUlF/yYQvbz/m/TAV9sx5BwiCLJP1Qr+juLnGs0282j8lXsWz2nVn
        tZJlEs/n1ULjC/KFrNn03g==
X-Google-Smtp-Source: AA+uWPxiKEmPkrEwWjSPSM1TDG1eAoE8+EuIjT+BDHksQDoWVJ6y6o424sXXB91wF5IlXRxDIA55ZQ==
X-Received: by 2002:a24:610d:: with SMTP id s13-v6mr19526158itc.68.1534364792243;
        Wed, 15 Aug 2018 13:26:32 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id e140-v6sm9940768iof.50.2018.08.15.13.26.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Aug 2018 13:26:31 -0700 (PDT)
Date:   Wed, 15 Aug 2018 14:26:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        linux-pci@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v4 4/6] dt-bindings: imx6q-pcie: Add turnoff reset for
 imx7d
Message-ID: <20180815202630.GA18952@rob-hp-laptop>
References: <cover.1534264292.git.leonard.crestez@nxp.com>
 <e4e35d89f8e393cd291cb612a95faf1653a26f9b.1534264292.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4e35d89f8e393cd291cb612a95faf1653a26f9b.1534264292.git.leonard.crestez@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Aug 2018 19:50:18 +0300, Leonard Crestez wrote:
> This is documented as "required" but won't be present in old dtbs.
> 
> These resets are also present on other imx chips but right now only
> imx7d implements them through the reset controller subsystem.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
