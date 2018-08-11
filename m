Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B817C46460
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 20:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85B8D21A13
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 20:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="rR+MaA1i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85B8D21A13
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbeHKWnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 18:43:35 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:33292 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727441AbeHKWne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 18:43:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FzW32jkF85SOibAaNTTjtdN6iNBbDZNTUsbsHECpiLU=; b=rR+MaA1i9cV7OBlQnb8AstLgb
        Hvo0PqJw50htYid9qukleNlvSqWgOrx0Qp8i0A0K2AGvK9fkIOh76bH+fxvjrH74zw3EdgmqJ3Osp
        Q2nX1/WPbdx03Mlq0p/X2/booV5+2jjti56oyo9sLQA72hFIjnCay4qsoFJO4D1yUKg9w=;
Received: from n2100.armlinux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:45451)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1foXCm-0005sa-9R; Sat, 11 Aug 2018 17:57:35 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1foXCj-0004Ab-Nf; Sat, 11 Aug 2018 17:57:29 +0100
Date:   Sat, 11 Aug 2018 17:57:28 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Stefan Agner <stefan@agner.ch>
Cc:     catalin.marinas@arm.com, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: drop experimental mark for ARM stack unwinding
Message-ID: <20180811165728.GS30658@n2100.armlinux.org.uk>
References: <20180811103127.21485-1-stefan@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180811103127.21485-1-stefan@agner.ch>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 11, 2018 at 12:31:27PM +0200, Stefan Agner wrote:
> ARM stack unwinding is upstream since 2009 and has been proven
> working well. At this time it is the preferred stack unwinding
> support since it also supports Thumb 2. Do not scare people
> and drop the EXPERIMENTAL mark.

Actually, there are still cases where we're missing the annotations -
I've seen them in various oops dumps, but I forget where they are.
What I do remember is that they didn't seem trivial to fix at the
time, so it's still recommended that frame pointers are used if you
want to guarantee getting a debuggable oops dump.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
