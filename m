Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E204AC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 17:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 916D72084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 17:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="wSjtM1a/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 916D72084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbeJ3BuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 21:50:14 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43660 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbeJ3BuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 21:50:14 -0400
Received: by mail-pl1-f195.google.com with SMTP id g59-v6so87828plb.10
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 10:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=1BG0m1yyZY14ijSGX18fG8UKYKGbe7Jp3Y7PPK3H2Qo=;
        b=wSjtM1a/h/uwPYVoWUAeYPAI45i36SZpJIJr/pY6W8367d03tQfapks1/IWYVQqDUj
         R9ovy0PN5q1ZJHfGlcF01jVite98+azp+fkMoirnOBFg+B9UHmJq5Q6Bqa/RMhpNHGVP
         ZQWOKRwtj9VPKRZPlgk3yduLAw3RrGkRDIUEK5LYwFgvIDZ54rJYEacuv/Ml+ChJzRL8
         5bXMxD/RVmvGQG4mba6//lrSeefPCZHRkOwi6Qv6jkoH0BdE12nIOEDWzraCV/PUPwwI
         2E8Qv+PmVOkF3R1JiP7sSSDTgwrTB8FnbR9o9QafwashVCVapa8wpa0MsbtIwXMxCpBR
         CgCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=1BG0m1yyZY14ijSGX18fG8UKYKGbe7Jp3Y7PPK3H2Qo=;
        b=Eysbbvp7951bTCYTMmTcgbrjNfRo5N66JcyQUZXh6O7hGBSd0SkyxlIA0m/O2NgYvq
         uW3NZgC/XcdgcWLcBJgPMTab053dtmDcthFTcnqr8i7UxPNbgxq+D7Aa0AUEOR0Ffu0L
         FBIRi3bYhvNPep11BOKr+pXo83l1bWFmsK6XOx7nfUbNj9zw2OOB937V8i/Uh6F6zx6c
         50pxzgBF6QFYh3z3iV0P0VfdNZrO52l/OpQqJijbXcqfjf2/wVkzXr95OxAgBZTlJeyt
         zNo+XRHYKQtuQ8I3tpEwYSY+xX7Afigobo9bpWDg35XiQsE1YYC/u+v4XQPsDt8xu2qP
         OYVA==
X-Gm-Message-State: AGRZ1gICGMQ3PqZS+j7ZvhF5z/tke1scMbVY/TT7ZljOSq/ZrJXkgkSC
        N55iPgsvncegnvRZ0+VsVmzEmA==
X-Google-Smtp-Source: AJdET5d8I0piEfp6qZQKhnU5ygZy92f1IzqZzjTpbGxWYHmKZ5rm4aGn8DAkdPgOHeWiU/B7FZDTlQ==
X-Received: by 2002:a17:902:343:: with SMTP id 61-v6mr3070884pld.327.1540832446984;
        Mon, 29 Oct 2018 10:00:46 -0700 (PDT)
Received: from localhost ([2605:e000:151d:2254:9f5:cd47:ec70:ef3a])
        by smtp.gmail.com with ESMTPSA id n2-v6sm9480759pgg.86.2018.10.29.10.00.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 10:00:45 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>
From:   Michael Turquette <mturquette@baylibre.com>
In-Reply-To: <CACRpkdbzQ1chqGPWj2wSrsOBc75ZKPfFGu0hqvMeo+x=s9S1BA@mail.gmail.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        =?utf-8?q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
References: <20181024153843.16021-1-brgl@bgdev.pl>
 <CACRpkdbzQ1chqGPWj2wSrsOBc75ZKPfFGu0hqvMeo+x=s9S1BA@mail.gmail.com>
Message-ID: <20181029170038.1422.70278@harbor.lan>
User-Agent: alot/0.7
Subject: Re: [PATCH] MAINTAINERS: add myself as co-maintainer of gpiolib
Date:   Mon, 29 Oct 2018 10:00:41 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Linus Walleij (2018-10-25 04:15:52)
> On Wed, Oct 24, 2018 at 5:39 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> =

> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > As discussed with Linus Walleij - I'm adding myself as
> > the co-maintainer.
> >
> > Cc: Beno=C3=AEt Cousson <bcousson@baylibre.com>
> > Cc: Kevin Hilman <khilman@baylibre.com>
> > Cc: Michael Turquette <mturquette@baylibre.com>
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> =

> Excellent, patch applied for fixes. Welcome aboard! :D

Completely unnecessary:

Acked-by: Michael Turquette <mturquette@baylibre.com>

;-)

Best regards,
Mike

> =

> Yours,
> Linus Walleij
