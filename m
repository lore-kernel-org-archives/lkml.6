Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2547C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 12:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 882AF20867
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 12:36:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 882AF20867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbeICQ4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 12:56:12 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46806 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbeICQ4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 12:56:12 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id EF0F5D30;
        Mon,  3 Sep 2018 12:36:13 +0000 (UTC)
Date:   Mon, 3 Sep 2018 14:36:11 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Peter Chen <peter.chen@nxp.com>
Cc:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: chipidea: imx: make MODULE_LICENCE and
 SPDX-identifier match
Message-ID: <20180903123611.GA9660@kroah.com>
References: <20180902173650.5514-1-marcus.folkesson@gmail.com>
 <AM0PR04MB53146633EA4508612434DCCB8B0C0@AM0PR04MB5314.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR04MB53146633EA4508612434DCCB8B0C0@AM0PR04MB5314.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 03, 2018 at 04:14:41AM +0000, Peter Chen wrote:
>  
> > 
> > The SPDX-License-Identifier is set to GPL-2.0+, which correspond to
> > MODULE_LICENSE "GPL".
> > 
> > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> > ---
> >  drivers/usb/chipidea/ci_hdrc_imx.c | 2 +-  drivers/usb/chipidea/usbmisc_imx.c | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
> > index 19f5f5f2a48a..555d398fbfa7 100644
> > --- a/drivers/usb/chipidea/ci_hdrc_imx.c
> > +++ b/drivers/usb/chipidea/ci_hdrc_imx.c
> > @@ -492,7 +492,7 @@ static struct platform_driver ci_hdrc_imx_driver =
> > {  module_platform_driver(ci_hdrc_imx_driver);
> > 
> >  MODULE_ALIAS("platform:imx-usb");
> > -MODULE_LICENSE("GPL v2");
> > +MODULE_LICENSE("GPL");
> >  MODULE_DESCRIPTION("CI HDRC i.MX USB binding");
> > MODULE_AUTHOR("Marek Vasut <marex@denx.de>");
> > MODULE_AUTHOR("Richard Zhao <richard.zhao@freescale.com>"); diff --git
> > a/drivers/usb/chipidea/usbmisc_imx.c b/drivers/usb/chipidea/usbmisc_imx.c
> > index 34ad5bf8acd8..d9cfa00b8a6c 100644
> > --- a/drivers/usb/chipidea/usbmisc_imx.c
> > +++ b/drivers/usb/chipidea/usbmisc_imx.c
> > @@ -633,6 +633,6 @@ static struct platform_driver usbmisc_imx_driver =
> > {  module_platform_driver(usbmisc_imx_driver);
> > 
> >  MODULE_ALIAS("platform:usbmisc-imx");
> > -MODULE_LICENSE("GPL v2");
> > +MODULE_LICENSE("GPL");
> >  MODULE_DESCRIPTION("driver for imx usb non-core registers");
> > MODULE_AUTHOR("Richard Zhao <richard.zhao@freescale.com>");
> 
> Greg, does this is a useful change? I am not sure.

As the two licenses are not matching, something needs to be fixed here,
don't you agree?

Please read include/linux/modules.h for what the strings mean, that
should help explain things more.

greg k-h
