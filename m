Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF04FC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 02:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F53121471
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 02:52:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y4Co2IaS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F53121471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732326AbeGLDAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 23:00:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:40044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726720AbeGLDAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 23:00:07 -0400
Received: from dragon (unknown [45.56.152.98])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53A8E2146F;
        Thu, 12 Jul 2018 02:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531363967;
        bh=T3JCCyljl45Ni/cy6re04iTIvnnFMtnCR2GDa8bwLx8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y4Co2IaSSxGT8k3Rwj0Foq66sQ0e0v/VAv0o4OCNOIlPFZKKH+ZBNaoab2n/pmIC3
         DYNAZSZaV3NGl7QMSQbzGCwPdGBtMFZuGm4vgukfxwtofiz55J1K0E8u72VwXKP+bA
         1jBjIIB6vhOzTiNz13/sy/4kpAL0Nh7tz5HP9k30=
Date:   Thu, 12 Jul 2018 10:52:04 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        mturquette@baylibre.com, sboyd@kernel.org, aisheng.dong@nxp.com,
        ping.bai@nxp.com, Linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: dts: imx6sll: add gpio clocks
Message-ID: <20180712025203.GQ6959@dragon>
References: <1529649154-5724-1-git-send-email-Anson.Huang@nxp.com>
 <1529649154-5724-2-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529649154-5724-2-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 02:32:34PM +0800, Anson Huang wrote:
> i.MX6SLL has GPIO clock gates in CCM CCGR, add
> clock property for GPIO driver to make sure all
> GPIO banks work as expected.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

I tried to create a topic branch for this patch with dependent clk
branch merged in.  But it turns out to be difficult and not worth the
effort, because too many imx6sll patches need to be moved out from
imx/dt branch, and some imx6sll changes are mixed with other SoCs.
Let's apply this in next cycle.  Ping me when 4.19-rc1 is available.

Shawn
