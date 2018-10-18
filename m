Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA4E3C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DC97204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPWYR5d3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DC97204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729609AbeJSCDu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 22:03:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:51858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729594AbeJSCDt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 22:03:49 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57FF521476;
        Thu, 18 Oct 2018 18:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539885703;
        bh=NjGerjqKOwYHj9NOFOv1CdYXgVIXYrQyX3X6YqiMS+Y=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=mPWYR5d3iVbWgpHICO4oqnNuQ2OycAghBr5lsy0OdDqm74PB+DFq6agk0Yavn+7ac
         +wpN1oRhqQmdbzVETSYoXtmsToKhHXX8FjV/3sK7r4SnD6bCtzsEv7S8ah8/wfU5Tj
         H8YV5niJR8oQWkdTDhY8yWrJn4361nAVRgxBpIdU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1539845238-24114-1-git-send-email-Anson.Huang@nxp.com>
Cc:     dl-linux-imx <linux-imx@nxp.com>
References: <1539845238-24114-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <153988570270.5275.247396954378886936@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: imx7d: remove UART1 clock setting
Date:   Thu, 18 Oct 2018 11:01:42 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Anson Huang (2018-10-17 23:51:55)
> There is clock assignment in dtb for UART1, so setting
> UART1 clock in clock driver is NOT necessary.

Can you mention the commit that introduced the assignment and possibly
the file where it is done?

> =

> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
