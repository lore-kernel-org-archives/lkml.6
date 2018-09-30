Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC88DC004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 07:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 985C12082A
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 07:34:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BdMsFTu0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 985C12082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbeI3OFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 10:05:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:52894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727651AbeI3OFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 10:05:54 -0400
Received: from dragon (unknown [45.62.52.36])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F409205C9;
        Sun, 30 Sep 2018 07:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538292841;
        bh=5Fxcx1canxdm/0DpWi2AEojYN8NSXRHydH7wpfFbF10=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BdMsFTu0ddo7ym2lcDucqeV4YEvIBdFZCLOBRCKMHSv26mtpu69LQcPsdFpztjyGC
         z7DPkEOmvLwHGhhoyFsxQrjNuQMOF9KNex3U/TP6JFY33Nah98TsQhXbVAtJYhMkm4
         NduzcV4T+eJYe1Ggp4CTq7U7fxU/g6bJ3uHcsHGc=
Date:   Sun, 30 Sep 2018 15:33:34 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, fabio.estevam@nxp.com,
        linux@armlinux.org.uk, ping.bai@nxp.com, Aisheng.dong@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Linux-imx@nxp.com
Subject: Re: [PATCH V3 0/3] Add i.MX6ULZ SoC support
Message-ID: <20180930073332.GO26692@dragon>
References: <1538278348-7716-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538278348-7716-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 30, 2018 at 11:32:25AM +0800, Anson Huang wrote:
> This patch set adds i.MX6ULZ SoC support, i.MX6ULZ is a new SoC of
> i.MX6 family, compared to i.MX6ULL, it removes below modules:
> 
>     - UART5/UART6/UART7/UART8;
>     - PWM5/PWM6/PWM7/PWM8;
>     - eCSPI3/eCSPI4;
>     - CAN1/CAN2;
>     - FEC1/FEC2;
>     - I2C3/I2C4;
>     - EPIT2;
>     - LCDIF;
>     - GPT2;
>     - TSC;
> 
> And i.MX6ULZ has same soc_id as i.MX6ULL, but SRC_SBMR2 bit[6] is
> to differentiate i.MX6ULZ from i.MX6ULL, 1'b1 means i.MX6ULZ and
> 1'b0 means i.MX6ULL. i.MX6ULZ reuse most of i.MX6UL/i.MX6ULL code,
> just add the new CPU type and remove those non-exist modules from dtb.
> 
> Anson Huang (3):
>   ARM: imx: add i.mx6ulz msl support
>   dt-bindings: arm: add compatible for i.MX6ULZ 14x14 EVK board
>   ARM: dts: imx: add i.mx6ulz and i.mx6ulz 14x14 evk support

Applied all, thanks.
