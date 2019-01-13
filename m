Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B0BFC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 03:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AA9A2086C
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 03:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547348522;
	bh=rkThKaPOzadWzMex50MwwnD49tREW8fZRGDyInivnic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qcyMeSMo4stbOeA4axBXiUodWg+bUh2S3PMh6myUGgt0uTC316F/1wjM2LiR/6fCu
	 U3OpWCvDcwlc6DaryQKU04HzsNWE7AZXkzvf9ph8CbAlsp8KZvuXo1kWhWJiwiHS4b
	 3lhrAPvTx94xZHJLqVttx0JNw5t+rg8XLL7tingg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbfAMC5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 21:57:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:44280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726472AbfAMC5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 21:57:07 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 078F52086C;
        Sun, 13 Jan 2019 02:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547348227;
        bh=rkThKaPOzadWzMex50MwwnD49tREW8fZRGDyInivnic=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dtJdPHGjI0nSVtMH119K5sFHks7TTSi2tUeAB+MW9j5MhTe7rzRK1gXnjMcE+hfAD
         /sJF/ot5TgcILt9Mhj9RIPDxnPWf8PHcTO9A5KBQEmpsT0V71kBgcv0XVk7yIkDuL2
         LT6rLhLLWnyAD3GQkIc35DwJrvbel8fMfn/ZQ9kM=
Date:   Sun, 13 Jan 2019 10:56:52 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Stefan Agner <stefan@agner.ch>
Cc:     s.hauer@pengutronix.de, arnd@arndb.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, linux-imx@nxp.com, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: imx: don't build ssi-fiq if not required
Message-ID: <20190113025650.GF11426@dragon>
References: <20190103143631.29284-1-stefan@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190103143631.29284-1-stefan@agner.ch>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 03, 2019 at 03:36:31PM +0100, Stefan Agner wrote:
> The symbols provided by ssi-fiq are used in sound/soc/fsl/imx-pcm-fiq.c
> only. Build ssi-fiq.o/ssi-fiq-ksym.o only if SND_SOC_IMX_PCM_FIQ is
> enabled.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Applied, thanks.
