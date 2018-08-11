Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5629FC46460
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 09:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A907219F2
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 09:44:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7QBIAOh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A907219F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbeHKMRn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 08:17:43 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:45204 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727249AbeHKMRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 08:17:42 -0400
Received: by mail-ua1-f67.google.com with SMTP id k8-v6so4458897uaq.12;
        Sat, 11 Aug 2018 02:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kucbI/XCgpOV25EQPWP0n0Z320dKe7cS61LzTYJLcw0=;
        b=a7QBIAOh0eJLuFehsnz3AKFA1meYfrpoT7kDD1XdnxkT35QreWcXzGrWXXQEUjQu36
         6ZhuhZ268eDua9TPsIWrk2Bdmf5pg2X3K7ovcU1/7taWxGpe0ESAnVU/N7T5r6UEsEae
         jyWxDFMnKf7ZxOVkf9gKiYst7Iz/qD/lYhp8sTm7f+4qGModhVFICbo4yLmSGkv99mRb
         mUiaky+ljr4nIYOf1IX+JWFnEnP5uwG5/95LmSjpVk3uYNco27dV0Cxcr4ITn9Uw6JaT
         D2m6BW9gCrsHVTLbCmu8TMhGfK4/RuBp1lIoOyAt3Ejyk4tTx8304kK2g8FJbBpirJaC
         sX3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kucbI/XCgpOV25EQPWP0n0Z320dKe7cS61LzTYJLcw0=;
        b=RNX2431opiKDUcpMGo3rSeou9jeUThECczkqozokkmtBfkugUdgMHroCoXPQp6a8JR
         JeDIk7lVUVGPkPOHZnBqOTk8W+cXbDejZrREtgV/nCTkRwDZ3HP8t99LY4L683JfJ1u4
         wH2FzidFC/Ho1qGDTE3cC8QwB+qN0i2aU1dO6/SwqegsvtUFoJG2KRy65B9A6nVJl8Lf
         J4rH229xu72X3ycFoeVvHPlIkCrUXYjNznv9xsSumnN4zjMq9NPWcmb995NiqIg2C39v
         u3BekauYZAlz9QsNdlfbXe4Omkc4rNr8QKnYgVqRlFdsOOKKJUPDJNa1d3yOZDEqn7de
         h97w==
X-Gm-Message-State: AOUpUlGDb5WmVTA/vt/p5NAnRnSgUcaD1r6Kq7kPruSh593ei8v9fKlH
        8OfM89hyjZtzA8Gm+Q05miicN0mCT95RLMSOvAw=
X-Google-Smtp-Source: AA+uWPwgCNL3c3PJG2b+bb/yE5KA2ImvzakuCbWXseKyYrCGg6VxABh7mZMxmziAH8TG0ZWT/0Qoz8ESJFOCVd8PqE0=
X-Received: by 2002:ab0:4025:: with SMTP id h34-v6mr6620435uad.12.1533980643188;
 Sat, 11 Aug 2018 02:44:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Sat, 11 Aug 2018 02:44:02
 -0700 (PDT)
In-Reply-To: <3a9ece34-baad-a19d-c3bd-96aa458ea70b@gmail.com>
References: <20180506080250.GA24114@amd> <20180716090814.GA4505@amd> <3a9ece34-baad-a19d-c3bd-96aa458ea70b@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 11 Aug 2018 12:44:02 +0300
Message-ID: <CAHp75Vf4PZW8A+uj8V5uL2LkTSzSogQDcR8JTqVh4jzVecgtRQ@mail.gmail.com>
Subject: Re: [PATCH v2] media: i2c: lm3560: use conservative defaults
To:     Daniel Jeong <gshark.jeong@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Sebastian Reichel <sre@kernel.org>, nekit1000@gmail.com,
        mpartap@gmx.net, merlijn@wizzup.org,
        Mauro Carvalho Chehab <m.chehab@samsung.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 11, 2018 at 9:10 AM, Daniel Jeong <gshark.jeong@gmail.com> wrote:
> Hi Pavel,
>
> I think if there is not exist pdata, it should be set to the value of power
> on reset (POR) to sync with the chip.
>
> According to the LM3560 datasheet, Flash Timeout is 512ms, Flash current is
> 875mA and Torch Current is 93.75mA.

Can't we simple read back?

-- 
With Best Regards,
Andy Shevchenko
