Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8A0C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E384A21506
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:25:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E384A21506
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbeHOXSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 19:18:37 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:51824 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728024AbeHOXSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 19:18:37 -0400
Received: by mail-it0-f68.google.com with SMTP id e14-v6so3406598itf.1;
        Wed, 15 Aug 2018 13:24:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=i7I5vHszIsxfRCflWUe8Kgd0b02gdzObO973E78fHv4=;
        b=DXdHmAKZZ6YR6vMFYsWVhcQFw9lBXoyx90/MTvqI2yE2KV18fvdSyvAh23Zh/8NGV5
         4tSQ9bPeP9uxscJhG/pMmvmjEgUGIDxWyJqPf4/1in+dqQ8XEtV+KJIjHysGBAdZ27kQ
         Wa9FeGXzB06kbEZF9DmOxgigwhxwjadYBN9TFHWvnVbxVl0eXAZqzW7BHwt8HJsR1Lov
         aujsTcB0DVMoL1IgUoXWhJZYBycB0dLhor7FFFyLp74gPR/smhAbbL3zorz3yegN/mUj
         SngEyyYYAWFFyus3ZNsJ4NXQIoGXtHWG1q9LJM3Ui5OxZLAPr6LgrURZNLyYLrkQ+AUd
         A9BQ==
X-Gm-Message-State: AOUpUlEE1UaadBl4CS0guRJXQdfHQwdSBWiMIkxAqWs/k122fBqWUOEq
        T2g4MwUXl287Bl08Grg/lw==
X-Google-Smtp-Source: AA+uWPwqLqX5YXslLyktHh7F7eh3HvWSZ8OeG+nkc7WknRefm1vfXij8VtXTs9YSMP+UNuO9t44LaA==
X-Received: by 2002:a02:1bdc:: with SMTP id 89-v6mr23818687jas.72.1534364696802;
        Wed, 15 Aug 2018 13:24:56 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id u139-v6sm1705131ita.1.2018.08.15.13.24.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Aug 2018 13:24:56 -0700 (PDT)
Date:   Wed, 15 Aug 2018 14:24:55 -0600
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
Subject: Re: [PATCH v4 3/6] reset: imx7: Add PCIE_CTRL_APPS_TURNOFF
Message-ID: <20180815202455.GA15583@rob-hp-laptop>
References: <cover.1534264292.git.leonard.crestez@nxp.com>
 <88a5997e37d048cfc2dabb44cc13dce89c93d5eb.1534264292.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88a5997e37d048cfc2dabb44cc13dce89c93d5eb.1534264292.git.leonard.crestez@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 07:50:17PM +0300, Leonard Crestez wrote:
> This is required for the imx pci driver to send the PME_Turn_Off TLP.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  drivers/reset/reset-imx7.c             | 1 +

>  include/dt-bindings/reset/imx7-reset.h | 4 +++-

Acked-by: Rob Herring <robh@kernel.org>

>  2 files changed, 4 insertions(+), 1 deletion(-)
