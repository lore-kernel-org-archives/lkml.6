Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE7AC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 17:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18BAD2152F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 17:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="szdmufcv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18BAD2152F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbeIZXc0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 19:32:26 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37374 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727411AbeIZXc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 19:32:26 -0400
Received: by mail-qk1-f194.google.com with SMTP id c13-v6so15974909qkm.4;
        Wed, 26 Sep 2018 10:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=171IPcMiyiUKdE7TRm/dlfQkmOyNnF/FP63UNve+vFE=;
        b=szdmufcvHqGP9CRqcbjcE1WCNS2Rr1qd5aeOY50saZdFC6/q7U8pYZNiDc3mSprGs6
         JMRCerQeeBlh+Iv7yIqHpGRIQ7a8eQYM8BSGMyiLnNtuPSdZLgbryP0h+fl0BPLlRONy
         pLRFX6b5L2fJkMMHo0jzy9BzRmQXwB99VJO+Tv15acM1yNGanFewBUdrtFCjGaOhQ9At
         c9cPuq+pEnuUCmPuPXxiS659NhEdmptF5A2jqedRWZATZYIZh1pELfJ5Scp40jFx84on
         zAnNu5r5kZuRiYRk/0fmVhQXxdfUYh/c71/x1l9FBbmbJM4UFIOTctJ0AEEQ4Mif1ZHS
         /dzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=171IPcMiyiUKdE7TRm/dlfQkmOyNnF/FP63UNve+vFE=;
        b=sPKP217KtQJmrPPDIQNKoMjKczAC5o7/d840f3JcdT1/ciRB+lBNmkGLtcRdExuXmC
         vePigk66cxGMyoN/mgNLvaMB8h4L3whenxDZt1agpWMxc8PVJTfng/TgzVG0e/yiZle5
         jAgJqdJqjL5IIW0rWM+bamEZXn5lBy+RAB4p2F+1JmbJ63rgXr9O3Jx1YVnWe8GjMtUj
         VCuzoSH9Qma+nMkLlclsquvaZ5Ol/qoXRbR2PsSvTvbH8i4ZRir/3LiBKnDFlbKcLJ/k
         IwIlXICSjxPq+d0yExhjlRw3g/TrBv7aq9NrGHqxB/JB1RRvxAkbmUAHPMZvGUi+wCQO
         XZQA==
X-Gm-Message-State: ABuFfoi3JZkjvfFIAwpKFfOEWZbIy4Z8iwaJrGrF1WDw9Ar8W7tX2wn/
        4Pup3XjjwV7fnfyGuZXGeyiaDzlEx+sZ/3q1lezyLwN7
X-Google-Smtp-Source: ACcGV61PuFz1PfuyPdZHEFTmejtZj5q1XdeMe5/ZVRR87J9zHG8of9jIVx2Z7x4JnZbt7IaWHYU0+sJm+8I6IFRBwiY=
X-Received: by 2002:ae9:d885:: with SMTP id u127-v6mr4862915qkf.219.1537982309282;
 Wed, 26 Sep 2018 10:18:29 -0700 (PDT)
MIME-Version: 1.0
References: <20180903180415.31575-1-rajneesh.bhardwaj@linux.intel.com>
 <20180903180415.31575-4-rajneesh.bhardwaj@linux.intel.com>
 <CAHp75VcE+BY=8aKEGqzkDBVazLGtwNNCa1CYCKGirS1vBLVXPg@mail.gmail.com> <69ad420e-362c-d8c9-331f-056cdaefb1eb@linux.intel.com>
In-Reply-To: <69ad420e-362c-d8c9-331f-056cdaefb1eb@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 26 Sep 2018 20:18:18 +0300
Message-ID: <CAHp75VeCC0CUmzieujpxUP1A3Mn8J9gekX6Vn-fbtD_ZFPbnYw@mail.gmail.com>
Subject: Re: [PATCH 4/4] platform/x86: intel_telemetry: report debugfs failure
To:     rajneesh.bhardwaj@linux.intel.com
Cc:     Platform Driver <platform-driver-x86@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Souvik Kumar Chakravarty <souvik.k.chakravarty@intel.com>,
        matt.turner@intel.com, "Brown, Len" <len.brown@intel.com>,
        Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 5:24 PM Bhardwaj, Rajneesh
<rajneesh.bhardwaj@linux.intel.com> wrote:
> On 26-Sep-18 7:26 PM, Andy Shevchenko wrote:
> > On Mon, Sep 3, 2018 at 9:05 PM Rajneesh Bhardwaj
> > <rajneesh.bhardwaj@linux.intel.com> wrote:

> >> not be obtained and result in a invalid telemetry_plt_config.
> > What is telemetry_plt_config?
>
> Internal data structure that holds platform config, maintained by the
> telemetry platform driver.

You need to spell if for the reader.

> >> This is also applicable to the platforms where the BIOS supports IPC1
> >> device under debug configurations but IPC1 is disabled by user or the
> >> policy.
> >>
> >> This change allows user to know the reason for not seeing entries unde=
r
> >> /sys/kernel/debug/telemetry/* when there is no apparent failure at boo=
t.

> >> +exit:
> >> +       pr_debug(pr_fmt(DRIVER_NAME) " Failed\n");
> > Completely useless.
> >
> > Device core does it in generic way.
>
> If i remove this print then perhaps there is no need of this patch.

Maybe.

> Reason to print this is that the platform driver / core driver does not
> show any error.

If the code fails and returns 0 =E2=80=94 it's a bug in error reporting ins=
ide the code.

> In-fact they are even loaded in module table. OTOH, this
> debugfs interface fails. This is very confusing to the users if they
> check the lsmod output so i feel this print might help.

Again, device core *already has* this and even more (it prints also a
return code!).

--=20
With Best Regards,
Andy Shevchenko
