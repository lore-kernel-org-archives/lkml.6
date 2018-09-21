Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2F9C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96AC62098A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="euTEnDcY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96AC62098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390629AbeIUWDK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 18:03:10 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:46504 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389657AbeIUWDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 18:03:10 -0400
Received: by mail-io1-f66.google.com with SMTP id y12-v6so12762658ioj.13
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 09:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yIjZPVN72xz/66YL0EBNDQF0c7jh+7XRcunSZ95AynE=;
        b=euTEnDcY8ZF5PwxUuSkNAAXb2fjKVqnEy141vrKyKbdb3oeNjpQ/9Qh/0M6VWLQJib
         Ep71mVS53OWvof+MqCGIQaa6Pdgboe4qtCNnk1qmT1elqFVR1k4SrZy0xyGp8aycvF+d
         5zq9f9bc6nyxKaClWGTC7GnXOcH5BWoj+yA5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yIjZPVN72xz/66YL0EBNDQF0c7jh+7XRcunSZ95AynE=;
        b=XWnztmCztjNMtlwPy/rfWzHfM48PL/CGy+cUgylPAnL4I6n6f0KbTU4SsSz3tOQbeY
         QIYK2guhiLTTFcM5ZknUKB/DP7qFDD38DreqkF0YgFxQ494oPmhN468Y2iHw7ddOdTFE
         Vzev2zQ1bsEw+Ac18aKzmMllvDVsVGrgqqgNz47aLrcNMI8APf6VslUx/iJ3ScgAe3KP
         qFMTU+AQPK//4VXSwgXDYSVreSyBz9tsEeNhjNmnEBiDeNuO1QxSf9KpjMZGMZDSq6It
         yI6WiLjQSQX82omMADe/8WZqgpBRC3TuJCCtAnpiMd27sdB0CwrQI8KD81tt9ic3f03F
         H04g==
X-Gm-Message-State: APzg51D6js/B74vj7eY0Tp1dyIUJdd4WC2kUDDAGBG0tOUCzQxD5eSC8
        gVgxJKTYJ9gkK4XhqjITFP68BhFloGvvT2Hle6iXpg==
X-Google-Smtp-Source: ANB0VdbrL/nEQQQpDv50whUeafivLbZayE0yoWHmNpWkdAuzLDDuLTAFXBPcIvurGYQAqJ/daHM9WxzGmjSJBPuvluY=
X-Received: by 2002:a6b:c3c4:: with SMTP id t187-v6mr37074046iof.304.1537546416077;
 Fri, 21 Sep 2018 09:13:36 -0700 (PDT)
MIME-Version: 1.0
References: <ab85fbee4d8286cbedbcc7317f89dc0d2dd83965.1537502494.git.sean.wang@mediatek.com>
 <a50aff453cb2ac2ad891893c3e3f7ef9676f40f2.1537502494.git.sean.wang@mediatek.com>
In-Reply-To: <a50aff453cb2ac2ad891893c3e3f7ef9676f40f2.1537502494.git.sean.wang@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 21 Sep 2018 09:13:23 -0700
Message-ID: <CACRpkdZeAvT=0XB-X30nawEDUVaKbZFHH9DaV3XDxzFckKikLg@mail.gmail.com>
Subject: Re: [PATCH 3/4] pinctrl: mediatek: add MT6765 pinctrl driver
To:     Sean Wang <sean.wang@mediatek.com>
Cc:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        zh.chen@mediatek.com, mars.cheng@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 9:07 PM <sean.wang@mediatek.com> wrote:

> From: ZH Chen <zh.chen@mediatek.com>
>
> Add MT6765 pinctrl driver based on MediaTek pinctrl-paris core.
>
> Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
> Signed-off-by: ZH Chen <zh.chen@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

Patch applied.

Yours,
Linus Walleij
