Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87DD1C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 01:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53F6A21B18
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 01:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KysuK/Hw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730770AbfBOB0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 20:26:34 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36736 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfBOB0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 20:26:34 -0500
Received: by mail-ot1-f68.google.com with SMTP id v62so5149293otb.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 17:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6uz0kUsZLOlyc/GsvAXtmKx3gYn3eTJy5dFjv86Wxg0=;
        b=KysuK/HwzYui1rqiNnrZVF3yeoDzVUDktPelt2MN2ez+sYxdKyBc0LoYbWB/1D0zwg
         /0G+dI9oaSVJ2skEdxHAYvtfwJ/4tzqrGxmJmtNG3h0ZdBNPZXW8jz7wsq8VwN8NuP0d
         +fo9g9M7RD03uwqj38t2JtROgBLmjwnMoLIxNhnxW02zeLGyNvbHZlAsfF8zAJmRAxVK
         ER77k86HW3G4bvpFmKYPVjRGV5B9cdoyrH75UyBnFiMEmqxWgbuRY6EYDrlzymtoY0mm
         SjHQ1uE4mjnkXjO9Nt+b18hRM88N7Zpl1UbEQh64SvaTtV0bcyKPFVqvUavpyLgvxCKF
         r1qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6uz0kUsZLOlyc/GsvAXtmKx3gYn3eTJy5dFjv86Wxg0=;
        b=sp1H4mN0FrcSVGd1i67u6j12v3Nnm9d4nt07adfUUPD1FrHandhm5mPn9OCi9klEXf
         MnpoV0D5Ig13qC8sRlakcgSSzCc6XGA/1SdKvQct+19CFd6PnrlhmXfqbpsOehABtovC
         vYWjJfLWjmmZxPliVCzO5ZKfQQjR1qr+H6wqZt7u7c4G2fvXVsUfIT4qfL7zTkqqQZdY
         ZbAEKuO4J9xm6tk4tyNJ9j3cnvM9AIbGOhCPNXKM5+MWqVc2l2cHwrxYAee/lp9cjBbg
         7w7wAKwR+grw7ofQeJ5HrA81tPF71ehmhWKij9MQ0sECz0KXyzlbVwXzbkWT9phArmR4
         3JFg==
X-Gm-Message-State: AHQUAuZ5ygeshRs9kDoqubEvxo3KVAye9yEmIBh2uFeSSz3/I5MPkB+b
        +zV73DL57UnpsRHFmkvTe889VPJcCoDC1Yc+loOZWw==
X-Google-Smtp-Source: AHgI3Ib6+3Vr9Gbya3LpY9yJE+KDUdpmO3Q6cGJnYQg/UPIMBerHNd7MAFAiq7CsZLlhXLnQff76Yg6Dzq5MHmYHsi0=
X-Received: by 2002:a9d:7597:: with SMTP id s23mr4192113otk.25.1550193993193;
 Thu, 14 Feb 2019 17:26:33 -0800 (PST)
MIME-Version: 1.0
References: <20190212185305.112847-1-brendanhiggins@google.com>
 <20190212185305.112847-2-brendanhiggins@google.com> <4cb7ca12-ce60-7516-b7eb-aef08f607acc@gmail.com>
In-Reply-To: <4cb7ca12-ce60-7516-b7eb-aef08f607acc@gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 14 Feb 2019 17:26:21 -0800
Message-ID: <CAFd5g441+6ATUKcNz7OstAB6Qd2BqeDh77SNnGUpZGBNvgysmg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] of: unittest: unflatten device tree on UML when testing
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 4:10 PM Frank Rowand <frowand.list@gmail.com> wrote:
>
> On 2/12/19 10:53 AM, Brendan Higgins wrote:
> > UML supports enabling OF, and is useful for running the device tree
> > tests, so add support for unflattening device tree blobs so we can
> > actually use it.
> >
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > ---
> >  drivers/of/unittest.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
> > index 84427384654d5..effa4e2b9d992 100644
> > --- a/drivers/of/unittest.c
> > +++ b/drivers/of/unittest.c
> > @@ -2527,6 +2527,9 @@ static int __init of_unittest(void)
> >       }
> >       of_node_put(np);
> >
> > +     if (IS_ENABLED(CONFIG_UML))
> > +             unflatten_device_tree();
> > +
> >       pr_info("start of unittest - you will see error messages\n");
> >       of_unittest_check_tree_linkage();
> >       of_unittest_check_phandles();
> >
>
> (Insert my usual disclaimer that I am clueless about UML, I still need to learn
> about it...)
>
> This does not look correct to me.
>
> A few lines earlier in of_unittest(), the live devicetree needs to exist for
> unittest_data_data() and a few of_*() functions to succeed.  So it seems
> that the unflatten_device_tree() for uml should be at the beginning of
> of_unittest().

It is true that other functions ahead of it depend on the presence of
a device tree, but an unflattened tree does get linked in somewhere
else. Despite that, this is needed for overlay_base_root. I got
similar behavior if you don't link in a flattened device tree on x86.
Thus, the order in which you call them doesn't actually seem to
matter. I found no difference from changing the order in UML myself.

Without my patch we get the following error,
### dt-test ### FAIL of_unittest_overlay_high_level():2372
overlay_base_root not initialized
### dt-test ### end of unittest - 219 passed, 1 failed

With my patch we get:
### dt-test ### end of unittest - 224 passed, 0 failed

I used the following .config for these results:
CONFIG_OF=y
CONFIG_OF_UNITTEST=y
CONFIG_OF_OVERLAY=y
CONFIG_I2C=y
CONFIG_I2C_MUX=y

>
> Rob, if I am correct please revert this patch.
>

Cheers
