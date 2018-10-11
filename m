Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47427C46463
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 10:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17A0420841
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 10:42:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17A0420841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbeJKSJO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 14:09:14 -0400
Received: from shell.v3.sk ([90.176.6.54]:58318 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728342AbeJKSJN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 14:09:13 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 716A5BD02D;
        Thu, 11 Oct 2018 12:42:28 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id u1KJRCuCgGYN; Thu, 11 Oct 2018 12:42:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 3C45DBD0A8;
        Thu, 11 Oct 2018 12:42:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 5MV--l3oDxu4; Thu, 11 Oct 2018 12:42:24 +0200 (CEST)
Received: from belphegor.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id DBF51BD02D;
        Thu, 11 Oct 2018 12:42:23 +0200 (CEST)
Message-ID: <40e6a8575d4bdc43cc069e561e12f404983c5567.camel@v3.sk>
Subject: Re: [PATCH 0/15] Add support for OLPC XO 1.75 Embedded Controller
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Cameron <quozl@laptop.org>,
        Sebastian Reichel <sre@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        platform-driver-x86@vger.kernel.org, devel@driverdev.osuosl.org,
        "open list:THERMAL" <linux-pm@vger.kernel.org>
Date:   Thu, 11 Oct 2018 12:42:24 +0200
In-Reply-To: <CAL_Jsq+MYBrkZ=OEv3avxC_NZ+q3+stOF8CsHeXUsomKZD9+AA@mail.gmail.com>
References: <20181010172300.317643-1-lkundrak@v3.sk>
         <CAL_Jsq+MYBrkZ=OEv3avxC_NZ+q3+stOF8CsHeXUsomKZD9+AA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.1 (3.30.1-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-10-10 at 14:26 -0500, Rob Herring wrote:
> On Wed, Oct 10, 2018 at 12:23 PM Lubomir Rintel <lkundrak@v3.sk> wrote:
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
> > already sent out separately, but I'm including it because the last
> > commit of the set depends on it.
> > 
> > Tested to work on an OLPC XO 1.75 and also tested not to break x86
> > support with an OLPC XO 1 machine. I don't have a XO 1.5, but it's
> > unlikely this breaks it when XO 1 works.
> 
> I asked this on the OLPC devel list recently, but I don't think my
> message ever got past the moderator. Could you generate a DT dump from
> /proc/device-tree of an XO 1 and send to me? I have some DT changes
> planned and need to see if they'd be okay for x86 OLPC.

The /proc/device-tree tarball: http://v3.sk/~lkundrak/olpc/xo1.tar
(Mirror: https://people.freedesktop.org/~lkundrak/olpc/xo1.tar)

My distro's dtc crashes with this (could be related to your recent dtc
fixes), the git tip needs -f to work around some funny property names.
I figure a raw data as opposed to a dts/dtb dump would be a better
idea.

Also, there's no phandles, so it's of rather limited use. If you need
those, then I can share a dump directly from ofw instead or patch the
kernel to fabricate and expose the phandle properties.

This is with the latest firmware. I guess the exact version is
somewhere within the device tree.

> 
> Rob

Cheers
Lubo

