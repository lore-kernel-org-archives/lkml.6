Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BCD8ECDFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 20:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D1D320645
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 20:05:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D1D320645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbeILBGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 21:06:40 -0400
Received: from mail-qt0-f176.google.com ([209.85.216.176]:33343 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbeILBGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 21:06:37 -0400
Received: by mail-qt0-f176.google.com with SMTP id r37-v6so29675141qtc.0;
        Tue, 11 Sep 2018 13:05:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0WoQ9ANcgOmj/ztrGKD1CZe0gWwHubUb8QBOvUny5A4=;
        b=o3ILd5Y2zIjk1IXQYVNHfL9wOTMvXqmuvDybAs2+IXtQYpos2CKGtv0f6JXpUFa4Q0
         9udGtmiWzvAoPiG3z3A4zk50HLuD7A9VW7PZZMYpCEAHAfa/yvZLCiqNKYV4c+lGVek9
         0nlMYLRLjOjMdD8gsZ5upHYDUhNKprHjxwolEv0Vr13oDV4+PnI2M+gcax+0ey1yqLtY
         kyf3p2mu7rGK6Vg1ajngrQWnl/ZaylQptbE/a7Pyc4ULccoIKub3//fjHLUF2V3GPYzc
         tCfl2jwT/LhyWmZuYTxzqk0PNm2niCcPRh7AAzACCQBFMLz5cA4q8CoHh/U3vxyHhBJk
         hijg==
X-Gm-Message-State: APzg51A1xchgX30chDjw0NgL3H6pIhgn7ZssFK4P+ckCfEh0zf2rQdOz
        QKLICU7NhGHOIhj1kLyyu8VgsxNSXiy0OQjhUlw=
X-Google-Smtp-Source: ANB0VdY1jpAJFsjrQdlEkGgOjCd/UC3oF09wU1bJX1Z6GU8k7WDl0fob/uhkUlmXuPbMO6v39zWA73eOnkFq7qmU3QY=
X-Received: by 2002:a0c:a8cc:: with SMTP id h12-v6mr20316913qvc.161.1536696343970;
 Tue, 11 Sep 2018 13:05:43 -0700 (PDT)
MIME-Version: 1.0
References: <1536078525-31534-1-git-send-email-sunil.kovvuri@gmail.com>
 <CA+sq2CdNRkbGrk4rHOQX1qHrRc2+=DXBscw7cD9UKrX4G5OaVg@mail.gmail.com>
 <CAK8P3a32gpNX42NuzmbW1PbsHpq7v7LoQ6WDeKtt=QiYbuyM7w@mail.gmail.com> <CA+sq2CeOSY9VLEY6ruGceo+NkwtfDuivy9joMkx9P3JTPyZxZQ@mail.gmail.com>
In-Reply-To: <CA+sq2CeOSY9VLEY6ruGceo+NkwtfDuivy9joMkx9P3JTPyZxZQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 11 Sep 2018 22:05:27 +0200
Message-ID: <CAK8P3a2+r_ZYZkmD_MLXbHZoEpCm=5zUajFDANjjBA0tuauSqw@mail.gmail.com>
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

On Tue, Sep 11, 2018 at 6:28 PM Sunil Kovvuri <sunil.kovvuri@gmail.com> wrote:
>
> On Tue, Sep 11, 2018 at 7:07 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Tue, Sep 11, 2018 at 2:37 PM Sunil Kovvuri <sunil.kovvuri@gmail.com> wrote:
> > >
> > > Didn't receive any feedback for the v3 patch series over a week's time.
> > > Can you please pick up these patches to merge into arm-soc ?
> >
> > I would still prefer to see the whole thing as part of drivers/net/
> > instead of drivers/soc,
> > and reviewed in full on the netdev side, including the parts that are
> > not ethernet specific.
> >
> >        Arnd
>
> Hmm.. I agree that there are many networking terms used in the driver
> but it's not a
> networking driver, it's just a HW configuration driver which includes
> how HW should
> parse the packet. This driver doesn't fit into drivers/net.

Who says it doesn't fit?

> Let's say if netdev driver in drivers/net/ethernet doesn't make use of
> crypto feature
> then i guess netdev maintainers would reject any patches which configure crypto
> block. Also as i have been saying there are other scenarios as well.
> Future silicons may add support for other features into this resource
> virtualization unit's domain.
> An example would be compression. Any patches which do compression
> related HW configuration
> might be rejected by netdev maintainers, cause they are no way related
> to networking.
>
> I will keep netdev mailing list in all the patch submissions but
> moving this driver into drivers/net
> doesn't sound right, from it's functionality perspective.

Have you discussed this with the network maintainers? I agree that
it's not a perfect fit, but IMHO it would be better to keep everything
in one place than to split the code location into separate ddirectories
for management, networking and crypto. If we find one place for it,
then I think drivers/net/ethernet is the best since the purpose of that
(combined) hardware is ultimately to interface with ethernet.

If the network folks say they don't want it there, we can take the
management bits into drivers/soc as you suggest.

       Arnd
