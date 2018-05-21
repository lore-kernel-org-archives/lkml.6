Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932403AbeEUVue (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 17:50:34 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:41488 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932280AbeEUVuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 17:50:24 -0400
X-Google-Smtp-Source: AB8JxZq9+KDu4zSy8aPiQ/Ve3odHDpgFSrUONRBLhedBbfTDiluvAfJFrDdCYAh3v/49i01tshZ8Zz6eJWFB1+fD7iA=
MIME-Version: 1.0
In-Reply-To: <1526903890-35761-13-git-send-email-xieyisheng1@huawei.com>
References: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com> <1526903890-35761-13-git-send-email-xieyisheng1@huawei.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 22 May 2018 00:50:23 +0300
Message-ID: <CAHp75Vf6rDpFQCt+qG3DSWKZm36F1hkAVPtGzr6NHPuQg4vhXQ@mail.gmail.com>
Subject: Re: [PATCH 12/33] clk: bcm2835: use match_string() helper
To: Yisheng Xie <xieyisheng1@huawei.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>, linux-clk@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2018 at 2:57 PM, Yisheng Xie <xieyisheng1@huawei.com> wrote:
> match_string() returns the index of an array for a matching string,
> which can be used intead of open coded variant.
>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Eric Anholt <eric@anholt.net>
> Cc: Stefan Wahren <stefan.wahren@i2se.com>
> Cc: linux-clk@vger.kernel.org
> Cc: linux-rpi-kernel@lists.infradead.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>

> -       size_t i, j;
> -       int ret;
> +       int i, ret;

I do not see any need to change type for i.

> +               ret = match_string(cprman_parent_names,
> +                                  ARRAY_SIZE(cprman_parent_names),
> +                                  parents[i]);
> +               if (ret >= 0)
> +                       parents[i] = cprman->real_parent_names[ret];


-- 
With Best Regards,
Andy Shevchenko
