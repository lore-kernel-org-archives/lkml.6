Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 454C5C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 23:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1B6F2082B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 23:46:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uG0ojKFS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1B6F2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbeJaIln (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 04:41:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:40232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727683AbeJaIlm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 04:41:42 -0400
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70E662082B;
        Tue, 30 Oct 2018 23:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540943165;
        bh=sRbk+A49jaUxQphS2a0uZr7Q65CCZ0AaGq5LNpVVD0M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uG0ojKFSKhWW1ZCcngmtrhgX/dwMd4Sotxi22SPRjCqh+5nwEZy7QogDvFQ2Qsj7o
         /rG6K2BvqYB7WXc3dyA57Tiwyd2jn3evopvYoveSO/BOhHB8zJ30TzM7/iycZgmMj1
         MY/ncJ7shaBiHi5xYB3nZ6RMXATk9eTSVln7nraM=
Received: by mail-wm1-f41.google.com with SMTP id h2-v6so9605336wmb.0;
        Tue, 30 Oct 2018 16:46:05 -0700 (PDT)
X-Gm-Message-State: AGRZ1gI4nw9x6Sy8FfgOMqkBZADFwE0TNE0JjnJZyemcrx9GneX+cA2w
        Oz19iqAH024hM1lymATrzrNhsNQMC0HfV6xu5k4=
X-Google-Smtp-Source: AJdET5eXWE6AUvPFHXn46PBt07Vd0o7SwA3ecUJjH0qLymKRVwTzUYn9Pag+nnTvLiFB2yr0DXkadSAIcvho5AVZM+Y=
X-Received: by 2002:a1c:cf08:: with SMTP id f8-v6mr539037wmg.56.1540943163947;
 Tue, 30 Oct 2018 16:46:03 -0700 (PDT)
MIME-Version: 1.0
References: <20181008191411.32555-1-manivannan.sadhasivam@linaro.org>
 <20181008191411.32555-6-manivannan.sadhasivam@linaro.org> <c8d65395-c60c-5d06-92ad-c389642c22ba@gmail.com>
 <20181011164429.GA18174@Mani-XPS-13-9360> <e7abee72-23a3-4716-baf0-484514bbb019@gmail.com>
 <CAGp9LzoP2zkryhJCQNGpe9X0+7yUd31ffV7vM4j6KvTdfPpCrA@mail.gmail.com> <CACRpkdb-Er8z6JdvYWE8UXUa3dfVSu4S-VbnqvcV+vf9erJuNw@mail.gmail.com>
In-Reply-To: <CACRpkdb-Er8z6JdvYWE8UXUa3dfVSu4S-VbnqvcV+vf9erJuNw@mail.gmail.com>
From:   Sean Wang <sean.wang@kernel.org>
Date:   Tue, 30 Oct 2018 16:45:52 -0700
X-Gmail-Original-Message-ID: <CAGp9LzpssWX2TxPdD0yWtmav2XGdG68ztx+hV1DxjRX52q0qvg@mail.gmail.com>
Message-ID: <CAGp9LzpssWX2TxPdD0yWtmav2XGdG68ztx+hV1DxjRX52q0qvg@mail.gmail.com>
Subject: Re: [PATCH 5/5] pinctrl: mediatek: Add initial pinctrl driver for
 MT6797 SoC
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        =?UTF-8?B?U2VhbiBXYW5nICjnjovlv5fkupgp?= <sean.wang@mediatek.com>,
        linux-kernel@vger.kernel.org, amit.kucheria@linaro.org,
        linux-gpio@vger.kernel.org, robh+dt@kernel.org,
        linux-mediatek@lists.infradead.org,
        Cheng Mars <mars.cheng@mediatek.com>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sure, the version of driver looked good to me, add the missing Acked-by from me

Acked-by: Sean Wang <sean.wang@kernel.org>


On Tue, Oct 30, 2018 at 5:51 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Thu, Oct 18, 2018 at 5:06 PM Sean Wang <sean.wang@kernel.org> wrote:
>
> > the driver currently only supports the basic operation, not including
> > driving operation, so
> > what value for the driving mode for a certain pin seems not really
> > matter in the early patch. I think these advanced operations can be
> > added with another patch.
>
> Sean can you provide an Acked-by for the pinctrl part so I can merge
> it once Manivannan resends it for v4.21?
>
> Yours,
> Linus Walleij
