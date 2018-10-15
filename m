Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16619C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 23:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD121208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 23:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="hbGIrbOt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD121208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbeJPHG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 03:06:58 -0400
Received: from mail-yb1-f172.google.com ([209.85.219.172]:46573 "EHLO
        mail-yb1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbeJPHG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 03:06:57 -0400
Received: by mail-yb1-f172.google.com with SMTP id o8-v6so8169034ybk.13
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 16:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sfgvSs63g/h45RD9rTLDUMJIpOacz1g63SGkw+GTkTo=;
        b=hbGIrbOti+zWYy9rq/oXHCiNRqhWLt8AI7qGGdBhY+qHKwh+MVG6+EwnLtzUsB09RH
         +hWBRTmQ0GKOi9aZ28dOsEWakdbiM9YjBytj6z9Nm+2nzymAfpe7B9LBzGglw0GRfi7t
         Jwn8LGEihzgXlpnPd1P93IkWfsbdatemPLOWJA8jgRqySH8/veQPaYm4OxJkUA0Hf4hJ
         bfvwOVvgPmUKe4F951PtMEWTbZqSpdfpGGAB2J+GUPNfkTA3eYhR/eG8KPlCv64ZnSbr
         EHCaKheg2Cvo5VJOBFEvDPm1omuuVnkwcTKSoSKVeBMJM8mmsPInI63UTuKMrwkIWr1e
         oqIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sfgvSs63g/h45RD9rTLDUMJIpOacz1g63SGkw+GTkTo=;
        b=cvy1ks9GXs0ZP6gISpYdNxlzVhctrg8Aw953dX0x+CJLHuBeq2yc/lmdEMRuEmXa/l
         /shdO3dcIZP4SBgLIUydP6AEbKXOud6lOQ7RVjt53ajiqxfSrJUK4tivx6+2ZKKd2vsK
         dzSx8gx/AKR85Vd68ABBfG9AuKySf7fCpeuU4uYXwRlg2fH68WK1IM2KRnBiql8cUItn
         mjzJ9wNJELHF8uCzYbxsYy9H03ZZ6Z2WF0sJemtVWIfJ9eP1BDWyqLrsN21A+hHMfZE9
         M+llfMPsPJ27FP2cbZqCQ3dX9Vv+rHnFUV7UGBE+RKDLGZJJGmkS4lxMqbpZy/ae9nVY
         CYOA==
X-Gm-Message-State: ABuFfohZeDg4Hrr8ZPt3BFWjDsIOxzNDu8nuiPF8oWFs6sX+uzSOmFXw
        7Me4OmskQJ4k0HzrRxWLKH1xe9md5pJFyGpxGoAYJw==
X-Google-Smtp-Source: ACcGV60EGFWVy2RlcWyHlaeM8RRzXKerazWPsZlW5KwxzYC73n6TL48lHcZSrvB5WsdbO3w4okjQr9XqPuzSray/hEI=
X-Received: by 2002:a25:abc1:: with SMTP id v59-v6mr5905098ybi.321.1539645571320;
 Mon, 15 Oct 2018 16:19:31 -0700 (PDT)
MIME-Version: 1.0
References: <1539111085-25502-1-git-send-email-atish.patra@wdc.com>
 <1539111085-25502-2-git-send-email-atish.patra@wdc.com> <20181010134926.GD21134@ulmo>
 <25758ab9-eb36-741b-6264-42412b3ddd8e@wdc.com>
In-Reply-To: <25758ab9-eb36-741b-6264-42412b3ddd8e@wdc.com>
From:   Wesley Terpstra <wesley@sifive.com>
Date:   Mon, 15 Oct 2018 16:19:20 -0700
Message-ID: <CAMgXwTieXNa13_xGp2mkw99+VJm-R1xrxMHSmRLZV-hG5oSdzA@mail.gmail.com>
Subject: Re: [RFC 1/4] pwm: sifive: Add DT documentation for SiFive PWM Controller.
To:     Atish Patra <atish.patra@wdc.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org,
        linux-gpio@vger.kernel.org, linus.walleij@linaro.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 3:57 PM Atish Patra <atish.patra@wdc.com> wrote:
> >> +SiFive PWM controller
> >> +
> >> +Unlike most other PWM controllers, the SiFive PWM controller currently only
> >> +supports one period for all channels in the PWM. This is set globally in DTS.
> >> +The period also has significant restrictions on the values it can achieve,
> >> +which the driver rounds to the nearest achievable frequency.
> >
> > What restrictions are these? If "nearest achievable" is too far off the
> > target period it might be preferable to error out.
> >
>
> @Wes: Any comments?

When I last looked at this driver and hardware, I briefly considered
throwing up my hands and pretending that this PWM device had no period
control at all, only duty-cycle. There are several examples of PWM
controllers in linux already that behave that way.

Most of the uses of this PWM are only going to care about the
duty-cycle, not the period. So failing when the period is unachievable
seems worse to me than just completely eliminating access to period
control.

> I think yes. Since fu540 is the first Linux capable RISC-V core, SiFive
> Guys decided mark it as version 0.
>
> @Wesly: Please correct me if I am wrong.

Correct.
