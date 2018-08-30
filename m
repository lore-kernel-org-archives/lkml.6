Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C35C6C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 00:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F07020666
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 00:49:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kq6VaQ8V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F07020666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbeH3EtT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 00:49:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:53696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbeH3EtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 00:49:19 -0400
Received: from mail-qt0-f177.google.com (mail-qt0-f177.google.com [209.85.216.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2F2C20666;
        Thu, 30 Aug 2018 00:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535590189;
        bh=sHEYaOURkt5sM58PLK/liSel6+Oivklx19TnCUcfHwo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kq6VaQ8V3U5mQOok9Ae6zB5L52g9j+aL9ERLO12GFNY9r8R71vazPK5akZ1JV5fdA
         xeMbdAgEFBPs3v7nR11Yvi3EbDhMv3lWVuBLcA1bPURK5zyTtRCuPQCs/InfiTIy+O
         qh/FdsoJg/9ZbAwpvatpt4UknIoWG8S8sJponUuM=
Received: by mail-qt0-f177.google.com with SMTP id x7-v6so8000997qtk.5;
        Wed, 29 Aug 2018 17:49:49 -0700 (PDT)
X-Gm-Message-State: APzg51CVeV5TX9zVrjplW4v4HM8H7mM7Cj06dWrxdbRcA1/plI0sqeck
        v9IerRp1sLjqbAFza6vx7gy0jLvYbU/5/LzUHA==
X-Google-Smtp-Source: ANB0VdZJd58IigFPmNx9oFAAbyyN5DtfeCtQ6TEXkG7hZLiWs3GrdXXkERkverJkXw2sYlBY2V3SjItBn+OEBalSk+o=
X-Received: by 2002:ac8:1909:: with SMTP id t9-v6mr9331735qtj.327.1535590188879;
 Wed, 29 Aug 2018 17:49:48 -0700 (PDT)
MIME-Version: 1.0
References: <20180828015252.28511-1-robh@kernel.org> <20180828015252.28511-21-robh@kernel.org>
 <3fa33583-f748-1708-2274-0a6f4e81004b@axentia.se> <CAL_JsqJcDdntsi3D=neU=Dhx0Xku_XPFC_OCLRb8V==HTtviBQ@mail.gmail.com>
 <d2736c07-d653-a855-401d-120b0650ae79@axentia.se>
In-Reply-To: <d2736c07-d653-a855-401d-120b0650ae79@axentia.se>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 29 Aug 2018 19:49:37 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLxdOH+1=0gvnP1TX4RNNTdKFNV_2NQDD8Jj91_t3DBEg@mail.gmail.com>
Message-ID: <CAL_JsqLxdOH+1=0gvnP1TX4RNNTdKFNV_2NQDD8Jj91_t3DBEg@mail.gmail.com>
Subject: Re: [PATCH] i2c: Convert to using %pOFn instead of device_node.name
To:     Peter Rosin <peda@axentia.se>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 7:25 PM Peter Rosin <peda@axentia.se> wrote:
>
> On 2018-08-29 20:42, Rob Herring wrote:
> > On Wed, Aug 29, 2018 at 1:03 PM Peter Rosin <peda@axentia.se> wrote:
> >>
> >> On 2018-08-28 03:52, Rob Herring wrote:
> >>> In preparation to remove the node name pointer from struct device_node,
> >>> convert printf users to use the %pOFn format specifier.
> >>>
> >>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> >>> Cc: Paul Mackerras <paulus@samba.org>
> >>> Cc: Michael Ellerman <mpe@ellerman.id.au>
> >>> Cc: Peter Rosin <peda@axentia.se>
> >>> Cc: linux-i2c@vger.kernel.org
> >>> Cc: linuxppc-dev@lists.ozlabs.org
> >>> Signed-off-by: Rob Herring <robh@kernel.org>
> >>> ---
> >>>  drivers/i2c/busses/i2c-powermac.c | 15 ++++++++-------
> >>>  drivers/i2c/muxes/i2c-mux-gpmux.c |  4 ++--
> >>>  2 files changed, 10 insertions(+), 9 deletions(-)
> >>>
> >>> diff --git a/drivers/i2c/busses/i2c-powermac.c b/drivers/i2c/busses/i2c-powermac.c
> >>> index f2a2067525ef..b706fd136ca5 100644
> >>> --- a/drivers/i2c/busses/i2c-powermac.c
> >>> +++ b/drivers/i2c/busses/i2c-powermac.c
> >>> @@ -390,7 +390,6 @@ static int i2c_powermac_probe(struct platform_device *dev)
> >>>       struct pmac_i2c_bus *bus = dev_get_platdata(&dev->dev);
> >>>       struct device_node *parent = NULL;
> >>
> >> Lose the initializer...
> >
> > That's pretty much unrelated though.
>
> I disagree. If you remove the need for the initializer, it's very much
> related to also remove the initializer.

You're right. I'd stared at it a bit and missed that in fact parent is
only accessed within the case statement.

Rob
