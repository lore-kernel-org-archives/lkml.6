Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A756C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 11:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADA5A213A2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 11:32:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RR7ioxzW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADA5A213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbeJDSZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 14:25:18 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:36628 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727234AbeJDSZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 14:25:17 -0400
Received: by mail-it1-f194.google.com with SMTP id c85-v6so13511353itd.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 04:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZnDXGBd0ueBaNE9ti9uz9DfaUR27jaCIrm1LxBlChDo=;
        b=RR7ioxzWXyMNHlD0apDNQyICAgmnDx7kPbzpa94u45NFlJnxV/UEjBwplWdhVBgw8P
         dSEr+jYcUMt8UUG5j33NvNwjD3Dx1u7MCo+wMeCD3G0S/Sq/BB7adbJ77uJKeh34oez0
         I+YNZmM5LiQY18NBT6urDpKJnopbItj44+Kpc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZnDXGBd0ueBaNE9ti9uz9DfaUR27jaCIrm1LxBlChDo=;
        b=BVXfs086h4QwbqkmZz8cNpOhx0hptpfKZX5O0xsSTr5QPievxaBOunXiuzw02IzTmq
         7It/0WXBOHyHucIU0AVpHjjbPJurAkGeKZXOW2dQZdzq5Ue+tMnwLC0x1l9nS8lPW+6F
         /CLnjyCC2w6OZoqOcwXUd3JxWX4S/gQDSR6xVY1RlKq0aguay4aG2bOxTRGpglya8q/Q
         UsSDgomA4B6zXfCqQNV+8fs+e3FPPwn8izY2C/GFIpRApUevBgmIiqawdd0X1/OmyrxN
         zA5kXPEKxS8kNmy3JmXZ2d5lJ0eK0KPGQPEgBpM/ipv/nLx4R5x3KE46BOtehb3w+m9y
         EEIg==
X-Gm-Message-State: ABuFfoicWKtYRkFLZ+FZlkmGtoz3qUwIgpBTpHmtpn1185MTdXJ3uRaY
        igxe8R7PXkL4jQP8FKd26KCnxtkx8Gitd4RRQ3LgDA==
X-Google-Smtp-Source: ACcGV60FonI3/3huGq+xvMGfkThwBAYfTvu6YHWut5zH3jJK5JHCDvuTWUjQShK5ekXtaS4Op1IhpvsyQ0oGjOkM9/g=
X-Received: by 2002:a02:9643:: with SMTP id c61-v6mr4810423jai.37.1538652746078;
 Thu, 04 Oct 2018 04:32:26 -0700 (PDT)
MIME-Version: 1.0
References: <20181004090654.32233-1-linus.walleij@linaro.org> <20181004105031.GD6412@sirena.org.uk>
In-Reply-To: <20181004105031.GD6412@sirena.org.uk>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 4 Oct 2018 13:32:13 +0200
Message-ID: <CACRpkdZZHYSRXktPLHKRc4Afsegn4q3rOmcPMhXh5chC1jH-JQ@mail.gmail.com>
Subject: Re: [PATCH] regulator: fixed: Use more standard GPIO binding
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 4, 2018 at 12:50 PM Mark Brown <broonie@kernel.org> wrote:
> On Thu, Oct 04, 2018 at 11:06:54AM +0200, Linus Walleij wrote:
>
> >  Optional properties:
> > -- gpio: gpio to use for enable control
> > +- gpios: gpio to use for enable control
>
> Are we supposed to be able to have just plain gpios as a standards
> conforming property or would best practice be to call it enable-gpios or
> something?

Oh I didn't think of that really. The gpio-regulator indeed uses
enable-gpio for the same thing. But it complicates things codewise,
as the GPIO line is also optional. I'm a bit uncertain, I tend
to think just "gpios" is fine when the usage is unambigous. but
I don't know what the DT maintainers think.

Yours,
Linus Walleij
