Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC159C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E9B82084E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544470486;
	bh=OtV4UjICH5aESXX0GcFxrGH53CZ4eFb/tZI9JTtfVik=;
	h=In-Reply-To:To:Subject:From:References:Cc:Date:List-ID:From;
	b=k/rlkamVhvvK21XmqtCv3VOT6wrfbEJyoP1Fhqin979279szpSGiMcDLV2yhzMWYR
	 ehW44EwRLlZ+XgFZycq7sCz1cSA0rRHSEoZGjzcdOlSaA5/stQR5ZXOu+qKf8F0YHW
	 LCWRyqex9GUNZISFVXJdPbOS8N8v6TPM/tOvfa/s=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E9B82084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729443AbeLJTep (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 14:34:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:48740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727570AbeLJTeo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 14:34:44 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27EA320821;
        Mon, 10 Dec 2018 19:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544470484;
        bh=OtV4UjICH5aESXX0GcFxrGH53CZ4eFb/tZI9JTtfVik=;
        h=In-Reply-To:To:Subject:From:References:Cc:Date:From;
        b=rUgCZyGRqUvby1Tc3ovvUsEv7aA4CriZsK70IXbaIpypSZIXUFKdsqBoAAbnYWFKF
         h3/pTsD+86EPGPIWnWGfICHyM32SrACHP3hWYlLXsPXzb8O9ltE0UCzr1dyrasKC61
         ZVwdJb7VssVbD1fFf5+jqXeDOvA9a6xHywRplIM4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1543562288-28638-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <154447048344.17204.1093424854159784373@swboyd.mtv.corp.google.com>
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
Subject: Re: [PATCH] clk: imx6sl: ensure MMDC CH0 handshake is bypassed
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.7
References: <1543562288-28638-1-git-send-email-Anson.Huang@nxp.com>
Cc:     dl-linux-imx <linux-imx@nxp.com>
Date:   Mon, 10 Dec 2018 11:34:43 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Anson Huang (2018-11-29 23:23:47)
> Same as other i.MX6 SoCs, ensure unused MMDC channel's
> handshake is bypassed, this is to make sure no request
> signal will be generated when periphe_clk_sel is changed
> or SRC warm reset is triggered.
>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---

Applied to clk-next

