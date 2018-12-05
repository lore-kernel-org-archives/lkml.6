Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E33FFC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A686F214C1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mHXQQTvO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A686F214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbeLEJ6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:58:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:36738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728086AbeLEJ6t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:58:49 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83A3620989;
        Wed,  5 Dec 2018 09:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544003929;
        bh=zeaIt5HzIj6Fqr5d3L3HkY1hqMyG7zhVpRYaqsFl5L8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mHXQQTvO95vopuKN0O5OHz+ay1Txtvnr3jDz7Sl7YIt3bAeThXpwkEwRncgN6NBbV
         WjBAdcypeV9WzrErdmXc5XR+sij3+tR72kVRV443dos4LSK+tONxWKXnu9IpjeKomL
         oahkleBF7JqCaKTXkMJkwdmMgQJNmeweE2gjANGo=
Date:   Wed, 5 Dec 2018 10:58:46 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Anup Patel <anup@brainfault.org>
Cc:     Jiri Slaby <jslaby@suse.com>, Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Rob Herring <robh@kernel.org>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 1/3] tty/serial: Add RISC-V SBI earlycon support
Message-ID: <20181205095846.GA9847@kroah.com>
References: <20181204135507.3706-1-anup@brainfault.org>
 <20181204135507.3706-2-anup@brainfault.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181204135507.3706-2-anup@brainfault.org>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 07:25:05PM +0530, Anup Patel wrote:
> In RISC-V, the M-mode runtime firmware provide SBI calls for
> debug prints. This patch adds earlycon support using RISC-V
> SBI console calls. To enable it, just pass "earlycon=sbi" in
> kernel parameters.
> 
> Signed-off-by: Anup Patel <anup@brainfault.org>

This makes more sense to take through the riscv tree, so feel free to
add:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

to it and take it that way.

thanks,

greg k-h
