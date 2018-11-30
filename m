Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96BFAC65BAE
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 00:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AE0E2145D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 00:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bCILhuB9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AE0E2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbeK3Ldg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 06:33:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:42864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbeK3Ldg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 06:33:36 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E34AD20834;
        Fri, 30 Nov 2018 00:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543537574;
        bh=+Q7twPuT2a1YMWUiciED1ctTBmPbfRoP7E/Mt8k1r7M=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=bCILhuB9VzFUS2hhU8LL6drVnBr/x+XwLKWUOv5e6T+CEfmFO1tRdHCsDAon+DMLs
         iID2hXhbbyOsA/EVnI6StNlI75ogO67oIrUvU+sr42hbAj9Xpg5cJhKcmMi4ZDYelj
         F9FJSokYA28gKDMQ/TURwtYH7P2dZgZjJI9qtIv0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Andreas Kemnade <andreas@kemnade.info>, bcousson@baylibre.com,
        letux-kernel@openphoenux.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        mturquette@baylibre.com, paul@pwsan.com, t-kristo@ti.com,
        tony@atomide.com
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181110203115.13335-1-andreas@kemnade.info>
Cc:     Andreas Kemnade <andreas@kemnade.info>
References: <20181110203115.13335-1-andreas@kemnade.info>
Message-ID: <154353757335.88331.5161306764126530976@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2 0/3] mach-omap2: handle autoidle denial
Date:   Thu, 29 Nov 2018 16:26:13 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Andreas Kemnade (2018-11-10 12:31:12)
> On the gta04 with a dm3730 omap_hdq does not work properly when the
> device enters lower power states. Idling uart1 and 2 is enough
> to show up that problem, if there are no other things enabled.
> Further research reveals that hdq iclk must not be turned off during
> transfers, also according to the TRM. That fact is also correctly describ=
ed
> in the flags but the code to handle that is incomplete.
> =

> To handle multiple users of a single ick, autoidle is disabled
> when a user of that ick requires that (has the OCPIF_SWSUP_IDLE))
> =

> Changes since v1:
> - uses spinlocks instead of mutexes
> - invert counter logic
> - check whether clock type is basic
> =


I'm expecting someone like Tero or Tony to review this.

