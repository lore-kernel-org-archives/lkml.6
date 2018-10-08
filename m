Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 926C8C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 07:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 429D32087D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 07:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cI5+SsJy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 429D32087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbeJHOuu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 10:50:50 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35670 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbeJHOut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 10:50:49 -0400
Received: by mail-lj1-f196.google.com with SMTP id o14-v6so16941478ljj.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 00:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qV8Bt5ptXCj9lZN41Kg/XyHeIBmyVTBB45u6HS1/aGM=;
        b=cI5+SsJytgM50rzgnOBwcwW/f/3fJhjd8ZstIjyp6wcfDJ+h4XoyakAJRbtM49u+wE
         QdE5J3tSTechhVPEjzjmb0amHiThoRpP5tmnAUlBS0mLNh5Hl/RHJ2NyUKYKbWs+kROn
         8teuuo+hMxtueCm6DCs8C13bSFfGLTu66/6XCT5+GSUC1cWlTvwjxhG3cf6/dX2qFomX
         gXnbJdpeezXYzVsKVmfTnCu6JrmPat+zKV80MyioSUh69CiCYtJwzy1TTKpGw3JC1PCG
         jhs2rs4DAQ6OShuDopuOH0fWwXCh63MeyE0so/1yc/vd9c/z/1loBpkokRPDyDx21A9w
         bRiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qV8Bt5ptXCj9lZN41Kg/XyHeIBmyVTBB45u6HS1/aGM=;
        b=ii8mz9Fz6CHWBxhZ0RICRs6BlN41WuGUvSnFzifkXg8H+884WgEddxKgPoYdExJ9bx
         NgQ+bRyMOkzjegc2mzCZoPbr6kmC8v71IalM8Ib8FMCZsHT5g5JV4jn6SolqizLtGJ6r
         168wySDa3+JnSD/Aa9sy2LtFQlG9LzzYOrKijH0muQ9kUmbSiIIHfLsn8xXCM6AN+ykz
         ye3/wKmNlV/OzMy9tDeTbHTL3otUpXL9Silz7s+fWdt89K62tjfGYaQlhYAmOtsyz7g5
         q3Ilge/CxjmsFSKqagzeFkIcQqC2NpiKtW8/pntp0MQKEJkPHgkHGhjBgnJ03irMEIuV
         B9LQ==
X-Gm-Message-State: ABuFfoiuDybGnjibKgg1Vtp/8ArRGOpDFtRKus3CVpZjS0/7pGKaxzQr
        spulMSY6rXCQazcStfwXLKm7m99Z2pY95ymNiM8=
X-Google-Smtp-Source: ACcGV61EpVAC0P11yd5pM1wz56LWiSoi6Sf14Av9YSJT65gkc3Kfzljn3b3oTnmEEDoMw4PrN8at1dDBRLdawdzQ8s8=
X-Received: by 2002:a2e:8919:: with SMTP id d25-v6mr15186320lji.69.1538984426148;
 Mon, 08 Oct 2018 00:40:26 -0700 (PDT)
MIME-Version: 1.0
References: <20181004142942.11887-1-ricardo.ribalda@gmail.com>
 <20181004142942.11887-2-ricardo.ribalda@gmail.com> <20181005002125.12fd229f@bbrezillon>
 <CAPybu_26HST5xGfhE6MoVTRZok_gfDqN=ZOAesuEMVskdrCpLA@mail.gmail.com>
 <20181005090811.6b7e9957@bbrezillon> <CAPybu_38xH2Cv+eONQmEJ1i6k=oiQM=WrcwOFR29LbtRvWfKXA@mail.gmail.com>
 <20181005103730.57d52e3c@bbrezillon> <CAPybu_1RMcro3xLNW5mbybYdObCTq=QwXgk+RT6hcmRGTh6s7A@mail.gmail.com>
 <20181005121235.7e64b64a@bbrezillon> <CAPybu_0TbeN+-F6zwN8XOMuY1EpgE6GRi=ExDx6O3Yun9kXjYQ@mail.gmail.com>
 <20181005141057.0f1b0a9b@bbrezillon> <CAPybu_0OZR==4k5nxVRZ-1NjPEXLQsun7QhnYds8dPndreUjcQ@mail.gmail.com>
 <20181005165234.468d2397@bbrezillon> <CAPybu_1cd9aJN9mC9m36Gd_fhU5UnfLH9EtU0h8BvJCZchOV_A@mail.gmail.com>
 <20181005182931.172b8f1c@bbrezillon> <CAPybu_01Bn5qmv91Pc-DExCAMheJyGYxiSvmGDUGiSxBA+S0DQ@mail.gmail.com>
 <20181005213203.247c369f@bbrezillon>
In-Reply-To: <20181005213203.247c369f@bbrezillon>
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date:   Mon, 8 Oct 2018 09:40:09 +0200
Message-ID: <CAPybu_3PS_19mGqHfdrD3oSRbUreBj1ABddMFdt5zOHmSg7=_g@mail.gmail.com>
Subject: Re: [PATCH v10 10/10] mtd: maps: gpio-addr-flash: Add support for
 device-tree devices
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Zhouyang Jia <jiazhouyang09@gmail.com>,
        linux-mtd@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris
On Fri, Oct 5, 2018 at 9:32 PM Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
>
> On Fri, 5 Oct 2018 20:12:43 +0200
> Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com> wrote:
>
> >
> > I think I know what might be the issue. on cfi_cmdset_002.c
> > cfi_amdstd_reset can be called in parrallel to cfi_amdstd_destroy.
> >
> > maybe we should call
> > unregister_reboot_notifier(&mtd->reboot_notifier);
> > before
> > cfi_amdstd_reset(mtd)
> >
> > need to try that on real hw with some strategical printfs :P. But that
> > will ahve to wait til Monday
>
> No problem, nothing urgent here. Have a nice weekend.

Just updated my kernel version (4.14.53 ->  4.14.69) with you last
github and I do not see the crash anymore. So I guess we are good to
go.

Thanks!


-- 
Ricardo Ribalda
