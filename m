Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2200C6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DB9623EC0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oS9YVCG7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DB9623EC0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755599AbeF2Ssm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 14:48:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:33974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753116AbeF2Ssl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 14:48:41 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2823219F4;
        Fri, 29 Jun 2018 18:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530298121;
        bh=Yy6COPgFAOF50e4C51ZH/f5IpUtle296CEn7PED/bxM=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=oS9YVCG7jc0SRS1l7XKhmJnMrJ+Da01h0reZlNj0eoyhCg2xUjGbQm4lYXBUUiWgl
         lMnjJEdSL2+JVuCwul94bmvyokN/RFK/J1T90NMGYvMoOIMv76czdYXq+D7fXh73cd
         el9SIUXV0X2lKUmSSfZ06PYoVTdIiSp5a09xqvsY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Philipp Puschmann <pp@emlix.com>, shawnguo@kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180608101924.31195-1-pp@emlix.com>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, pp@emlix.com,
        linux-kernel@vger.kernel.org, fabio.estevam@nxp.com,
        mturquette@baylibre.com, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org
References: <20180608101924.31195-1-pp@emlix.com>
Message-ID: <153029812029.143105.12945867831074005837@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: imx6: fix video_27m parent for IMX6QDL_CLK_CKO1_SEL
Date:   Fri, 29 Jun 2018 11:48:40 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Philipp Puschmann (2018-06-08 03:19:24)
> q/dl datasheets list the 5th selection value for ck01_sel as
> video_27M_clk_root.
> =

> By replacing the dummy value we then can set IMX6QDL_CLK_VIDEO_27M
> as parent for IMX6QDL_CLK_CKO1_SEL.
> =

> Signed-off-by: Philipp Puschmann <pp@emlix.com>
> ---

Applied to clk-next

