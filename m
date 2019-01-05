Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC1C2C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 04:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7F6D20868
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 04:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Oy21tj0Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbfAEE3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 23:29:02 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54792 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbfAEE3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 23:29:02 -0500
Received: by mail-wm1-f65.google.com with SMTP id a62so2747059wmh.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 20:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SZSPuh0GXoAKyYjln7SJ7jKQMpi8XwwTaPAt7OPwCjc=;
        b=Oy21tj0QQqmmGz7i2/XrD2TeUMqgmQrkK5jy50yVnBDdaNDQ4WOxYS9YI4jb6B2cUM
         qUZ8XpbC/7RjbKdIc3RRGCCQnUjupiyogCyQ9DhdRSMyTlZapSmfRabA4ifv7ofpnoqm
         bjp9y4bcHOOH+TjYIO00SL6Yn13bD/nyVKXWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SZSPuh0GXoAKyYjln7SJ7jKQMpi8XwwTaPAt7OPwCjc=;
        b=UPK7SQBMvfdG8Ty7IZq5Cdbbcc+rt8jGNx3sSGFTgWLkWkTxhxdGSST9sIoXZavwUw
         6GKAaVlQHbc/+zcIN+BJxptEgPikwRvaArV7zlCaX4xNNc8LbcgkekknlGHCSn3muUKD
         q+H5RhxRw4myjjAeMrhMcpftvbeic1EKR/MiE6fdm1i+U5pr75I5tglyBO4fxQ9V13mx
         uHym9bBrMwCFp9LaFbt/f/m6yK1l9HQmLzqOo/9WytnBdmAcn8P5XchUsgNKy9YnxU9l
         3UTNrccD1gIM04M7RqSMWiZ3P+UI01nTP2fSChKV1kKONQGuWtp1qFAuGaDp9Dmr6WCX
         cSDA==
X-Gm-Message-State: AJcUuke1gP22fht1x3DktyolD4EZGNUCsoT2DSaDbNeS5fb4eFAeztaI
        nIWxiye9cAv5dY3fZuK+BArCb06PhSbY6QaphHmP8w==
X-Google-Smtp-Source: ALg8bN5quKAQpWOq4LNucC+H/1bH9zn7q5I8ge8a/LwB6gqregrDQL7e4yeizLVpqht9G177mObTS0vgm47WVYjo/no=
X-Received: by 2002:a1c:e088:: with SMTP id x130mr2867040wmg.23.1546662541221;
 Fri, 04 Jan 2019 20:29:01 -0800 (PST)
MIME-Version: 1.0
References: <1546635388-13795-1-git-send-email-john.stultz@linaro.org> <20190105033738.GA2477@Mani-XPS-13-9360>
In-Reply-To: <20190105033738.GA2477@Mani-XPS-13-9360>
From:   John Stultz <john.stultz@linaro.org>
Date:   Fri, 4 Jan 2019 20:28:48 -0800
Message-ID: <CALAqxLUkLExkYUY+JARcp6znngFiRnXO8dYF9qWEZNmBPtdDpw@mail.gmail.com>
Subject: Re: [PATCH 0/8 v2] k3dma patches to add support for hi3660/HiKey960
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Tanglei Han <hantanglei@huawei.com>,
        Zhuangluan Su <suzhuangluan@hisilicon.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>, Wei Xu <xuwei5@hisilicon.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Guodong Xu <guodong.xu@linaro.org>,
        Ryan Grachek <ryan@edited.us>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, dmaengine@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 4, 2019 at 7:37 PM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> Hi John,
>
> On Fri, Jan 04, 2019 at 12:56:20PM -0800, John Stultz wrote:
> > This patch series is based on recent work by Tanglei Han, and
> > adds support for hi3660 SoCs as found on the HiKey960 board,
>
> Not sure about the description/subject here! This patchset adds support
> for ASP DMAC found in HI3660 SoCs, Peripheral DMAC is already supported.
>

So yes, it does enable ASP DMAC support, but the full set also enables
the Peripheral DMAC as well in a few ways:
* Avoiding setting the AXI register, which is configured differently on hi3660.
* By adding support for the dma-avail-chan (so we don't try to use
reserved channels)

thanks
-john
