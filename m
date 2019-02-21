Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA83C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 01:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7ECD2089F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 01:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="o9df63Dz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfBUBVo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 20:21:44 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35670 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbfBUBVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 20:21:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aBFE7ZKpQNK/17tRCfomJ7fWvfu19kP1UHh0wcJf+fk=; b=o9df63DzDPiywefxzHo6LwijR
        tj80+KR5pbDLt/uwI03EJ48N/Vp4hWCeWBtYezaMrHsg03FEw9YiERB6naPIxkTFgdkuFM7xB8koq
        isJb0tkcc4b1uKS3+d2QABT42yjIb9e65cx28VMbNCCz2arxHQltQKXovkDxYiW0nX4+VTTuT/p2l
        jrRMFJ0qbZLyV91mAe+JCUYi4JwC6CHc+7xdb9euOGNNt/dkM432Dsk8VFfHIvp2poRRj43NOqjkC
        8CtxlpNUeIqndz3jrUwYWMKauJlG/Cg3VGtjXE8wSrwHAxivdh+egiS+KB+GN261ECHylI/yoCQu2
        4hM8XJE3Q==;
Received: from dvhart by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gwd3M-0000DR-KT; Thu, 21 Feb 2019 01:21:32 +0000
Date:   Wed, 20 Feb 2019 17:21:30 -0800
From:   Darren Hart <dvhart@infradead.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Lubomir Rintel <lkundrak@v3.sk>,
        Andy Shevchenko <andy@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v5 01/10] dt-bindings: olpc,xo1.75-ec: Add OLPC XO-1.75
 EC bindings
Message-ID: <20190221012130.GB5838@wrath>
References: <20190110175845.1203986-1-lkundrak@v3.sk>
 <20190110175845.1203986-2-lkundrak@v3.sk>
 <20190111143635.GA21484@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190111143635.GA21484@bogus>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 08:36:35AM -0600, Rob Herring wrote:
> On Thu, 10 Jan 2019 18:58:36 +0100, Lubomir Rintel wrote:
> > The OLPC XO-1.75 Embedded Controller is a SPI master that uses extra
> > signals for handshaking. It needs to know when is the slave (Linux)
> > side's TX FIFO ready for transfer (the ready-gpio signal on the SPI
> > controller node) and when does it wish to respond with a command (the
> > cmd-gpio property).
> > 
> > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> > Acked-by: Pavel Machek <pavel@ucw.cz>
> > 
> > ---
> > Changes since v1:
> > - s/cmd-gpio/cmd-gpios/
> > - s/ready-gpio/ready-gpios/ in the documentation paragraph
> > - Remove status = "okay" from the example
> > 
> >  .../bindings/misc/olpc,xo1.75-ec.txt          | 23 +++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.txt
> > 
> 
> Please add Acked-by/Reviewed-by tags when posting new versions. However,
> there's no need to repost patches *only* to add the tags. The upstream
> maintainer will do that for acks received on the version they apply.
> 
> If a tag was not added on purpose, please state why and what changed.

Rob, I saw you ack this patch in an earlier version. Based on your comment here,
is that ack still valid?

-- 
Darren Hart
VMware Open Source Technology Center
