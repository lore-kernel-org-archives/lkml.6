Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F51BECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 17:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1975D20661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 17:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r6bOIV/Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1975D20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388277AbeGTSoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 14:44:24 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42424 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388131AbeGTSoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 14:44:24 -0400
Received: by mail-lj1-f196.google.com with SMTP id f1-v6so10155930ljc.9;
        Fri, 20 Jul 2018 10:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OhnPoVfzDLkfUO+KQ56PnXFtuslLKy1xij0YG9E5eAA=;
        b=r6bOIV/ZuacXRoh52AUn3XF+de5ehfDAT3nT4j8D58t/FujD679QmsAGj4ZbzUKo3L
         nLfx+QelR99K2jKfL8sbUvZe2K1Nddcf5f02AzLw1AFcaFwg2PQxyAY3cA27ZSyRSgSn
         rJarojbD/ZlDatW3qeAx7UmkGd/P2OLKySLAewJ6LoAZs0JY4S2v+QU3x0eagAsGEfwA
         wJsrKgSXFla+sS2yikq6oPTUZ0LyjQww8F28dOqJjL+FFNgFhNYUkroJOu4+VPy3n3Pl
         hHKyDkhALcyDmozht/HpId618TJx8NSz0YdPnbYOjf6QZMixITUXYXmDI+lpC9MZ/U9o
         Ychw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OhnPoVfzDLkfUO+KQ56PnXFtuslLKy1xij0YG9E5eAA=;
        b=Ej6KKt+wFWbMwi4umSZZyJQB89wOToBXqGa0Z5JKHyoIWSz/clE1W91LBLS3t0CJa2
         Viv5JfW5uvLS18NncCH3bQdYqFY3qpXkWPBg6qTYGka2tHdH9eH8DWvPxEXVVG01ovsH
         w7uI1+D6FiPIRkA+OmSLBs1ujyK9/XrAAVHjI0oi5T5fTkRBVtA4lMxK61/wiJliW8+Z
         z1I5LWOQvhq7gd53e+33qcu/axEbAxk0rWARyngJkTBijdXrFVmK0qxVoS9nMBFoW04R
         RgIpl2BjQU4SeQl6sUZgA3uwuzYsHp46ZlSVo94CQCnm6b+i1gbM/I8w2qOiKSA0NOgS
         y9xQ==
X-Gm-Message-State: AOUpUlGkCl43kqEwGwkVnXMW6za70Zt+zmr3lVW0pNG7hDQ0Y+/yIy5x
        qQYWWViRsC+SG/YiLeNhRto=
X-Google-Smtp-Source: AAOMgpdBQypamzkjzkJWZAwmeY18cZjmCd7EYjwv7s4AsDLvY7IKB6ubQUzrl33m1PaTL08LGRYwAA==
X-Received: by 2002:a2e:8950:: with SMTP id b16-v6mr2472372ljk.111.1532109301292;
        Fri, 20 Jul 2018 10:55:01 -0700 (PDT)
Received: from z50.localnet ([31.0.82.186])
        by smtp.gmail.com with ESMTPSA id m66-v6sm383354lfi.17.2018.07.20.10.54.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 10:55:00 -0700 (PDT)
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
Subject: Re: [RFC PATCH 0/8] mtd: rawnand: ams-delta: Use gpio-omap accessors for data I/O
Date:   Fri, 20 Jul 2018 19:55:42 +0200
Message-ID: <6335220.Jscgez8sxx@z50>
In-Reply-To: <20180719081508.5dafebde@bbrezillon>
References: <20180718235710.18242-1-jmkrzyszt@gmail.com> <20180719081508.5dafebde@bbrezillon>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On Thursday, July 19, 2018 8:15:08 AM CEST Boris Brezillon wrote:
> Hi Janusz,
> 
> On Thu, 19 Jul 2018 01:57:02 +0200
> Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:
> 
> > Implement the idea suggested by Artem Bityutskiy and Tony Lindgren
> > described in commit b027274d2e3a ("mtd: ams-delta: fix
> > request_mem_region() failure").
> 
> Thanks for doing that. I'll review the patches, but I already have a
> extra request: can you convert this driver to ->exec_op()? It does not
> necessarily have to be done in this patchset, but, that'd be great to
> have one more driver converted to the new interface.

OK, I'll have a look as my free time permits.

> BTW, there seems to be a nand_gpio driver, maybe we should merge
> ams-delta code into nand_gpio after it's been patched to use the GPIO
> consumer API.

nand_gpio uses a form of read()/write() on a single bidirectional register for 
data transfer, not GPIO, and it does not make use of NRE / NWE signals.  Maybe 
the two drivers could be merged to some extent but not entirely, I think.

Thanks,
Janusz


