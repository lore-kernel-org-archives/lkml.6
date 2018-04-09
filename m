Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932697AbeDIBeE (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 21:34:04 -0400
Received: from mail-ot0-f181.google.com ([74.125.82.181]:39049 "EHLO
        mail-ot0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932611AbeDIBeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 21:34:02 -0400
X-Google-Smtp-Source: AIpwx48boj2Lh9+oMv7AMQ8HWWsXq/ALC+ybxwoWV7KJ8W6/mhQ68MRvy/V+9THs6jqAO4hxBx+8lIR8s0zSIn9ZB8k=
MIME-Version: 1.0
In-Reply-To: <1523231855-7854-1-git-send-email-nicoleotsuka@gmail.com>
References: <1523231855-7854-1-git-send-email-nicoleotsuka@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 8 Apr 2018 22:34:01 -0300
Message-ID: <CAOMZO5BK4v8arweyBy_C2n8n3ziBYC2peg9qooR8G9mrP8D9gg@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl_esai: Fix divisor calculation
 failure at lower ratio
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Marek Vasut <marex@denx.de>,
        alsa-devel@alsa-project.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolin,

On Sun, Apr 8, 2018 at 8:57 PM, Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> When the desired ratio is less than 256, the savesub (tolerance)
> in the calculation would become 0. This will then fail the loop-
> search immediately without reporting any errors.
>
> But if the ratio is smaller enough, there is no need to calculate
> the tolerance because PM divisor alone is enough to get the ratio.
>
> So a simple fix could be just to set PM directly instead of going
> into the loop-search.
>
> Reported-by: Marek Vasut <marex@denx.de>
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> Cc: Marek Vasut <marex@denx.de>

If this fixes Marek's usecase then I think we should also add:

Cc: <stable@vger.kernel.org>

Thanks
