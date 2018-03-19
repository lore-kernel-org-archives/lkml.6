Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932375AbeCSK0m (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 06:26:42 -0400
Received: from mail-ot0-f173.google.com ([74.125.82.173]:43503 "EHLO
        mail-ot0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755372AbeCSK0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 06:26:37 -0400
X-Google-Smtp-Source: AG47ELuJehCLthMVEgRRDf7jcn2bYq27amE9h+XVFiXATeL35qN1L+dXi7nVCBKDCtzgbzK+pss9til2fpU/yg8WU10=
MIME-Version: 1.0
In-Reply-To: <152122292977.70929.17084619305591596735@swboyd.mtv.corp.google.com>
References: <1519071723-31790-1-git-send-email-david@lechnology.com>
 <1519071723-31790-11-git-send-email-david@lechnology.com> <CAMpxmJVxfGtO=kh63KF-5Uqew3yy97DsK4FSd14CyyRQTOhrTA@mail.gmail.com>
 <152122292977.70929.17084619305591596735@swboyd.mtv.corp.google.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 19 Mar 2018 11:26:35 +0100
Message-ID: <CAMRc=Me-OCQjB-q8iV5k-n00-iF8aH-UU444iL1zCN=DdKnwzA@mail.gmail.com>
Subject: Re: [PATCH v7 10/42] clk: davinci: New driver for davinci PSC clocks
To: Stephen Boyd <sboyd@kernel.org>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        David Lechner <david@lechnology.com>, linux-clk@vger.kernel.org,
        linux-devicetree <devicetree@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>, Adam Ford <aford173@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-16 18:55 GMT+01:00 Stephen Boyd <sboyd@kernel.org>:
> Quoting Bartosz Golaszewski (2018-02-28 04:38:38)
>> 2018-02-19 21:21 GMT+01:00 David Lechner <david@lechnology.com>:
>>
>> I believe there to be two issues: one is with v7 - we need to increase
>> the clock reference count in davinci_psc_genpd_attach_dev().
>>
>> Second is the error path in the clock framework - we should remove the
>> destroyed clk_core from the debug list, which is not being done now.
>>
>> Why we even need to track the refcount of clk_core is a mistery for me
>> though. Stephen, Mike?
>>
>
> Which part of the code are we talking about? I see that
> __clk_core_init() calls clk_debug_register() when ret == 0 and that
> looks fine. I do wonder why clk_debug_register() even returns a value
> though because we ignore it.

Hi Stephen,

invalid usage of clock pm ops was the culprit here. I just had not
understood why we count references in the CCF - now I get it so
nevermind this mail.

Thanks,
Bart
