Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC39C4646D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 00:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9430A21A13
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 00:14:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9430A21A13
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=buserror.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732824AbeHGCZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 22:25:36 -0400
Received: from baldur.buserror.net ([165.227.176.147]:48926 "EHLO
        baldur.buserror.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730724AbeHGCZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 22:25:35 -0400
X-Greylist: delayed 702 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 Aug 2018 22:25:35 EDT
Received: from [2601:449:8400:7293:12bf:48ff:fe84:c9a0]
        by baldur.buserror.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <oss@buserror.net>)
        id 1fmpdG-00022M-O7; Mon, 06 Aug 2018 19:13:51 -0500
Message-ID: <fe49ef59e93842c6f2beabd130918c9262cef9fe.camel@buserror.net>
From:   Scott Wood <oss@buserror.net>
To:     Rob Herring <robh@kernel.org>, Ran Wang <ran.wang_1@nxp.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Zhao Chenhui <chenhui.zhao@freescale.com>,
        Li Yang <leoyang.li@nxp.com>,
        Paul Mackerras <paulus@samba.org>,
        linux-arm-kernel@lists.infradead.org,
        Li Yang <leoli@freescale.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 06 Aug 2018 19:13:49 -0500
In-Reply-To: <20180416151356.r7si6higfrovl53l@rob-hp-laptop>
References: <20180411063551.30368-1-ran.wang_1@nxp.com>
         <20180411063551.30368-6-ran.wang_1@nxp.com>
         <20180416151356.r7si6higfrovl53l@rob-hp-laptop>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2601:449:8400:7293:12bf:48ff:fe84:c9a0
X-SA-Exim-Rcpt-To: robh@kernel.org, ran.wang_1@nxp.com, mark.rutland@arm.com, devicetree@vger.kernel.org, chenhui.zhao@freescale.com, leoyang.li@nxp.com, paulus@samba.org, linux-arm-kernel@lists.infradead.org, leoli@freescale.com, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: oss@buserror.net
Subject: Re: [PATCH v2 6/6] fsl_pmc: update device bindings
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-04-16 at 10:13 -0500, Rob Herring wrote:
> On Wed, Apr 11, 2018 at 02:35:51PM +0800, Ran Wang wrote:
> > From: Li Yang <leoli@freescale.com>
> 
> Needs a commit msg and the subject should give some indication of what 
> the update is. And also start with "dt-bindings: ..."

This patch should also come before the patches that use the new binding.

> > -  fsl,mpc8536-pmc: Sleep specifiers consist of three cells, the third of
> > -  which will be ORed into PMCDR upon suspend, and cleared from PMCDR
> > -  upon resume.  The first two cells are as described for fsl,mpc8578-pmc.
> > -  This sleep controller only supports disabling devices during system
> > -  sleep, or permanently.
> > -
> > -  fsl,mpc8548-pmc: Sleep specifiers consist of one or two cells, the
> > -  first of which will be ORed into DEVDISR (and the second into
> > -  DEVDISR2, if present -- this cell should be zero or absent if the
> > -  hardware does not have DEVDISR2) upon a request for permanent device
> > -  disabling.  This sleep controller does not support configuring devices
> > -  to disable during system sleep (unless supported by another compatible
> > -  match), or dynamically.
> 
> You seem to be breaking backwards compatibility with this change. I 
> doubt that is okay on these platforms.

I don't think the sleep specifier stuff ever got used.

-Scott

