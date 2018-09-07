Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB4BC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 15:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1866920844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 15:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ytdAaPpv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1866920844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729121AbeIGTyr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 15:54:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:36908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728410AbeIGTyr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 15:54:47 -0400
Received: from mail-qt0-f178.google.com (mail-qt0-f178.google.com [209.85.216.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 834622086B;
        Fri,  7 Sep 2018 15:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536333205;
        bh=KxK4VCSI3zM/O34qZJ2v/XgZesy+XhMQf8/CdH+QrkI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ytdAaPpvk4IStHGCkg6/HEMN6aFi/hhu8+8xAKrReO7S/xWAAMevY9LYsMsJ0veCq
         zMo5eUuzzGD2RP0hBMtsMQtViDpJzEwRVHECf6OqKErkvVLCcC7Ec7bk/d7pVlYXKY
         2l03yLTkb5pl5bwmlwLa4AcuV9oR5bq4ZLUkUWys=
Received: by mail-qt0-f178.google.com with SMTP id x7-v6so16562552qtk.5;
        Fri, 07 Sep 2018 08:13:25 -0700 (PDT)
X-Gm-Message-State: APzg51CPHjunoe7QlN56Thxb/cuXKi/1wG7qUGUDgig/F6N2uGXeHlu8
        TJobEc4WGULSnnheL9d6ldrbEzPKKC416n+bBg==
X-Google-Smtp-Source: ANB0VdYYftR8aF7xjFZjnfR5nX6A0eBmpRuLDMrBj02BsFxjLXeu/q2N8V5rmrssS/CDCcFxoQbMrITDVkEqOecGsas=
X-Received: by 2002:a0c:d5d3:: with SMTP id h19-v6mr6215602qvi.218.1536333204715;
 Fri, 07 Sep 2018 08:13:24 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1536138304.git.ren_guo@c-sky.com> <62dae1828ade759584bbf1507fe4a9e69d247a50.1536138304.git.ren_guo@c-sky.com>
 <CABGGiswB5OUU7JDP+-s3s8ONkXZY2AAvSijQedsNtZ6p8LqZeA@mail.gmail.com>
 <20180906021254.GC29405@guoren-Inspiron-7460> <CAK8P3a3h4KxkvAXZV+=7T6vdiQdOd0quos9BUtX-E=Q2H_0rfA@mail.gmail.com>
In-Reply-To: <CAK8P3a3h4KxkvAXZV+=7T6vdiQdOd0quos9BUtX-E=Q2H_0rfA@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 7 Sep 2018 10:13:13 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLhLdoGO=WNHZ0aRxXD4dqZhXHxB7Y1q651ABXi_kOXEQ@mail.gmail.com>
Message-ID: <CAL_JsqLhLdoGO=WNHZ0aRxXD4dqZhXHxB7Y1q651ABXi_kOXEQ@mail.gmail.com>
Subject: Re: [PATCH V3 21/26] dt-bindings: interrupt-controller: C-SKY APB intc
To:     Arnd Bergmann <arnd@arndb.de>, ren_guo@c-sky.com
Cc:     "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        wbx@uclibc-ng.org, Greentime Hu <green.hu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 6, 2018 at 8:05 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Sep 6, 2018 at 4:13 AM Guo Ren <ren_guo@c-sky.com> wrote:
> >
> > On Wed, Sep 05, 2018 at 07:43:10PM -0500, Rob Herring wrote:
> > > On Wed, Sep 5, 2018 at 7:10 AM Guo Ren <ren_guo@c-sky.com> wrote:
> > > >
> > > > Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> > > > +
> > > > +       intc: interrupt-controller {
> > >
> > > Needs a unit-address.
> > Ok, change it to:
> >             intc: interrupt-controller@0x00500000 {
>
> The unit address has no leading 0x or leading zeroes, so
> interrupt-controller@500000

Please build your dts files with W=12 and it will tell you this and
other errors. And then update any examples based on that.

Rob
