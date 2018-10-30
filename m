Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91750C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50C0320823
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ngqvoVqC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50C0320823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbeJ3XyU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 19:54:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:39900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726721AbeJ3XyT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 19:54:19 -0400
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD1F62080A
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 15:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540911631;
        bh=Hc+hlHS3aRqyDEd1NfDRRTBYE0yYIaFyC57wsxwYOpI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ngqvoVqCSBhB+J5HbBcWWUBK++pQ7yhgMHjacsF9SHSWm98yElwMezH2HEbqNrvIN
         xsAj1QZtfMb2l2gNhvuMSHa0mzuHKvm6k3Sj89o/SFRldzQFjp7QphU8jP5/XtXsaT
         UMgj5jzxAphg3mWcQOTkBMB1FnD9hjPynN6ToN6M=
Received: by mail-wm1-f50.google.com with SMTP id q12-v6so8938664wmq.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 08:00:30 -0700 (PDT)
X-Gm-Message-State: AGRZ1gJ6rYa1itpYkvQB4+2qLAPoBU1zrEZoIq1jCZdlApPSchmefN46
        fjQFMWfu1SMfRG843KG1wOdO8O2LQiUvlX9r01oXyw==
X-Google-Smtp-Source: AJdET5eADw3llxB/QBHgPe0GjVPIR6TXmPb0lrHJDbFObJY6D6ehsaXkO7rrxhzxm2c5cV7NAU0kXA4F9DCdZ77Dv7M=
X-Received: by 2002:a1c:b20b:: with SMTP id b11-v6mr2081584wmf.64.1540911629267;
 Tue, 30 Oct 2018 08:00:29 -0700 (PDT)
MIME-Version: 1.0
References: <20180905193738.19325-1-robh@kernel.org> <20180905193738.19325-2-robh@kernel.org>
 <874ld3jz6v.fsf@concordia.ellerman.id.au> <871s87jz3g.fsf@concordia.ellerman.id.au>
In-Reply-To: <871s87jz3g.fsf@concordia.ellerman.id.au>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 30 Oct 2018 10:00:17 -0500
X-Gmail-Original-Message-ID: <CABGGisw_bd+bJedZ_T2e-dxmRnXf2N_gGBZj8u+QVGQxj_gc+Q@mail.gmail.com>
Message-ID: <CABGGisw_bd+bJedZ_T2e-dxmRnXf2N_gGBZj8u+QVGQxj_gc+Q@mail.gmail.com>
Subject: Re: [PATCH 01/21] of: Add cpu node iterator for_each_of_cpu_node()
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        Frank Rowand <frowand.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 9:20 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Michael Ellerman <mpe@ellerman.id.au> writes:
> > Hi Rob,
> >
> > Sorry I missed this when you posted it.
> >
> > Rob Herring <robh@kernel.org> writes:
> >> Iterating thru cpu nodes is a common pattern. Create a common iterator
> >> which can find child nodes either by node name or device_type == cpu.
> >> Using the former will allow for eventually dropping device_type
> >> properties which are deprecated for FDT.
> >
> > Device trees we see on powerpc generally don't (never?) use "cpu" as the
> > node name for CPU nodes. And many of those device trees come from
> > firmware, so we can't update them.
> >
> > So dropping support for device_type is a non-starter from our POV.
>
> ps. presumably that's what you meant by deprecated *for FDT*.

Right.

> But anyway just wanted to make sure we are on the same page.

Yes, I was aware at least older powerpc DTs don't use 'cpu' for node names.

Rob
