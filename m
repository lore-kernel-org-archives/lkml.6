Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 545DAC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BB5B2087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kbeEOxjx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387550AbfA3TQ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 14:16:58 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34324 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728197AbfA3TQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 14:16:57 -0500
Received: by mail-lf1-f65.google.com with SMTP id p6so518904lfc.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 11:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SFTTDZR6YcJzF46vICwfSJ+8tqAs4omNQ9g0nqdfois=;
        b=kbeEOxjxBB3VUw2oPfJYeJuZpaQWy15eSI71DDEAF5210vDE8pnejqJovUL1RvHtMT
         VfM5b1Oy5i1GNGm2T56TFvVKWffxvtEr55ALOkbchwvr5Mcr8lOnaLcntRlhPjZ/FTeY
         dCHUQhk9SK6qAQ76sPxgdz5DhA2eLZMNbEx/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SFTTDZR6YcJzF46vICwfSJ+8tqAs4omNQ9g0nqdfois=;
        b=sxCd+OC1WGRtH6iPdbZEN/119RSbCT308zPz62HMdiGvnpaO2MTMUWbi2/RvEwhJFU
         TsuuhHUJXKbmFepHuEzxexIZaVamyZx8Gjnskgfu7H9m4jDXZdVs+ewymcC6YiOJZVdU
         X8tngVZ5UOO1Cy6KMRAd5dbTE0sVk9M3bfrYw2LI/ppIg5XcbZq3FYcXH58KTmNZA/9r
         bVrC5OVwD1zwZseczK+d5bpG48PErTSjoCiH7jCQALDEORQZZUIgW2T8nGFoghscetC0
         PpvOxNv6PJ5mIrysKzie+9bP33fAgouR+m3ytU7QEwQIj51jST8bLNK56St737xaE/F+
         zR2Q==
X-Gm-Message-State: AJcUukdP7UMPxIixoAds/tnjXp5ajYNNsOc0My3vNePePKLHMp0Use2q
        4Mdcn6U08MMiJMOfeGEpIJdKVHgVHRs=
X-Google-Smtp-Source: ALg8bN5jrAaHHtpHgIhup8IiSy9xTnmmfxzOxPM7RUcckBSOS2XUM9PxXUCGjQHGfZTXk15N03QC0g==
X-Received: by 2002:a19:1994:: with SMTP id 142mr24480926lfz.134.1548875815036;
        Wed, 30 Jan 2019 11:16:55 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id q10-v6sm437382ljh.72.2019.01.30.11.16.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 11:16:54 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id u18so467656lff.10
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 11:16:53 -0800 (PST)
X-Received: by 2002:a19:8c1b:: with SMTP id o27mr23897594lfd.90.1548875813284;
 Wed, 30 Jan 2019 11:16:53 -0800 (PST)
MIME-Version: 1.0
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com> <1546314952-15990-21-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1546314952-15990-21-git-send-email-yong.wu@mediatek.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 30 Jan 2019 11:13:02 -0800
X-Gmail-Original-Message-ID: <CAE=gft6Dje_VF6vr3=iM9BSKB1N8xe3F5EkEzMgC+fyF69csJQ@mail.gmail.com>
Message-ID: <CAE=gft6Dje_VF6vr3=iM9BSKB1N8xe3F5EkEzMgC+fyF69csJQ@mail.gmail.com>
Subject: Re: [PATCH v5 20/20] iommu/mediatek: Switch to SPDX license identifier
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
        iommu@lists.linux-foundation.org, Arnd Bergmann <arnd@arndb.de>,
        yingjoe.chen@mediatek.com, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 31, 2018 at 8:00 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> Switch to SPDX license identifier for MediaTek iommu/smi and their
> header files.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: Evan Green <evgreen@chromium.org>
