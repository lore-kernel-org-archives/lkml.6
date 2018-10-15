Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6350DC04EBB
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 21:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25D9F208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 21:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xCf8rc2I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25D9F208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbeJPFlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 01:41:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:33650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbeJPFlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 01:41:03 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 390382089E;
        Mon, 15 Oct 2018 21:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539640437;
        bh=BImICXSS+tTBo8IhYNUWt/lmGO7tgL/MD69GQ8t9FMY=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=xCf8rc2IkvIteSDdWfeqdwN9R+k9o+X7IiViC6fsI+TkbmJ90yG/3w0KdjUPIvflp
         NQhiFwj1PkTnv2t/M/DJaYTzp9FP/561cy5GpvSG4KZXuGx4Cnjv9lcKbHckAuKpya
         8QPKMm3ZNOo6neM7cfyZyCPi8r9Hm7Svl0adhLmo=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Mark Brown <broonie@kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181015165528.GD12949@sirena.org.uk>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        lee.jones@linaro.org, linus.walleij@linaro.org,
        mturquette@baylibre.com, robh+dt@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org
References: <20181008132542.19775-1-ckeepax@opensource.cirrus.com>
 <20181008132542.19775-3-ckeepax@opensource.cirrus.com>
 <153924124658.207691.10370075148426001371@swboyd.mtv.corp.google.com>
 <20181011132602.GD1653@imbe.wolfsonmicro.main>
 <153935999691.5275.1587207165396958375@swboyd.mtv.corp.google.com>
 <20181015104905.GF1653@imbe.wolfsonmicro.main>
 <153962159992.5275.9275448716859702011@swboyd.mtv.corp.google.com>
 <20181015165528.GD12949@sirena.org.uk>
Message-ID: <153964043651.5275.8596868422770600346@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2 3/5] clk: lochnagar: Add support for the Cirrus Logic Lochnagar
Date:   Mon, 15 Oct 2018 14:53:56 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mark Brown (2018-10-15 09:55:28)
> On Mon, Oct 15, 2018 at 09:39:59AM -0700, Stephen Boyd wrote:
> =

> > Ok if there's going to be read/volatile regs and defaults then it makes
> > sense to leave the defines in some shared header file, which is
> > unfortunate for the independent merge of driver bits. Either way, I
> =

> Kconfig dependencies take care of that pretty well - if there's a
> dependency on the MFD then the function driver just won't get built
> until the MFD gets merged.  =


Yep. I'm just saying that I can't merge the clk driver part by itself
when there's a shared header dependency, unless someone provides a
stable tree with the header file patch applied to it.

