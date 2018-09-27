Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE744C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 13:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F95A20877
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 13:25:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FFAyxXe2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F95A20877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbeI0Tn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 15:43:29 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:47258 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727477AbeI0Tn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 15:43:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=TmEo+4t6CnDlpFyrq6nfTpTy6+5A6qk7lpbjoQ0Ef2o=;
        b=FFAyxXe2YTmW1E3HZMiDN8bQerxdbywK3Y1dcY+ZdPWfFs6uUV1uQ+OyflQbxFE3PeIEHDj4EXXpFFPEb84e8AhstDzpE+Ov2HXN01MZAiMM13M1gZ1iMcju3awtZ0ecEEjybTK7bXuN0f0DUYisKZgX7CjmDBhY4kpSF7/HsSQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1g5WHz-0006VA-Lo; Thu, 27 Sep 2018 15:25:07 +0200
Date:   Thu, 27 Sep 2018 15:25:07 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Yangbo Lu <yangbo.lu@nxp.com>
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        netdev@vger.kernel.org, Richard Cochran <richardcochran@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Ioana Radulescu <ruxandra.radulescu@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/2] net: dpaa2: move DPAA2 PTP driver out of staging/
Message-ID: <20180927132507.GB23375@lunn.ch>
References: <20180927111228.46118-1-yangbo.lu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180927111228.46118-1-yangbo.lu@nxp.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 07:12:27PM +0800, Yangbo Lu wrote:
> This patch is to move DPAA2 PTP driver out of staging/
> since the dpaa2-eth had been moved out.
> 
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
> ---
>  drivers/net/ethernet/freescale/Kconfig             |    9 +--------
>  drivers/net/ethernet/freescale/dpaa2/Kconfig       |   15 +++++++++++++++
>  drivers/net/ethernet/freescale/dpaa2/Makefile      |    6 ++++--
>  .../ethernet/freescale/dpaa2}/dprtc-cmd.h          |    0
>  .../rtc => net/ethernet/freescale/dpaa2}/dprtc.c   |    0
>  .../rtc => net/ethernet/freescale/dpaa2}/dprtc.h   |    0
>  .../rtc => net/ethernet/freescale/dpaa2}/rtc.c     |    0
>  .../rtc => net/ethernet/freescale/dpaa2}/rtc.h     |    0
>  drivers/staging/fsl-dpaa2/Kconfig                  |    8 --------
>  drivers/staging/fsl-dpaa2/Makefile                 |    1 -
>  drivers/staging/fsl-dpaa2/rtc/Makefile             |    7 -------
>  11 files changed, 20 insertions(+), 26 deletions(-)
>  create mode 100644 drivers/net/ethernet/freescale/dpaa2/Kconfig
>  rename drivers/{staging/fsl-dpaa2/rtc => net/ethernet/freescale/dpaa2}/dprtc-cmd.h (100%)
>  rename drivers/{staging/fsl-dpaa2/rtc => net/ethernet/freescale/dpaa2}/dprtc.c (100%)
>  rename drivers/{staging/fsl-dpaa2/rtc => net/ethernet/freescale/dpaa2}/dprtc.h (100%)
>  rename drivers/{staging/fsl-dpaa2/rtc => net/ethernet/freescale/dpaa2}/rtc.c (100%)
>  rename drivers/{staging/fsl-dpaa2/rtc => net/ethernet/freescale/dpaa2}/rtc.h (100%)

Hi Yangbo

Calling a ptp driver rtc.[ch] seems rather odd. Could you fixup the
name, change it to ptp.[ch]. Also, some of the function names, and
structures, rtc_probe->ptp_probe, rtc_remove->ptp_remove,
rtc_match_id_table-> ptp_match_id_table, etc.

ptp_dpaa2_adjfreq() probably should return err, not 0.
ptp_dpaa2_gettime() again does not return the error.
If fact, it seems like all the main functions ignore errors.

kzalloc() could be changed to devm_kzalloc() to simplify the cleanup
Can ptp_dpaa2_caps be made const?
dpaa2_phc_index does not appear to be used.
dev_set_drvdata(dev, NULL); is not needed.
Can rtc_drv be made const?
Is rtc.h used by anything other than rtc.c? It seems like it can be removed.

It seems like there is a lot of code in dprtc.c which is unused. rtc.c
does nothing with interrupts for example. Do you plan to make use of
this extra code? Or can it be removed leaving just what is needed?

struct dprtc_cmd_get_irq - Putting pad at the beginning of a struct
seems very odd. And it is not the only example.

      Andrew
