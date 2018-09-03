Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A8F7C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 06:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32FE020843
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 06:38:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32FE020843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbeICK5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 06:57:32 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43448 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbeICK5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 06:57:32 -0400
Received: by mail-lf1-f66.google.com with SMTP id h64-v6so14264132lfi.10;
        Sun, 02 Sep 2018 23:38:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QtuX6b3HRK2OUAWekr+ubG66O4SYDpxAdJ56e70A00o=;
        b=Y0xJcXcwTNmrDcyennVWdu8+W9GdE1PqGTHXre6ZlcllnRMwJtZqV9lg1woA+9t6l1
         gdljM10zjqwGVOA3JEPJu1z2oj0np+mBMCMJtm+IHz05OQ0Of8z2Yv37v57hWFdOsaHX
         PNHcbEtnTBIjqNujY93fzL1y4ulXwTNYFz8FU8U3fP1StOLioOEiDiysmpFgYxj0nCZE
         pykcYGKOd4XTQYxZzbo3ZO5R4JKk5vXUNKAg8VuNWUXWm+K/yNoY+OHMCFqlUQc4FsWd
         AkGnGFXQaWSIt8KBZuj8i/R0R5AXMSrxF+bbdQR98UUm1j6Gk5rTr9V8KpSEo+u/EnXL
         UJ0Q==
X-Gm-Message-State: APzg51DEgKfNnWEmMf8v8MgYIKLNaoUANvEJICBDmGgmiz7YnKb19l1q
        VxC29es1n+2l/xMSK/t9O6I=
X-Google-Smtp-Source: ANB0VdZ/IaqEExk06Fj1/MIt8r/r3TYIQT3eYki317ErGd8jq0RVK1VxjZSyFNlh5EHLTDhmth+wAw==
X-Received: by 2002:a19:e44c:: with SMTP id b73-v6mr7040858lfh.117.1535956726951;
        Sun, 02 Sep 2018 23:38:46 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id d10-v6sm3212452lfk.63.2018.09.02.23.38.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 02 Sep 2018 23:38:46 -0700 (PDT)
Date:   Mon, 3 Sep 2018 09:38:43 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        corbet@lwn.net, mturquette@baylibre.com, linux@armlinux.org.uk,
        andrew.smirnov@gmail.com, robh@kernel.org, sre@kernel.org,
        linux@roeck-us.net, sjhuang@iluvatar.ai, mazziesaccount@gmail.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com
Subject: Re: [PATCH 2/2] clk: bd718x7: Initial support for ROHM
 bd71837/bd71847 PMIC clock
Message-ID: <20180903063843.GD2472@localhost.localdomain>
References: <0e6f19f99a4321d37472635c9210f6c13ac53147.1535630942.git.matti.vaittinen@fi.rohmeurope.com>
 <201808310820.GfPfChXp%fengguang.wu@intel.com>
 <20180831102123.GA2472@localhost.localdomain>
 <153582920636.19113.4389105687778850598@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153582920636.19113.4389105687778850598@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Stephen

On Sat, Sep 01, 2018 at 12:13:26PM -0700, Stephen Boyd wrote:
> Quoting Matti Vaittinen (2018-08-31 03:21:23)
> > Hello All,
> > 
> > Just wanted to point out for the reviewers that this patch depends on
> > not yet accepted MFD/regulator patch. (struct/defines in
> > include/linux/mfd/rohm-bd718x7.h were changed)
> > https://lore.kernel.org/lkml/cover.1535545377.git.matti.vaittinen@fi.rohmeurope.com/
> > 
> > On Fri, Aug 31, 2018 at 09:18:19AM +0800, kbuild test robot wrote:
> > > Hi Matti,
> > > 
> > > Thank you for the patch! Yet something to improve:
> > > 
> > > [auto build test ERROR on clk/clk-next]
> > > [also build test ERROR on v4.19-rc1 next-20180830]
> > > [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> > 
> > Thus this error was expected. What is the generally best way to work
> > when there is changes to more than one subsystem? With this approach
> > the patch set here won't compile until MFD part gets applied. But if
> > I use old definitions/structs here, then clk tree gets broken when
> > MFD/regulator part changes defines. I see only bad and worse options =)
> > Anyways, I guess sending this patch with new defines (and applying it
> > only after MFD) is still better than applying this with old defines and
> > breaking it when MFD changes. (Assuming all of the patches get applied
> > at some point).
> > 
> 
> Does anything besides the clk driver need the defines that are in the
> header which are used in this file?

The register address for clk enable and bit mask are not used by any
other driver. But I'd like to keep all the register addresses in one
enum. That eases checking changes when new chips come.

The private data for MFD (which contains for example the regmap and chip
type) are required by other drivers too.

> If not, then it's better to put
> those defines in the C file for the clk driver so we don't have to hop
> between files and have merge dependencies. Also, the regmap could
> possibly by grabbed from the dev->parent pointer instead of passing it
> down through an mfd structure, allowing this driver to be more generic
> assuming it is always a child of some mfd device that has a regmap.

Currently clk only uses regmap directly from the struct bd718xx. But I
would like to have the access to chip_type as well. And even if we forget
the chip_type. Well, I only see two bad ways of omitting the struct
bd718xx:

1. Always keep the regmap as first member in parent device's driver_data.
Then we can just get the driver data and do cast to regmap. I am not fan
of this as it breaks as fast as someone changes the struct bd718xx - and
as this is part of MFD - well, there is no guarantees the clk people are
even reviewing such change. Also if we need the chip type we are back
using the struct.

2. Use some regmnap wrapper functions which would only take the parent
dev pointer and dig out the regmap details. This would be doable but
then we still have dependency to these wrappers (so dependency is not
solved). Additionally these wrappers are something we decided to get rid
of few patch versions ago.

I don't expect much renamings to take place after the latest patch set
to MFD/regulator tree has been applied. So maybe the clk patch set can
just wait untill MFD/regulator stuff gets integrated. I would be
gratefull if we could review the clk patch set already now though so I
could do improvements/changes to clk side while waiting for
MFD/regulator to get applied. Also, the devm_ functions (patch 1) are
not depending on MFD - so maybe we can get them reviewed/applied? If I
have the spare time I can look if I can clean up some of those not freed
clkdev lookups.

Br,
	Matti Vaittinen
> 
