Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53BF8C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 241DA2192D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:09:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mflT7Vmu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392065AbfBOOJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 09:09:50 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:51738 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389298AbfBOOJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 09:09:50 -0500
Received: by mail-it1-f195.google.com with SMTP id y184so24335644itc.1;
        Fri, 15 Feb 2019 06:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GdqafAwly330nvNvFHRKL4/uUf3uAJzVgQPB2+4wY8I=;
        b=mflT7Vmu8qwd367UsuMo/5RlFSN/uLTmsD67KO5BAtwB0YBZpgW8PeaCTry9Eom+Tk
         tXv6xwmStRku6+BRg0o/oHvASQLGMa1ftbhd1X+6s/gA1GcQR2XscX4E2nKCJ5jvtpC6
         HtvwgL5s0UiP1QIMoM9RjBPfym/a0WrUaMpTOI03ycx7uwFnumGJsAc/rhxnuTUCG79q
         zZ0u/WyDjpEYaNEI+KzjSAZKxqJ9c+MATdot7yOVYNxcRLOmzS3y1lmrVG6z4y8GcIMy
         8G2hJusYuvv17tkrrKPy8j4diVlGrEA4N3oOWUkvBnkKEOOfFOqablRW98WObHT7bQdu
         /4SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GdqafAwly330nvNvFHRKL4/uUf3uAJzVgQPB2+4wY8I=;
        b=p42OA+POLpNtQoG3MwdCNZ79wMSGtNVvdO5TdjDVCRXwukcdKep2DpvnB3PBZc81BI
         e1Ii3KZq9mkwf8C6OT//d+jt4Qnw1j8bklYcatiRuqYzbN+uhknVgrNW/qYRiyrnN4P3
         QKoap8XeYuerIi+299qTt5FCJSnlR02E42twG05ZQmm1mWCkeN9mYx4sweQ9qLBDHgqA
         Cr8uAa+7qmbkq9wG/xi3YkN7nfV4ySQRTTbdOw7UI6uMicmyc6z1ZFJFzcoGqYYUxXaA
         u5B0UWmnrecRGqZ2V2WAZFy8UmlWl2UzVezx1i/wN+2JLEaLh86zJ5Z19TapNtqB+gWO
         EV1A==
X-Gm-Message-State: AHQUAuZcSmTnuB9+a6ZWvqXqNW9m1GFOWgsooAibs+oDjHBZZsqc6oea
        9MXyT+EWTAg60PI4uZzrTaTMe15ZKLYiDrps9Pw=
X-Google-Smtp-Source: AHgI3IaUUXlVInY+v6hXxHm/VwGkufEXTBv9ztdlk1qpOnGsETERJdgB0wACvkghr0QX1okvUtw04fRIOu3IX01HqWw=
X-Received: by 2002:a6b:c005:: with SMTP id q5mr5384132iof.225.1550239789338;
 Fri, 15 Feb 2019 06:09:49 -0800 (PST)
MIME-Version: 1.0
References: <20190214130910.9201-1-tiny.windzz@gmail.com> <20190214130910.9201-5-tiny.windzz@gmail.com>
 <20190214143842.nqsh6trwdjxq2ecd@flea> <CAEExFWuxrVC1J0g93R3ifaDxOGy-20B4jftoHw932V7+wqhtxw@mail.gmail.com>
 <CAEExFWv_K_07e30dgPbafVhDD_smwZkpi6Fqk6yzCahesdnrGg@mail.gmail.com> <20190215135613.sdz56vtiawqeryi5@flea>
In-Reply-To: <20190215135613.sdz56vtiawqeryi5@flea>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Fri, 15 Feb 2019 22:09:51 +0800
Message-ID: <CAEExFWt84MmpoWeibVf4bBJXOuPy9P7RrAFmEx304zz5z1GHwQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] arm64: dts: allwinner: h6: Add CPU Operating
 Performance Points table
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, robh+dt@kernel.org,
        mark.rutland@arm.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 9:56 PM Maxime Ripard <maxime.ripard@bootlin.com> w=
rote:
>
> Hi
>
> On Fri, Feb 15, 2019 at 12:56:03AM +0800, Frank Lee wrote:
> > How about to implement a thermal driver that is not integrated with
> > gpadc =EF=BC=9F
> >
> > GPADC on soc is rarely used now.
>
> You mean GPADC in general, or the gpadc driver in particular?
> Otherwise, yes, having a driver for the thermal sensor in the H6
> sounds like a good plan for thermal throttling, but I don't see it as
> a dependency for that whole series.
At present, sunxi's thermal driver is integrated with the gpadc driver.
I have a idea to implement the thermal driver alone. I haven't started yet,
and it may take a while to do it.

How about the plan to implement a thermal drive alone and put i
under drivers/thermal?

In addition to the cpu dvfs of H6, patch v2 has been sent.

Thanks,
Yangtao
>
> Maxime
>
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
