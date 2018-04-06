Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751982AbeDFJ5W (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 05:57:22 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:34502 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751874AbeDFJ5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 05:57:20 -0400
X-Google-Smtp-Source: AIpwx4/TMIn8UgJO6T2+KczG5BcZoLTR03Kn2YWgDKZFto093KFnuVd2spBc1NG6KJbAYK4Fy9Yo2JFK8ZE1d1te3Xc=
MIME-Version: 1.0
In-Reply-To: <TY1PR01MB1769064C77AE3E5ABA4993DAF5BB0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
References: <1522246950-9110-1-git-send-email-phil.edworthy@renesas.com>
 <CAHp75VeOTjZ30ok1JOW0cefZfxqUM-f0-zpTnC5TonyeqQVUKg@mail.gmail.com> <TY1PR01MB1769064C77AE3E5ABA4993DAF5BB0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 6 Apr 2018 11:57:19 +0200
X-Google-Sender-Auth: lWRHq-D_wyDDUQnGrIAP8aps1R0
Message-ID: <CAMuHMdX34f1pDCVqNV43_qtzqZ-fruOcUsUN_Ysz4ihJwe-56A@mail.gmail.com>
Subject: Re: [PATCH] gpio: dwapb: Add support for 32 interrupts
To: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hoan Tran <hotran@apm.com>, Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Michel Pollet <michel.pollet@bp.renesas.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Phil,

On Thu, Apr 5, 2018 at 11:42 AM, Phil Edworthy
<phil.edworthy@renesas.com> wrote:
> On 30 March 2018 22:26 Andy Shevchenko wrote:
>> On Wed, Mar 28, 2018 at 5:22 PM, Phil Edworthy wrote:
>> > The DesignWare GPIO IP can be configured for either 1 or 32
>> > interrupts,
>>
>> 1 to 32, or just a choice between two?
> Just a choice of 1 or 32.
> Note that by 'configured' I am talking about the hardware being configured in
> RTL prior to manufacturing a device. Once made, you cannot change it.
> This configuration affects the number of output interrupt signals from the GPIO
> Controller block that are connected to an interrupt controller.

Differentiating between different versions of an IP block using DT properties
is usually a bad idea, for several reasons:
  - What if you discover another difference later?
  - You cannot add differentiating properties retroactively, because
of backwards
     compatibility with old DTBS.

Hence I think you should introduce a new compatible value instead.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
