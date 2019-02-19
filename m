Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB88C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 23:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AA632147A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 23:31:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Yz4riTNS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730083AbfBSXbX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 18:31:23 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41056 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728765AbfBSXbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 18:31:23 -0500
Received: by mail-lj1-f196.google.com with SMTP id z25so11303008ljk.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 15:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WO1ho7JCnpG79Vmw76pV30lk4sOfvZriBKEmXw9hSIo=;
        b=Yz4riTNSMSuXCOJjngAXOWHTXCPdN2xSlXdZ3eQ/yNF82u0hxWbe13xDIlReoe+i2/
         NcQD/TYX3aRBJL2yauZIg9A9YM0TgoxscrYABuEhDWJFFH+SxmIHp3ouqirs/x2xJ2M9
         oJXRwYrWVGdIEjPhYUjtjGIu/IWfOVcHZJ/HA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WO1ho7JCnpG79Vmw76pV30lk4sOfvZriBKEmXw9hSIo=;
        b=HFGWHif7EAr0/V3e0xaIKmUG2Nyv9TySYgYGjY8XLiGEFckxMXfbQAVnp3rn1LeJZI
         nRqO0axtGfxwjRDOoPYMjrjJ2UkdzrAkUOpTMXrrrUGDX3YORBOUFyWfc4Ctbh7EcWsM
         hXc3yq7bNFIBXiJo7nbQvXbeuFln4YHG2Koag0y8oPDCndgAay6uPR0PQJB+h0wbiPlO
         Eb02jSahi+zUZ33o/4WStg0/xydXwOX/LO+PdNYfeolAgV6WIHk4qa7pQjGB0GBBh3Fw
         y4R5NizU4m+1qgSFwb/z3x46iIm46Gx7loPt6/DxJoaIziHO0ZacOQ7Bmz/6bzUj4kGj
         Qmkw==
X-Gm-Message-State: AHQUAub1yQ0bfPXnN2IBfdIx98Lup7A2KsVubMhzt5xwX0kT+7kxz3bV
        86+eluwz48HMIdK77YAtG1NSf8wK2x8=
X-Google-Smtp-Source: AHgI3Iagcq4zeIEqeq+qEQ1yb5AxdSp7CbZNtAcv9muPwj6vDyB8o/YBca5T95Aa0sbhySea5OabQw==
X-Received: by 2002:a2e:21d1:: with SMTP id h78mr6208034lji.49.1550619081297;
        Tue, 19 Feb 2019 15:31:21 -0800 (PST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id m28sm2039885lfj.44.2019.02.19.15.31.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 15:31:20 -0800 (PST)
Received: by mail-lj1-f176.google.com with SMTP id j13-v6so19169190ljc.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 15:31:20 -0800 (PST)
X-Received: by 2002:a2e:9f0b:: with SMTP id u11mr19711923ljk.64.1550619079667;
 Tue, 19 Feb 2019 15:31:19 -0800 (PST)
MIME-Version: 1.0
References: <1550394300-17420-1-git-send-email-yong.wu@mediatek.com> <1550394300-17420-11-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1550394300-17420-11-git-send-email-yong.wu@mediatek.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 19 Feb 2019 15:30:43 -0800
X-Gmail-Original-Message-ID: <CAE=gft6urwBfjLPjF29UooMbZTVA5h7fLgEmtajsLi5zYoaVUg@mail.gmail.com>
Message-ID: <CAE=gft6urwBfjLPjF29UooMbZTVA5h7fLgEmtajsLi5zYoaVUg@mail.gmail.com>
Subject: Re: [PATCH v6 10/22] iommu/mediatek: Move reset_axi into plat_data
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tomasz Figa <tfiga@google.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, yingjoe.chen@mediatek.com,
        youlin.pei@mediatek.com, Nicolas Boichat <drinkcat@chromium.org>,
        anan.sun@mediatek.com, Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 17, 2019 at 1:08 AM Yong Wu <yong.wu@mediatek.com> wrote:
>
> In mt8173 and mt8183, 0x48 is REG_MMU_STANDARD_AXI_MODE while it is
> REG_MMU_CTRL in the other SoCs, and the bits meaning is completely
> different with the REG_MMU_STANDARD_AXI_MODE.
>
> This patch moves this property to plat_data, it's also a preparing
> patch for mt8183.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Reviewed-by: Nicolas Boichat <drinkcat@chromium.org>

Reviewed-by: Evan Green <evgreen@chromium.org>
