Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32800C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 076532087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cJ7GeL5r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387611AbfA3TYO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 14:24:14 -0500
Received: from mail-lj1-f169.google.com ([209.85.208.169]:40824 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387544AbfA3TYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 14:24:13 -0500
Received: by mail-lj1-f169.google.com with SMTP id n18-v6so577313lji.7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 11:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kUoP8ow0u3BjoGMjMpf081Xt5GpQYKWK+yws+VrVB9U=;
        b=cJ7GeL5raixS5kQ0QSjZNPpYMJLD708nwHxeU4aWWr7W1gOpUV1ISKdvs3fdzRK63s
         tQen7oDI8yCkKjpWeo4PSinWqcK1ZBM1Wbj04cDXDBHSIXH9A6Zvp+utqUTUg077tKMd
         p4H0bzNtrnTFIvI7pXY77t22jgWkHlWnH8/54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kUoP8ow0u3BjoGMjMpf081Xt5GpQYKWK+yws+VrVB9U=;
        b=Ckfa/ug5MHsUqh121m6i96evptsqznmHR2v+jfgLyY2LTZS0Q5t6aObdXwms7BIvv8
         HHtl9OHGaTX+Z4z27Ey/t40B6vVy/C8Hr07/HvtHPRckb0GAk2XJ4CjgFd2SFIKSMlkY
         A80xPApLEPAs8xvnUuNMg4tgJf5Yh+S+gx/Lev/2NyFgFmV3IgHmuU/cy8F8kcNwO07j
         PwnRofC/sqdWjCeN68Bm/qDwrobQ5JOg7ymR8OlEbXnz/FalkWUfbbXgmzJeJnvpwehK
         n9q9wsWCbpGez58IhR9HqA5nEQI197ahB6kVnj9sfrXEBfD9p4RM2jY+TQqicT+20Kln
         irwA==
X-Gm-Message-State: AJcUukcV7dQ0Dp7NvJmZW+OODq6dzm06x8RwbEWSwb3hiRc1L6WUEUXb
        8BFoGVbakGb4/JM9Fuk+yYRUs8eLy6I=
X-Google-Smtp-Source: ALg8bN6nV45DZd/3gCjEAIsh0oxXbq9hlLXM9fMcbEodV2nbsW2BoYrzHCMkovYYmCN+i4OcfUys9Q==
X-Received: by 2002:a2e:5152:: with SMTP id b18-v6mr25005754lje.88.1548876251025;
        Wed, 30 Jan 2019 11:24:11 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id 11-v6sm410528ljv.1.2019.01.30.11.24.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 11:24:10 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id i26so541477lfc.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 11:24:10 -0800 (PST)
X-Received: by 2002:a19:7d42:: with SMTP id y63mr25092101lfc.47.1548875771635;
 Wed, 30 Jan 2019 11:16:11 -0800 (PST)
MIME-Version: 1.0
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com> <1546314952-15990-20-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1546314952-15990-20-git-send-email-yong.wu@mediatek.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 30 Jan 2019 11:12:51 -0800
X-Gmail-Original-Message-ID: <CAE=gft4g4HbDG7shtiqUP5vw9tiyRr4VEheMGM2uhEL_65yYmg@mail.gmail.com>
Message-ID: <CAE=gft4g4HbDG7shtiqUP5vw9tiyRr4VEheMGM2uhEL_65yYmg@mail.gmail.com>
Subject: Re: [PATCH v5 19/20] iommu/mediatek: Add shutdown callback
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
> In the reboot burning test, if some Multimedia HW has something wrong,
> It may keep send the invalid request to IOMMU. In order to avoid
> affect the reboot flow, we add the shutdown callback to disable
> M4U HW when shutdown.

Sounds unpleasant. Hopefully the reboot flow still continues properly
even in that case, since this shutdown code may not run during some
rougher resets.

Reviewed-by: Evan Green <evgreen@chromium.org>
