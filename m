Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB296C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 07:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7400D214FF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 07:04:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxM8Fp8M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7400D214FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbeHUKXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 06:23:23 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:46305 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbeHUKXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 06:23:23 -0400
Received: by mail-vk0-f65.google.com with SMTP id b14-v6so7731957vke.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 00:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Fjo2eHTPSDJUaBCcaIepc9/Ac6cA65elEIqBO0D4WKk=;
        b=kxM8Fp8MuxtZo9Cq/VbUaFEEdl3Cqs7q0f49ezgZwiwDLY8u1mrnIZFwCzNSsin2XV
         1cBhBBxT0EgfTcraKScOWSQzgb4EXZ3CYt/V2IpZ0bxDIxdU7W3wXKiL+r/xE6qGk2tY
         nmdtfJCfInQgoKXHY0ADkIw4TD71sFK7lfCfthZxqlZrW+qhDsy5kXyxZbqboRI8LFQq
         kVs6Nt3hI42xzbI8rrXttncDtHgnkstZZWEW+BrGMXTuNalFkCURY5h1Lxk/jxYiOzYr
         Rt3ragKsYfauutqQsYTSCuAqb+T29wS0+M/pdWvJAW1cF4mxKRqids9wDznv+bKYK+5A
         MC4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Fjo2eHTPSDJUaBCcaIepc9/Ac6cA65elEIqBO0D4WKk=;
        b=lY3nVP2BQUIkappY0ujOOlyOdnbMYTif4+sL1LDfDTaFZpHTU+Z7FGsMOgdOshqWul
         uqXbLr0PEyBcK5zSrVG5Wk7KUG7nFulSS8eMDdfTmMDhdoSSGkT0RvLKU0j6kYtHIQA2
         CMiRPikWzzWIT68Ty5ZhBlGyWaPHqUSwVockJl/hdFYMzaOqkczcIn7fNf6yr3WJGqOU
         DSK/stXk9558iTxGChv29caAxRosAsPprJGv/oAyKB7cYhDJLVDmpNJNJOXlQNmN7nMA
         HoRbsKcF1dlK+2ukvU4rh/Nk/rv4dBGYGWHGAZfW4YHSl5++epwXQShp0PJjavPiZ2fK
         driQ==
X-Gm-Message-State: AOUpUlFYg++KwRRJAXHuLN/Sxe6rCfwoiNrAINwjps1aLBwN7I2fbzTi
        DM6tS0+AaY6ai1xVsSnzWt9SR6iUO1XD/Tpel/U=
X-Google-Smtp-Source: AA+uWPwC9L5v7vD5MxnV5RG+Kua0IWGvqIFQn3r+IXRdtWke65saPrMzgAfKYBAx0PX1XdBG6AeS6oSXfEKE3ysE4Uc=
X-Received: by 2002:a1f:cca:: with SMTP id 193-v6mr31594551vkm.98.1534835067360;
 Tue, 21 Aug 2018 00:04:27 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1534151350.git.zong@andestech.com>
In-Reply-To: <cover.1534151350.git.zong@andestech.com>
From:   Greentime Hu <green.hu@gmail.com>
Date:   Tue, 21 Aug 2018 15:03:50 +0800
Message-ID: <CAEbi=3fWTVzyQviRRy86ME6fA1G=88KFvfy3pQH_EJWQir8A3w@mail.gmail.com>
Subject: Re: [PATCH 0/3] Fix get_user and put_user pointer issue
To:     Zong Li <zong@andestech.com>
Cc:     Vincent Chen <deanbo422@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Zong Li <zongbox@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zong Li <zong@andestech.com> =E6=96=BC 2018=E5=B9=B48=E6=9C=8813=E6=97=A5 =
=E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=885:27=E5=AF=AB=E9=81=93=EF=BC=9A
>
> These patches fix the issue of expand macro with pointer argument,
> clean up the coding style and refactor the macro by extracting the
> checking and getting pointer to another macro definition.
>
>
> Zong Li (3):
>   nds32: Fix get_user/put_user macro expand pointer problem
>   nds32: Clean up the coding style
>   nds32: Extract the checking and getting pointer to a macro
>
>  arch/nds32/include/asm/uaccess.h | 229 ++++++++++++++++++++-------------=
------
>  1 file changed, 119 insertions(+), 110 deletions(-)
>
Acked-by: Greentime Hu <greentime@andestech.com>
