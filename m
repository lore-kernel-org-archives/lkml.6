Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE84C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3D0220815
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:28:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbeLRP2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 10:28:16 -0500
Received: from shell.v3.sk ([90.176.6.54]:44760 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727015AbeLRP2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 10:28:14 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 75852CA2C8;
        Tue, 18 Dec 2018 16:28:10 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id AozWiRNCSlkx; Tue, 18 Dec 2018 16:28:07 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 89C31CA2C9;
        Tue, 18 Dec 2018 16:28:07 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 0v-RuWIuNP7H; Tue, 18 Dec 2018 16:28:06 +0100 (CET)
Received: from belphegor (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id ADFF5CA2C8;
        Tue, 18 Dec 2018 16:28:06 +0100 (CET)
Message-ID: <9e501c50ed5e9a965f7cbedd7079c24d2d95a352.camel@v3.sk>
Subject: Re: [PATCH 2/2] misc: hx8837: add a HiMax HX8837 display controller
 driver
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 18 Dec 2018 16:28:05 +0100
In-Reply-To: <20181127074140.GB13965@kroah.com>
References: <20181112023929.650002-1-lkundrak@v3.sk>
         <20181112023929.650002-2-lkundrak@v3.sk> <20181127074140.GB13965@kroah.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-11-27 at 08:41 +0100, Greg Kroah-Hartman wrote:
> On Mon, Nov 12, 2018 at 03:39:29AM +0100, Lubomir Rintel wrote:
> > HiMax HX8837 is a display controller used on OLPC platforms. It controls
> > backlight and is able to capture and freeze a frame when the LCD controller
> > (and the rest of the plaform) is powered off.
> > 
> > This driver is based on the same code as drivers/staging/olpc_dcon.
> > I modernized it to use managed GPIO, device-tree bindings, sysfs attribtue
> > groups, essentially fixing the staging driver's TODO.
> 
> You are creating custom sysfs files, with no Documentation/ABI/ update
> for us to know what those files are or how they are used :(
> 
> Why do you need custom sysfs files in the first place?  Isn't there
> already an api for this type of device in the kernel?

I am actually not sure. I certainly didn't find anything similar.

I've later discovered that this should perhaps be a DRM encoder driver,
because it sits between the LCDC and the panel; I'm submitting an
updated RFC version to the dri list.

Perhaps the color swizzling and frame freezing functionality that's
exposed via sysfs in this version could be exposed as a DRI property
instead.

> 
> thanks,
> 
> greg k-h

Lubo

