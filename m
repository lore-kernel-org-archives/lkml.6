Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08CACC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 12:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DC8B20857
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 12:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="A4Le+RI6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DC8B20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbeIEQmc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 12:42:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:40642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725868AbeIEQmc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 12:42:32 -0400
Received: from mail-qt0-f178.google.com (mail-qt0-f178.google.com [209.85.216.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B9C020867;
        Wed,  5 Sep 2018 12:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536149553;
        bh=WwSoqj5+IRTFPOjeLkjXBsnP0rGG9fbJPRXQHb/LuwQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=A4Le+RI6RJ4cSnJQnFxZDP2/SJE1yGjDHMSO7x0QYEQub7yq3lSQ3x9Q8QQZT0Cyk
         zAJ8VXDS0550F9vVJt3uxZwCX5jGwQdmEdXSccN/HQJTVwFf11nrayFjD9nDKctUXm
         tZVW2UvzQ/QMdHatV8YqInj/EhoG02+QI7VFFfN4=
Received: by mail-qt0-f178.google.com with SMTP id t5-v6so7715511qtn.3;
        Wed, 05 Sep 2018 05:12:33 -0700 (PDT)
X-Gm-Message-State: APzg51CAooq9+FTg9CDzZ3k5iDCVx3m9aEOx0at9JL36CLi6rIzYMQ1J
        a4oofZ0hFDhwkaHsr+ua9pkQm8esDURKK5xreQ==
X-Google-Smtp-Source: ANB0VdZyCQCHozr3l+Ih62SjWSGM1w3pmSH4ijeumQXSr0+bJyL/7kRNDKbG5FeHjJ+PXtn16jAaDhVD1YJiNz5iZVI=
X-Received: by 2002:aed:2da7:: with SMTP id i36-v6mr34321052qtd.164.1536149552422;
 Wed, 05 Sep 2018 05:12:32 -0700 (PDT)
MIME-Version: 1.0
References: <20180830190523.31474-1-robh@kernel.org> <20180830190523.31474-4-robh@kernel.org>
 <35247ddc-303b-89d0-53b5-231c1a293721@gmail.com> <9c873e57-84c8-75af-1d44-60e7cd41282d@ilande.co.uk>
In-Reply-To: <9c873e57-84c8-75af-1d44-60e7cd41282d@ilande.co.uk>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 5 Sep 2018 07:12:20 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ5qZpdA2QugzEg8dJSyddZkK3ABfJO4RG0-bbM4kaWaw@mail.gmail.com>
Message-ID: <CAL_JsqJ5qZpdA2QugzEg8dJSyddZkK3ABfJO4RG0-bbM4kaWaw@mail.gmail.com>
Subject: Re: [PATCH 3/3] of: make default address and size cells sizes private
To:     mark.cave-ayland@ilande.co.uk
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 4, 2018 at 11:59 PM Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
>
> On 05/09/18 02:55, Frank Rowand wrote:
>
> > On 08/30/18 12:05, Rob Herring wrote:
> >> Only some old OpenFirmware implementations rely on default sizes. Any
> >> FDT and modern implementation should have explicit properties. Make th=
e
> >> OF_ROOT_NODE_*_CELLS_DEFAULT defines private so we don't get any outsi=
de
> >> users.
> >>
> >> This also gets us one step closer to removing the asm/prom.h dependenc=
y on
> >> Sparc.
>
> Just for the record: you say "any FDT and modern implementation should
> have explicit properties", however the default values of these
> properties when missing are clearly defined in the IEEE-1275
> specification (Annex A):

The spec may define defaults, but best practice is to be explicit. For
FDT, dtc doesn't allow defaults (and never has). No arch added in the
last 10 years has relied on the defaults.

> "#address-cells"
> Standard property name to define the package=E2=80=99s address format.
> ...
> In a package with a "decode-unit" method, a missing "#address-cells"
> property signifies that the number of
> address cells is two.

So only Sparc is compliant as the default for everyone else is 1.

> "#size-cells"
> Standard property name to define the package=E2=80=99s address size forma=
t.
> ...
> A missing "#size-cells" property signifies the default value of one.
>
> I can't speak for FDT but it isn't completely unreasonable for a guest
> parsing a DT without these properties to assume these default values.

I'm not removing the defaults. Just not allowing for code outside of
drivers/of/ to use the defaults.

Rob
