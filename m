Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC04C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 13:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7197221526
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 13:10:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7197221526
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753512AbeGDNKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 09:10:16 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:36448 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753106AbeGDNKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 09:10:15 -0400
Received: from localhost (unknown [211.196.191.92])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 3F8C11094D0F4;
        Wed,  4 Jul 2018 06:10:13 -0700 (PDT)
Date:   Wed, 04 Jul 2018 22:10:11 +0900 (KST)
Message-Id: <20180704.221011.251299583459668989.davem@davemloft.net>
To:     marcel@ziswiler.com
Cc:     netdev@vger.kernel.org, oneukum@suse.com,
        marcel.ziswiler@toradex.com, linux-usb@vger.kernel.org,
        Dean_Jenkins@mentor.com, linux-kernel@vger.kernel.org,
        andreyknvl@google.com
Subject: Re: [PATCH v2] net: usb: asix: allow optionally getting mac
 address from device tree
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180703150649.30030-1-marcel@ziswiler.com>
References: <20180703150649.30030-1-marcel@ziswiler.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 04 Jul 2018 06:10:14 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel@ziswiler.com>
Date: Tue,  3 Jul 2018 17:06:49 +0200

> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> For Embedded use where e.g. AX88772B chips may be used without external
> EEPROMs the boot loader may choose to pass the MAC address to be used
> via device tree. Therefore, allow for optionally getting the MAC
> address from device tree data e.g. as follows (excerpt from a T30 based
> board, local-mac-address to be filled in by boot loader):
> 
> /* EHCI instance 1: USB2_DP/N -> AX88772B */
> usb@7d004000 {
> 	status = "okay";
> 	#address-cells = <1>;
> 	#size-cells = <0>;
> 	asix@1 {
> 		reg = <1>;
> 		local-mac-address = [00 00 00 00 00 00];
> 	};
> };
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Applied to net-next.
