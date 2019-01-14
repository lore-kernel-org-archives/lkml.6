Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF22CC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 00:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9585F20850
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 00:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547427382;
	bh=616qQYLjy0TWEpz1JCSpCs+flqKc1k3ChSUmgQ2vz/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FjGW9uCc/08Wg0exH4pKlD7c+8RfGJWnySo3KVc2Yqe79PMokNY5ZSx/JKQDX8QBB
	 GaULA6vKNBiWyUvXuIHS2NR5Ov753sXVWv8Ijx/ZREmKFA/FD5TZ2BtqIR9z7IXAaA
	 4tMfd3/XLoSENRT40U2FRzhDQ40DgspxkVGtPaiw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfANA4V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 19:56:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:54300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726617AbfANA4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 19:56:21 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD16320656;
        Mon, 14 Jan 2019 00:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547427380;
        bh=616qQYLjy0TWEpz1JCSpCs+flqKc1k3ChSUmgQ2vz/o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eFBksLaJYMKNokGYGFKML9tJy45VwWt52KdwmUahpRNjzU7AC6ot6BRXugOG3Q5MS
         MuOVhJsoSxWPglJKWBvIaLtJ+t2rQg/qZJ1DNx2tVT/j55YxsuiynWlBoFPXiMfAlH
         E2xlfKSXaxdvQDrMf27z5ZH27en3Z1zpDRgzTRLc=
Date:   Mon, 14 Jan 2019 08:56:01 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V2] ARM: imx: add i.MX7ULP cpuidle support
Message-ID: <20190114005600.GN11426@dragon>
References: <1547185955-2395-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547185955-2395-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 05:57:30AM +0000, Anson Huang wrote:
> This patch adds cpuidle support for i.MX7ULP, 3 cpuidle
> states supported as below:
> 
> 1. WFI, just ARM wfi;
> 2. WAIT mode, mapped to SoC's partial stop mode #3;
> 3. STOP mode, mapped to SoC's partial stop mode #1.
> 
> In WAIT mode, system clock and bus clock will be enabled;
> In STOP mode, system clock and bus clock will be disabled.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
