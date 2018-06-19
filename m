Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF34C5AE5A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 20:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AAB420661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 20:07:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tMCcDuFG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AAB420661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030665AbeFSUHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 16:07:20 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:37234 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030259AbeFSUHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 16:07:19 -0400
Received: by mail-ua0-f196.google.com with SMTP id l14-v6so645503uao.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 13:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RQ3qEp9q1EtUZ9u/wTrFMDpZ2Tb+5Mr2TSNokFwUYDU=;
        b=tMCcDuFGK/K52rFpePzv8+7i0HrXuQ17oOakGObMcCwENgkpH12D6NXadsTAcrqLSr
         CGdeLAYGyB5PuZIVCPV6YXXKbmqfvd67zZbEiT+7yU7Ne/waQIStpUoBzS0tQ91EqNYe
         Pne2ihsOVyEE/i67ZfE7PV180L/EyL5/StCu96Myrf+L9yBPgdod9jzTGrb1Zhs+cW+T
         xGmSS1zrVhhhUnavvJnwENdx2VJV7iv2dyLrKf4JgPzg+oX8oA6C/gt825krEVdKz+c2
         g+QkiXiQSc4i0Y2bwXuSKKFoSOY2sm7MXn7Bg0Li5JywGCvbdi4uxHJ11w3jD//6PWbT
         Az+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RQ3qEp9q1EtUZ9u/wTrFMDpZ2Tb+5Mr2TSNokFwUYDU=;
        b=FNz2AnhJzUU5uU1Wifepcn5bNshvrJ/yxM9zzQzjPHLE+oNVdATzOAAC7Y/a8hKfPd
         ChxLZsol8Rjkac/FUBjy01ThtH7gR22L2l3j5/NgbEZeAJSVBy91LRAY9V6+zRwREHko
         4nHUd+FO3PR2p2wHUsnQkcpPQryvjm3VEmWwxxehjdUSoJBn8++r0q81W8E7p8RrgXif
         pQpu1DtnkllynvUWr58WCABZRMvOWQwZjqBZg96CgLytnyX0xhmAxTessY8yhoNcwqI5
         TFvUIXH7JPjOZO2ZmUonXdRXQRDPP6EWB4t+pFivat4Xn4heVIz7Y1ElBYkiRWIn+/Uh
         ccLw==
X-Gm-Message-State: APt69E1IePWnuPIn+TcUYhuRjBT5IwfFy6wZrNP2s7yYyD/tAnnm+Cl3
        Eao/lzW5HNzORUhvZbTc6yWSJO5zXjOasOFGAKBCVqnN
X-Google-Smtp-Source: ADUXVKKZk/XGtNny/g6FtFTiVHdqFvzKG3Rv7c9DsJKEyg5uTaIyfix+XncObo5zuh1zBZYW78MNLpbeE5mjdNRK2q8=
X-Received: by 2002:ab0:1b9b:: with SMTP id k27-v6mr11519182uai.122.1529438838834;
 Tue, 19 Jun 2018 13:07:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Tue, 19 Jun 2018 13:07:18
 -0700 (PDT)
In-Reply-To: <20180619195605.31321-3-johnfwhitmore@gmail.com>
References: <20180619195605.31321-1-johnfwhitmore@gmail.com> <20180619195605.31321-3-johnfwhitmore@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 19 Jun 2018 23:07:18 +0300
Message-ID: <CAHp75VchsRzaADMkRam8HXb3x860mP=L3W=ELf0F1FP-notMiQ@mail.gmail.com>
Subject: Re: [PATCH 2/9] staging: rtl8192u: Correct indentation of switch
 statement - Coding Style
To:     John Whitmore <johnfwhitmore@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 10:55 PM, John Whitmore <johnfwhitmore@gmail.com> wrote:
> Removed an extra indentation from the code of the various case options in a
> switch statement.

> +               //no MCS rate
> +               for (i = 0; i <= 15; i++)
> +                       pOperateMCS[i] = 0;

This would be just memset().

> +               break;



-- 
With Best Regards,
Andy Shevchenko
