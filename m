Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10BC2C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2C2720855
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="HPe8AyBl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbfBHRAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:00:06 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:44198 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726522AbfBHRAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 12:00:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=4o0xSUNUq51GNelN0go2QOdvaapvNWxd82lpZTYqDsQ=; b=HPe8AyBlqylXJ2onQbVdTeplJm
        vdkB5dhrhExPKorERAxQypg6OPo8ka1lkk3R00fwm+oEqz6hd6JFk1YRi3+ht+axhmvI+Or2znADJ
        8DfYRDSg9YHTyv/vcLS/r9MRvBXO0vygrutzRxqSi7P13Yw5he0aPLHKHq2jC6LOhv8s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1gs9VT-0000Xx-98; Fri, 08 Feb 2019 18:00:03 +0100
Date:   Fri, 8 Feb 2019 18:00:03 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Federico Vaga <federico.vaga@cern.ch>
Cc:     Peter Korsgaard <peter@korsgaard.com>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/5] i2c:ocores: do not handle IRQ if IF is not set
Message-ID: <20190208170003.GB1853@lunn.ch>
References: <20190208161201.7860-1-federico.vaga@cern.ch>
 <20190208161201.7860-3-federico.vaga@cern.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190208161201.7860-3-federico.vaga@cern.ch>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 05:11:58PM +0100, Federico Vaga wrote:
> If the Interrupt Flag (IF) is not set, we should not handle the IRQ:
> - the line can be shared with other devices
> - it can be a spurious interrupt
> 
> To avoid reading twice the status register, the ocores_process() function
> expects it to be read by the caller.
> 
> Signed-off-by: Federico Vaga <federico.vaga@cern.ch>
> Acked-by: Peter Korsgaard <peter@korsgaard.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
