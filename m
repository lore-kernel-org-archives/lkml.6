Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753575AbeDSONc (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 10:13:32 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33345 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751957AbeDSON3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 10:13:29 -0400
X-Google-Smtp-Source: AIpwx4+7G6mxUJop/rMV8awrugz9dO/rd/PDgQboEQWpyKAx4OAFA3842f3mc/pDfSbuW4BtZVGmIg==
Message-ID: <1524147206.2601.104.camel@baylibre.com>
Subject: Re: [PATCH 0/2] nvmem: meson-efuse: add write support
From: Jerome Brunet <jbrunet@baylibre.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>
Cc: linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Thu, 19 Apr 2018 16:13:26 +0200
In-Reply-To: <20180316150113.9779-1-jbrunet@baylibre.com>
References: <20180316150113.9779-1-jbrunet@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-03-16 at 16:01 +0100, Jerome Brunet wrote:
> This changeset adds write support to meson efuse driver.
> The first patch just changes the way the nvmem data are allocated w/o
> any functional changes. The second patches actually adds write support.
> 
> The memory being an OTP, it is safer if it remains read-only by default,
> which is why I also submitted this DT patch [0].
> 
> If a user knows what he is doing, it should be easy to remove the
> read-only property from the board DT. This can be done in u-boot, before
> starting linux:
> 
>  > fdt rm /efuse read-only
> 
> Tested on the gxl libretech-cc

Hi Srinivas,

Is this patchset ok with you ? Do you want to me to change something ?

Regards
Jerome

> 
> [0]: https://lkml.kernel.org/r/20180316145021.8517-1-jbrunet@baylibre.com
> 
> Jerome Brunet (2):
>   nvmem: meson-efuse: remove econfig global
>   nvmem: meson-efuse: add write support
> 
>  drivers/nvmem/meson-efuse.c | 37 +++++++++++++++++++++++++++----------
>  1 file changed, 27 insertions(+), 10 deletions(-)
> 
