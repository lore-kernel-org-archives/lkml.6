Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BDC9ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 17:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B587A20661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 17:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8On4HoH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B587A20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388302AbeGTSpy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 14:45:54 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37193 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387950AbeGTSpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 14:45:53 -0400
Received: by mail-lf1-f66.google.com with SMTP id j8-v6so2354528lfb.4;
        Fri, 20 Jul 2018 10:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Psgn7FKoFGrtQZQ6Ijpq8PkNv74rzZlWBmpuohue/qg=;
        b=J8On4HoHYFrYntkev9Y2Nmna+wG+JScr8oLvm/ISN0jmvYksissT/yAmSNtltUxjjN
         e+AowKvQ8ysNh6s0w5YqZTGBvaQAALluVEG5WrwBoR05ebOAdumSRA0aZviKjUHSDJ4d
         7DimjoN+b7PIqPkRHWu8T7UHcayvv3uLL3mrPLV49Z8Y+ka/bNJYLjGjdtizn9tQAhxK
         O/3NW4+46j3hG+/lclQ9112ZtPRMrFudO3JUK4/2zIbW1+co/YG2XQGd9tKDcL2d1Vb7
         oYtoDZ/UlbNpm7fk9qk6jRluvQ5nLwW9FnqtYVa+2rQ5SYlNp5PjiUByJPKhi3A76mvB
         FoDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Psgn7FKoFGrtQZQ6Ijpq8PkNv74rzZlWBmpuohue/qg=;
        b=JVt1OUlNiHa3HgbYNcFUf/cvu37I/h+JqPu3SzDmA859SmBFXooxfKEY4k7zaG0vyx
         utitWsxTvSAtsWcjl/l17rImWnta/twKpk+bwXWXkKFZZH3jkf1EogsCsFT/lzaVGfkA
         MezzvCCLjw0w1cSmrQi+9mv0uIkuCCFfJgJyRDOe5gn4NdlAb6TVklL3Oe1ks0PtpgiE
         aLjK8azRM4jATh0Dyhi4sR2YFVV9YUO0z66tslPQKOYhBH5Pq7Np/2sNpohma/2W54fD
         iJmKrH0gJvn/HNvpRiTGmOnXWlxjoLx3c1XZ7rnExLIlDjGd1qErxrka23YPM6yCuFBF
         Zc7A==
X-Gm-Message-State: AOUpUlE6XqUWvNrVMmTPVJ87x3b8LQIn/KH47VUPb663JtBhUTUIZisL
        mILhjlEkkKmh+Mu83BUBkg8=
X-Google-Smtp-Source: AAOMgpfWr4feNRxWJlwq7TTFDxHnGNf6fY5j4T0Dv4RMEy/h84Lso2MKK9FBwMwWrnrq+VEiplNC+A==
X-Received: by 2002:a19:5d54:: with SMTP id p20-v6mr1908342lfj.143.1532109390614;
        Fri, 20 Jul 2018 10:56:30 -0700 (PDT)
Received: from z50.localnet ([31.0.82.186])
        by smtp.gmail.com with ESMTPSA id p65-v6sm455730lja.44.2018.07.20.10.56.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 10:56:29 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Subject: Re: [RFC PATCH 1/8] mtd: rawnand: ams-delta: Use private structure
Date:   Fri, 20 Jul 2018 19:57:12 +0200
Message-ID: <1763213.HC3d3VW7aF@z50>
In-Reply-To: <20180719081728.46eb7ab5@bbrezillon>
References: <20180718235710.18242-1-jmkrzyszt@gmail.com> <20180718235710.18242-2-jmkrzyszt@gmail.com> <20180719081728.46eb7ab5@bbrezillon>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, July 19, 2018 8:17:28 AM CEST Boris Brezillon wrote:
> On Thu, 19 Jul 2018 01:57:03 +0200
> Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:
> 
> > Introduce a driver private structure and allocate it on device probe.
> > Use it for storing nand_chip structure, GPIO descriptors prevoiusly
> > stored in static variables as well as io_base pointer previously passed
> > as nand controller data or platform driver data.
> 
> That's a good thing. Thanks for doing that.
> 
> > Subsequent patches
> > may populate the structure with more members as needed.
> > 
> > While at it, fix missing mtd->dev.parent and drop useless mtd->owner.
> 
> I'd prefer to have it done in a separate patch if you don't mind.

No problem, I'll split it.

Thanks,
Janusz





