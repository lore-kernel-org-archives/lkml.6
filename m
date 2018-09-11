Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F359BC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 13:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CBB820833
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 13:37:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CBB820833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbeIKSga (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 14:36:30 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36308 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbeIKSga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 14:36:30 -0400
Received: by mail-qk1-f194.google.com with SMTP id 93-v6so16718767qks.3;
        Tue, 11 Sep 2018 06:37:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+AeOewCazC98VFLhXpd/rZgCcJtTL5cSnyNZ53UjQbE=;
        b=kzTNH8QObdg/N3hASv8ZEXuS+tBdK5dw54RBVKtgYfMtwWKdWQpVQpiF63+5N9L7O+
         jL41/39y1t25bBxMaI8nWlVfg9cCu7JpI/w3klw4Y9gC/0+zkEhZJJPGgJMWCZ8EYPgr
         saXjDE9BXCgQl7FFgkMbMFoztcM4z3MugVgHRmlMJX4T3GmqCHq3KHcNYglpc46O+PD2
         UNMZH0AheTCjMqMmgvmGxseaFEdX3HvZiaDxF8kVE5mkaKy5MwVe/WqHTwnGeL1wIMrX
         3R5c2VXssbIDPEQU5UqxZDUjghRszrLL6pA8O0jOVTNomWrzE7JAgQGIQ919R+0xVJ66
         HtnQ==
X-Gm-Message-State: APzg51DOydlL9qA/LK1djSL2iHUMPwDB4y1swiutu0SYA95PF83XLyUO
        Svt7gvU6O4EQpkoJMXq37YUr1SdwpkTsyWUzQIQ=
X-Google-Smtp-Source: ANB0Vdb1nQmUyKGOz6ATVGg2FenG9lGkb5MyovzambEKaIJ0Fyvl6AWqBI+isHul/u8PfgH+RiyltvU+O4heP2Ru7TA=
X-Received: by 2002:a37:1b62:: with SMTP id b95-v6mr18185943qkb.343.1536673027746;
 Tue, 11 Sep 2018 06:37:07 -0700 (PDT)
MIME-Version: 1.0
References: <1536078525-31534-1-git-send-email-sunil.kovvuri@gmail.com> <CA+sq2CdNRkbGrk4rHOQX1qHrRc2+=DXBscw7cD9UKrX4G5OaVg@mail.gmail.com>
In-Reply-To: <CA+sq2CdNRkbGrk4rHOQX1qHrRc2+=DXBscw7cD9UKrX4G5OaVg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 11 Sep 2018 15:36:51 +0200
Message-ID: <CAK8P3a32gpNX42NuzmbW1PbsHpq7v7LoQ6WDeKtt=QiYbuyM7w@mail.gmail.com>
Subject: Re: [PATCH v3 00/15] soc: octeontx2: Add RVU admin function driver
To:     Sunil Kovvuri <sunil.kovvuri@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-soc@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>, sgoutham@marvell.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 2:37 PM Sunil Kovvuri <sunil.kovvuri@gmail.com> wrote:
>
> Didn't receive any feedback for the v3 patch series over a week's time.
> Can you please pick up these patches to merge into arm-soc ?

I would still prefer to see the whole thing as part of drivers/net/
instead of drivers/soc,
and reviewed in full on the netdev side, including the parts that are
not ethernet specific.

       Arnd
