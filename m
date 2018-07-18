Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD1BECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C32042075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knN8RoHK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C32042075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731126AbeGRLKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 07:10:55 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:44229 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbeGRLKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 07:10:55 -0400
Received: by mail-ua0-f196.google.com with SMTP id k25-v6so2597324uao.11;
        Wed, 18 Jul 2018 03:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=w/EtiM7nS2y94StdvKrCs47sFnQw5wDrCw76FqY+8Ps=;
        b=knN8RoHKkPKPo4XYdMABxVMEFgO4yypfODjsjUR28Qg9gvCCLWfod/KevWZEUt5OlL
         1E3cYBas4rGi/0t46Bu/Jxn1s41NWXVcxDjutNBqbSiLoAtDgFMQ1i8474/X4eYc7+ZU
         1JQvnUEucQ9OmPpn/O9wl7l0OmQ0vg/yQeKsNbDBkh3uTUV/06DpSXesUfn6kDLZoXmn
         DWwW4N2CDB4umEiK6j+c/v92HcbWfO+qcbx3xvDaatfHDslt1O+NrAioGJXIdZrAyYMe
         8KLXG0KT1VGe43Z3in+U8I+lEzDfiH5N5yV85VBzY6mZSqkXVNr0dGaCF3OCYOpjsup/
         2jVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=w/EtiM7nS2y94StdvKrCs47sFnQw5wDrCw76FqY+8Ps=;
        b=oo4o04ybD6uyA5c6Q6nUBxsQge5yx2jMOTnCjcoh1Yis/NmymfSQHjbxD1on/pv4l+
         Qu7Q/53PzRWZPiXJTAcdzW3U9l33ytayPBeMzW+KwGNoRWvOli/KDAvZvncA13f80RGp
         lNDBtpxTYdPB6O9OeJSpa0S3eEWE/z0HmwmR+m/JZRLQLi5eiUVA4TR7qn7lhRth5ekN
         2rd+PfumYVQZAhrNd90cHPmIFUDaCi1IBKmP9CARKKsXbnV5K5DqdiBUzOaYOgdtKOAd
         JeuyEqr2EtmF5quHGhOWku1Hy4p/4NYzmbX/DG4KpkDPJ/rWh+KYtWVm2Tp2lI7e17t0
         58Xw==
X-Gm-Message-State: AOUpUlEtOEe6qD3/B6dSnIqxunVixYdzPyl956H/Q/LCDH9bKWWwWZTz
        LWf0mHOR1+5Zz7bOL8n2SI9Lwd9fMECd98DtUwc=
X-Google-Smtp-Source: AAOMgpeR78oueyb1O0lLFA6KLVCfltg6G/bM9qN/gzP2JaUd6Yz6BrCpFVaZu7wDjKYZsN8cxL4c7WqzcC/e8fiA+6g=
X-Received: by 2002:ab0:1b93:: with SMTP id k19-v6mr3556456uai.122.1531910019667;
 Wed, 18 Jul 2018 03:33:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 03:33:39
 -0700 (PDT)
In-Reply-To: <20180717221301.GF3211@piout.net>
References: <20180717142314.32337-1-alexandre.belloni@bootlin.com>
 <20180717142314.32337-2-alexandre.belloni@bootlin.com> <CAHp75Vc4SrMXznc6PSrO2Lfrc3gspu_g1QYjuFDWT9-J=C+bjw@mail.gmail.com>
 <CAHp75VfRS_gSv6x22M1TiTariUftF04sLyd84dQpxudOmT0s7w@mail.gmail.com>
 <20180717214212.GE3211@piout.net> <CAHp75VdEkQ=AC8xUBno7qp0E+cXqwq03WOtVB3sX+Z6zthDJSw@mail.gmail.com>
 <20180717221301.GF3211@piout.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 18 Jul 2018 13:33:39 +0300
Message-ID: <CAHp75VfvP7s-ud0XRUfESjTNRdbaZH_qKRpXbkCzKqp8j5e6kg@mail.gmail.com>
Subject: Re: [PATCH 1/5] spi: dw: fix possible race condition
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Mark Brown <broonie@kernel.org>, James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microsemi.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 1:13 AM, Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
> On 18/07/2018 00:54:21+0300, Andy Shevchenko wrote:
>> On Wed, Jul 18, 2018 at 12:42 AM, Alexandre Belloni
>> <alexandre.belloni@bootlin.com> wrote:
>> > On 18/07/2018 00:30:49+0300, Andy Shevchenko wrote:

>> > Well, I'm not sure how far this can be backported. It also seems nobody
>> > ever hit that while our hardware will hit it at every boot.

>> No-one enabled CONFIG_DEBUG_SHIRQ?

> Nope, this is a real HW IRQ. I meant find out up to when it can be
> sanely backported.

I meant that before your case no-one tested with that option enabled
which will behave like you describe (IRQ gets fired as soon as being
registered).

-- 
With Best Regards,
Andy Shevchenko
