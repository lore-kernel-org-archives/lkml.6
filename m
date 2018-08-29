Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FBA2C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 11:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1CAD2086A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 11:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+o8CDzt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1CAD2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbeH2PKU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 11:10:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:56960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727444AbeH2PKU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 11:10:20 -0400
Received: from mail-qt0-f175.google.com (mail-qt0-f175.google.com [209.85.216.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7E4E20862;
        Wed, 29 Aug 2018 11:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535541236;
        bh=TDHMAAzyocjcODs2/ZzTEQl8NWri2ZtzzGeWvVGD/+Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=L+o8CDzt5LTh/tRpAkk4xbna6OfKshHJs18oVHHkJ+ydzeKmr4tuLZoUfB5v1jVz8
         lwiGzptp+F5BxnZbVpYfG1WVQeK3Obd4Hg5n/HTIuY3Vx5rc287dCW30BG+HTdwm4y
         cYCS3T/emfidijt0M77dSi1tQzLnMjgtb/B5NIs0=
Received: by mail-qt0-f175.google.com with SMTP id t5-v6so5214460qtn.3;
        Wed, 29 Aug 2018 04:13:56 -0700 (PDT)
X-Gm-Message-State: APzg51AjEjPQQjECAeLMRq3e8SwGBNpf96G9pGquxS7UUd+kGFjDGStW
        D5yeEcAa3kOfK+pT/Ztq33Qt5BMaIzrL4eU+3A==
X-Google-Smtp-Source: ANB0VdZokuFGGMPC1yCeW+w9MUhOCbp/+MfRwB9ZiaoW7WEtpLPtWDSgwIGEFuliXJjxOeYF+cgO5cBYyd84C+T/ckg=
X-Received: by 2002:a0c:d5d3:: with SMTP id h19-v6mr5927159qvi.218.1535541235889;
 Wed, 29 Aug 2018 04:13:55 -0700 (PDT)
MIME-Version: 1.0
References: <20180828154433.5693-1-robh@kernel.org> <20180828154433.5693-3-robh@kernel.org>
 <153549455575.129321.22566359378173086@swboyd.mtv.corp.google.com>
In-Reply-To: <153549455575.129321.22566359378173086@swboyd.mtv.corp.google.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 29 Aug 2018 06:13:44 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ35s0vfor4AdzKRvxOsqSvSD+_y4J3vYNeVk9ZW6HtjQ@mail.gmail.com>
Message-ID: <CAL_JsqJ35s0vfor4AdzKRvxOsqSvSD+_y4J3vYNeVk9ZW6HtjQ@mail.gmail.com>
Subject: Re: [PATCH v2] clk: Convert to using %pOFn instead of device_node.name
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:MEDIA DRIVERS FOR RENESAS - FCP" 
        <linux-renesas-soc@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 5:15 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Rob Herring (2018-08-28 08:44:29)
> > In preparation to remove the node name pointer from struct device_node,
> > convert printf users to use the %pOFn format specifier.
> >
> > Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> > Cc: Michael Turquette <mturquette@baylibre.com>
> > Cc: Stephen Boyd <sboyd@kernel.org>
> > Cc: linux-clk@vger.kernel.org
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-renesas-soc@vger.kernel.org
> > Cc: linux-omap@vger.kernel.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
>
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>

Please apply to the clock tree. There's no dependencies and removing
name will take some time.

Rob
