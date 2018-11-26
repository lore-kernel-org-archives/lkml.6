Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E30FAC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE36F2133F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:41:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE36F2133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbeK0KhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 05:37:10 -0500
Received: from muru.com ([72.249.23.125]:55310 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727826AbeK0KhK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 05:37:10 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 3ED998068;
        Mon, 26 Nov 2018 23:41:21 +0000 (UTC)
Date:   Mon, 26 Nov 2018 15:41:16 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     David Lechner <david@lechnology.com>
Cc:     Roger Quadros <rogerq@ti.com>, robh+dt@kernel.org,
        bcousson@baylibre.com, ssantosh@kernel.org, ohad@wizery.com,
        bjorn.andersson@linaro.org, s-anna@ti.com, nsekhar@ti.com,
        t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com,
        m-karicheri2@ti.com, woods.technical@gmail.com,
        linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 01/17] dt-bindings: remoteproc: Add TI PRUSS bindings
Message-ID: <20181126234116.GQ53235@atomide.com>
References: <1542886753-17625-1-git-send-email-rogerq@ti.com>
 <1542886753-17625-2-git-send-email-rogerq@ti.com>
 <a4fe952b-9065-d91b-4c07-984ec3f5b276@lechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4fe952b-9065-d91b-4c07-984ec3f5b276@lechnology.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* David Lechner <david@lechnology.com> [181126 21:14]:
> I haven't looked into Tony's suggestion of using ti-sysc yet, so this may be a
> moot point, but how will this work with AM18xx that does not have a PRUSS CFG
> register? It seems to me that reg here should be the address and size of the
> entire PRUSS IP block and the CFG register should be a syscon node or something
> like that.

The SoC specific wrapper IP is probably different on am18xx compared
to omaps, it might be TIPB like on omap1?

If am18xx has something simlar to omaps, there would be revision,
sysconfig and sysstatus registers typically at offsets 0x00, 0x10
and 0x14.

The wrapper IP code should be independent of the PRU code and just
provide services to the PRU. For a minimal wrapper IP driver example
that might work for am18xx see for drivers/usb/musb/musb_am335x.c.

Regards,

Tony
