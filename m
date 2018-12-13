Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D82C6C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 06:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C89E2080F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 06:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="KMqP9efC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C89E2080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbeLMGvk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 01:51:40 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35843 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727051AbeLMGvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 01:51:36 -0500
Received: by mail-lf1-f66.google.com with SMTP id a16so709240lfg.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 22:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JdgcwaD2BuNk7SPz5Qho5H0RctNB2IAwYYQYfuyLYf4=;
        b=KMqP9efCNfIIZz6WnaMVik0lnS8XmdqtZFA6uHyfye/HwrH+27cTawXz2U9gGTbzag
         D1fVHRtmxbu+qCpLXTKDgscQnyWrQO8j4rQcTg2iV6tiMyltC4ozyeyeGNkgInITFqhv
         SYOGy26SS6apyixX8OC3Bsvtlo98TBdKcRiELPLicI0doMvyiqTpZWoMbSzYXfN6aPYf
         oD/ZasYzv8TbUKmdW5tDUbwrLFylzk0hRtTofinGQmZdUE2fo8tl99xov9Au+70//O5u
         fAnMLF4pLKtL/Oz0XgRAJwtJ0fN/ju1Pl24c2G/uQGodPGaO1A9N6KngjHp7S1FjlJ1n
         LSsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JdgcwaD2BuNk7SPz5Qho5H0RctNB2IAwYYQYfuyLYf4=;
        b=MRXezdWmSHJyzSEXFQy7onF6cMzcVOP/Aoi8V8t7hROUHOOVrb8ICmEtW35xgmj3fa
         58XsXh6EvmE1RAVRgQzHh7Ab7bFqvfTPMR+UCc/uatL3pyfPB6CQ7aamsDL4yAZD+iO7
         2NfjAVwcMYRX37Sp2Pk4oUtLen9nlYgP7g3Mk/hdzb9h4Rls9RdjFn44T5eaRppNkioy
         cYfSkH2NaJ83S2D6KkUoSel8x6G2DTxZeKnnjH/gHypjUo586aRFHkUhDpR8jZd01AcK
         GEKsraj3ithKXF31KGn5iX9cLTN5eY27zyJk3jgY/lxw5xqTGAb0Bg1w+cFcKdVbuXmk
         pi1w==
X-Gm-Message-State: AA+aEWYFkUr6cav9SGyMlaezqP7S04Z57BULEQQBQC1LvUerVoMtlTft
        mmbuyEGN94FGNIcBbWRJtNaHZhUaXotyhQ==
X-Google-Smtp-Source: AFSGD/WUo8ssXkqSckXrLXameooM4KZASyiq2mEX1a75tFA+P9k/7c9zWJEjZvvH9SPMcrbt/J5WqQ==
X-Received: by 2002:a19:4345:: with SMTP id m5mr13228859lfj.142.1544683894283;
        Wed, 12 Dec 2018 22:51:34 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id r27-v6sm152528lja.65.2018.12.12.22.51.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 22:51:33 -0800 (PST)
Date:   Wed, 12 Dec 2018 18:14:42 -0800
From:   Olof Johansson <olof@lixom.net>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     arm-soc <arm@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/9] arm64: defconfig: Drop USB_ULPI_BUS and
 USB_CHIPIDEA_ULPI
Message-ID: <20181213021442.i7eabju22cviqnae@localhost>
References: <49a5d199-4eeb-a7c2-b539-13356162547f@free.fr>
 <a5a9193c-018a-8d52-7b62-2743db048a69@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5a9193c-018a-8d52-7b62-2743db048a69@free.fr>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 02:02:18AM +0100, Marc Gonzalez wrote:
> Commit a930d8bd94d8 ("usb: chipidea: Always build ULPI code") made
> USB_CHIPIDEA select USB_ULPI_BUS, and removed USB_CHIPIDEA_ULPI.
> 
> Reviewed-by: Fabio Estevam <festevam@gmail.com>
> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>

This one is the same as some of the others; it had already dropped off with the
refresh.


-Olof
