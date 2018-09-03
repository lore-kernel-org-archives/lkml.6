Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A82C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A6CA20843
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:10:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s7sUJezr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A6CA20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbeICSab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 14:30:31 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42567 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727169AbeICSab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 14:30:31 -0400
Received: by mail-lj1-f194.google.com with SMTP id f1-v6so570736ljc.9;
        Mon, 03 Sep 2018 07:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zvokTpUiD1hisEVg5BEI0ay5OevzimtOEVTO/5Rh6lI=;
        b=s7sUJezrCtpuSJjxwakDmyjNcRs55Knddt4TfuyHXodujU4O/0guhDS8GMW3eveTiB
         eD6h6atQNhsQCBqt3dSNuwKeZyeQkjPkQKmMBV4o0ld0fN/2E+h6QX5n9YozvL4oywxJ
         EvF3gKe5vqS2KY59FHVOIu4G1cQgHb/AaMssp6yz9bL4ojClVZUgQ/MzKu7B15uDq68l
         OzUW7NBeksBpqdARb1UN3LqbWoj3e/s+a3ChN2qG3zwBWO3ai/y0gs/7ZG1WWhx1W1wv
         JzqIS3yIIjG0o5vnOYOgvF8mnIeZu6ll+nWw12eI2y2FWktZiducWrC8m+yxutlW02Xy
         7rCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zvokTpUiD1hisEVg5BEI0ay5OevzimtOEVTO/5Rh6lI=;
        b=sNPA0+j+FQd1OApQpo6WQQtukNuzH/1aKEYEBzzmSp8waBFV1EgmL+XKZwUZshbRDL
         NWiUZp43A5mwlo9vEjMvzUdEka8xAAieX01+YJZ5b1us8ogF1Ag9Q4sg+CKHWez7TL3X
         BGZFBNfKlXFtOEhYgFSGHUWuVBXQxszM4QpfYyvozYbT/ATo4jKn1IDFCLDh/m8fAnvq
         BJQ5BqUApTTuCv7SXRWf9LeW9l9OUF3GXyVPIr5o/ePc/gO4irv4gVSkOtlNNgKpbFzd
         CH+tx1ehX8O652Mwo2T3gpBc6kr7piR/9X2F/L3xI/y8daI11Rlxn/A6/jOQ6Fg7Ga5J
         HEBQ==
X-Gm-Message-State: APzg51Bj+N8rVUBbuh1GnDJhf8AOODwRl1UCxOewYyVzoRvnyN2Rn1MQ
        9JGID8dzaNIhWTz+U9L3ULA=
X-Google-Smtp-Source: ANB0VdZ2Il+FZSbTyLLqPVqKUb0MuPtGZI9L0e2ykFmTSC6zxqrh+OKrGXdQYd+bRK4BJQw85TMwVA==
X-Received: by 2002:a2e:9e17:: with SMTP id e23-v6mr3548983ljk.14.1535983808917;
        Mon, 03 Sep 2018 07:10:08 -0700 (PDT)
Received: from gmail.com (213-238-244-10.customers.ownit.se. [213.238.244.10])
        by smtp.gmail.com with ESMTPSA id u191-v6sm3471965lja.13.2018.09.03.07.10.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Sep 2018 07:10:07 -0700 (PDT)
Date:   Mon, 3 Sep 2018 16:10:02 +0200
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Peter Chen <peter.chen@nxp.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: chipidea: imx: make MODULE_LICENCE and
 SPDX-identifier match
Message-ID: <20180903141002.GA12321@gmail.com>
References: <20180902173650.5514-1-marcus.folkesson@gmail.com>
 <AM0PR04MB53146633EA4508612434DCCB8B0C0@AM0PR04MB5314.eurprd04.prod.outlook.com>
 <20180903123611.GA9660@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180903123611.GA9660@kroah.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Sep 03, 2018 at 02:36:11PM +0200, Greg Kroah-Hartman wrote:
> On Mon, Sep 03, 2018 at 04:14:41AM +0000, Peter Chen wrote:
> >  
> > > 
> > > The SPDX-License-Identifier is set to GPL-2.0+, which correspond to
> > > MODULE_LICENSE "GPL".
> > > 
> > > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> > > ---
> > >  drivers/usb/chipidea/ci_hdrc_imx.c | 2 +-  drivers/usb/chipidea/usbmisc_imx.c | 2 +-
> > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
> > > index 19f5f5f2a48a..555d398fbfa7 100644
> > > --- a/drivers/usb/chipidea/ci_hdrc_imx.c
> > > +++ b/drivers/usb/chipidea/ci_hdrc_imx.c
> > > @@ -492,7 +492,7 @@ static struct platform_driver ci_hdrc_imx_driver =
> > > {  module_platform_driver(ci_hdrc_imx_driver);
> > > 
> > >  MODULE_ALIAS("platform:imx-usb");
> > > -MODULE_LICENSE("GPL v2");
> > > +MODULE_LICENSE("GPL");
> > >  MODULE_DESCRIPTION("CI HDRC i.MX USB binding");
> > > MODULE_AUTHOR("Marek Vasut <marex@denx.de>");
> > > MODULE_AUTHOR("Richard Zhao <richard.zhao@freescale.com>"); diff --git
> > > a/drivers/usb/chipidea/usbmisc_imx.c b/drivers/usb/chipidea/usbmisc_imx.c
> > > index 34ad5bf8acd8..d9cfa00b8a6c 100644
> > > --- a/drivers/usb/chipidea/usbmisc_imx.c
> > > +++ b/drivers/usb/chipidea/usbmisc_imx.c
> > > @@ -633,6 +633,6 @@ static struct platform_driver usbmisc_imx_driver =
> > > {  module_platform_driver(usbmisc_imx_driver);
> > > 
> > >  MODULE_ALIAS("platform:usbmisc-imx");
> > > -MODULE_LICENSE("GPL v2");
> > > +MODULE_LICENSE("GPL");
> > >  MODULE_DESCRIPTION("driver for imx usb non-core registers");
> > > MODULE_AUTHOR("Richard Zhao <richard.zhao@freescale.com>");
> > 
> > Greg, does this is a useful change? I am not sure.
> 
> As the two licenses are not matching, something needs to be fixed here,
> don't you agree?

I just want to fill in that the former license text (removed in
51b751f112dcbb24b46051fe64c2ddbe8aa367ea) was:

- * The code contained herein is licensed under the GNU General Public
- * License. You may obtain a copy of the GNU General Public License
- * Version 2 or later at the following locations:

According to this, the SPDX-identifier is valid and the MODULE_LICENSE
should be fixed.

> 
> Please read include/linux/modules.h for what the strings mean, that
> should help explain things more.
> 
> greg k-h

Best regards
Marcus Folkesson
