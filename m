Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD442C00449
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 00:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A289213A2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 00:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="c3c36moi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A289213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbeJDHlr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 03:41:47 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:25490 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbeJDHlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 03:41:47 -0400
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id w940ovl4022849;
        Thu, 4 Oct 2018 09:50:58 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w940ovl4022849
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1538614258;
        bh=zlb+QSq0CUIoNb8vpmgS5iun/54NmXm4/6/ogW9Id9I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=c3c36moio/sT5xvW1e7Ldu9W2swiI/QKo6MFVWCUrMGfYBWIZ/VY3ayxJCGQVvhh2
         LW9whnG5UbXvoE6MLriyUYwy961B/U3goozIN3PV7wOKGU7ABtLdYLG32kCrjhwbeK
         yHAX6z1EXY9EOTHiWFlEF1TP19E7R450t67yxW+56NwPQR01EBoMEdeHRZP4WblHe9
         51CUG21d2vq9Xamb4O9j4pd5f1bsF1Ubg5/FiLdnAIrSIloyLv0pbDqQ2BQSOYQeXU
         yq8ZPuj8PoqJBX2UVCO2xS1gDQptEcJbrGGT3QMVSknwvLLMJfowaVJXND3CtOGIBN
         Wg/XPs0OBZroA==
X-Nifty-SrcIP: [209.85.217.45]
Received: by mail-vs1-f45.google.com with SMTP id e206so4410668vsd.0;
        Wed, 03 Oct 2018 17:50:57 -0700 (PDT)
X-Gm-Message-State: ABuFfoh8DWIIiRinMOKyIIZ7WPwKRogc8yz9cM0ZS3VuRrR6yeJKyFVy
        fND72EP/grGyr/OAVWjcaYDEkjLVNQoU9mpjW+w=
X-Google-Smtp-Source: ACcGV60cNYNl9M5vx40HTG10z/qeVRtuFmRFsGvr+CXD/OQKFatccW6dQEc3uGRR9RajxC86SweJAaZBFI5urpd1zS4=
X-Received: by 2002:a67:f1d2:: with SMTP id v18mr1573373vsm.181.1538614256842;
 Wed, 03 Oct 2018 17:50:56 -0700 (PDT)
MIME-Version: 1.0
References: <1538521191-16333-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1538521191-16333-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 4 Oct 2018 09:50:21 +0900
X-Gmail-Original-Message-ID: <CAK7LNASM5qjYOBm_ho4ZMtzNjtFGgTiNXrZpvH9k3nJmOF7vSg@mail.gmail.com>
Message-ID: <CAK7LNASM5qjYOBm_ho4ZMtzNjtFGgTiNXrZpvH9k3nJmOF7vSg@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: dts: uniphier: add SD/eMMC controller nodes
To:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Cc:     DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 3, 2018 at 8:01 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Add SD controller nodes for LD4, Pro4, sLD8, Pro5, and PXs2.
> This is also used as an eMMC controller for LD4, Pro4, and sLD8.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Series, applied.


-- 
Best Regards
Masahiro Yamada
