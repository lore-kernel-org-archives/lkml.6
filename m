Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C1AC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 06:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FCEC2473D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 06:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="KEJb9VOp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FCEC2473D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933059AbeGDG7N (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 02:59:13 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:51428 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753288AbeGDG7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 02:59:11 -0400
Received: by mail-it0-f44.google.com with SMTP id o5-v6so6451487itc.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 23:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZGeG7m+D9lfbx7I3GfDeaLHS3b6Lzk651r2DvAdJsLc=;
        b=KEJb9VOpt2Vu5njy/H1hIXX22QQwoIL61dIJzRj8bdyRSuqPzCQYUZMA4G04qL3+BI
         JTwMSK5nAmKNnNOU5AmQ7qEPiC+9j3jTs0X4aKOjikPsRrFznzptNAcrLEbEZH/pv2k3
         Mxwo6NV3c8IdHzUMii1hY6UviDSneGMSl2XJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZGeG7m+D9lfbx7I3GfDeaLHS3b6Lzk651r2DvAdJsLc=;
        b=ZTBrwJRRpJRR7C8D4GzVflyScBNxePWmPZcW0x/xOBrmRVsGzjuiMbMaAYXGm+jyNw
         LDgHuxHNcTamR2/den12WE06+NBDvZ7tf3hjnXn8IEA5ykImTCVcs9AS6REF1yS8hmrx
         tTc9AxCxIsiSRdm0bLfbKNh+TGRcLLK4Pz/dzMYD/P4LSX/lSX9GhmvETb3L0KRBglTc
         nQfMyJ8+DjZI7GV3aubaxos3ddWuXS4D+s6+UUTEWqjzXd5Ybaa7UBLg41Ltp6kOnEeA
         P+tfDsERKdjUnRo3ZNcdgkcHxUh9HCMj8UrkzqlZN13uWooaYagAxMqRBJTA10fz6c5p
         2Dmw==
X-Gm-Message-State: APt69E0RxDtddUQyKB36z7fjaAV9RYvlvt2uJGdI8hqa3PKrCcM5cbHR
        fiCtAmN86aBSn/00vMrWFwghO/Li4Rh4ldwzJE3xBA==
X-Google-Smtp-Source: AAOMgpc5vE96AObPhq4ShtcfHDxNgbZIJBTk55rag/77Dx15/9Ir1xyxXbe7FhZTuraoKCiwKR40dJgxpdX8udxeYJA=
X-Received: by 2002:a24:d80a:: with SMTP id b10-v6mr823378itg.141.1530687550890;
 Tue, 03 Jul 2018 23:59:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:a785:0:0:0:0:0 with HTTP; Tue, 3 Jul 2018 23:59:10 -0700 (PDT)
In-Reply-To: <588A2275-4D45-442D-8B38-7A17C27BED10@gmail.com>
References: <CAMty3ZAMjCKv1BtLnobRZUzp=9Xu1gY5+R3Zi-JuobAJZQrXxg@mail.gmail.com>
 <20180531190659.xdp4q2cjro33aihq@pengutronix.de> <CAMty3ZCeR3uEx8oy18-Ur7ma7pciKUf_myDk6_SpWvxc6DvygQ@mail.gmail.com>
 <CAOMZO5AOpOSAx=L4tOU1Na6hm8Tex3PHNxCYDB81C0+NPHzTZQ@mail.gmail.com>
 <20180703184117.GC5611@w540> <CAMty3ZCWztkM2oEaKQRVmMkA0C1V6b9Oj59DBX9XAWAybZbRAw@mail.gmail.com>
 <588A2275-4D45-442D-8B38-7A17C27BED10@gmail.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Wed, 4 Jul 2018 12:29:10 +0530
Message-ID: <CAMty3ZAkSTO-GXK7tjMMY6fjWV=R_mvT_Qe=wO5iJy5NvLwBEw@mail.gmail.com>
Subject: Re: i.MX6 MIPI-CSI2 OV5640 Camera testing on Mainline Linux
To:     Discussion of the development of and with GStreamer 
        <gstreamer-devel@lists.freedesktop.org>
Cc:     jacopo mondi <jacopo@jmondi.org>,
        Steve Longerbeam <steve_longerbeam@mentor.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Philipp Zabel <pza@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        linux-media <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 4, 2018 at 12:14 PM, chain256 <tonu.jaansoo@gmail.com> wrote:
> Hi!
>
> Just to let you know, I have same sensor working on Variscite iMX6 DART.
> Using Yocto Morty release (
> http://variwiki.com/index.php?title=VAR-SOM-MX6_Yocto&release=RELEASE_MORTY_V1.0_VAR-SOM-MX6
> )
> Had to hack device tree abit and that was about it. Hope you find something
> useful on that page.

Thanks for the link. Can you confirm is your sensor working with
Mainline? we are trying to verify mainline ov5640 sensor here.
