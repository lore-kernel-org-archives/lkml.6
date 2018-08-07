Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2005FC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 17:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDF0B2083C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 17:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZj+hiQ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDF0B2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390118AbeHGT3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 15:29:45 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33169 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388943AbeHGT3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 15:29:45 -0400
Received: by mail-lj1-f194.google.com with SMTP id s12-v6so14061444ljj.0;
        Tue, 07 Aug 2018 10:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bp9uvIlvguEwPciq30De7KVejHbFOs1GcXgwov1QK10=;
        b=iZj+hiQ0rpNDUVuySbl0kmgKLR36OPS7rwt7lSTcF5oftuvKpv7GL+naBxVRDaCWsR
         w92LhssyoDwUr3GbFZpP1Z30eyiKS+8hOT5ZLgpLpHDlBmby3zPq8exE6ChTXKkisWQo
         oz2X5NK17J18TEKM9aWqmvh0wfsQXZCKvrGN+83wcQd9tpTZv2ingN/wy9PcbMuPOkYA
         ru08uQBdFoY0kMh1UQ1GrJUnrlVo8nYhCEBAd5wyWL6jPQfRuAuJRC0DAHIFQIyeOtkm
         99jLfyB5Mvfa3+2I9MCWx3jtsQWhZFkkVuLedWhy4N0mj9Dv8/aeaH+HI07SHDzOAksm
         fu5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bp9uvIlvguEwPciq30De7KVejHbFOs1GcXgwov1QK10=;
        b=UCT1B28Di7PjVg7lvboBBeLWRHriGieW04HFYS/F5Xmd8JhXsioxJ+5BJ7QCdDRpmC
         HDQs8v0K1FrdBML8q+jmyFnOK4VTcfnW0+e+jEtoGAJVSI2hNQmPhuOAKziHr4hwuGh3
         GY+bttBz2T8nyuQs3AWPgeqhRs5yh21rjHXO5hVDfbPEfsJSU59JRrvlT7BTqoMNC2J3
         5x4YHLa5bIqyBSei7I68nt4Qi6m1PPpe9k5k4e6gviLsOaZGqLKWv/2Ouw5PXhX9MLF4
         V62aXOkBqd93WNlkbLFtEgkHkNk94XQrq4BL1sRf+zRkkT0x7ttDTc4LptWMH8JdO0fk
         Jv/Q==
X-Gm-Message-State: AOUpUlFGEzR2cYZfP74GkCI4UuxH9TtboaMG709CV808GwLGzwhEiGQp
        oTPb5DXKWeghXg+mxL629a4=
X-Google-Smtp-Source: AAOMgpfn5CLOCUBAKEFhD7B+dh/yx99ZznLQxwGj6tk0mdhmAyid7mDXDATKI0x3sfP+qsVPCKLbXw==
X-Received: by 2002:a2e:4e02:: with SMTP id c2-v6mr15670857ljb.108.1533662065336;
        Tue, 07 Aug 2018 10:14:25 -0700 (PDT)
Received: from z50.localnet (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id h6-v6sm379666lfb.58.2018.08.07.10.14.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 10:14:24 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 08/12] mtd: rawnand: ams-delta: Simplify pointer resolution on read/write
Date:   Tue, 07 Aug 2018 19:15:24 +0200
Message-ID: <1630565.P2WKYxFjuh@z50>
In-Reply-To: <20180807190256.092b2364@bbrezillon>
References: <20180718235710.18242-1-jmkrzyszt@gmail.com> <20180806222918.12644-9-jmkrzyszt@gmail.com> <20180807190256.092b2364@bbrezillon>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, August 7, 2018 7:02:56 PM CEST Boris Brezillon wrote:
> On Tue,  7 Aug 2018 00:29:14 +0200
> Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:
> 
> > Simplify data read/write sub-functions by changing their APIs so they
> > accept driver private structure pointer instead of mtd_info.
> > 
> > Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> 
> Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
> 
> Can you move that one earlier in the series so that it can be applied
> even if we're still discussing the GPIO bitmap changes?

Sure, I will, and I would be still more happy if you agreed on me doing the 
same with [RFC PATCH v2 07/12] mtd: rawnand: ams-delta: Set port direction 
once per transfer.

Thanks,
Janusz


