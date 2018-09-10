Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB98C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 230572086E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="LGGKtxC9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 230572086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728870AbeIJTwn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 15:52:43 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:51148 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728127AbeIJTwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 15:52:43 -0400
Received: by mail-it0-f67.google.com with SMTP id j81-v6so29901388ite.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 07:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1Pruq3Tz5s49VO2Apt6/tfAnK0T76s/IR8tNE2SBqGY=;
        b=LGGKtxC9yWVqNEaZxFmDK5H5sK8IPjAjNa7I4jHxTKxoESMm+gGhWynVMgFgj4gxUy
         9gOwssPHhebXHGVl8IQF7COpMlS63xYMiD8BRdU/cA8V+Y1JrMrmAugJ+rvj9UN4EfRQ
         uVS2E1v2Hd0gtOmUs1xdzci+gDenEBGb5+TdrefqNBLG4ueKTSCJpsFlUF/c47iPqYp2
         aC6YdLNuQNoUvz3Z0EjYHb3m4tzAhXiQvIDfdHE5rUTYkyYhkCoGDkkEnc9zIPauNFwB
         zcgxWe/GXLJh1Si6I8LWxvJzZ9b0PQG+ffvLTvatTLI00IWsEqdqBYC7FlEtFvTrOkg2
         7x+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1Pruq3Tz5s49VO2Apt6/tfAnK0T76s/IR8tNE2SBqGY=;
        b=T75bUEdyiXnI8Dzf2tULF3maMREjSkkQA9qyAtJpAvRfUpJqcrnnbhkJp4ajZRbqEv
         McoK9UDirF85poND5nwax80ffgr0VDQ0zX2OORYI2y02RaOG8WwvWV+D7jgxDRR/DKf3
         Cx6KehQ0acIH/tK+ETzkP+6jy3R+uc/B4RnGxRoc3VOIN2mGu1bOvWalzvkPdTO5bQpx
         LYMzHM0CmF11YZUPchWVntEj1CT4FK46uWyQRsL4GD51SgxEcV+TxiNSRF+PlyVU5MeM
         3nXdvJ3A/gs0gOsnmBh7L9PZP+dfLQwAfUOrYngTAEwsM1lx88DW5THHkXXRNCA/GnDI
         Qagg==
X-Gm-Message-State: APzg51AAYwG/ev8RPqiv5LMVHJ5W1XiEEBKe71wzpmTVm+wetdGK+yoi
        fCSQZe8mxSe6rTfG3Zhw/BSp1gwhaUJguconFEcaTw==
X-Google-Smtp-Source: ANB0VdaDQ0g6G4tsJAKC770YtCnMYCXARX0Tj5PbH/fz0fT97muwuAdmyJLnI7eteWwVbrlejdb6mRqQ3GBvwz5dHaw=
X-Received: by 2002:a24:41cd:: with SMTP id b74-v6mr17563120itd.85.1536591494286;
 Mon, 10 Sep 2018 07:58:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:1905:0:0:0:0:0 with HTTP; Mon, 10 Sep 2018 07:58:13
 -0700 (PDT)
In-Reply-To: <dec727cf-486f-8126-34f8-1b1099cec3a1@linaro.org>
References: <20180907100750.14564-1-brgl@bgdev.pl> <da9556fd-0022-8e6a-12b4-cc3babbae5b0@linaro.org>
 <CAMRc=MeT7UP57x+Q-a1ODRCvcGKKj_NSfkBLVQ9O5dhTC1DAYg@mail.gmail.com> <dec727cf-486f-8126-34f8-1b1099cec3a1@linaro.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 10 Sep 2018 16:58:13 +0200
Message-ID: <CAMRc=Mdmi91=2zn-T0B8C2rxVhsXL9cHh7mx8RamYfBpfDjC=Q@mail.gmail.com>
Subject: Re: [PATCH v2 00/16] nvmem: rework of the subsystem for non-DT users
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        David Lechner <david@lechnology.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, Alban Bedel <albeu@free.fr>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-09-10 12:02 GMT+02:00 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>:
>
>
> On 10/09/18 09:24, Bartosz Golaszewski wrote:
>>
>> The API changes change so many things, that these series would be
>> incompatible. I can send the series separately but they would be
>> co-dependent anyway. Does it sound good?
>
>
> What am asking is to reorder the patches in a such a way that its easy to
> review.
> ex: Order can be :
> 1> kref and update nvmem_unregister followed by the provider changes.
> 2> Add support to cell tables, cell lookup, notifier
> 3> general cleanup patches  followed by fixes
>
> Current set seems to jump from one thing to other which makes it hard to
> follow and time consuming while review!
>

I would just change that ordering a bit: I think we should fix stuff
that's broken first, so fix the name field of struct nvmem_device,
then the rest as you listed it.

Bart
