Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E811C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 16:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E24752081D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 16:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Oe4BwAuM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E24752081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389288AbeKGBqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 20:46:31 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:54422 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387685AbeKGBqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 20:46:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CrLnaigG3ktwFrAe5OjTPxvj5NXhOcqDbBXHOdTNEt0=; b=Oe4BwAuMJp3ku1ePndRX/wKVx
        KkVb8DIEN3BNivBC6DGyNbIrfGZEvE38DuNxJmwrkKyFgdzQ5h0eLrzcyMNS3vPJ8195ycxQjfxnV
        vVhTeAsd/qfWtQfLPQoyT5SrmDniaI96WuGGzEYMTeBPuNotduaC5NPXNHAF2I0IKX8LQ=;
Received: from n2100.armlinux.org.uk ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:44228)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gK45Z-0001F2-NU; Tue, 06 Nov 2018 16:20:29 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gK45U-00062e-7g; Tue, 06 Nov 2018 16:20:21 +0000
Date:   Tue, 6 Nov 2018 16:20:15 +0000
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     David Binderman <dcb314@hotmail.com>,
        Julien Thierry <julien.thierry@arm.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: linux-4.20-rc1/arch/arm/vfp/vfpmodule.c:576: possible
 cut'n'paste error
Message-ID: <20181106162014.GH30658@n2100.armlinux.org.uk>
References: <VI1PR08MB3342D4ADBFBC43F2BE2FD34D9CCA0@VI1PR08MB3342.eurprd08.prod.outlook.com>
 <VI1PR08MB33420789A2AA1096D3F5FC9D9CCA0@VI1PR08MB3342.eurprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <VI1PR08MB33420789A2AA1096D3F5FC9D9CCA0@VI1PR08MB3342.eurprd08.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2018 at 01:53:13PM +0000, David Binderman wrote:
> Hello there,
> 
> 2nd try. Plain text might help.

Yep, Linux kernel development generally doesn't like wasteful html
emails, sorry.

> linux-4.20-rc1/arch/arm/vfp/vfpmodule.c:576]: (warning) Redundant assignment of 'ufp_exc->fpinst2' to itself.
> 
> Source code is
> 
>        ufp_exc->fpexc = hwstate->fpexc;
>        ufp_exc->fpinst = hwstate->fpinst;
>        ufp_exc->fpinst2 = ufp_exc->fpinst2;

Thanks for the report - it most certainly is a bug introduced by
Julien's patches, but I don't get your warning here.  Which compiler
produces that warning?

Julien - unfortunately, I've just asked Linus to take another fix
for Spectre, so we're going to have to wait a bit before I can
submit something for this.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
