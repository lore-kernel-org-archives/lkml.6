Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6478C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 00:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E27A23F70
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 00:39:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="ECDsT7rs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E27A23F70
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753525AbeGFAjz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 20:39:55 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:21503 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753439AbeGFAjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 20:39:54 -0400
Received: from mail-ua0-f171.google.com (mail-ua0-f171.google.com [209.85.217.171]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id w660dXZZ021810;
        Fri, 6 Jul 2018 09:39:34 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w660dXZZ021810
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1530837574;
        bh=3bNOM2Ho1Fk0O9sx5ZT+VWd34qvD2agtd/qqwjOnUHw=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=ECDsT7rsXHnO5a6Z5OzYDCZ7oBPvRqP2/Ss8a1DCVFE5clOwjClvfHrF0otiqPriY
         09qkecr08pa4T1cOz7Rx9tWl7BkZcltsSJbbLPupBCk1pbIWUUOULBEh0rIJgLZFqw
         bxkx2AoADak9c0yHzssTXVBIF8AfCPT18I40qIO0Bq/HixRpg8FX4a2FSjhk0KynXj
         I5d7m3kJzYbtENHKSqGVEDTxYwPX+EfuVWeW5AhnwSO4pD80FwwkKIlTNL3yWkMqGO
         hCfmFtJ8I9zVfuuqbZnFBsCiuag2S/ypHqunaz7D54k5xqclDWKz+GlnQKTZjcUCko
         4pNKdhrysZzaA==
X-Nifty-SrcIP: [209.85.217.171]
Received: by mail-ua0-f171.google.com with SMTP id g18-v6so6543770uak.0;
        Thu, 05 Jul 2018 17:39:33 -0700 (PDT)
X-Gm-Message-State: APt69E0AlzfiHOTmOPsA8u6ZkQ4kbeNCkj32FvzT3F1lmtpVCoUEYs5y
        XBCe04jXz3dr2NmW+B8wSxhR/shY22Mn4tEeXos=
X-Google-Smtp-Source: AAOMgpe/91Q5rwxpjpp/yto90UaLtjP+9pb0Ljc4hpIYJkGbLU4pEUIS4OQ8RB/eY6qMx4qN+ETMvMEbZeNQ5bceHR8=
X-Received: by 2002:ab0:13c8:: with SMTP id n8-v6mr4993224uae.140.1530837572808;
 Thu, 05 Jul 2018 17:39:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3308:0:0:0:0:0 with HTTP; Thu, 5 Jul 2018 17:38:52 -0700 (PDT)
In-Reply-To: <53a0c9d4-cf1c-fbcf-3706-742f5ad41178@infradead.org>
References: <53a0c9d4-cf1c-fbcf-3706-742f5ad41178@infradead.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 6 Jul 2018 09:38:52 +0900
X-Gmail-Original-Message-ID: <CAK7LNASPOrhUCTwCXTbrVbjwh+AHoPkHcmJ5mzC24wU8hwsM2w@mail.gmail.com>
Message-ID: <CAK7LNASPOrhUCTwCXTbrVbjwh+AHoPkHcmJ5mzC24wU8hwsM2w@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: verify that $DEPMOD is installed
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kbuild <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lucas De Marchi <lucas.demarchi@profusion.mobi>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Jessica Yu <jeyu@kernel.org>,
        Chih-Wei Huang <cwhuang@linux.org.tw>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-02 11:46 GMT+09:00 Randy Dunlap <rdunlap@infradead.org>:
> From: Randy Dunlap <rdunlap@infradead.org>
>
> Verify that 'depmod' ($DEPMOD) is installed.
> This is a partial revert of 620c231c7a7f (from 2012):
>   ("kbuild: do not check for ancient modutils tools")
>
> Also update Documentation/process/changes.rst to refer to
> kmod instead of module-init-tools.
>
> Fixes kernel bugzilla #198965:
> https://bugzilla.kernel.org/show_bug.cgi?id=198965
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
> Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
> Cc: Michal Marek <michal.lkml@markovi.net>
> Cc: Jessica Yu <jeyu@kernel.org>
> Cc: Chih-Wei Huang <cwhuang@linux.org.tw>
> Cc: stable@vger.kernel.org # any kernel since 2012

Applied to linux-kbuild. Thanks!




-- 
Best Regards
Masahiro Yamada
