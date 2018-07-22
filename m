Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A91C6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 14:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97CEE20878
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 14:44:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97CEE20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbeGVPk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 11:40:57 -0400
Received: from mailoutvs11.siol.net ([185.57.226.202]:46933 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728351AbeGVPk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 11:40:57 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 9EAB7521723;
        Sun, 22 Jul 2018 16:43:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta09.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta09.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id EGFm2yoYZUZr; Sun, 22 Jul 2018 16:43:59 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 2807E521729;
        Sun, 22 Jul 2018 16:43:59 +0200 (CEST)
Received: from jernej-laptop.localnet (unknown [194.152.15.144])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPA id 353AA521723;
        Sun, 22 Jul 2018 16:43:57 +0200 (CEST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     wens@csie.org, robh+dt@kernel.org, airlied@linux.ie,
        mark.rutland@arm.com, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 00/18] Allwinner R40 HDMI refactoring
Date:   Sun, 22 Jul 2018 16:43:56 +0200
Message-ID: <2309112.TTVI9Fv1ar@jernej-laptop>
In-Reply-To: <20180711083036.7attjq4hm5ay5gmn@flea>
References: <20180710203511.18454-1-jernej.skrabec@siol.net> <20180711083036.7attjq4hm5ay5gmn@flea>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

Dne sreda, 11. julij 2018 ob 10:30:36 CEST je Maxime Ripard napisal(a):
> On Tue, Jul 10, 2018 at 10:34:53PM +0200, Jernej Skrabec wrote:
> > This series fixes several issues found in R40 HDMI patch series after
> > it was applied. Conversation can be found here:
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2018-June/586011.htm
> > l
> > 
> > Patches are based on latest linux-next (next-20180710) and are ordered
> > in such way that they don't break R40 HDMI at any time. Because of that
> > I suggest that whole series goes through drm-misc to preserve that order.
> > 
> > I also tested those patches on H3 to make sure it doesn't break other
> > platforms. However, it would be nice to test for regressions also on
> > older SoCs (with DE1).
> > 
> > Best regards,
> > Jernej
> 
> Applied all patches but the patch 10, thanks!
> Maxime

It seems that you forgot to merge some patches:

[PATCH v2 12/18] drm/sun4i: tcon: Add another way for matching mixers with 
tcon
[PATCH v2 13/18] drm/sun4i: tcon: Add support for R40 TCON

Without them, R40 display pipeline can't work.

Maybe they are in your spam folder?

Best regards,
Jernej


