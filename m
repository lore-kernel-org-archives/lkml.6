Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA51C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4814C20835
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VjG7Zg14"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4814C20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729399AbeH3SlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 14:41:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39274 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728972AbeH3SlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 14:41:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=M0k/5Fqr7whVeDVdrDgGwm3ml23UOh3Is6Xh7+89Fa0=; b=VjG7Zg142JCv9WQ58/W/CIhjS
        XZ7GRkHfMtyqcRfk4yfXloa/zrNUhHNgKWsUZi/GuNLS2qlrhjwTYFLXEcUvxYVWCLshL20aO4onP
        cbWgvUsIiXAcns8mGps0S4LFyllCDXxO1nqu3xyMgfDhI8KZXoxGJuY0h0uJjDTzX6y2ZHHMS9+zu
        I6ENNVMCdBCRnx6mGmUA28KU6mBpTN4cJkiFzfcxt8HiJw09MlxBd2VZjICbEvH2aqdH8zo1xn22c
        mKpJ63WNNqHZ43OVy1VuDgIPOIWbiJZsBzYHqf9AVKi8rvDwrmu2H+YN4DUt7CU0T1HheKrOHCImW
        wxS6vSUBQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fvO61-0005ht-Od; Thu, 30 Aug 2018 14:38:53 +0000
Date:   Thu, 30 Aug 2018 07:38:53 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     linux-riscv@lists.infradead.org, daniel.lezcano@linaro.org,
        jason@lakedaemon.net, ard.biesheuvel@linaro.org,
        marc.zyngier@arm.com, catalin.marinas@arm.com,
        dmitriy@oss-tech.org, jeremy.linton@arm.com,
        linux-kernel@vger.kernel.org, atish.patra@wdc.com,
        aou@eecs.berkeley.edu, Greg KH <gregkh@linuxfoundation.org>,
        tglx@linutronix.de
Subject: Re: [PATCH 2/8] RISC-V: Don't set
 cacheinfo.{physical_line_partition, attributes}
Message-ID: <20180830143853.GD11544@infradead.org>
References: <20180827184243.25344-1-palmer@sifive.com>
 <20180827184243.25344-3-palmer@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180827184243.25344-3-palmer@sifive.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 11:42:37AM -0700, Palmer Dabbelt wrote:
> These are just hard coded in the RISC-V port, which doesn't make any
> sense.  We should probably be setting these from device tree entries
> when they exist, but for now I think it's saner to just leave them all
> as their default values.
> 
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>

Looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>
