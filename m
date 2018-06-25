Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14C8C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 995AC25F4E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:32:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="jTfY3f9U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 995AC25F4E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964801AbeFYRcS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 13:32:18 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:37056 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934051AbeFYRcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 13:32:16 -0400
Received: by mail-oi0-f66.google.com with SMTP id l22-v6so13273412oib.4;
        Mon, 25 Jun 2018 10:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aX/PPo5zxvwZ87kPeYfHinMG/jiEjbx7usdWqjQ71oE=;
        b=jTfY3f9UHMa65MBwGWvz+mIy3f+zp5Htjtvp7a6vbED0/MlEDLQgQPrBW1Zi+MSjg/
         TQZ0qwd+WJ1G2fcvrendNO0rwasBuwT20L3z5mS46Ad+WCvoB11HHuQBo6qtsbMq8XyK
         //k8HKrihIIqDyrK5nYMbsP3ZXaLCbK4TmlmLweGDMuL8gTjjcJicJaEuW2CR17e0RuD
         5j+Mz2Y0MDE5+tEu3w/hu1DkGVl89B8paP8JQZmJGKaJ8pNvsB5wRnSZuDLhRP85iq1d
         6Scho6Ynn70wxpf5wzlIjVsW3eIVE/GTdfklhVzFCFntMX4mrPTOSoetcyXQgEFuBFPw
         +X+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aX/PPo5zxvwZ87kPeYfHinMG/jiEjbx7usdWqjQ71oE=;
        b=Ptzw3VN0dWzwfBSdbsLV82pHka5KxGgb2UbL6CJ8quhH8t0VOY5vVv9tGM+CYdDel4
         uvu8ds/96he3tox6uLYbsK6S59nc4W9pGvwQuummA945RXYGa7SpwT4UA3No0/v6gkLK
         2O1h8eNI3RMmRCXuQGZwP2oQbMXIseYkmpwRRvU5z/wkciSJa954M/h7LV+QAp52UgUU
         kGmW3ewJMOXs26g8vmDrq3itgjHHcAf1Z7qTwIvldDF+4hrG4OAnEEswBCO2fOrGyiTS
         bez0CSYMcM0KgMQIKuyRakmjUzO7EVTedwoOOE9yYTU+xkjw2dh3KG578r5/YcQfnDq4
         7AdQ==
X-Gm-Message-State: APt69E3eFmwK+cUaUeYjVCqsq6RG58N1tpf/FAN+Kp1LGNQ2qRa6ykgp
        VK5GkWXxEeM8x405FYnJVhU6QF9ROhO5id10Flg=
X-Google-Smtp-Source: ADUXVKJ6KcnaoSGUJOhuvGzrIO8s91n9lq/9WtK/7QQaLbU/p5w+jXLvNIWKpHfgRnu8LoivjoHEaz8Lrwj9YAQ5lH4=
X-Received: by 2002:aca:4d87:: with SMTP id a129-v6mr1339631oib.256.1529947935957;
 Mon, 25 Jun 2018 10:32:15 -0700 (PDT)
MIME-Version: 1.0
References: <4c338a129ab14ab41949da5e3c21aed0d77dff8d.1529647619.git.chunfeng.yun@mediatek.com>
 <644d00edd2932c1a0d0a1bf368dd25427d1d9f64.1529647619.git.chunfeng.yun@mediatek.com>
 <CAFBinCBS+fpfx6jaaqD=kqFuMF6ko8GikbV1ZVwgbDh-Sn8T8w@mail.gmail.com> <1529908621.32173.27.camel@mhfsdcap03>
In-Reply-To: <1529908621.32173.27.camel@mhfsdcap03>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 25 Jun 2018 19:32:04 +0200
Message-ID: <CAFBinCDuGd-R1OR6h1UTTsWm2XNJC_f8iREgdE8fQQv1ph9hpQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] usb: core: phy: fix return value checking about devm_of_phy_get_by_index()
To:     chunfeng.yun@mediatek.com
Cc:     johan@kernel.org, gregkh@linuxfoundation.org,
        felipe.balbi@linux.intel.com, matthias.bgg@gmail.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chunfeng,

On Mon, Jun 25, 2018 at 8:37 AM Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:
>
> On Sun, 2018-06-24 at 20:00 +0200, Martin Blumenstingl wrote:
> > Hello Chunfeng,
> >
> > thank you for the patch!
> >
> > On Fri, Jun 22, 2018 at 8:33 AM Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:
> > >
> > > 1. use IS_ERR() but not IS_ERR_OR_NULL() because devm_of_phy_get_by_index()
> > >     never return NULL value;
> > ACK - good catch!
> >
> > > 2. devm_of_phy_get_by_index() should not fail for a valid index
> > I have learned that the PHY framework can return -ENODEV if the PHY is:
> > 1. supposed to be handled by the legacy USB PHY framework
> > 2. the PHY node is disabled in devicetree
> A little confused, we can avoid this error by not using a disabled or
> "usb-nop-xceiv" phy in host node.
I think that would be the mid or long term goal

> If ignore error of -ENODEV, we will also skip an error case which we
> don't want it happen.
as far as I understand the problem is that there are .dts files out
there which specify "usb-nop-xceiv" in the "phys" property, see [0]
(there might be even some more out-of-tree cases)
so I think the -ENODEV check can only be removed once nothing uses
"usb-nop-xceiv" anymore


Regards
Martin


[0] https://patchwork.kernel.org/patch/10160181/
