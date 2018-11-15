Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF67C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 18:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6914E21582
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 18:57:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6914E21582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbeKPFGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 00:06:51 -0500
Received: from shell.v3.sk ([90.176.6.54]:52348 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725742AbeKPFGv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 00:06:51 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 455C14C388;
        Thu, 15 Nov 2018 19:57:49 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 71A5V7ibCKxB; Thu, 15 Nov 2018 19:57:46 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 19BC34C46F;
        Thu, 15 Nov 2018 19:57:46 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id jJkvuG9Uix5p; Thu, 15 Nov 2018 19:57:45 +0100 (CET)
Received: from belphegor (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id E46714C388;
        Thu, 15 Nov 2018 19:57:44 +0100 (CET)
Message-ID: <49eee45692f16dcbcf8aceaf3a999bb7f33178ba.camel@v3.sk>
Subject: Re: [PATCH 02/15] Revert "platform/olpc: Make ec explicitly
 non-modular"
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Cameron <quozl@laptop.org>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        platform-driver-x86@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-pm@vger.kernel.org
Date:   Thu, 15 Nov 2018 19:57:44 +0100
In-Reply-To: <20181102221626.GC5322@amd>
References: <20181010172300.317643-1-lkundrak@v3.sk>
         <20181010172300.317643-3-lkundrak@v3.sk> <20181102221626.GC5322@amd>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-11-02 at 23:16 +0100, Pavel Machek wrote:
> On Wed 2018-10-10 19:22:47, Lubomir Rintel wrote:
> > It doesn't make sense to always have this built-in, e.g. on ARM
> > multiplatform kernels. A better way to address the problem the
> > original
> > commit aimed to solve is to fix Kconfig.
> > 
> > This reverts commit f48d1496b8537d75776478c6942dd87f34d7f270.
> 
> This looks ok, but I don't see the Kconfig fix in the series. Is it
> needed?

It's flipped to a tristate in "Platform: OLPC: Move OLPC config symbol
out of x86 tree" and mentioned in the commit message.

Perhaps I could made that clear by separating the change into a
separate patch. I'm keeping it as it is in next version of the patch
set, but I'm going to improve this one's commit message and sort the
patches closer together.

> 							Pavel

Lubo								

