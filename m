Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD611C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 12:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47B0C20659
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 12:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PlrR8YzH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47B0C20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbeIDRFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 13:05:53 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:36516 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727359AbeIDRFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 13:05:53 -0400
Received: by mail-io0-f193.google.com with SMTP id q5-v6so2816016iop.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 05:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ah054tHw4QcniAqJR6mhIELK4+aYkYgFnKE5xNouZvM=;
        b=PlrR8YzHTsuw04hkiO0NfcdJbSuBsdumw7YOcto1Binc4vUZ+zVzPYpIqDh+q64BA6
         d6BrjZkMv1RiQHz6ru5Iq30tw6Z7F3aYxFH2pfY6xmFQFqWCxtteFjmJmicRWimgCAz+
         icDseplvGG2L8G2Efdyp8QmMAotmhyN+SYkNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ah054tHw4QcniAqJR6mhIELK4+aYkYgFnKE5xNouZvM=;
        b=Knj7sgjTmcPTHnEw5Ki5lClghj30degWwyfmx6sG/NnTNlEvR52qzDgUTnibZjU+Rp
         GN7aC5jAzZRQEC4u0/mmFpgL4F4P+ld4RxORTXW19X4I8Za2Q/7F3OLAhOPHsJhEwOke
         i4mLGWEI8gkYG/ze9qQ+oF38/Aju/GTLAJHIomOedXVMzPOH0oQ7PpjNHvmSGhLMVfU2
         /thJsNitiR5r7GsFAxesIn4OfuJXyJFphE3Zs+X4E9RgWaKgxzl5xQafmp7bWRQ5NkYv
         TS3vi0rHS7rPop0aDkpVHjZAekFacDQd2qdOXCuYp+LWTWFQcxGIJCbTPMRGEllhgL5W
         M4SA==
X-Gm-Message-State: APzg51DsAEATUasCIPqLDB2H7ShmxYlzCEFYP2DxKzdvzr6eagZ2wQx4
        wdbge5dC+WCXHM89/R/MP0ArxYImvyZuXL0zon4Rig==
X-Google-Smtp-Source: ANB0VdYBVFyoKGEmLU0a0xWFZ4FBXFiVj5QJbM0yWb0+bx5gCc9+Av+Pz0HkfLtriq8SJe6oQDITBECN7PVXqJVQQe4=
X-Received: by 2002:a6b:93c3:: with SMTP id v186-v6mr21915559iod.148.1536064854597;
 Tue, 04 Sep 2018 05:40:54 -0700 (PDT)
MIME-Version: 1.0
References: <20180904094922.8131-1-linus.walleij@linaro.org> <20180904121503.GF13888@piout.net>
In-Reply-To: <20180904121503.GF13888@piout.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 4 Sep 2018 14:40:41 +0200
Message-ID: <CACRpkdbd=SQPF0Vi2HP9uAwA27M8a5dZO-r31D5=3j5sjGh+qg@mail.gmail.com>
Subject: Re: [PATCH] spi: Delete Atmel AT91 SPI driver
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Haavard Skinnemoen <hskinnemoen@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 4, 2018 at 2:15 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
> On 04/09/2018 11:49:22+0200, Linus Walleij wrote:
>
> > This driver depends on the deleted AT91 architecture and cause
> > me headaches from a GPIO point of view. It is unused so delete
> > it.
> >
>
> While AVR32 is gone, AT91 is alive and well.

Gnah sorry guys that's the problem, I mixed up AVR32 and AT91.

Sorry for the screwup :(

OK back to the drawing board, I will work slowly and careful
and try not to do silly mistakes like this.

Yours,
Linus Walleij
