Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6266FC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 20:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2759320779
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 20:07:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBL6cryp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2759320779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbeI2Cck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 22:32:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:51340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726451AbeI2Cck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 22:32:40 -0400
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9241720779;
        Fri, 28 Sep 2018 20:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538165239;
        bh=8ceWlt+FzbQiWADpwWjP3zubqEZymXgsNtv1I1R9vaU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MBL6cryp9Z6vYLJzamJ7TYaHFv4gyUJsPhqAzz0tvNjjePtrhydwp8gxrW3ZoMyJc
         cmHvEJJ1vMLpk75YkqS0mBNL2TbAIzfrC0RVzdyXs66txLQUHvtQau2u035pg0UkjR
         aDepIXyGpQMFgUXbwEt/xE572HWBCsnGWkErytMU=
Received: by mail-qt1-f179.google.com with SMTP id c56-v6so3113021qtd.11;
        Fri, 28 Sep 2018 13:07:19 -0700 (PDT)
X-Gm-Message-State: ABuFfogvTBFGxujOfasuWuQiyhc0X5dghlFIaK+esGtdT0GGqCWAaGaP
        6dQEosMlILsZLxsvn+qOL4OHgFTqsg2v/2I8Tg==
X-Google-Smtp-Source: ACcGV615ydwOQE5KHku0hZnk45wbAeEPDYPi3wviHcgcLf7nZZu4M38GrG5PEHmoyjmRuIYwMfCqKg7tCHrAf/j/HAs=
X-Received: by 2002:ac8:46d3:: with SMTP id h19-v6mr170261qto.188.1538165238817;
 Fri, 28 Sep 2018 13:07:18 -0700 (PDT)
MIME-Version: 1.0
References: <CADRPPNT0QiBkJtJnxjW95Yf-mirL5OzRrvqj8rC-O8fiz17VnA@mail.gmail.com>
In-Reply-To: <CADRPPNT0QiBkJtJnxjW95Yf-mirL5OzRrvqj8rC-O8fiz17VnA@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 28 Sep 2018 15:07:05 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKRH8uEzSx6H6ZSRJF9Ecp4am1cNsxgQqf2OO5_aGR1zw@mail.gmail.com>
Message-ID: <CAL_JsqKRH8uEzSx6H6ZSRJF9Ecp4am1cNsxgQqf2OO5_aGR1zw@mail.gmail.com>
Subject: Re: drivers binding to device node with multiple compatible strings
To:     Yang-Leo Li <leoyang.li@nxp.com>
Cc:     Grant Likely <grant.likely@secretlab.ca>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Frank Rowand <frowand.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 5:25 PM Li Yang <leoyang.li@nxp.com> wrote:
>
> Hi Rob and Grant,
>
> Various device tree specs are recommending to include all the
> potential compatible strings in the device node, with the order from
> most specific to most general.  But it looks like Linux kernel doesn't
> provide a way to bind the device to the most specific driver, however,
> the first registered compatible driver will be bound.
>
> As more and more generic drivers are added to the Linux kernel, they
> are competing with the more specific vendor drivers and causes problem
> when both are built into the kernel.  I'm wondering if there is a
> generic solution (or in plan) to make the most specific driver bound
> to the device.   Or we have to disable the more general driver or
> remove the more general compatible string from the device tree?

It's been a known limitation for a long time. However, in practice it
doesn't seem to be a common problem. Perhaps folks just remove the
less specific compatible from their DT (though that's not ideal). For
most modern bindings, there's so many other resources beyond
compatible (clocks, resets, pinctrl, etc.) that there are few generic
drivers that can work.

I guess if we want to fix this, we'd need to have weighted matching in
the driver core and unbind drivers when we get a better match. Though
it could get messy if the better driver probe fails. Then we've got to
rebind to the original driver.

Do you have a specific case where you hit this?

Rob
