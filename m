Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE9CC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 17:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E98120665
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 17:03:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E98120665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbeJXB1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 21:27:49 -0400
Received: from shell.v3.sk ([90.176.6.54]:33233 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727359AbeJXB1t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 21:27:49 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id B2A51BE77E;
        Tue, 23 Oct 2018 19:03:32 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 4UlrXyoArNos; Tue, 23 Oct 2018 19:03:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id C93B7BE77F;
        Tue, 23 Oct 2018 19:03:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id og7WxHmwkZb9; Tue, 23 Oct 2018 19:03:28 +0200 (CEST)
Received: from belphegor (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 9E625BE77E;
        Tue, 23 Oct 2018 19:03:27 +0200 (CEST)
Message-ID: <734019816c2a8e1930127332249b1180f6d0cddc.camel@v3.sk>
Subject: Re: [PATCH 0/15] Add support for OLPC XO 1.75 Embedded Controller
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        quozl@laptop.org, Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        devel@driverdev.osuosl.org, Linux PM <linux-pm@vger.kernel.org>
Date:   Tue, 23 Oct 2018 19:03:26 +0200
In-Reply-To: <CAHp75Vd_9RmfDFnSzkNOQyfKVOR1tfzbMPy0_J7_DfZ2e4A16g@mail.gmail.com>
References: <20181010172300.317643-1-lkundrak@v3.sk>
         <CAHp75Vd_9RmfDFnSzkNOQyfKVOR1tfzbMPy0_J7_DfZ2e4A16g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.1 (3.30.1-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-10-19 at 16:57 +0300, Andy Shevchenko wrote:
> On Wed, Oct 10, 2018 at 8:23 PM Lubomir Rintel <lkundrak@v3.sk> wrote:
> > Hi.
> > 
> > This patchset adds support for the Embedded Controller on an OLPC XO
> > 1.75 machine. OLPC XO 1.75 is a MMP2 based ARM laptop. It plugs into
> > the existing OLPC platform infrastructure, currently used by the x86
> > based models.
> > 
> > The EC operates in SPI master mode, meaning the SOC is the SPI slave. It
> > uses extra handshake signal to signal readiness of SOC to accept data
> > from EC and to initiate a transaction if SOC wishes to submit data.
> > 
> > The SPI slave support for MMP2 was submitted separately:
> > https://lore.kernel.org/lkml/20181010170936.316862-1-lkundrak@v3.sk/T/#t
> > 
> > THe "power: supply: olpc_battery: correct the temperature" patch was
> 
> The
> 
> > already sent out separately, but I'm including it because the last
> > commit of the set depends on it.
> > 
> > Tested to work on an OLPC XO 1.75 and also tested not to break x86
> > support with an OLPC XO 1 machine. I don't have a XO 1.5, but it's
> > unlikely this breaks it when XO 1 works.
> > 
> > Thanks in advance for reviews and feedback of any kind.
> 
> Thanks for the series.
> I'm about to review the patch 6, otherwise read my comments for the
> rest and consider addressing them.

Thank you very much for your feedback, it is very appreciated.

The XO 1.75 patch set has grown somewhat larger than I'm comfortable
with, so I need some time to digest and address the review. I hope I'll
be able to post a v2 some time after the 4.20 merge window closes and
respond to questions raised in individual patches before that.

> 
> > Lubo
> > 
> 
> 

