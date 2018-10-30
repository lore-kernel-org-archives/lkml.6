Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A19BC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E458F2081B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:19:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cy/wYoOL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E458F2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbeJ3WNS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 18:13:18 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36108 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727804AbeJ3WNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 18:13:18 -0400
Received: by mail-lf1-f66.google.com with SMTP id h192so8846161lfg.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 06:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HspSmfBDzptBzR2Kjg+MRKQqBhB8F2WJHal4+FQ9+OI=;
        b=Cy/wYoOLeJ1tGXyyKDOnNj7e/N5vjhfB9AO3igK9RqBp7uUS1oz2Iacp/eoAQMbKAM
         hi0SJZ66mCN5Cj+56WYRWYx8BS4NldiGcdmm41+aE6HzAnfBxh7o1/WUO/orwsNj/5Le
         8BchXJLHEeLKbNNxWREdRehCQZLiq0o2cc1k0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HspSmfBDzptBzR2Kjg+MRKQqBhB8F2WJHal4+FQ9+OI=;
        b=uTS6fxlMNakEDmd4/9Qty8W4OgK1TE6DeFxE/Ul4gNZlVEev9aPOfT7E4soZwea2ng
         MaEtMGuPb5YbT9uLgNcvySAC2eO3VLn+kzwdiRp7yz+zZCP6SF8M4s6X/JP7OPZsn4O0
         5Vq0e6f8KA1P87AJmB2WrvDt4lkNjDJoUcjHCmwFqsgqAAjB2qKRLSAuklo7zxSW2MAA
         J9PVopDQAvN5LQzWXtDkyIco0YDyIOh+y7b1bWEAj4MnOKmiKf8RGHriyq8PvRM5oZCh
         cllE+6NZ0zEHg3UOKNK/zoklz3JzWgBrx2KLViYXxfBxSlfdl6zohtZBuFu0f6SK2d1o
         PXYg==
X-Gm-Message-State: AGRZ1gIQANsX+1BgEmN3GJQ/jWUOqrGAFdA4Ycm/+RDU69GvDMnee+4N
        IHn9LB/N89U66S6V23ieCRwj1wvDZ4kRwuJWwRi4mBUeHWw=
X-Google-Smtp-Source: AJdET5dq7INM5x+hO9e+cXX0Y3Q5ZSUxY69gMwZqba3l56CWShFXfSdinj1b78bL4oIgTOgdbphsZjs+9MfSr3lWo4Q=
X-Received: by 2002:a19:f813:: with SMTP id a19mr1833628lff.67.1540905591503;
 Tue, 30 Oct 2018 06:19:51 -0700 (PDT)
MIME-Version: 1.0
References: <20181021200002.1472-1-wsa+renesas@sang-engineering.com> <20181021200002.1472-7-wsa+renesas@sang-engineering.com>
In-Reply-To: <20181021200002.1472-7-wsa+renesas@sang-engineering.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 30 Oct 2018 14:19:39 +0100
Message-ID: <CACRpkdawU7QaQEmM0-o=FBB9=-EYBUs9Rt2=Y_ZTF5xiL69Rdg@mail.gmail.com>
Subject: Re: [PATCH 6/6] gpio: gpio-zynq: simplify getting .driver_data
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 21, 2018 at 10:00 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:

> We should get 'driver_data' from 'struct device' directly. Going via
> platform_device is an unneeded step back and forth.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Patch applied.

Yours,
Linus Walleij
