Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59CECC43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 17:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 003DC24CA9
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 17:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzM1zOpS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 003DC24CA9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751610AbeFWR1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 13:27:12 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:41406 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751482AbeFWR1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 13:27:11 -0400
Received: by mail-oi0-f68.google.com with SMTP id c6-v6so1180732oic.8
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jun 2018 10:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=uZ/cKN99V9rNLCWYZ0LnfuplHzNecEnNi1hIsRvcxFc=;
        b=DzM1zOpSjQ2hm9LoXQNEUyzb5Tx9pRbgK1WeogR3pgtN5Rq0XVZB6bfD8CsyiLNotK
         QOb1BW98o2E6TuXTUTDKgvm9uPW/ELp/t27SgLjFowJb1yT7NFSfJgnnrXgy84KsbuOw
         B4YI03h/kTD2nVo3tpSinE1xBoVEuGTwsmdiETZfnuATHhbGl2Us3/jW1Zyqbw1x1/j6
         mZJCzP2GrZRScGD+HN5AOwaAkeP9EVtzSTqHF076lZ93yRCfoRjLaaKwcphoq1wZMZvd
         5MJgd2/afrOiwe4X+Mx5dzLhlL3YnJ+KYZEou++HBpk3bq8s2iZ5/saYRhfPdXqEWlLI
         N0yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=uZ/cKN99V9rNLCWYZ0LnfuplHzNecEnNi1hIsRvcxFc=;
        b=dSVcHT+CgZKLzrJ1VLmF6WbK8x10YDwQSF8y7iIqz7OnAZslHyoZR9NTG3ii5hE1Rh
         A8wIkL5pbIuMT2aDQ7jyB8hhLcbTzY8ICeUHh2npZshUdmqlYkUjugLhk2xP/jTAF16c
         K7eu95D5606xpBq0JoA52Y9me5CeMOMpe/eCJm+r7IZ/0mUp2H+iDj/TIr7nbP6jvrYJ
         +n49aUpkFhfzHZXt/2HJTVcfoY4uEuQFCuiImd8v3es6zz0/BEyPeRewjMolC6VMXGu2
         NzfJh6YXBCWdY08VRzdMunrkJtxFKyzHJ1aD5xyGmj365sXKEmEScJkQxJJFmr1SW4Em
         rEqw==
X-Gm-Message-State: APt69E3Ilhfjid3GcbfT8BjNkDwf+Az4wbmsDlbWb7Z90ZTVANOin2Bn
        LEvFX6gdkIk2mDrXnL4kVCCN0+dT6Hk1dDN/TC0=
X-Google-Smtp-Source: ADUXVKLA4K6bMRctgGXQ5pKOYe253NU3eknjO9v6q4kop8dszYlvAC0QwJuK6X4/FY6MJ2HQiQ+moqJtagVtClMHS4I=
X-Received: by 2002:aca:fc82:: with SMTP id a124-v6mr3628104oii.69.1529774830568;
 Sat, 23 Jun 2018 10:27:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1049:0:0:0:0:0 with HTTP; Sat, 23 Jun 2018 10:27:10
 -0700 (PDT)
In-Reply-To: <CAOMZO5BSVKSEjk1inZb_yA6VNkZiW_gWK3LdzkAzwZzJb+hVfQ@mail.gmail.com>
References: <1529636119-4076-1-git-send-email-chakra@openedev.com>
 <CAOMZO5DJGCESqtSqbEw4O0Vxv3noUoCrTgbRCmwB2fJdVvu0RQ@mail.gmail.com> <CAOMZO5BSVKSEjk1inZb_yA6VNkZiW_gWK3LdzkAzwZzJb+hVfQ@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sat, 23 Jun 2018 14:27:10 -0300
Message-ID: <CAOMZO5B8tSTgBkZbAqRPdru=TaZ9=NZyKAOncgeCGCRqpQWwzg@mail.gmail.com>
Subject: Re: [PATCH] Fix for clk disable issue on imx6ul
To:     Chakra Divi <2chakrass@gmail.com>
Cc:     Robin van der Gracht <robin@protonic.nl>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Chakra Divi <chakra@openedev.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Yongcai Huang <anson.huang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 23, 2018 at 12:47 PM, Fabio Estevam <festevam@gmail.com> wrote:
> On Sat, Jun 23, 2018 at 12:38 PM, Fabio Estevam <festevam@gmail.com> wrote:
>
>> Looking at the CCM_CCGR0 register (address: 20C_4068) there is no
>> aips_tz3 clock gate in bits 31-30.
>>
>> Bits 31-30 are gpio2_clocks and Anson has recently sent a patch adding
>> support for it:
>> https://patchwork.kernel.org/patch/10481351/
>
> Sorry, the correct link for the imx6ul patch is this one instead:
> https://patchwork.kernel.org/patch/10445059/

And you will also need the dts part of the patch as well:
https://patchwork.kernel.org/patch/10445053/
