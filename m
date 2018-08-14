Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB896C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 02:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E78321742
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 02:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="cjDnQ1Dd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E78321742
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730281AbeHNFdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 01:33:53 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:52857 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbeHNFdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 01:33:53 -0400
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id w7E2mZ2Q026065;
        Tue, 14 Aug 2018 11:48:35 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w7E2mZ2Q026065
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1534214916;
        bh=80BXYUCBFhBrLSlsbPRN8fNtCMikB8/nS8wQA7HwDOs=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=cjDnQ1DdbYBK+zr2t2VWCdmX7KYHL0ewbIgANJZN1JZBGDYJMJiJgnkoQ1JMDyNBV
         J+VFRxxlHwF0wYk9nfnCO93YlkeFeKWQH3l8UQzgh+ekXupMUcAULQXQ6VrNQkg9Js
         qMEiGEMikaLxOBsJgmnwNZ85GhkgqCBe31TQSjnHLn5jFlUjW/vpSpVHdrgo3/TtXZ
         wgi3Ag46IV/PJLXL0kjzeeMlYbu8OCZR+AZzVLLlWscZ0v+hTkWmzK+LNixi7wrIEx
         MsUW5yhJM3mlOnnq3Bi9nd/4S6S8zbRPVoGauj6KO9vEIy9UQX+G1CICr9Zxm5ZjTK
         GnwGEWLjOoX5A==
X-Nifty-SrcIP: [209.85.222.46]
Received: by mail-ua1-f46.google.com with SMTP id u11-v6so11549053uan.13;
        Mon, 13 Aug 2018 19:48:35 -0700 (PDT)
X-Gm-Message-State: AOUpUlHz01TRF2KmSx6/E4o8zirQNE8c6+bs7Z1yNgwV76P7yXIEJqSd
        LMdB0HIojvcNdIfTsyYoKbJi3jOVN+RD/iyA6UQ=
X-Google-Smtp-Source: AA+uWPxaIWpnBdtK4i7RYVTAhajf2dvYZKbzWv+TvD2Al/pSQyWT5NEwiKZBiXkewS7QmqJGNZKvOZIfNyMZgWsg6gw=
X-Received: by 2002:ab0:290:: with SMTP id 16-v6mr12798860uah.144.1534214914706;
 Mon, 13 Aug 2018 19:48:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2642:0:0:0:0:0 with HTTP; Mon, 13 Aug 2018 19:47:54
 -0700 (PDT)
In-Reply-To: <20180814073337.15250fe1@canb.auug.org.au>
References: <20180814073337.15250fe1@canb.auug.org.au>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 14 Aug 2018 11:47:54 +0900
X-Gmail-Original-Message-ID: <CAK7LNATUMsS0aQMABWe5PRLx_ma7eJRc-XO_8kSf-_u2eeZEJQ@mail.gmail.com>
Message-ID: <CAK7LNATUMsS0aQMABWe5PRLx_ma7eJRc-XO_8kSf-_u2eeZEJQ@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the kbuild tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen,

2018-08-14 6:33 GMT+09:00 Stephen Rothwell <sfr@canb.auug.org.au>:
> Hi Masahiro,
>
> Commit
>
>   bd714f5f14e0 ("Coccinelle: doubletest: reduce side effect false positives")
>
> is missing a Signed-off-by from its committer.

Thanks for catching this.
I will fix it.




> --
> Cheers,
> Stephen Rothwell



-- 
Best Regards
Masahiro Yamada
