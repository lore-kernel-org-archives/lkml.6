Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292E9C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 07:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C64942084A
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 07:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="mecH6lYo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C64942084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbeKAQO6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 12:14:58 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:50871 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727573AbeKAQO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 12:14:57 -0400
Received: by mail-it1-f194.google.com with SMTP id k206-v6so852655ite.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 00:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CfajSEk2XC2ZRHx/6xYFW6S3bju4FLuRiQBGRNohddM=;
        b=mecH6lYowLWX213hhsKc+uO5LuNusq9bUxgI6kjBmKxJTot29rrCB+FVHfbu7ig6H9
         t6fqDgr6F44U6FLFLqmMFBKLrG8WiGLpCv8AZjjPlCG849BV2UkDmQwosXe5cONRyuVK
         4qzdbsqX0qqBvDL0Exvn1PbjJsAE3iTfv/MpU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CfajSEk2XC2ZRHx/6xYFW6S3bju4FLuRiQBGRNohddM=;
        b=Os/CS31AO91NeBNgmTG4A31N7qyZ/gAzDxbPiZYWa926OPXoNCv1YlPjD05qDhzUMy
         35kgrTwqPnfQu4j2TwHsjb6l3/SihDZ3gGcdMZ+iTh6PdvWj2P0K4WEeNpkLOw+KDkEQ
         3Vp3V4O/rz0UZmkwWZJ86nwcWzXAoojQ4JkpjeSbUSdokXbZwjgn39tAU2xFQJkhAsoo
         TOmNGh2m4bzddshCWTgjmhaINbKg2CO5lBhkXtALACYTBN10mLqoUIy7xvIqAv6aY1pb
         mBqHnCm0vX+stUspKI5YATgq0MhaTpjb7VziJJA30ESh22zbHCgniBkSaB4534rg59q9
         MwYA==
X-Gm-Message-State: AGRZ1gJyzj7Z2SlqqYx7PdELa/RSmrFiTJ8reJNf3E9WeAX8QgjV3Pbj
        tKZkbMkcnKBci3DAhMx8EP8sGvAtwKBtYR9Op4Kobg==
X-Google-Smtp-Source: AJdET5fr9iE/Fv+KgUcwQ1Wn48VNN+XAWGpUT6mT8pz6U/5EqNyQWOELjTH3hwmxM3uUWTybVv1Cdb0VCteqAhtg+bc=
X-Received: by 2002:a24:d0c2:: with SMTP id m185-v6mr4643411itg.173.1541056392888;
 Thu, 01 Nov 2018 00:13:12 -0700 (PDT)
MIME-Version: 1.0
References: <20181031183634.29640-1-jagan@amarulasolutions.com>
 <20181031183634.29640-2-jagan@amarulasolutions.com> <CAGb2v66ALW1EL5+buporX8cPjkfpNdwGJEVUrC9Xpcmt3-NX7g@mail.gmail.com>
In-Reply-To: <CAGb2v66ALW1EL5+buporX8cPjkfpNdwGJEVUrC9Xpcmt3-NX7g@mail.gmail.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Thu, 1 Nov 2018 12:43:01 +0530
Message-ID: <CAMty3ZCv9z=uALo-PShS-RegNt2cOwOHWE=6vsRVgPm9oOQ_Fw@mail.gmail.com>
Subject: Re: [PATCH 2/7] arm64: allwinner: h6: Add common orangepi nodes into dtsi
To:     Chen-Yu Tsai <wens@csie.org>, zhaoyifan <zhao_steven@263.net>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 1, 2018 at 8:23 AM Chen-Yu Tsai <wens@csie.org> wrote:
>
> On Thu, Nov 1, 2018 at 2:37 AM Jagan Teki <jagan@amarulasolutions.com> wrote:
> >
> > Orangepi H6 boards, One Plus and Lite2 shares common
> > nodes like axp805, uart, mmc0 etc and the common differences
> > between them is Ethernet is available in One Plus where
> > as Wifi, USB3, CSI port is available in Lite2.
>
> You can claim this for pretty much all Allwinner boards, because they mostly
> derive from the reference designs Allwinner's design houses put out. Yet we
> don't do this for all of them. We do this for boards that are clearly derived
> or extended from one another. One example would be the Orange Pi PC and PC Plus.
>
> Do you have any evidence to suggest so? This is not about common device nodes,
> but a common hardware design.

I got this information from hardware schematics and from Steven (added
in to list), he too claimed the same.
