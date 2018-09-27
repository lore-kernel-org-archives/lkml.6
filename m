Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A920C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 11:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4910215E4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 11:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ezJpXime"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4910215E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbeI0Rw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 13:52:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:34572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727027AbeI0Rw1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 13:52:27 -0400
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C384B215E4;
        Thu, 27 Sep 2018 11:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538048075;
        bh=g6WUTW4M2gkmMrkGPpehGRiikbssFYddbz/aAcbuJc8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ezJpXimeBp/89LWXNaruiVR0MzrA+By5jggjBD6uzswwItyudptZ8GSZcOl7nTktL
         mQXp4EcRIu9gs65J1kXxXZe7ZDGbHQXM2mNttMIkPbH0II6BJq12uUnsoMTj9rYuK/
         niOvIkHOfTRGpHGX0JG95Xa5vOYwh6G6rCNXyTBk=
Received: by mail-qk1-f171.google.com with SMTP id v18-v6so1298163qka.10;
        Thu, 27 Sep 2018 04:34:35 -0700 (PDT)
X-Gm-Message-State: ABuFfogVNEBnWWmnasdRthIg+4uc7liAuM8YzBmL3O8TTT9xykLqykfQ
        8PC6yV/ABiCK/mM/bfnghil/XhPLHnLz7KhQng==
X-Google-Smtp-Source: ACcGV61w5potfGRZRfw99UamSohzCXfcJb23c3pEHjc2Xy0gjlG4MqNlfJK9Sn8F9Dc2KVsIPKoGsFYSh7si9pI1olY=
X-Received: by 2002:a37:bec4:: with SMTP id o187-v6mr7407638qkf.326.1538048074967;
 Thu, 27 Sep 2018 04:34:34 -0700 (PDT)
MIME-Version: 1.0
References: <20180919164712.4030353-1-vijaykhemka@fb.com> <20180926230026.GA26508@bogus>
 <CACPK8XctuiN8yphXFUmwXnpphb5LP2i8Cje_HAdsBwMWSvpsdA@mail.gmail.com>
In-Reply-To: <CACPK8XctuiN8yphXFUmwXnpphb5LP2i8Cje_HAdsBwMWSvpsdA@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 27 Sep 2018 06:34:23 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLvJDatz1oJG3CPY1LcFmqbRwdOeZ0-=Mpbbpq0jfmEwg@mail.gmail.com>
Message-ID: <CAL_JsqLvJDatz1oJG3CPY1LcFmqbRwdOeZ0-=Mpbbpq0jfmEwg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ARM: dt-bindings: Add vendor prefix for Facebook
To:     Joel Stanley <joel@jms.id.au>
Cc:     Vijay Khemka <vijaykhemka@fb.com>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        devicetree@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 10:14 PM Joel Stanley <joel@jms.id.au> wrote:
>
> On Thu, 27 Sep 2018 at 03:01, Rob Herring <robh@kernel.org> wrote:
> >
> > On Wed, 19 Sep 2018 09:47:10 -0700, Vijay Khemka wrote:
> > > Initial introduction of Facebook TiogaPass family equipped with
> > > Aspeed 2500 BMC SoC. TiogaPass is a x86 server development kit
> > > with a ASPEED ast2500 BMC manufactured by Facebook.
> > >
> > > This adds an entry of Facebook in Documentation for vendor prefix
> > >
> > > Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
> > > ---
> > >  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> >
> > Reviewed-by: Rob Herring <robh@kernel.org>
>
> Rob, can you take this through the dt tree? I've already merged
> Vijay's device tree through the arm soc tree, and don't plan on
> sending another pull req for 4.20 at this stage.

Sure, now applied.

Rob
