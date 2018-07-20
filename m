Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E5BECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 18:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D77320647
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 18:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mrzc/oxf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D77320647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388314AbeGTTDl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 15:03:41 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41543 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388065AbeGTTDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 15:03:40 -0400
Received: by mail-lf1-f68.google.com with SMTP id v22-v6so2387213lfe.8;
        Fri, 20 Jul 2018 11:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c1ddH9FrDCfBrbcDe40qYS/oJ+v2+JO9NyIPEdd9YbM=;
        b=mrzc/oxfppRNTVf9NGdO3pUNyex+EHcx3NWP8qs7jFqya09WeTCaOxs1BMeg6zfQM8
         aLGPwIgJD6vgO1USVAqAz1INa2DwaZ/fF74Ee3C8nfmmQ7Yy2Tb545Cli5FhK1O6c8C9
         7HcbtqoQVfGJ/5qxQ/lSPL//d8h0uRzeHaepM3WNfEwZ1gtTvAJDx1ZNaWe0WuVnrhFk
         BNqyW1lQsncctayVNTmJYkXb6n3NnGyTOHWsMxtOsIs6bQfoVCrV4r1EjKlM27kKP/06
         rTWVyAAnUmACkXNrLAHkQRI0GBQmv84VTsRILwC/LsyLpfbMkNWt3bR15J+dFTSnV3qU
         wG7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c1ddH9FrDCfBrbcDe40qYS/oJ+v2+JO9NyIPEdd9YbM=;
        b=bs5RQ726S2IskGx1/bL/Z7RdBaac6gEJP/WtVDIHM0R918OKOPBHDWPR3wb6ZkpP57
         rdB4At2ZWG76o+jytngf8QXtO4nnrxIJL8j6W22Titu/bRIfVLm4wHCnvMGiT5WCYVQs
         XDIKJQCUNxAztWjnsA/BhhxfnU4tJHIO8Qc4spBoF0JYnbqM7gPKXFVJeZBIDrYNQh5S
         OS6kC+uXwWeS6widV9W5UbxyXbkYusEvgAawak285cEXfOMQfBh9Q3lapaEN2K5/PAC1
         VS2u9Brg5tIN4Zjltt3Sf5KJXuHE32SC6SklY7a17OYfokgJTdH0f39tQQ0KDjTFMR0F
         BJjQ==
X-Gm-Message-State: AOUpUlH5WDwb6OQ5IoymM8B+FRXa4Q7O/twzY21XvaGU84nmp7Q84EtF
        J//pOpMWtAm9otqxCaSBxXQ=
X-Google-Smtp-Source: AAOMgpfTECvgAl+mOpkdD7pBn3G+TBgZCl+L3/hwN12Rco9Rp2+DOx2Q1tLYEOqP8uvXoIG1CwdiNA==
X-Received: by 2002:a19:d44a:: with SMTP id l71-v6mr1964292lfg.28.1532110453372;
        Fri, 20 Jul 2018 11:14:13 -0700 (PDT)
Received: from z50.localnet ([31.0.82.186])
        by smtp.gmail.com with ESMTPSA id l141-v6sm384165lfg.55.2018.07.20.11.14.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 11:14:12 -0700 (PDT)
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
Subject: Re: [RFC PATCH 4/8] mtd: rawnand: ams-delta: Optimize pointer resolution on read/write
Date:   Fri, 20 Jul 2018 20:14:55 +0200
Message-ID: <9888773.rgnYII6m0f@z50>
In-Reply-To: <20180719082538.222396bf@bbrezillon>
References: <20180718235710.18242-1-jmkrzyszt@gmail.com> <20180718235710.18242-5-jmkrzyszt@gmail.com> <20180719082538.222396bf@bbrezillon>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, July 19, 2018 8:25:38 AM CEST Boris Brezillon wrote:
> On Thu, 19 Jul 2018 01:57:06 +0200
> Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:
> 
> > Further optimize processing speed of read/write callback functions by
> > resolving private structure pointer only once per callback and passing
> > it to all subfunctions instead of mtd_info.

OK, I'll call it simplification (the code looks more simple after that, doesn't 
it), not optimization if you agree.

Thanks,
Janusz



