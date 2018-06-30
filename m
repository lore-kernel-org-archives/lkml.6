Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C960C6778C
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 01:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDE2E280FE
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 01:22:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDE2E280FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932846AbeF3BWy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 21:22:54 -0400
Received: from gate.crashing.org ([63.228.1.57]:33022 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753629AbeF3BWr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 21:22:47 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w5U167Z9001754;
        Fri, 29 Jun 2018 20:06:08 -0500
Message-ID: <36f23db17a3d25e78e3387cc9d18fc66b4df74d1.camel@kernel.crashing.org>
Subject: Re: [RFC PATCH 01/14] devres: Add devm_of_iomap()
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        linux-aspeed@lists.ozlabs.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Andrew Jeffery <andrew@aj.id.au>
Date:   Sat, 30 Jun 2018 11:06:07 +1000
In-Reply-To: <CAHp75VfshFLuvOSB4deALX=EUf2Z_RW4Ct-K5cMsAj4yifF-cg@mail.gmail.com>
References: <20180622043134.18238-1-benh@kernel.crashing.org>
         <20180622043134.18238-2-benh@kernel.crashing.org>
         <CACRpkdbhxjahYaVnQN0xqD0NLPouO8VCW8w-GZD0sbLFtFtY5g@mail.gmail.com>
         <CAHp75VfshFLuvOSB4deALX=EUf2Z_RW4Ct-K5cMsAj4yifF-cg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.3 (3.28.3-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-06-29 at 23:27 +0300, Andy Shevchenko wrote:
> On Fri, Jun 29, 2018 at 12:14 PM, Linus Walleij
> <linus.walleij@linaro.org> wrote:
> 
> > I wonder if it is easy to find these cases and replace them with
> > this neat function...
> 
> Would be reasonable easy by using coccinelle.

For the obvious ones yes. A lot of the existing users of of_iomap
however don't do the request_region, and while they probably should and
should use the new accessor, this can't be done blindly without
testing, because there are many old things around that have broken
memory region tracking and that will fail..

I plan to do a sweep through some of my old powermac/powerpc stuff one
of these days and do some conversions.

Cheers,
Ben.

