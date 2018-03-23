Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752042AbeCWQbJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 12:31:09 -0400
Received: from mail-qt0-f179.google.com ([209.85.216.179]:45235 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751714AbeCWQbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 12:31:06 -0400
X-Google-Smtp-Source: AG47ELs//v7uHQ2kc1vnZY297WGTCLTX1NYe3ztEfZg9GAn83XIJcdmJSsxkNgbFGKtEkJgGE4dS62IWv2w/8XSza/E=
MIME-Version: 1.0
In-Reply-To: <152182210780.178046.13284917877743312593@swboyd.mtv.corp.google.com>
References: <20180321165848.89751-1-swboyd@chromium.org> <20180321165848.89751-4-swboyd@chromium.org>
 <97380342-c3aa-5d34-7b22-f6ebbab4bafe@codeaurora.org> <1521804964.23017.96.camel@linux.intel.com>
 <152182210780.178046.13284917877743312593@swboyd.mtv.corp.google.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 23 Mar 2018 18:31:05 +0200
Message-ID: <CAHp75VeTxGu-pxqde_egsqUkLBdZujoJv=0YEj9cv8ujnthyPA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] pinctrl: qcom: Don't allow protected pins to be requested
To: Stephen Boyd <swboyd@chromium.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Timur Tabi <timur@codeaurora.org>, Stephen Boyd <sboyd@codeaurora.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>, linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Grant Likely <grant.likely@secretlab.ca>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 23, 2018 at 6:21 PM, Stephen Boyd <swboyd@chromium.org> wrote:

>        bitmap_zero(chip->valid_mask, max_gpios);
>        for (i = 0; i < len; i++)
>                set_bit(tmp[i], chip->valid_mask);

Looking to this code I just realized it would be nice to have

{of,device}_property_read_bitmask() where bitmask_parse() is called.

Since it related to change a binding, I would really take couple of
days to hear other opinions.

In the above case, you need to supply a string, like

"1-5,16,18,25"

-- 
With Best Regards,
Andy Shevchenko
