Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D28C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 20:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 026AC20815
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 20:58:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 026AC20815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbeKSHTs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 02:19:48 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:55002 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbeKSHTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 02:19:48 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 3B0EC140030D5;
        Sun, 18 Nov 2018 12:58:28 -0800 (PST)
Date:   Sun, 18 Nov 2018 12:58:27 -0800 (PST)
Message-Id: <20181118.125827.533500141350535906.davem@davemloft.net>
To:     thesven73@gmail.com
Cc:     svendev@arcx.com, siva.kallam@broadcom.com, prashant@broadcom.com,
        mchan@broadcom.com, andrew@lunn.ch, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, arnd@arndb.de
Subject: Re: [PATCH v1] tg3: optionally use eth_platform_get_mac_address()
 to get mac address
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181117155618.19486-1-TheSven73@googlemail.com>
References: <20181117155618.19486-1-TheSven73@googlemail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 18 Nov 2018 12:58:28 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: thesven73@gmail.com
Date: Sat, 17 Nov 2018 10:56:18 -0500

> This function will try to determine the mac address via the devicetree,
> or via an architecture-specific method (e.g. a PROM on SPARC).
> 
> The SPARC-specific code in this driver (#ifdef SPARC) did exactly this,
> and is therefore removed.
> 
> Note that you can now specify the tg3 mac address via the devicetree,
> on any platform, not just SPARC:
> 
> Devicetree example:
> (see Documentation/devicetree/bindings/pci/pci.txt)
> 
> &pcie {
> 	host@0 {
> 		#address-cells = <3>;
> 		#size-cells = <2>;
> 		reg = <0 0 0 0 0>;
> 		bcm5778: bcm5778@0 {
> 			reg = <0 0 0 0 0>;
> 			mac-address = [CA 11 AB 1E 10 01];
> 		};
> 	};
> };
> 
> Signed-off-by: Sven Van Asbroeck <svendev@arcx.com>

Applied to net-next, thanks.
