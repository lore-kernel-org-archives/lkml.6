Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B391C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 23:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EE9121B31
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 23:02:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EE9121B31
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=buserror.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731364AbeHIBXw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 21:23:52 -0400
Received: from baldur.buserror.net ([165.227.176.147]:59112 "EHLO
        baldur.buserror.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729838AbeHIBXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 21:23:52 -0400
Received: from [2601:449:8400:7293:12bf:48ff:fe84:c9a0] (helo=home.buserror.net)
        by baldur.buserror.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <oss@buserror.net>)
        id 1fnXSk-0002bN-Ms; Wed, 08 Aug 2018 18:01:55 -0500
Date:   Wed, 8 Aug 2018 18:01:52 -0500
From:   Scott Wood <oss@buserror.net>
To:     Ran Wang <ran.wang_1@nxp.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kumar Gala <galak@kernel.crashing.org>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        Zhao Chenhui <chenhui.zhao@freescale.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org
Message-ID: <20180808230152.GA5459@home.buserror.net>
References: <20180411063551.30368-1-ran.wang_1@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180411063551.30368-1-ran.wang_1@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-SA-Exim-Connect-IP: 2601:449:8400:7293:12bf:48ff:fe84:c9a0
X-SA-Exim-Rcpt-To: ran.wang_1@nxp.com, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, robh+dt@kernel.org, mark.rutland@arm.com, galak@kernel.crashing.org, leoyang.li@nxp.com, devicetree@vger.kernel.org, chenhui.zhao@freescale.com, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: oss@buserror.net
Subject: Re: [v2, 1/6] powerpc/pm: Fix suspend=n in menuconfig for e500mc
 platforms.
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 11, 2018 at 02:35:46PM +0800, Ran Wang wrote:
> Also, unselect FSL_PMC which is for older platfroms instead.
> 
> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> ---
> Changes in v2:
>   - no change
> 
>  arch/powerpc/Kconfig |    4 +---
>  1 files changed, 1 insertions(+), 3 deletions(-)

It's not "fixing" anything, but rather enabling something that was
previously unsupported -- and that should happen after the code that
adds support.

-Scott
