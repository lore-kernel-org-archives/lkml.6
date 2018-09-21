Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ADF0C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43F9A21550
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="S66BSCJF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43F9A21550
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390579AbeIUWCV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 18:02:21 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:41731 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388909AbeIUWCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 18:02:20 -0400
Received: by mail-io1-f68.google.com with SMTP id q4-v6so12791156iob.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 09:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IXBAE3LfY8w7vw6fWZEYsSQCjgE5e6CTi8NlHeEy/is=;
        b=S66BSCJFLhSzW+0656vLR6rKQIWNmcj3CdS8Hil1/yd/XY7oxeJNyTZLDSBQToHCi4
         6jrAdQlxw9m4mCnJ9pKw/aHxm2vBASY7raB4F816PGAXqvtydXaLh3n/9WNtXpIVXt0J
         Gobns87NRcjwFhLtUYhilwvP9xi7SAvz0F+rc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IXBAE3LfY8w7vw6fWZEYsSQCjgE5e6CTi8NlHeEy/is=;
        b=f8bRDur4WWrBgOL3QxuOgif+v0mX9BtgPWcxvFLzMAjwYmwS+99uzp4J0Uv4ZgEXjO
         TJmu7Zi6z4frH7VD90CItEaUR1/W0kVOl1E2EP5TinSeD7pX1tHBK5gsljCDkyPq7KIf
         UJl7tj6IQvEca5wF8iaJ4ib3Nz9gDCJgGLp1PB9YOLI88fVv4fLMN3eGlvKUzV0Nyvsj
         6eUsgOYasrNEBzE6PRXL/8Zx4ceESHfvENLNnqaiIrZ1waTyn/gmBFgSv9pN5s7IjRPQ
         BqJ/jLE9d8D8jm5qHfpAqi8FzCWAwhqMFjSXtXhiQkeibs13VHHXCv07iTR6O+aGKKrH
         yGsA==
X-Gm-Message-State: APzg51Dp9wDaoACx9TBVGUtiD9xWLQvOWCf9xFkDaJAIpNoPUWXKtANR
        PFh1m8PFzi9orNbF48IxjQeCvDqipy6IARCHjzRxIA==
X-Google-Smtp-Source: ANB0Vdb0AUahCCfUu3TrpyeQBUBJ/qd3kjOHilhRi3i61ujUqkNNoo587hB1KAyxpphwZw+HOoIj/Xvs7ttm1OuhiOo=
X-Received: by 2002:a6b:4006:: with SMTP id k6-v6mr24974687ioa.277.1537546366584;
 Fri, 21 Sep 2018 09:12:46 -0700 (PDT)
MIME-Version: 1.0
References: <ab85fbee4d8286cbedbcc7317f89dc0d2dd83965.1537502494.git.sean.wang@mediatek.com>
 <554196e837f622eea62d11602b7c88721d6a776d.1537502494.git.sean.wang@mediatek.com>
In-Reply-To: <554196e837f622eea62d11602b7c88721d6a776d.1537502494.git.sean.wang@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 21 Sep 2018 09:12:34 -0700
Message-ID: <CACRpkdZoH5zTF2Vt9TbCiB68e0npgOCDVE00fNgFNgUwZ6Bi3Q@mail.gmail.com>
Subject: Re: [PATCH 2/4] pinctrl: mediatek: add no eint function for pin define
To:     Sean Wang <sean.wang@mediatek.com>
Cc:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        mars.cheng@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 9:07 PM <sean.wang@mediatek.com> wrote:

> From: Mars Cheng <mars.cheng@mediatek.com>
>
> Add NO_EINT_SUPPORT back to pinctrl-mtk-common-v2.h as the alias of
> EINT_NA to indicate that some pin not capable of being controlled as eint
> and that is required by pinctrl-paris based driver as old
> pinctrl-mtk-common.h already had.
>
> Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

Patch applied.

Yours,
Linus Walleij
