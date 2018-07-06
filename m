Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3097C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 00:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F3D92400E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 00:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="ewIRsj8M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F3D92400E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753782AbeGFA4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 20:56:23 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:18583 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753442AbeGFA4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 20:56:22 -0400
Received: from mail-ua0-f178.google.com (mail-ua0-f178.google.com [209.85.217.178]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id w660uIQI010384;
        Fri, 6 Jul 2018 09:56:18 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w660uIQI010384
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1530838578;
        bh=p7G3TpILgBRM8eGdUZ5Fg+glpODWIiOIVyd19lsnm1M=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=ewIRsj8MEFwOCYMzjFyEG4rpGK5zQFxTOTfrLk5wkCPlr8bJje/7vBXnzN0W80PRb
         RbeJwdOynx/bxGuMBJtx6azS55r07mxKtPi3R66wbpj4WvFUoJ3AbiR5k8L0fHZJos
         QYWyHyiSk4p5+mAsdmv7grepm6vN22LN0FqH5SKcRqv3naZW8jzLcI/BQcHjppYSGL
         LATd/jo41tpIPb1hAFDf8yIEn/TEp3lEdDvJWxPX6184/it2vBS8jGfkHkUQcOgyzL
         28nLCIEvu4RdZhT7klkGSFfGS6oWmsk3cXyFQKw/Wv9E3tXBmN3dNgAlD3H3LmJ5zd
         kOVxxpSBVtRgA==
X-Nifty-SrcIP: [209.85.217.178]
Received: by mail-ua0-f178.google.com with SMTP id u8-v6so6564318uao.4;
        Thu, 05 Jul 2018 17:56:18 -0700 (PDT)
X-Gm-Message-State: APt69E1ajo5GNKXWMiWQDAaF5KsLeV3ql6eeM+TYClZwcrNk7ZB2I1cn
        k+wk7vBQYq6IozweVQ4gVhWawSNMsa8ZnCJHSC4=
X-Google-Smtp-Source: AAOMgpfs7X9r9RtkB0KzldDvND2ie5/0JYe7bcmMiVi7S7rmYLyV1I1UHRkXZsXHT4j0FgfolISauU7Leg4X/FYDwz8=
X-Received: by 2002:ab0:4946:: with SMTP id a6-v6mr4990373uad.82.1530838577578;
 Thu, 05 Jul 2018 17:56:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3308:0:0:0:0:0 with HTTP; Thu, 5 Jul 2018 17:55:37 -0700 (PDT)
In-Reply-To: <70d08f42-27e4-ccc2-00f6-266568123d8c@infradead.org>
References: <70d08f42-27e4-ccc2-00f6-266568123d8c@infradead.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 6 Jul 2018 09:55:37 +0900
X-Gmail-Original-Message-ID: <CAK7LNASzU_a37BEnSxyF_tTUjhkfurYxOS-giX7UA9fn0Ghu6w@mail.gmail.com>
Message-ID: <CAK7LNASzU_a37BEnSxyF_tTUjhkfurYxOS-giX7UA9fn0Ghu6w@mail.gmail.com>
Subject: Re: [PATCH] kbuild: document the KBUILD_KCONFIG env. variable
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kbuild <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-05 11:47 GMT+09:00 Randy Dunlap <rdunlap@infradead.org>:
> From: Randy Dunlap <rdunlap@infradead.org>
>
> Add usage info for the Kbuild environment variable KBUILD_KCONFIG.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>


Applied to linux-kbuild.  Thanks!



-- 
Best Regards
Masahiro Yamada
