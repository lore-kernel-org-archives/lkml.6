Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A608EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 00:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69EC8218AE
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 00:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PQUfPwrH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbfBZACt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 19:02:49 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45637 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727529AbfBZACt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 19:02:49 -0500
Received: by mail-lf1-f68.google.com with SMTP id h10so8241209lfc.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 16:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BBBvJ5O1lizmSG/RcyRUvgsbHkA/R9Bv19K+pXXW6dc=;
        b=PQUfPwrHQX+Q5XqDAUVTooJpkVnxbAm0WClBt2lGerOGUm5e5PmWfkcbOyWTSnw4Go
         goAOdRvVF716J6oWY9S6DT4TKVWy/QUQBCzZ+Z3TwUPTmFSytAXu2VA6zcb21UYvdtMU
         fDt2I6QYCFDFF+McYhuoYtpdiw/s5i03jrbHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BBBvJ5O1lizmSG/RcyRUvgsbHkA/R9Bv19K+pXXW6dc=;
        b=f6uEZf1kW/VGCNlGoP6LG5vcpGlesbHrh++e8UIxKuE5jALMhH5yZnc9a7sBS/4F0h
         c6/2H1xlXJTWMg3sGJ4fcZd7hl1U6lsPgBZbiW+CX956VnQA8KJCWER+de4Uv25bxDM8
         h9w8AQT+3gGAeBtx2SKOe/nLSnanUJHmk4eh2VBCsMeftExK/Rqu1Jgam/ZMxjPbqR9k
         R1RHdd9z78wVMjD1HmJrDMlgQNR9WpcLTYK7v1MKKymEbELfujDJ6e4WSN//h33v5Lis
         vlXJHPYhz56/CJBMvYgAMJA44yQsaYKvb2yVvjhCNfDUZqS89EZr2ek8PZYPeOAIf6iK
         w97g==
X-Gm-Message-State: AHQUAuamHws+d6gs9WUgVwsMIYXQDaWpwwZ+lMvUwD2E5d01vsjsNEh2
        tPDcqbvneF/GomVNFttYKbIguFex1dE=
X-Google-Smtp-Source: AHgI3IafI7WCiXuxJKCk3RiwhCOVKP83qnVTCc6fHZ7S2W3LZe8jP5J7AADJse5VLXj2ynMMhJPdUw==
X-Received: by 2002:a19:ae0b:: with SMTP id f11mr12334829lfc.104.1551139367165;
        Mon, 25 Feb 2019 16:02:47 -0800 (PST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id g13sm2784259lfb.57.2019.02.25.16.02.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 16:02:47 -0800 (PST)
Received: by mail-lj1-f178.google.com with SMTP id v10so9125618lji.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 16:02:47 -0800 (PST)
X-Received: by 2002:a2e:9ad1:: with SMTP id p17mr11648555ljj.30.1551138951645;
 Mon, 25 Feb 2019 15:55:51 -0800 (PST)
MIME-Version: 1.0
References: <1546318276-18993-1-git-send-email-yong.wu@mediatek.com> <1546318276-18993-8-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1546318276-18993-8-git-send-email-yong.wu@mediatek.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Mon, 25 Feb 2019 15:55:15 -0800
X-Gmail-Original-Message-ID: <CAE=gft7VtbN2kQ=sxcdtCSB=hc-AEFqSWK3WfipzoaZb3i0sag@mail.gmail.com>
Message-ID: <CAE=gft7VtbN2kQ=sxcdtCSB=hc-AEFqSWK3WfipzoaZb3i0sag@mail.gmail.com>
Subject: Re: [PATCH 07/13] media: mtk-mdp: Get rid of mtk_smi_larb_get/put
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@google.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, Arnd Bergmann <arnd@arndb.de>,
        yingjoe.chen@mediatek.com, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>,
        Minghsiu Tsai <minghsiu.tsai@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 31, 2018 at 8:52 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> MediaTek IOMMU has already added the device_link between the consumer
> and smi-larb device. If the mdp device call the pm_runtime_get_sync,
> the smi-larb's pm_runtime_get_sync also be called automatically.
>
> CC: Minghsiu Tsai <minghsiu.tsai@mediatek.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: Evan Green <evgreen@chromium.org>
