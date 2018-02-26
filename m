Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753067AbeBZMnd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 07:43:33 -0500
Received: from mail-ot0-f195.google.com ([74.125.82.195]:43692 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753042AbeBZMn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 07:43:29 -0500
X-Google-Smtp-Source: AG47ELu3oT4IdbZGJIimP13jLKy5JjEMbzM/5ZnfX7fTMWCfGecOvM35D8PMt8v9eIEbghz0I4FiK7BRK8ptjr5l6uI=
MIME-Version: 1.0
In-Reply-To: <20180226120418.3589-1-colin.king@canonical.com>
References: <20180226120418.3589-1-colin.king@canonical.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 26 Feb 2018 09:43:27 -0300
Message-ID: <CAOMZO5DriLRHgwD3rn562UM5WtwTmb-owZ+OTTmfCONvmGNG8A@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: imx: fix unsigned check if nfuncs with less than
 or equal zero
To: Colin King <colin.king@canonical.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        inus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 9:04 AM, Colin King <colin.king@canonical.com> wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> The unsigned integer nfuncs is being error checked with a value less
> or equal to zero; this is always false if of_get_child_count returns
> a -ve for an error condition since nfuncs is not signed. Fix this by
> making variables nfuncs and i signed integers.
>
> Detected with Coccinelle:
> drivers/pinctrl/freescale/pinctrl-imx.c:620:6-12: WARNING: Unsigned
> expression compared with zero: nfuncs <= 0
>
> Fixes: ae75ff814538 ("pinctrl: pinctrl-imx: add imx pinctrl core driver")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
