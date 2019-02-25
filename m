Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64BFFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 00:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 293AA2184D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 00:22:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jbJJWEWM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729760AbfBZAWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 19:22:32 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35272 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729247AbfBZAWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 19:22:31 -0500
Received: by mail-lf1-f67.google.com with SMTP id m73so2737299lfa.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 16:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6at03+IfyftJOZ611UYmfrhKENe4hC81JDgP6PclobI=;
        b=jbJJWEWM6eF9oCP1NMpk8Yukinjlq9+t7gv/7a84CBFGDZukcP4flP8NA4wUzECL6d
         gQaSHzdMtqzdPFVijtcmq0cBgXks4jXI9RK/EKomvMbxjXgGjI1RV6koI7ViM0LSMXZQ
         Z65IfBARVH9OVaof5/TgeXzwxyg84u4pxKBrw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6at03+IfyftJOZ611UYmfrhKENe4hC81JDgP6PclobI=;
        b=nUFIutStg++gEP2PqdOHv37uFInDlHaOwyX/34fu2O6q6P0ju3sHm5FmKy+DU0NRJi
         1wNdX/999QLQBUm2vsP0ucWRc3uT6DsDp7Vrae+YdeYo1GBjtd5XkdQ8tqijBeQA394U
         BXTuzF5pMvxN3eIjidZMAfy2x2yzrNTGYdKSe6bUbqkDaHJUGEc9Vpahu4FBoC8BUTDd
         H1/3OXM2liiLfU+jECVUwMeNjzNVi0ixRrufNZoXmds6IQlnIZSsjnj0j0sOqFyuKjXe
         5xiYDI17VrjAxQL8T66GqFiJByQWQFeKkMYCAl9hP3tFt5nrFdFCzFbRvNMSt5sME9KU
         qdXQ==
X-Gm-Message-State: AHQUAuaeujlWxBroYay8XNq+2E3aSnBFh8YHhyTk6JmAuEe0F/rBl1xa
        BOQISUgsxTGQC0L4ZbcRGPZRbSqQOPY=
X-Google-Smtp-Source: AHgI3IZkINpOWCbtM9Ytg/xOdBN9Y+vMHXNaiN0nHfDc3bPcro54Fh391Wrs8cIUfzgixdQ29tqYyQ==
X-Received: by 2002:a19:6554:: with SMTP id c20mr4573615lfj.15.1551140549347;
        Mon, 25 Feb 2019 16:22:29 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id b19sm1721837lfg.56.2019.02.25.16.22.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 16:22:29 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id z7so8955322lji.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 16:22:29 -0800 (PST)
X-Received: by 2002:a2e:2ce:: with SMTP id y75mr11069375lje.126.1551138938131;
 Mon, 25 Feb 2019 15:55:38 -0800 (PST)
MIME-Version: 1.0
References: <1546318276-18993-1-git-send-email-yong.wu@mediatek.com> <1546318276-18993-7-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1546318276-18993-7-git-send-email-yong.wu@mediatek.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Mon, 25 Feb 2019 15:55:01 -0800
X-Gmail-Original-Message-ID: <CAE=gft76=+Jv-zxZiftt5F=m4wTY2yyWJ5cjxuG9jLP49CqAZQ@mail.gmail.com>
Message-ID: <CAE=gft76=+Jv-zxZiftt5F=m4wTY2yyWJ5cjxuG9jLP49CqAZQ@mail.gmail.com>
Subject: Re: [PATCH 06/13] media: mtk-jpeg: Get rid of mtk_smi_larb_get/put
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
        Rick Chang <rick.chang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 31, 2018 at 8:52 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> MediaTek IOMMU has already added device_link between the consumer
> and smi-larb device. If the jpg device call the pm_runtime_get_sync,
> the smi-larb's pm_runtime_get_sync also be called automatically.
>
> CC: Rick Chang <rick.chang@mediatek.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: Evan Green <evgreen@chromium.org>
