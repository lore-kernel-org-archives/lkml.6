Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2290EC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 23:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8E3620825
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 23:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U1XNbmcI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8E3620825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbeKFIhF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 03:37:05 -0500
Received: from mail-yb1-f172.google.com ([209.85.219.172]:36137 "EHLO
        mail-yb1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725733AbeKFIhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 03:37:05 -0500
Received: by mail-yb1-f172.google.com with SMTP id g192-v6so4499733ybf.3;
        Mon, 05 Nov 2018 15:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SphPvtPRYyE4uKANELJMXD5WBG3ryHpnI653UX84IoE=;
        b=U1XNbmcILn4FmhlJOodgKJMvFQY56XO0oFfbYmeCOx9yl/SLchSy+Cmnq9Dpkm/SDW
         ZOkBgbMSVZ2Wo10g32inX+62FnsrUt5A++3pFPgC+VLZyIAB1XDScPHrJ2JZCTh60UVM
         DkI7/G9a4qe2T19ajpUL/cQ/9govIL9HuJZXG7u+K67CUC8Az5Y1AtUR7C0nE1JHHTl8
         CJYj59EMWU1JAhZI6MlF2miMZ6diuWYnuGpr9kici9smxonJrvAP9wNImp074VEavHvj
         uStxzeDmtdKNwVbD4ub6e9dmnA9Q63F3KscRuiCc7GXbMqJ5zWhfvo8QqhIR+dr8Hwpn
         NBZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SphPvtPRYyE4uKANELJMXD5WBG3ryHpnI653UX84IoE=;
        b=ZPetWqbT6fT9tY3Uy5U4DDScH7kFMkTHuamiNHMUU6RTHDKSNpTb5qicu8Q/Ox3rJW
         ZS2Z4yqKw+0nwj4v9LPA7piTeO1v1WOrez6pIZWun7gT2hmIln+I2R9UYIkq1RLsWIjk
         SkbJ9Q0RJiSE+anrtbO1czcfWrypGP5IDu5f0T1lie+w3xYCntS5RJplITcCqI8WUJto
         g2jvR+3bCWNWQcYxg/YTbuJAFQ2nqCGhplyqv+8oyi212IsFLlTayX96Xi0bRI14hTOb
         8fGawUuciUVUauSWA06ouZOS9MBmPbTDPUXsZmsslG1ndqVxuMPcsDeA4/IoBegGwOhK
         IDbg==
X-Gm-Message-State: AGRZ1gKYcnt0psOyPn5Pjkm2Ba65HCYrUUVK7efY7DSCO7fusQDFZxWK
        WNC5UBULY/gz7I0UD3HPliQK9Iq6p+mGRGkcBUIDFIt3
X-Google-Smtp-Source: AJdET5fEpnuk2r9FKyAGJFDSHjV7fOcMcG72GpGxPxzGrvwnJ6/lu1Vh+VlEHEKcmMqUzpirM53tMeFU94vN6aQ+kwU=
X-Received: by 2002:a25:6c08:: with SMTP id h8-v6mr21030350ybc.452.1541459697816;
 Mon, 05 Nov 2018 15:14:57 -0800 (PST)
MIME-Version: 1.0
References: <20181106100856.0c9bdf3a@canb.auug.org.au>
In-Reply-To: <20181106100856.0c9bdf3a@canb.auug.org.au>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Mon, 5 Nov 2018 15:14:44 -0800
Message-ID: <CAMo8BfLfkk864aRwy0jG9Tq5CizyDax85Sq6+5=3N0wrA_Cg5w@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the xtensa tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux-Next <linux-next@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Mon, Nov 5, 2018 at 3:09 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Commit
>
>   12e90ddd8dbf ("Revert "xtensa: xtfpga: implement platform DMA address helpers"")
>
> is missing a Signed-off-by from its author and committer.
>
> Reverts are commits too.

Thanks for catching that. Should I rewrite that branch fixing up that commit?

-- 
Thanks.
-- Max
