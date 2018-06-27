Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC3DC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 22:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B2F02495F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 22:54:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B2F02495F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751633AbeF0Wyb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 18:54:31 -0400
Received: from smtprelay0002.hostedemail.com ([216.40.44.2]:45418 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751391AbeF0Wy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 18:54:29 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id E7AD3182CED34;
        Wed, 27 Jun 2018 22:54:27 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: table68_92b5c436ce36
X-Filterd-Recvd-Size: 3213
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Wed, 27 Jun 2018 22:54:22 +0000 (UTC)
Message-ID: <8bf36e4025b6ec5198a668edda6bcbef3b06e97b.camel@perches.com>
Subject: Re: [PATCH v5 09/10] gpio: Add a driver for Cadence I3C GPIO
 expander
From:   Joe Perches <joe@perches.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Przemyslaw Sroka <psroka@cadence.com>,
        Arkadiusz Golec <agolec@cadence.com>,
        Alan Douglas <adouglas@cadence.com>,
        Bartosz Folta <bfolta@cadence.com>,
        Damian Kos <dkos@cadence.com>,
        Alicja Jurasik-Urbaniak <alicja@cadence.com>,
        Cyprian Wronka <cwronka@cadence.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vitor Soares <Vitor.Soares@synopsys.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>,
        Przemyslaw Gaj <pgaj@cadence.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Date:   Wed, 27 Jun 2018 15:54:21 -0700
In-Reply-To: <20180627213617.51e10712@bbrezillon>
References: <20180622104930.32050-1-boris.brezillon@bootlin.com>
         <20180622104930.32050-10-boris.brezillon@bootlin.com>
         <CAHp75Vdxg49q6aQj0dDpzM4q2WnQbGoCECWR1roda7aMR+u4gg@mail.gmail.com>
         <20180626215648.1472b96e@bbrezillon>
         <CAHp75VcVvOzgOM87rSrwsCxh+WAK-z+zVCJifnY+Xeeu=cPFiA@mail.gmail.com>
         <20180626234638.076fb816@bbrezillon>
         <CAHp75VdBXj66Yd6sQHOWz19R9MUtYMSeq4j-+UidLedpfkB6mA@mail.gmail.com>
         <20180627213617.51e10712@bbrezillon>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-06-27 at 21:36 +0200, Boris Brezillon wrote:
> I mean, kzalloc() is not deprecated AFAIK and I don't really see the
> benefit of using kmalloc_array(), but if that makes you happy, let's go
> for kmalloc_array().

kcalloc

> I do run checkpatch --strict and fix most of the thing reported except
> those hurting readability. I don't remember seeing checkpatch complain
> about kzalloc() usage, and I guess it's not smart enough to detect that
> for_each_bit_set() can be used to replace the "for() if (BIT(x) & val)"
> pattern.

That would not an appropriate conversion suggestion in any case.
coccinelle could at least look at whether or not x is allocated
as a bitmap via DECLARE_BITMAP or bitmap_alloc


