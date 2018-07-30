Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F123516256E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A87CE20870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:25:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A87CE20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731578AbeG3SBa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 14:01:30 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:60770 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727181AbeG3SBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 14:01:30 -0400
Received: from localhost (c-24-20-22-31.hsd1.or.comcast.net [24.20.22.31])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D83A613F00BBE;
        Mon, 30 Jul 2018 09:25:45 -0700 (PDT)
Date:   Mon, 30 Jul 2018 09:25:45 -0700 (PDT)
Message-Id: <20180730.092545.225621578249887012.davem@davemloft.net>
To:     yangbo.lu@nxp.com
Cc:     netdev@vger.kernel.org, madalin.bucur@nxp.com,
        richardcochran@gmail.com, robh+dt@kernel.org, shawnguo@kernel.org,
        devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] ptp_qoriq: convert to use module parameters for
 initialization
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180730100154.27906-3-yangbo.lu@nxp.com>
References: <20180730100154.27906-1-yangbo.lu@nxp.com>
        <20180730100154.27906-3-yangbo.lu@nxp.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 30 Jul 2018 09:25:46 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangbo Lu <yangbo.lu@nxp.com>
Date: Mon, 30 Jul 2018 18:01:54 +0800

> +static unsigned int cksel = DEFAULT_CKSEL;
> +module_param(cksel, uint, 0644);
> +MODULE_PARM_DESC(cksel, "Select reference clock");
> +
> +static unsigned int clk_src;
> +module_param(clk_src, uint, 0644);
> +MODULE_PARM_DESC(clk_src, "Reference clock frequency (if clocks property not provided in dts)");
> +
> +static unsigned int tmr_prsc = 2;
> +module_param(tmr_prsc, uint, 0644);
> +MODULE_PARM_DESC(tmr_prsc, "Output clock division/prescale factor");
> +
> +static unsigned int tmr_fiper1 = 1000000000;
> +module_param(tmr_fiper1, uint, 0644);
> +MODULE_PARM_DESC(tmr_fiper1, "Desired fixed interval pulse period (ns)");
> +
> +static unsigned int tmr_fiper2 = 100000;
> +module_param(tmr_fiper2, uint, 0644);
> +MODULE_PARM_DESC(tmr_fiper2, "Desired fixed interval pulse period (ns)");

Sorry, there is no way I am every applying something like this.  Module
parameters are to be avoided at all costs.

And you don't need it here, you have DTS, please use it.

You are required to support the existing DTS cases, in order to
avoid breaking things, anyways.
