Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DBFCC0044B
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 07:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3790D216FD
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 07:46:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3790D216FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbeKLRiA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 12:38:00 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35684 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727319AbeKLRiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 12:38:00 -0500
Received: by mail-lf1-f66.google.com with SMTP id e26so3661325lfc.2;
        Sun, 11 Nov 2018 23:45:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O4DEwIynUc77dZg/ag93qK776/mMU+0Tp2u/PyN0MDg=;
        b=PKVzyw9CBGxc3i0Vq0mknRJTds1L4OHce2qsJESgEd6u1u+ztw9h3XS4EhFCyhCnk8
         In4I9OHG2H3ZGnU9lgydkr+C7BER9MbFLkjC5RCsdHlVMkxVURkPUXlsV3A3TOu8YZ8Y
         HVzrH+iSeJTSb+VWP3x1n6G8d/v0lR5g3xL4g8H9r+4HSGQ2GpM+wd4mKY5qbKpOSqgX
         zIcpte4ZsxDn5Ut5U2Cr3MWA6feWPOEsaMX/1WUzce7xu+w30QxRJfEPe8zcGLZhHvZf
         8bC5jxE69TBMhrp1c9XrqEta92oidzDD+TiBccydhZR6h3b3Jafo4BMWrFZE73itRRL2
         Okfw==
X-Gm-Message-State: AGRZ1gKc4cCV9tiCDUdZkgz8PQ7rS+OBbDh6PGq1unwPgoAzlpOTHK++
        YiwLS3eEhRA786bsX7gd0hs=
X-Google-Smtp-Source: AJdET5ekhvrfI5wjvCWJqH83ildkN78kpN4k2vKCg6ST1dTxykWYZCKPg2b/qAD4GyvEGkpisTYOLg==
X-Received: by 2002:a19:c18d:: with SMTP id r135mr9894718lff.59.1542008757105;
        Sun, 11 Nov 2018 23:45:57 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id b25sm2849673lfa.96.2018.11.11.23.45.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 11 Nov 2018 23:45:55 -0800 (PST)
Date:   Mon, 12 Nov 2018 09:45:53 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     corbet@lwn.net, mturquette@baylibre.com, linux@armlinux.org.uk,
        andrew.smirnov@gmail.com, robh@kernel.org, sre@kernel.org,
        linux@roeck-us.net, sjhuang@iluvatar.ai, mazziesaccount@gmail.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 2/2] clk: bd718x7: Initial support for ROHM
 bd71837/bd71847 PMIC clock
Message-ID: <20181112074553.GB31573@localhost.localdomain>
References: <0e6f19f99a4321d37472635c9210f6c13ac53147.1535630942.git.matti.vaittinen@fi.rohmeurope.com>
 <201808310820.GfPfChXp%fengguang.wu@intel.com>
 <20180831102123.GA2472@localhost.localdomain>
 <153582920636.19113.4389105687778850598@swboyd.mtv.corp.google.com>
 <20180903063843.GD2472@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180903063843.GD2472@localhost.localdomain>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Stephen & All,

On Mon, Sep 03, 2018 at 09:38:43AM +0300, Matti Vaittinen wrote:
> 
> On Sat, Sep 01, 2018 at 12:13:26PM -0700, Stephen Boyd wrote:
> > Quoting Matti Vaittinen (2018-08-31 03:21:23)
> > > Hello All,
> > > 
> > > Just wanted to point out for the reviewers that this patch depends on
> > > not yet accepted MFD/regulator patch. (struct/defines in
> > > include/linux/mfd/rohm-bd718x7.h were changed)
> > > https://lore.kernel.org/lkml/cover.1535545377.git.matti.vaittinen@fi.rohmeurope.com/
> > 
> > Does anything besides the clk driver need the defines that are in the
> > header which are used in this file?
> 
> The register address for clk enable and bit mask are not used by any
> other driver. But I'd like to keep all the register addresses in one
> enum. That eases checking changes when new chips come.
> 
> The private data for MFD (which contains for example the regmap and chip
> type) are required by other drivers too.
> 
> > If not, then it's better to put
> > those defines in the C file for the clk driver so we don't have to hop
> > between files and have merge dependencies. Also, the regmap could
> > possibly by grabbed from the dev->parent pointer instead of passing it
> > down through an mfd structure, allowing this driver to be more generic
> > assuming it is always a child of some mfd device that has a regmap.
> 
> Currently clk only uses regmap directly from the struct bd718xx. But I
> would like to have the access to chip_type as well. And even if we forget
> the chip_type. Well, I only see two bad ways of omitting the struct
> bd718xx:
> 
> 1. Always keep the regmap as first member in parent device's driver_data.
> Then we can just get the driver data and do cast to regmap. I am not fan
> of this as it breaks as fast as someone changes the struct bd718xx - and
> as this is part of MFD - well, there is no guarantees the clk people are
> even reviewing such change. Also if we need the chip type we are back
> using the struct.
> 
> 2. Use some regmnap wrapper functions which would only take the parent
> dev pointer and dig out the regmap details. This would be doable but
> then we still have dependency to these wrappers (so dependency is not
> solved). Additionally these wrappers are something we decided to get rid
> of few patch versions ago.
> 
> I don't expect much renamings to take place after the latest patch set
> to MFD/regulator tree has been applied. So maybe the clk patch set can
> just wait untill MFD/regulator stuff gets integrated. I would be
> gratefull if we could review the clk patch set already now though so I
> could do improvements/changes to clk side while waiting for
> MFD/regulator to get applied. Also, the devm_ functions (patch 1) are
> not depending on MFD - so maybe we can get them reviewed/applied? If I
> have the spare time I can look if I can clean up some of those not freed
> clkdev lookups.
> 
The MFD renaming patch has now been merged to clk-next. So dependencies
to MFD should now be in-tree. I will rebase this to clk-next and do
resend. This patch still requires the devm variants for clkdev lookups
an devm variant of "parent of provider"-registration. I did submit those
as part of the cleanup series:
https://lore.kernel.org/linux-clk/cover.1541161503.git.matti.vaittinen@fi.rohmeurope.com/

My question is if you prefer me to add this driver in that series and
resend the series as v4? Or do you want me to send this in own
individual patch with just a note about the dependency?

Best Regards
	Matti Vaittinen

-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
