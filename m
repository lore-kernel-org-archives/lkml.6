Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76714C6778C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 17:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28295248BF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 17:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dt9nq1lL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28295248BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754870AbeF2Ris (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 13:38:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:45852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750965AbeF2Rip (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 13:38:45 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0E2623E8D;
        Fri, 29 Jun 2018 17:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530293924;
        bh=oEzsR/Y7TIEfk4lpYQomzLwlBZ7Q1PC3Evhh5a2Y1i4=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=dt9nq1lLYbuBTyz9YCt5R4StoeGTWTFXkLEvHpxRVSz6hbyWNsJ8TIUTHxPLXtd4t
         +4w3hcOdupvesN12sge5ebjS5u/M4fi4YA0D4C/HCHEb1vMgUfdE0wygTaEoT/yZUR
         9s6OjI1PspyODOM/hI2pr7ftkflMZrarT7vwP0vo=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Saravanan Sekar <sravanhome@gmail.com>, afaerber@suse.de
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180628191805.3722-1-sravanhome@gmail.com>
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        Saravanan Sekar <sravanhome@gmail.com>,
        catalin.marinas@arm.com, mturquette@baylibre.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, manivannan.sadhasivam@linaro.org, pn@denx.de,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20180626192820.28237-3-sravanhome@gmail.com>
 <20180628191805.3722-1-sravanhome@gmail.com>
Message-ID: <153029392426.143105.1931235700216822088@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2 0/3] Add clock driver for Actions S700 SoC
Date:   Fri, 29 Jun 2018 10:38:44 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Saravanan Sekar (2018-06-28 12:18:02)
> Changelog v2:
> Fixed 0 day compilation warning
> Modified existing dts Actions S900 clock bindings common to Actions
> Soc family
> =

> This patchset adds clock support for Actions Semi OWL series S700 SoC
> with relevant clock bindings and device tree info. =

> =

> Changed the UART clock using CMU instance and changes are tested in
> cubieboard7
> =

> Thanks and regards,
> Saravanan,
> Parthiban
> =

> Saravanan Sekar (3):
>   arm64: dts: actions: Enable clock controller for S700
>   clk: actions: Add S700 SoC clock support
>   dt-bindings: clock: Modify Actions Soc clock bindings

Normally this patch comes first, and then clk driver, and then dts bits.
Also, the header file for the #define constants would be part of the
bindings patch.

