Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA09AC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D41B2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="laJKfL/b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D41B2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730411AbeKTFwN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 00:52:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:47198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726350AbeKTFwM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 00:52:12 -0500
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E613A208E4;
        Mon, 19 Nov 2018 19:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542655630;
        bh=gWfvx1UsuiNpWCJUp337JT/K1ziYS9I+jwJHfD5a9l0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=laJKfL/bRt9sBsTMZNM24XPjAEMKvgZV4eRp65Izuo0nUA8TnW79fEA675JnzhUyb
         ea2eQEbn1301+4wwTEyYZ7y/nYOehR5ZvlF0H2/FiHnbrpJeaxX5oSEyb3g8huN0bz
         Q6F4kPtcGpPry32g3iXbo7fPdmWXnTFnOC9V24B8=
Received: by mail-wr1-f41.google.com with SMTP id j10so19079850wru.4;
        Mon, 19 Nov 2018 11:27:09 -0800 (PST)
X-Gm-Message-State: AA+aEWYw2PQhIL1CUED/Y/Ar2rh2KenHFtvz+pte7x3hdg8FKjsCKymq
        qvCfRwtm67Axq58jiImrTCVD+YHtUksFbUrE0Tw=
X-Google-Smtp-Source: AFSGD/VIiJxjejEVlLdTGGGC5FjazqemEZMuvOTSu1wyVsbDRM3tJzmSK4ekhMY8EspmJY5qEolFLNRvZfDoYFbfQac=
X-Received: by 2002:a5d:66c1:: with SMTP id k1mr11892563wrw.132.1542655628443;
 Mon, 19 Nov 2018 11:27:08 -0800 (PST)
MIME-Version: 1.0
References: <20181116220540.17222-1-robh@kernel.org> <20181116220540.17222-4-robh@kernel.org>
 <CAGp9LzpgZsj79Tf5Hee45Wt6ag+WHV0SMWd6qvvtj4G3pzAZKQ@mail.gmail.com> <CAL_Jsq+r6JrKKcHnmBSncdEaw=7Jhobv_w8PJrH=sbY2qtxOTQ@mail.gmail.com>
In-Reply-To: <CAL_Jsq+r6JrKKcHnmBSncdEaw=7Jhobv_w8PJrH=sbY2qtxOTQ@mail.gmail.com>
From:   Sean Wang <sean.wang@kernel.org>
Date:   Mon, 19 Nov 2018 11:26:57 -0800
X-Gmail-Original-Message-ID: <CAGp9Lzr7Y97BLDMy8aNvPkct2YphTHBrOfKrPbFeFqwEN3iK-Q@mail.gmail.com>
Message-ID: <CAGp9Lzr7Y97BLDMy8aNvPkct2YphTHBrOfKrPbFeFqwEN3iK-Q@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: mediatek: Convert to using %pOFn instead of device_node.name
To:     robh@kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 11:07 AM Rob Herring <robh@kernel.org> wrote:
>
> On Fri, Nov 16, 2018 at 5:46 PM Sean Wang <sean.wang@kernel.org> wrote:
> >
> > On Fri, Nov 16, 2018 at 2:06 PM Rob Herring <robh@kernel.org> wrote:
> > >
> > > In preparation to remove the node name pointer from struct device_node,
> > > convert printf users to use the %pOFn format specifier.
> > >
> > > Cc: Sean Wang <sean.wang@kernel.org>
> > > Cc: Linus Walleij <linus.walleij@linaro.org>
> > > Cc: Matthias Brugger <matthias.bgg@gmail.com>
> > > Cc: linux-mediatek@lists.infradead.org
> > > Cc: linux-gpio@vger.kernel.org
> > > Cc: linux-arm-kernel@lists.infradead.org
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> >
> > Acked-by: Sean Wang <sean.wang@kernel.org>
>
> BTW, messages to you bounce:
>
> <sean.wang@mediatek.com> (expanded from <sean.wang@kernel.org>): host
>     mailgw01.mediatek.com[216.200.240.184] said: 550 Relaying mail to
>     sean.wang@mediatek.com is not allowed (in reply to RCPT TO command)
>
> Perhaps you need your kernel.org account to route somewhere else.
>
> Rob

Thanks. I've found the issue. Will fix it soon.
