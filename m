Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91CA4C32789
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49D0520831
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:44:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="blXvnzE1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49D0520831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729552AbeKUDOW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 22:14:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:38306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726557AbeKUDOW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 22:14:22 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FE83206BA;
        Tue, 20 Nov 2018 16:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542732258;
        bh=FkrbSU/ecm3ESgLM7C4j8tFlO/2FqbXhePEVxDvoims=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=blXvnzE155mnncfdXAnYLNFhlOzYpOHA4qOe7lz77DNXBTyL8vaLcqz4aR3GvGeJI
         IvWT9OZQK09EjFZSTMbLuFQDnBG4JNObe8M9mKJb4vF0xLbZ9Q0j+JDAOSTzjcxgNh
         MwbKTlMO+9tXLsDRQ/mVgeElWddwiXHCTx+fEwZg=
Date:   Tue, 20 Nov 2018 17:44:16 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Ioana Ciornei <ioana.ciornei@nxp.com>
Cc:     Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev-owner@vger.kernel.org" <netdev-owner@vger.kernel.org>,
        Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Leo Li <leoyang.li@nxp.com>
Subject: Re: [PATCH v3 2/4] bus: fsl-mc: add fsl-mc userspace support
Message-ID: <20181120164416.GB27531@kroah.com>
References: <1542728371-6972-1-git-send-email-ioana.ciornei@nxp.com>
 <1542728371-6972-3-git-send-email-ioana.ciornei@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542728371-6972-3-git-send-email-ioana.ciornei@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 03:39:45PM +0000, Ioana Ciornei wrote:
> +
> +			error = fsl_mc_uapi_create_device_file(mc_bus);
> +			if (error < 0) {
> +				error = -EPROBE_DEFER;
> +				goto error_cleanup_msi_domain;
> +			}

What error could occur here that would be somehow fixed if you defer and
try this all again?  Shouldn't you just return the error given (as
something really went wrong here, it's not a "something else needs to
start up first issue), and abort?

thanks,

greg k-h
