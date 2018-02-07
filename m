Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754194AbeBGNwK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 08:52:10 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:41777 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753630AbeBGNwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 08:52:07 -0500
X-Google-Smtp-Source: AH8x227kX9BktSvjcOJnEpUAGP+8ub8rrLyX3KtWj0XVr+9tjEh5gahutk67QGGN3D2T5d5xlchCU0AlKDSrQB8TMzA=
MIME-Version: 1.0
In-Reply-To: <20180129005948.7714-1-bjorn.andersson@linaro.org>
References: <20180129005948.7714-1-bjorn.andersson@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 7 Feb 2018 14:52:05 +0100
Message-ID: <CACRpkdb0OWQzeJZ7K1bXrdNPwu0GhygW1p04Xoyf9WjTg7+=BQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: msm: Use dynamic GPIO numbering
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Timur Tabi <timur@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 29, 2018 at 1:59 AM, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:

> The base of the TLMM gpiochip should not be statically defined as 0, fix
> this to not artificially restrict the existence of multiple pinctrl-msm
> devices.
>
> Fixes: f365be092572 ("pinctrl: Add Qualcomm TLMM driver")
> Reported-by: Timur Tabi <timur@codeaurora.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

OK I put this in devel for v4.17, let's see if something explodes
in linux-next else we can go with this.

Otherwise we need something that conserves base 0 for singular
TLMM drivers and make it -1 for newer platforms with several
instances.

Yours,
Linus Walleij
