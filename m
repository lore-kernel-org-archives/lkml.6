Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751901AbeBVCT4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 21:19:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:45580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751834AbeBVCTy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 21:19:54 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 775B621796
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=shawnguo@kernel.org
Date: Thu, 22 Feb 2018 10:19:44 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Rob Herring <robh+dt@kernel.org>
Cc: Mathieu Malaterre <malat@debian.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, Jun Nie <jun.nie@linaro.org>,
        Baoyou Xie <baoyou.xie@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 16/25] arm: zx: dts: Remove leading 0x and 0s from
 bindings notation
Message-ID: <20180222021943.GA3217@dragon>
References: <20171215124649.30692-1-malat@debian.org>
 <20171226080312.GE23070@X250>
 <CAL_JsqL02_v46mxqF2cFerC82fNPQAEpm0vfjr2F_78i3fVM7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqL02_v46mxqF2cFerC82fNPQAEpm0vfjr2F_78i3fVM7Q@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 09:37:12AM -0600, Rob Herring wrote:
> On Tue, Dec 26, 2017 at 2:03 AM, Shawn Guo <shawnguo@kernel.org> wrote:
> > On Fri, Dec 15, 2017 at 01:46:48PM +0100, Mathieu Malaterre wrote:
> >> Improve the DTS files by removing all the leading "0x" and zeros to fix the
> >> following dtc warnings:
> >>
> >> Warning (unit_address_format): Node /XXX unit name should not have leading "0x"
> >>
> >> and
> >>
> >> Warning (unit_address_format): Node /XXX unit name should not have leading 0s
> >>
> >> Converted using the following command:
> >>
> >> find . -type f \( -iname *.dts -o -iname *.dtsi \) -exec sed -i -e "s/@\([0-9a-fA-FxX\.;:#]+\)\s*{/@\L\1 {/g" -e "s/@0x\(.*\) {/@\1 {/g" -e "s/@0+\(.*\) {/@\1 {/g" {} +^C
> >>
> >> For simplicity, two sed expressions were used to solve each warnings separately.
> >>
> >> To make the regex expression more robust a few other issues were resolved,
> >> namely setting unit-address to lower case, and adding a whitespace before the
> >> the opening curly brace:
> >>
> >> https://elinux.org/Device_Tree_Linux#Linux_conventions
> >>
> >> This will solve as a side effect warning:
> >>
> >> Warning (simple_bus_reg): Node /XXX@<UPPER> simple-bus unit address format error, expected "<lower>"
> >>
> >> This is a follow up to commit 4c9847b7375a ("dt-bindings: Remove leading 0x from bindings notation")
> >>
> >> Reported-by: David Daney <ddaney@caviumnetworks.com>
> >> Suggested-by: Rob Herring <robh@kernel.org>
> >> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> >
> > Hi Arnd, Olof,
> >
> > I do not have any other ZTE ZX platform patches to send you.  Is it okay
> > to send this one using IMX branch, or can you apply it to arm-soc
> > directly?
> 
> Ping. This one didn't make it into 4.16.

Sorry about that.  I will send a pull request to arm-soc folks for this
one, and hopefully it can still be merged for 4.16 as a fix.

Shawn
