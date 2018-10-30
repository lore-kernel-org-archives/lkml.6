Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00623C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB63D2082D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="koMHq43s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB63D2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbeJ3X5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 19:57:08 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38695 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbeJ3X5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 19:57:08 -0400
Received: by mail-qt1-f193.google.com with SMTP id v1-v6so9592407qtq.5;
        Tue, 30 Oct 2018 08:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lFtw6+DU1slT4MuP0Tyn01JMQ2GXDOCYhHWpLXbyKg8=;
        b=koMHq43sH0b3yC8kdle/YHBteOJckPI/f+RGpNqPZ3cF0C/bgkyD/OcgibdJ5Ty2Qx
         pd0+/+Yx9vpXTwRJEWM8b969NiGb0wrgLyERtD5thDm9IU2OP7DPk9TMp9ergSGyUjcW
         ABT870uQ/z3tYceo//tc/yicieNuPpKuTNQEZPg4QnGoE4fZxLsCIRSvIFHcdrgrZxaP
         Hpveqwz+b1yjisxRhKKUSQJBOdZoCsuDSpBaFDUyUWbKMkuEjVdPX+pn4FIQ4MRCFK1I
         pEz4zebMbr8wkSFIe6MypMd/p7K4mALOZLMSv3g2ichoZaqvdHqvqil7JQGYmWURy/AI
         njmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lFtw6+DU1slT4MuP0Tyn01JMQ2GXDOCYhHWpLXbyKg8=;
        b=QpROjHy1lqoLO6KZ6IaAS2DAc4WQnseQD28+mnUx+DkpCiiQ6ZAgYLCHvJ9HRcVhEr
         T8yt5TeZvn2BdfCmpEXtJ0xYmNCCWG6TTkuaDaAnGRGR9fS2DQ/zwRwI6tef679RN1WB
         2uiEUx3FtFbFFtFXv+Z4i3bvjDo8SrCk6fV1Hq5IccI57JnTPujXxou8//EWvOv29Sek
         7L3yWiSwNyHqEEhTq7ukXaqg1aaSfvB7carLnAaam4y+zY+C+lgF+YCjUkXHoQ+ISqbg
         2CF66JP0iXkTRJwbJw315qrX48JDQVLqqhQCFi66zRq0xm/SSb9D89OVM8hbpfz9xWA/
         YIVA==
X-Gm-Message-State: AGRZ1gI1X2IRmEE5JpkJDV9+7NJoZR/UHJ9rLo7kB6pQW9zD8l9yFBbk
        U58IbDbVDDLKb4N+DN6M30XSdmwB4SiRkQ+GDp4=
X-Google-Smtp-Source: AJdET5cUNYYHzX08hEX8KJc4CW8RbZfiXnOnRqTcRyYq9qLiEIVOprSnhe62QSSHDOgTJ5ihtGEjX3CRVgviHWKVjKA=
X-Received: by 2002:a0c:e202:: with SMTP id q2mr5116394qvl.180.1540911797398;
 Tue, 30 Oct 2018 08:03:17 -0700 (PDT)
MIME-Version: 1.0
References: <20181025232517.ywnw54qibemosjws@picard> <154083512089.98144.9141070901932719147@swboyd.mtv.corp.google.com>
 <CAHp75VfnN5tF1Z9+CDDhKFNG5QfCRcGOZeAkpf-5BfCEx16gvg@mail.gmail.com>
 <CAHp75VctdBE-GM60udJawBCXdmoOqZn4N=kFWz5GLHzjPG2iQQ@mail.gmail.com>
 <20181029190819.2ivlx73n6y6sx4vk@picard> <ffc4bcc9-62c3-8940-85d6-d0fd01f3a1b8@linux.intel.com>
 <c8fb730a-c160-41b4-dad0-8ed8594e5687@redhat.com> <20181030143836.feo7zcxiestylxoo@picard>
 <d21fe935-5732-7f8c-2c26-3fc3969b4c1c@redhat.com>
In-Reply-To: <d21fe935-5732-7f8c-2c26-3fc3969b4c1c@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 30 Oct 2018 17:03:05 +0200
Message-ID: <CAHp75Ve8FjHLYkq1uXhen40DDj8DJa42vXXs83qDimigcH-=DA@mail.gmail.com>
Subject: Re: Regression found (Stop-marking-clocks-as-CLK_IS_CRITICAL)
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     duffydack73@gmail.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Stable <stable@vger.kernel.org>,
        Johannes Stezenbach <js@sig21.net>,
        Carlo Caione <carlo@endlessm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mogens-jensen@protonmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 4:48 PM Hans de Goede <hdegoede@redhat.com> wrote:
> On 30-10-18 15:38, Dean Wallace wrote:

> > Excellent work Hans.  Compiled 4.19 with
> > 0001-ASoC-intel-cht_bsw_max98090_ti-Use-pmc_plt_clk_0-ins.patch, sound
> > works as before.
> >
> > for i in /sys/kernel/debug/clk/pmc_plt_clk_?; do echo -n "$i: "; cat $i/clk_flags; echo; done
> > /sys/kernel/debug/clk/pmc_plt_clk_0:
> > /sys/kernel/debug/clk/pmc_plt_clk_1:
> > /sys/kernel/debug/clk/pmc_plt_clk_2:
> > /sys/kernel/debug/clk/pmc_plt_clk_3:
> > /sys/kernel/debug/clk/pmc_plt_clk_4:
> > /sys/kernel/debug/clk/pmc_plt_clk_5:
>
> Ok, so as I expected the Swanky is using pmc_plt_clk_0
> as mclk instead of pmc_plt_clk_3. Now the question
> becomes is this true for all the designs using the
> max98090 codec?

> 1) Unconditionally use pmc_plt_clk_0 as mclk (as my test patch does)
> in the cht_bsw_max98090_ti.c machine driver

I don't know the details, but the main question here indeed do we ever
had a working example of that machine with CLK #3 in use?

P.S. I would go your first proposal until the opposite will be proved.

-- 
With Best Regards,
Andy Shevchenko
