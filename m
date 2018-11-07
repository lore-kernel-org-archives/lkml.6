Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C052C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F417820827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oOYa5Scp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F417820827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731478AbeKHChL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 21:37:11 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53364 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727757AbeKHChK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 21:37:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qh8Qhy2w4pgR2qGVXcDQImmaucvrFE5+2bUXf3C9+GY=; b=oOYa5ScpZaThsr3IkQ4R4TEF/
        mAeZMegZpH718Zh8UnoE01KS2zpJ3BxLV1YIkvnf6g7nrERqEI1TRd7aGe3i6Q60H4ckBB9YvgbjI
        mUkQ5+OE75QlmedHoOEKPnsOQJL5NOBDqSM9lrevuCQTDJstkBdIhS3q3OcKXzr1CKsaAw8pcOJ60
        kPQtjYCgHqinpMo39HmIwQYqRvROVqF01cDSBB/rGU0omY1rFADd4p2IJyE3wK76p234myYR9te9q
        XBu/iddTIqJfIhHZ3tceM+NqrXZVOPW5NXM93UZb66hdNRRcEMJOcan/pfMCErI2s82BYNlm3oMyB
        sknqPV4kQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gKRH7-0000fg-FI; Wed, 07 Nov 2018 17:05:53 +0000
Date:   Wed, 7 Nov 2018 09:05:53 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Vitor soares <vitor.soares@synopsys.com>
Cc:     boris.brezillon@bootlin.com, wsa@the-dreams.de,
        linux-i2c@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, gregkh@linuxfoundation.org,
        arnd@arndb.de, psroka@cadence.com, agolec@cadence.com,
        adouglas@cadence.com, bfolta@cadence.com, dkos@cadence.com,
        alicja@cadence.com, cwronka@cadence.com, sureshp@cadence.com,
        rafalc@cadence.com, thomas.petazzoni@bootlin.com, nm@ti.com,
        robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
        ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        geert@linux-m68k.org, linus.walleij@linaro.org,
        Xiang.Lin@synaptics.com, linux-gpio@vger.kernel.org,
        nsekhar@ti.com, pgaj@cadence.com, peda@axentia.se,
        mshettel@codeaurora.org, swboyd@chromium.org,
        joao.pinto@synopsys.com, luis.oliveira@synopsys.com,
        manuel.abreu@synopsys.com, gustavo.pimentel@synopsys.com
Subject: Re: [PATCH 1/3] i3c: master: Add driver for Synopsys DesignWare IP
Message-ID: <20181107170553.GJ3074@bombadil.infradead.org>
References: <1540807618-13246-1-git-send-email-soares@synopsys.com>
 <1540807618-13246-2-git-send-email-soares@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1540807618-13246-2-git-send-email-soares@synopsys.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 10:06:56AM +0000, Vitor soares wrote:
> Add driver for Synopsys DesignWare I3C master IP

The so-called "data sheet" (actually just an advertising brochure)
on your website claims DMA support.  I don't see that support
anywhere in this driver.

