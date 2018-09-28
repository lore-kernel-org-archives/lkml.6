Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295D6C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E29F62073F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:32:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="R58wsY2L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E29F62073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbeI2E6l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 00:58:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:60172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbeI2E6l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 00:58:41 -0400
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D23EC20779;
        Fri, 28 Sep 2018 22:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538173970;
        bh=44y4d2y1zP0R6MC3c2D5h1AQJ3PlMLrFxf2MliMGeo0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=R58wsY2L/qKnVV4kAaBrayeyiqmGVA32nytU6QLfL2fZ/rWYVEKc17sQw68Bx0otL
         1iN7eNt4D0lvUDyqApFVXRwiLwwG2bBEgJrXKIHQFcEsEAlySCU1Ll3+hJu7EQ7Ay6
         1ghlnaF0g4DSjTiUk/kNlqDB/7/ZjBE0esf3HQCo=
Received: by mail-qt1-f179.google.com with SMTP id n6-v6so8411735qtl.4;
        Fri, 28 Sep 2018 15:32:49 -0700 (PDT)
X-Gm-Message-State: ABuFfoge+L0APOFnExo6GSyqlqKXE9qY0B3ez3mgqT+LNO25oSoSdkGj
        KyRjbFD4K/ZUo+09J1awRMush+3SZqdWrmNLzQ==
X-Google-Smtp-Source: ACcGV62fGDMrgc8H6mepxZcQMZfILiuS5uwCKK/+faJD/vKMTkZn3Ul6L3rgwEUv19otVIvWxoTZDDVudJMmqSuv59Y=
X-Received: by 2002:aed:3983:: with SMTP id m3-v6mr544627qte.164.1538173969059;
 Fri, 28 Sep 2018 15:32:49 -0700 (PDT)
MIME-Version: 1.0
References: <20180828015252.28511-1-robh@kernel.org> <20180828015252.28511-46-robh@kernel.org>
 <CAL_JsqJfAsv-MOgk2Ycs2VBj2vK0m29B_3FxwJV5xUjnMbH4sg@mail.gmail.com>
In-Reply-To: <CAL_JsqJfAsv-MOgk2Ycs2VBj2vK0m29B_3FxwJV5xUjnMbH4sg@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 28 Sep 2018 17:32:37 -0500
X-Gmail-Original-Message-ID: <CAL_JsqK4UGPoqE=K0hdx1=3XnzB5DVY=mCO8jPe=iZrsf9vk2Q@mail.gmail.com>
Message-ID: <CAL_JsqK4UGPoqE=K0hdx1=3XnzB5DVY=mCO8jPe=iZrsf9vk2Q@mail.gmail.com>
Subject: Re: [PATCH] tty: Convert to using %pOFn instead of device_node.name
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 5:09 PM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Aug 27, 2018 at 8:55 PM Rob Herring <robh@kernel.org> wrote:
> >
> > In preparation to remove the node name pointer from struct device_node,
> > convert printf users to use the %pOFn format specifier.
> >
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Jiri Slaby <jslaby@suse.com>
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Cc: Paul Mackerras <paulus@samba.org>
> > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > Cc: linux-serial@vger.kernel.org
> > Cc: linuxppc-dev@lists.ozlabs.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  drivers/tty/ehv_bytechan.c                  | 12 ++++++------
> >  drivers/tty/serial/cpm_uart/cpm_uart_core.c |  8 ++++----
> >  drivers/tty/serial/pmac_zilog.c             |  4 ++--
> >  3 files changed, 12 insertions(+), 12 deletions(-)
>
> Hey Greg, Is this still in your queue? Maybe you've just been extra
> busy lately. ;)

NM. I see it's applied now. Sorry for the noise.

Rob
