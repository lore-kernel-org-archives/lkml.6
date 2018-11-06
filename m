Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B1AC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 16:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0FF620862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 16:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="LuF/EGlT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0FF620862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389315AbeKGCGQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 21:06:16 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:54722 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387685AbeKGCGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 21:06:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MPmaVUa0Kwu47mv42llYyFZCQR5KJhKM3iIEj6B9ZMk=; b=LuF/EGlTr1m0qjOvLNebfw5WK
        cwtiEBqCVip9xwRbNYY3hB3JeZ+ku6YbN2Z4AmM5sk8xWxfeJ3wJvOzvlyY6RtneJZKNp6sh0SspH
        7Ss3B2Fv5H1zyJV2SJ9PZrFimSQa9131rC2r4JytoK6K4sXXUfmNHWRNMjhUMfb7Nmsik=;
Received: from n2100.armlinux.org.uk ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:44488)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gK4Og-0001L8-1i; Tue, 06 Nov 2018 16:40:10 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gK4OX-0006J4-2w; Tue, 06 Nov 2018 16:40:01 +0000
Date:   Tue, 6 Nov 2018 16:39:59 +0000
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Julien Thierry <julien.thierry@arm.com>
Cc:     David Binderman <dcb314@hotmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: linux-4.20-rc1/arch/arm/vfp/vfpmodule.c:576: possible
 cut'n'paste error
Message-ID: <20181106163959.GL30658@n2100.armlinux.org.uk>
References: <VI1PR08MB3342D4ADBFBC43F2BE2FD34D9CCA0@VI1PR08MB3342.eurprd08.prod.outlook.com>
 <VI1PR08MB33420789A2AA1096D3F5FC9D9CCA0@VI1PR08MB3342.eurprd08.prod.outlook.com>
 <20181106162014.GH30658@n2100.armlinux.org.uk>
 <77f6e853-2d6d-1149-f2f2-d23ddad6c611@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <77f6e853-2d6d-1149-f2f2-d23ddad6c611@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 04:29:54PM +0000, Julien Thierry wrote:
> Hi Russel, David,
> 
> On 06/11/18 16:20, Russell King - ARM Linux wrote:
> >On Mon, Nov 05, 2018 at 01:53:13PM +0000, David Binderman wrote:
> >>Hello there,
> >>
> >>2nd try. Plain text might help.
> >
> >Yep, Linux kernel development generally doesn't like wasteful html
> >emails, sorry.
> >
> >>linux-4.20-rc1/arch/arm/vfp/vfpmodule.c:576]: (warning) Redundant assignment of 'ufp_exc->fpinst2' to itself.
> >>
> >>Source code is
> >>
> >>        ufp_exc->fpexc = hwstate->fpexc;
> >>        ufp_exc->fpinst = hwstate->fpinst;
> >>        ufp_exc->fpinst2 = ufp_exc->fpinst2;
> >
> >Thanks for the report - it most certainly is a bug introduced by
> >Julien's patches, but I don't get your warning here.  Which compiler
> >produces that warning?
> >
> 
> Hmmm, silly typo/copy-paste from my end. Last line should be:
> 
> 	ufp_exc->fpinst2 = hwstate->fpinst2;
> 
> Sorry about that.
> 
> >Julien - unfortunately, I've just asked Linus to take another fix
> >for Spectre, so we're going to have to wait a bit before I can
> >submit something for this.
> >
> 
> It is just a one line fix, should I submit a patch to the LAKML or patch
> system?

Both I guess.

> Otherwise let me know when is it best for you to receive the fix then to
> send to Linus.

As mentioned, I'll have to wait a while, it's not fair to send a pull
request for one patch followed immediately by another pull request for
another patch on top of the same pull request.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
