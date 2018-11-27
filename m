Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C96AAC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 23:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90B352086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 23:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="M8l2XXMb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90B352086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbeK1K2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 05:28:11 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:36388 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbeK1K2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 05:28:11 -0500
Received: by mail-it1-f195.google.com with SMTP id c9so1417038itj.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 15:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gfpWsQb1kFEJzpIb7Rpfmw0g5NooBSm+r7b/HQg60I4=;
        b=M8l2XXMbi914XAfWkBEzZ6d8Zs0fFxfC/cpWm6ijf0DOmAfeSjErxXBV13LX5sKIXT
         8qcjlyTMrVqai3Tsduc0xfrGGL1FATAor7xJet115WJeTlk8mgIbzeQ6xAvSyIe44LDj
         ZNO093zPmDvAbUQ3OJCDHs4SdB1WUkTmFOYEstqE9m1BiQdEc2BruzD8ACvWNlrE6ieY
         qJGyUbymTijEsX1i9qsX1gSBBNaWY3TDbYan7ybki6NGJjf/Oix4QEPoBvLhdYuCXNfT
         QOAz1InWaUVADBXXfVtox+hN5Fe+CnMMeH/kEu+omyWiRgOqvoQaO1GLug2QgRG6RqRQ
         wlQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gfpWsQb1kFEJzpIb7Rpfmw0g5NooBSm+r7b/HQg60I4=;
        b=mCjN/jzQKRDyjXTZ8yo7glGiLUQ+Vr7RG/vJtDvGZGGscPatHRdkgvKESQrZ4VtGdP
         E5S8dd3C1KiyAY/y01w6kKx++t0+yPLWbMPWNdP7nHu1KFRIgRkgv0h2Kry5VbDvQJ+K
         ZjFwI78R49ojGM0zkaOgCSRnJALBptv6XZYo+7jn1Yo1ePayuirwlCkbvX2j6o+7rQpx
         vqIM3J8xotk7miJFldqD35kgNEojw8SVFIYi9zwIS4Wge1FfYnBTAoFPU68qXoF1T7Lx
         KbwkKVk6jt2ocY4oid737o2RfjYxoCpE1wtTCTS25zdH/9KZIKXsh8c4L7RBjE7wblTZ
         vurg==
X-Gm-Message-State: AA+aEWbVpB90PL+BRUnbh/IEXp9k+QSQhAmK0tDLcmEdbu3JfaCQyXQn
        AAN1Wk4DJJT8ce2QKNVP3M25nW+D7rvOivYU8zVFZw==
X-Google-Smtp-Source: AJdET5e25ng0gnL/HJyY5fqFSFtgUostESJqy0n3yma09W1oF+np1i6+Bcq2k5uiRJLA+VvOKMjLooq4Z5ktNTyK5M8=
X-Received: by 2002:a02:98d2:: with SMTP id c18mr28724138jak.11.1543361319815;
 Tue, 27 Nov 2018 15:28:39 -0800 (PST)
MIME-Version: 1.0
References: <1543298903-8389-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1543298903-8389-1-git-send-email-Anson.Huang@nxp.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Tue, 27 Nov 2018 15:28:28 -0800
Message-ID: <CAOesGMiDx+0BaTxoo4YPVQD-JPbX9h+drUvrKPQ6wfAyUUGjiQ@mail.gmail.com>
Subject: Re: [PATCH] defconfig: arm64: add i.MX system controller thermal support
To:     anson.huang@nxp.com
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Simon Horman <horms+renesas@verge.net.au>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        ezequiel@collabora.com, Amit Kucheria <amit.kucheria@linaro.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, linux-imx@nxp.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Nov 26, 2018 at 10:14 PM Anson Huang <anson.huang@nxp.com> wrote:
>
> This patch enables CONFIG_IMX_SC_THERMAL by default.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

I don't think this driver is needed to boot the system to root
filesystem, is it? If so, it would be preferred to enable this as a
module to keep kernel binary size down for all platforms.

It looks like we should revisit and bring some of the other platforms
back to modules too (Rockchip is today, but Renesas and Armada don't
seem to be).


-Olof
