Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73908C004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 22:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 193CC20645
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 22:31:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.ca header.i=@yahoo.ca header.b="Iva50SqX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 193CC20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=yahoo.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbeJAFFr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 01:05:47 -0400
Received: from sonic308-11.consmr.mail.ne1.yahoo.com ([66.163.187.34]:44809
        "EHLO sonic308-11.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726261AbeJAFFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 01:05:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.ca; s=s2048; t=1538346662; bh=DYPS0AVZehbZ4+YruFO2lqm0s28ppldc85Dk4xbJ3CI=; h=To:From:In-Reply-To:Cc:References:Subject:Date:From:Subject; b=Iva50SqXpgQHoqhhWhS2PC8ujpLpA8IyGoJfsxP5NoMBs+DCxtbkh+fuxYDQbw9Ba6n6gX9yWLEpENsQ29x/kL0WAeYaRfPmbFKld0Z0xxSipEcmAQ0bfD+bxLwe2IksYvgVOTAxXKZGxbA85Rfd4xdWEOHIxHKMcELYbsTWWKtG1hkRzLF1QJARBU8TSb9J1+9yV/PLyaOKqFcxxqgfGc38muP8i54GVEopy4OoVgQL0t+36YoZqfplBsYIvsUHgzSssNkAmZ9Hd0OEKSRxdILPDpyb8xwgD1Nqz7xSoFRHsLx32XHHeB+2fNenOW4OKPvWZGP0N+pnpj7kVvOptA==
X-YMail-OSG: OUzFmNQVM1m1zzPY0NOZsCOcoqR7j4nS15_l4AYXZ__TTyoUafQY0mt270VWGts
 x8VEZtVQxjC2cHDNjOSjTt0SQW3HTc2lQDdkhY9dhVpGmNbWc4xFtxqab8InabGmgJpVmneHVNdQ
 3eKF2gewgaF8zyoba86cAvFd6oLLN9cuRqCxU0bNe3tlOw5vHpOeJ5sGynt8CtZQ7mnxGDty3klB
 TdczOitC_obrN2RlHv2__wH9uQS3SWcw8OxqdIxMIwTqTjFxAxCQiTl_MauIidkmyQ7xzdi2Kp3v
 XG7ESLqPWLrKuEyg2XOY2c12WOg6hB.l9WAUzRvXA0dyDfySSQvmoT52_._Q4q.NYW3HIfZK3tqv
 VxPURCHOQ0UM6ckHOspJysODKE7horp8_TiVvl1KiPVxBg22oAk2mmyxOgCgikwxM86.CEnN70Oy
 U3.CLuo4laqEhAUT5ru0_RJVl7AcP4gVuopd_KXBJCEROJ9xDy.S2Kl1VvjswPMY3FMn6VyL_1SL
 rPuX4qQ7UzmQxSsfGk4dFl0Za.HTNS5lxQuAz8hCanX6JnOjcMURje62aaNRhZ6Yct0mycFQE5mN
 2NlrD.AYYHedN_2k68xaNo0q5ytat0tyF4sz_kKhAg46eBndCP.w0A4Jv0GBCNsWkB9PCemlNdea
 YUYXtB_i0h16fc9k_bfXRtIiH4ijEVCJiySByeB9Jotn48L6YAfxUVAjr3stjsisyf4.3q8N1o4u
 j0cSxmgzuXaeifWnXtFMsyONDffhI1KOdW1hjzG2hNuFY1216h1mWTppcw6aVrXGmHOk1N.JX.3X
 VbqDmiBUOnUaLMR3sCpJ9e2bSnxc_aFmq_esb9Hadhr4Kxf2YCqx5wvulsUWJnJ47QRFlKyxR.dP
 7Oth3ZsqLQD08i5_DUDe44Ks73D.75lg3lRNxDFn6tI_GYKZbaMd.z.kpYOjWKiHcUbYTu2ews6l
 S7KtFjUD1IXDlf_r6_5GU5NCHTKSZOA6bMMvSoEowvXiGfv6PweVO9PAgaazMFtNU4Akx
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Sun, 30 Sep 2018 22:31:02 +0000
Received: from pink.alxu.ca (EHLO localhost) ([198.98.62.56])
          by smtp414.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 263ca9ca334a00e7841d07209282ff53;
          Sun, 30 Sep 2018 22:31:00 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Daan Wendelen <daanwendelen@gmail.com>
From:   Alex Xu <alex_y_xu@yahoo.ca>
In-Reply-To: <20180930221751.rd7wva3zolephj6q@scappy>
Cc:     netdev@vger.kernel.org, hkallweit1@gmail.com, nic_swsd@realtek.com,
        davem@davemloft.net, linux-kernel@vger.kernel.org
References: <1538319728.z22jaatdgh.astroid@alex-desktop.none>
 <20180930221751.rd7wva3zolephj6q@scappy>
Message-ID: <153834665886.421.6376790866713055481@pink.alxu.ca>
User-Agent: alot/0.7
Subject: Re: [PATCH net v2] r8169: always autoneg on resume
Date:   Sun, 30 Sep 2018 22:30:58 +0000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Daan Wendelen (2018-09-30 22:17:51)
> Hi Alex,
> =

> I randomly opened your patch even though I have absolutely no idea what t=
his patch is about, but I
> found a mistake in one of the comments:
> =

> On Sun, Sep 30, 2018 at 11:06:39AM -0400, Alex Xu (Hello71) wrote:
> > This affects at least versions 25 and 33, so assume all cards are broken
>                      ...
> >        * 1GBit link after resuming from S3. For whatever reason the PHY=
 on
> > -      * this chip doesn't properly start a renegotiation when soft-res=
et.
> > +      * these chips doesn't properly start a renegotiation when soft-r=
eset.
>                        ~~~~~~~ =

> I believe it should be "these chips don't"
> =

> With kind regards,
> Daan

The grammar is correct as is. The subject of the sentence is "the PHY",
which is singular. However, I think it should be "the PHYs" instead,
assuming that they are different.
