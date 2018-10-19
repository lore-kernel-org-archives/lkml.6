Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E59AECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 13:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 158B621476
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 13:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/0gZavi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 158B621476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbeJSWDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 18:03:31 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43050 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbeJSWDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 18:03:31 -0400
Received: by mail-qt1-f195.google.com with SMTP id q41-v6so38313506qtq.10;
        Fri, 19 Oct 2018 06:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WGlybueR+JBJxJX4/aOPPGvuNm4KKha+mJdIYQz+c/g=;
        b=e/0gZavi0VPYw0yf72lY8S5+C0/1O2m+EQ+lmRWiuWZ7Q+qt1UMJTWOqwKyiSEFzxb
         PVtRA0XYFMFKejJuVN2mdcQSjNycsZOij7ZUC18o60zQU253Xc96LlG4yOtVJaVVkVUa
         LI7XdE5b0M36PAJ/UkyBKVp9CSPzbZYYDPS049iDbPaqKMsK4VtMEFoSDUFMqrSsFvsG
         F+JlgxrmfO4eL9+f+0K/y9DsyahTZNBP2lLqFoRCOMstotIpmrMpM3rWJKiO/XaQL0kA
         EdC5edBFFyTzD44TSd+U8jk13L/4XpJmt+d3+sQtFC6g4UUiArm3r0ZzhJ7O1U+lLBvb
         BxRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WGlybueR+JBJxJX4/aOPPGvuNm4KKha+mJdIYQz+c/g=;
        b=gJkHd10jBGzOL9ARc7z90+UVR9/CWskid4SB4JPYW4wMHYT4Qb1z1F2KEAgyk5gOOR
         y/noTMNIZc503GqdXPM5o1BzAR0JHz4qZLWfTI+8s63fKgaYov9mczdgzSDvr4/DBdD2
         BPJoRC+9WCS/PpOnXmgf50IGVQZ+ohIyABNzuhOz5JcTEL4cq+fQc2N5MiGlwT7xv1/c
         bLzXgahIaxGJdvRoAjw8GDtZ7VYXPTzezO6FxqojI2xNz/RwQTe1f+sFDFEGuNE05hWB
         7Tm14CKtu2Ep7f5OoxFBg2zmmDsfmk+quF6fqavvGe6jthO63PpfDg+ORdF2zImVBMEQ
         I8mQ==
X-Gm-Message-State: ABuFfohI7Yt+8VKmzI5u/mrr1isB909D15cyfAf7CHeN4Q/t33EYv+kw
        h/UO/4P7XMJlPIjlhwUIJ4RezfvHOiLQkrGIpbBQ0cU2
X-Google-Smtp-Source: ACcGV63M5uDWwBtjDOZHZfUWmscHYowmT9sv92D0Act/lFyr7eNjXRjkyJW5OV9QTEmwp1gBf4f0FU2ZV/91m39M404=
X-Received: by 2002:ac8:2413:: with SMTP id c19-v6mr32732998qtc.194.1539957435393;
 Fri, 19 Oct 2018 06:57:15 -0700 (PDT)
MIME-Version: 1.0
References: <20181010172300.317643-1-lkundrak@v3.sk>
In-Reply-To: <20181010172300.317643-1-lkundrak@v3.sk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 19 Oct 2018 16:57:04 +0300
Message-ID: <CAHp75Vd_9RmfDFnSzkNOQyfKVOR1tfzbMPy0_J7_DfZ2e4A16g@mail.gmail.com>
Subject: Re: [PATCH 0/15] Add support for OLPC XO 1.75 Embedded Controller
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        quozl@laptop.org, Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        devel@driverdev.osuosl.org, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 8:23 PM Lubomir Rintel <lkundrak@v3.sk> wrote:
>
> Hi.
>
> This patchset adds support for the Embedded Controller on an OLPC XO
> 1.75 machine. OLPC XO 1.75 is a MMP2 based ARM laptop. It plugs into
> the existing OLPC platform infrastructure, currently used by the x86
> based models.
>
> The EC operates in SPI master mode, meaning the SOC is the SPI slave. It
> uses extra handshake signal to signal readiness of SOC to accept data
> from EC and to initiate a transaction if SOC wishes to submit data.
>
> The SPI slave support for MMP2 was submitted separately:
> https://lore.kernel.org/lkml/20181010170936.316862-1-lkundrak@v3.sk/T/#t
>

> THe "power: supply: olpc_battery: correct the temperature" patch was

The

> already sent out separately, but I'm including it because the last
> commit of the set depends on it.
>
> Tested to work on an OLPC XO 1.75 and also tested not to break x86
> support with an OLPC XO 1 machine. I don't have a XO 1.5, but it's
> unlikely this breaks it when XO 1 works.
>
> Thanks in advance for reviews and feedback of any kind.

Thanks for the series.
I'm about to review the patch 6, otherwise read my comments for the
rest and consider addressing them.

>
> Lubo
>


-- 
With Best Regards,
Andy Shevchenko
