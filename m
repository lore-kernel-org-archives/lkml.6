Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0966C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86BC022453
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:45:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKji35J1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86BC022453
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933662AbeFUVpJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 17:45:09 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:35857 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933115AbeFUVpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 17:45:08 -0400
Received: by mail-it0-f65.google.com with SMTP id j135-v6so161428itj.1;
        Thu, 21 Jun 2018 14:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0aNrLy1W1FKDq0zdwakCQvCAGKUEfmwufHhojbarOc4=;
        b=kKji35J1TFU9JjBd1KxKsdVNV5Xi3Fl+7H8L+kMGYm/MhV/Ncj+/g43BQ+GY/uVh/9
         H2CnC9TOub9RU/gihXErJQSpvHKP6tP//dMJIclNO4qJM5soQN+/2QUzLQ5aTGxET6qn
         L1AmL4BDhJmej+5x0LLyMyoJ5R05SkQ0qB0K8BtEr0P4AAzk2kVH0B/rIAy167GTccdg
         j86YkwRFFkauvvzyLqS7GLzXh+i9jjQzW09X1fxUeFmKwBS9RnFWtdh1vEC98XC5wqAt
         FjRUvzFe8hcJ5ROwsjrpmMeLbuN5arTHEBuIKb+eLKf6aOg+RdYByukQ4lKbfG/3HX9V
         Vvzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0aNrLy1W1FKDq0zdwakCQvCAGKUEfmwufHhojbarOc4=;
        b=b3vCtohf+e6Hp17fdio6bm1bgyTCe+GJfhoCXb0sJP1scotV2W+HQR7obcwgGYVjQG
         HEUblckxywLhojA7CiGmtN3uwCS3M0ldMbSF87zsOJgZPCWLYLWDmIwMhVPdA5+V2TfZ
         D6a18BX7xLoicg6oDPbj5oySONtPswBwfXDeYwrEVW68dktXsrE3PsQw1I3axf4JBOu4
         vb+3Hk4FSTskTldFSERFOGPxJidtBNYh1YB92yQFcUepMog0PrZJyldRosV9Yc/cuaDN
         s+RD8lEGte66Bw5jmlr4gxMCoM5DdMhvwP3MqO02jGIQ+FHlvGyvqo6aRgLBOnpsKiCz
         6MRg==
X-Gm-Message-State: APt69E0OCx+s02zjWBqTYAeDBGdB1/lIb/ilPb+LnJfdb5K3aBwDxBjC
        3N/fvycgdle2W68cMIDym3vwTt+U3AnHHau0wjc=
X-Google-Smtp-Source: ADUXVKK1GnXUZYo8ymuDGYPwLwxKv7TkElGJlO8/i3XElSmpUPPvWiTLgj9X/gD+jLVWIR/1A84qMBopvFOCWX8mpsc=
X-Received: by 2002:a24:b21a:: with SMTP id u26-v6mr6571241ite.81.1529617507328;
 Thu, 21 Jun 2018 14:45:07 -0700 (PDT)
MIME-Version: 1.0
References: <20180530173414.6121-1-andrew.smirnov@gmail.com>
 <CAOMZO5AyAegbvUtX42by99mU8yQfi91bmhJfd9iqu1Ak0dEHiw@mail.gmail.com>
 <CAOMZO5DJj=oQfsB-vNP=81HCiy-69j-5U+Km9P6LxGpnLx9xzg@mail.gmail.com>
 <CAHQ1cqHxq+RM1nNHECY75Cojd_kxu1ERLe6+MhMLUa5kb10r8w@mail.gmail.com> <CAOMZO5B98O9XA8GhdWxJZ6DFgS=O+smHURm8v5jEirj31tuUhg@mail.gmail.com>
In-Reply-To: <CAOMZO5B98O9XA8GhdWxJZ6DFgS=O+smHURm8v5jEirj31tuUhg@mail.gmail.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Thu, 21 Jun 2018 14:44:54 -0700
Message-ID: <CAHQ1cqELs4LaQkmPiPjXQuF17+7PBsEtbmSt8iveLqRv+4bgfQ@mail.gmail.com>
Subject: Re: [PATCH] usb: chipidea: Fix ULPI on imx51
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Peter Chen <peter.chen@nxp.com>, linux-usb@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 7:08 AM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Andrey,
>
> On Thu, Jun 21, 2018 at 9:47 AM, Andrey Smirnov
> <andrew.smirnov@gmail.com> wrote:
>
> > I never assumed it was a regression and that USB worked on RDU1 board
> > before, so I never tried to see if this was a regression. I can only
> > tell you that it hangs as soon as any PORTSC registers are accessed.
>
> I think we need to investigate this portsc register hang further.
>

I just finished experimenting with it on RDU1 and Babbage boards and I
can't reproduce the hang that you describe against 4.18-rc1. At this
point I wonder if it's the bootloader that is a variable that plays
into this. I was booting both boards with 2018.06.0 version of barebox
+ the custom patches that can be found here
https://github.com/ndreys/barebox/commits/rdu1-netboot. Note that the
last patch in that branch/stack was added as a part of this
investigation, but even before it, I was able to boot Linux just fine,
albeit without working USB.

Any chance you can try it on your end and see if that makes a difference?

Thanks,
Andrey Smirnov
