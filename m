Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A5AC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 02:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42D7420852
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 02:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RJYSbbPJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42D7420852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937193AbeFSC4w (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 22:56:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:45614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934644AbeFSC4v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 22:56:51 -0400
Received: from dragon (unknown [45.56.152.47])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E08D204EC;
        Tue, 19 Jun 2018 02:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529377010;
        bh=cPbNda2OIizF1IKWHPxWzCNWpNKskWvjhmArRezJwdA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RJYSbbPJv1GPvSBP9NqdgmM2AN+4aSgEPHwaqwXfYyBjsWMWzAKGULdop/4BFtMxv
         AGJ7a4AQOZ00s196mdHpw1d5yQNfeSYOgJQ+KmRodFCDhXNJXPvleKsxvJPeXKYdNA
         AOWwORZcaJSImTqbzX76gkCrMpqwKawlm0k2ChU0=
Date:   Tue, 19 Jun 2018 10:55:55 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Fabio Estevam <fabio.estevam@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de,
        Robby Cai <robby.cai@nxp.com>
Subject: Re: [PATCH] ARM: dts: imx7d-sdb: Remove duplicate regulator-can2-3v3
Message-ID: <20180619025554.GC16091@dragon>
References: <abacbb7485b0c9b908eae8ae87be9d8e0eab87b3.1529327283.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abacbb7485b0c9b908eae8ae87be9d8e0eab87b3.1529327283.git.leonard.crestez@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 04:11:09PM +0300, Leonard Crestez wrote:
> Two different regulators are defined with the same name and label but
> distinct properties.
> 
> The first definition was added with the first board dts and the second
> was added when upstream added flexcan support.
> 
> Looking at schematics it is indeed gpio2 14 connected to the STB pin of
> the CAN transceiver so remove the first definition.
> 
> The second definition entirely overrides the first so this already
> worked and this patch results in no DTB change, just a cleanup.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

Applied, thanks.
