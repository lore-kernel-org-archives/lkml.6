Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8277ECDFBB
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 00:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E2192084E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 00:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9UrPirI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E2192084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730638AbeGSBbt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 21:31:49 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:45150 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727635AbeGSBbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 21:31:48 -0400
Received: by mail-io0-f194.google.com with SMTP id l25-v6so5665663ioh.12;
        Wed, 18 Jul 2018 17:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v/2Wwv/MbOlH5ssrzTcUNkQ57Cjb/sOUs9Z+/rj9tOg=;
        b=b9UrPirIMaDZufJlkkvOHm1LVyC8HPC1xXxc374ivTm9nCWfIV/3TYhx6WnYtPw9NJ
         m0awGELeqifBSdjdxP0binEvh47G52gf1aIIFaOxNm8qztFoH3wBc5zZUZ1CxBL8BZiy
         8tiTl2qp/VFjxg3DgHIuwlslNTKfm4PZf1s5q0Unym8Xn21enysX/f12Yj7tctqcGNYQ
         OJBM6sOapq99JwqFmIjXfpvLsw3Dw5H3EVwGb9Cd24iGcALD1+8qJwaMdO7jF5Jj0imT
         Fi6gcBjybFivPvRHcX2KW6bnnmp7YLqq6pL2hynlx5w75gNVqi80srPKlKqPmdTYcLCI
         3ToA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v/2Wwv/MbOlH5ssrzTcUNkQ57Cjb/sOUs9Z+/rj9tOg=;
        b=CNgvKw8Wqg6Ov2SsF0RvONTPrIva6V901TA1JMmgw5uw+e1Wx1hXLsBNO8VgLlxfZ3
         4mRxUvaVPBQ+87lKkLEemzUUsErg2Fldn9IVXuWMqu8XdX3RGiCxpzT9EyOWkzbfALIQ
         jauaywXk+D2yYBI/JxmGD3gd/L0Pu7ltxc9WrgSt9TxFElIJL9o0EJJ8IH6g3MfynuZI
         L6/ZI8dpqxG3+S7+ZuKsY63TLjK+aezT0qQDcza1JpI3ENIElgwCaGwM7HRS1HLtNBkL
         gmUFgngLkriXC71DdDX70i6HtaAN38NvkpfoWtlrMvpyMxj18cMb44LdfiPBQQQUr7Aq
         GAmw==
X-Gm-Message-State: AOUpUlH2KW/10kBnZMRqIc1X3yG8+0GH6JPREh3uYsFH+Hfyr+2LFZSk
        +Zo90eIck4aA1vAyPy0LUB5F4sC+T+I8ia2dyXo=
X-Google-Smtp-Source: AAOMgpc9wnqacwQk1j0d+3vhDYq+wUrsiM+jw9w2YRUnraIroX42DCvlq0dUbGML2fY0ukWa0U1MLmPlcyqyZmx+xas=
X-Received: by 2002:a6b:d812:: with SMTP id y18-v6mr6546696iob.141.1531961479939;
 Wed, 18 Jul 2018 17:51:19 -0700 (PDT)
MIME-Version: 1.0
References: <20180717040651.641-1-andrew.smirnov@gmail.com> <CAOMZO5Dp5aTZF0drkD+QSRyX6qGxAe0yeYGUS8-v=FtJwA7=SA@mail.gmail.com>
In-Reply-To: <CAOMZO5Dp5aTZF0drkD+QSRyX6qGxAe0yeYGUS8-v=FtJwA7=SA@mail.gmail.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Wed, 18 Jul 2018 17:51:08 -0700
Message-ID: <CAHQ1cqG+-7sxJjqs86HG3iOdqDWNQZRpTDTev8XYi2jH=BVFOg@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: vf610: Add ZII SSMB SPU3 board
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Chris Healy <cphealy@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 3:50 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Andrey,
>
> On Tue, Jul 17, 2018 at 1:06 AM, Andrey Smirnov
> <andrew.smirnov@gmail.com> wrote:
>
> > +/dts-v1/;
> > +#include "vf610.dtsi"
> > +
> > +/ {
> > +       model = "ZII VF610 SSMB SPU3 Board";
> > +       compatible = "zii,vf610spu3", "zii,vf610dev", "fsl,vf610";
>
> Looks good to me.
>
> Just a minor comment: Is " "zii,vf610dev" really needed here?
>

It's not used in Linux, but I do rely on it in Barebox here:

https://git.pengutronix.de/cgit/barebox/tree/arch/arm/boards/zii-vf610-dev/board.c#n94

and here:

https://git.pengutronix.de/cgit/barebox/tree/arch/arm/boards/zii-vf610-dev/board.c#n137

so it's pretty handy to have. I can remove it if it is too much of an eyesore.

Thanks,
Andrey Smirnov
