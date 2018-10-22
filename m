Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A77C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1206E20658
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OYEiBANF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1206E20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728773AbeJVTNo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 15:13:44 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46152 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727857AbeJVTNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 15:13:44 -0400
Received: by mail-qt1-f195.google.com with SMTP id c16-v6so3329233qtj.13;
        Mon, 22 Oct 2018 03:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mc6n9RDE069zmDGh7Erk/5o1EdKIgivk148RbW3dU7Y=;
        b=OYEiBANFZajX8NNigRISJMWAwHV+C2+hRMWVv1hCN21SWIZqfZo3wsP7HHjlvjEvr7
         4v1LpZolpOLTljapGF++hacbMUqcvxw3D1EFrNOX+Z1eb1w3zq5Gp7752Mbk6Er3BJyY
         9oeMPs+3zjSRRMVwS//TXpaPvT40+QtO4uQduZXN8C3NkLwmh712Bxbn0Lq5g/DWPZmN
         IC3hRNie+h0mC8MPU2b4olJXzpPPYtLOnY10Hqss4PJjxVW0PqEz7Zz6/FGHT5eF2e/L
         0YeYqwVjc5AKTi6M/gKT6Zpg2lHie2nicFabZgEZPLMS4pdRrCI7DUL6/k4DRH699KLM
         H5jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mc6n9RDE069zmDGh7Erk/5o1EdKIgivk148RbW3dU7Y=;
        b=YziQe+Fdangw9oeTbzV/obx77E0sfpaEl9NpWWWvnPdw8MmG9Bw2htSqC+nYElZSS9
         fxWXGMYWbQ7dUbB1wQSEDSDy5Ul5FBuvG2jHUUNQZWbqSkFfWHVejcqB6Usz7k8GYRof
         tfv5ckIcWoNeA6c8JqU4FzqBDRm9yzkOyQBXi40TKVH2Xd41Q3EWlfPePSs4P0lcCMnZ
         cvpda6a4DZFIt/j5cre/s3ZV/G2XAwEuZ9qhlru/2pdggCl9e0FtourE5iROoo5+OTJ6
         HhyrPXS8omLCzh2AsYbzQbnxxWCbOPEM+iSsTIRynTTl5YOM5Zed8qr4kKomD5mrShTt
         brTA==
X-Gm-Message-State: AGRZ1gKbNRwJWroM9AGvNxy0T2MhGvUjDO/YPRcPUilzfr05nbu1EOiW
        MSxS3mgKkx6Iqlw5ZJGR2K6YR+faeeJ5ciCSFzw=
X-Google-Smtp-Source: ACcGV6025EFyAxdVVMJWKya6OOXumOir2aAMvqK4fM4z8fdayJGZzBZsWXll29A/Qn7p+uVOL2G8hpOs6lwkusoaws0=
X-Received: by 2002:aed:3e46:: with SMTP id m6-v6mr11213184qtf.99.1540205740064;
 Mon, 22 Oct 2018 03:55:40 -0700 (PDT)
MIME-Version: 1.0
References: <20181021200032.1833-1-wsa+renesas@sang-engineering.com>
 <20181021200032.1833-2-wsa+renesas@sang-engineering.com> <20181021211951.GM10650@smile.fi.intel.com>
 <20181022081718.GQ2302@lahna.fi.intel.com>
In-Reply-To: <20181022081718.GQ2302@lahna.fi.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 22 Oct 2018 13:55:25 +0300
Message-ID: <CAHp75VfTevUTdYwMxg9RSsEp+bNJRna24seg6eTAjNgRPggqtA@mail.gmail.com>
Subject: Re: [PATCH 1/5] pinctrl: intel: pinctrl-baytrail: simplify getting .driver_data
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2018 at 11:51 AM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> On Mon, Oct 22, 2018 at 12:19:51AM +0300, Andy Shevchenko wrote:
> > On Sun, Oct 21, 2018 at 10:00:27PM +0200, Wolfram Sang wrote:
> > > We should get 'driver_data' from 'struct device' directly. Going via
> > > platform_device is an unneeded step back and forth.

> > Thanks!
> >
> > I see only 3 out of 5 patches.
> >
> > Since we are about to establish a separate tree as well as an additional record
> > in MAINTAINERS data base for Intel pinctrl driver, I ask you to resend only
> > Intel related stuff in a separate series.
>
> Well, it is easy enough to apply to our tree even if part of larger
> series :) So no need to resend anything IMHO.

I think it's slightly harder to sort things out for the more complex
series, anyway, I'm right now talking to Wolfram and he shared how he
did this series. The split is based on records in MAINTAINERS data
base, that's why we have non-Intel parts there. Whenever we push new
record, this automatically fixes the split.

> Looks good to me,
>
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Thanks!

-- 
With Best Regards,
Andy Shevchenko
