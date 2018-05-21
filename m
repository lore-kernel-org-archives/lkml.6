Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753156AbeEULhT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 07:37:19 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:39170 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752717AbeEULhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 07:37:07 -0400
X-Google-Smtp-Source: AB8JxZqEKJmYH47e5tbgAfVAvuNxaqDtH5xnmsLIAdKO/BbK8sO24phkfHSe9YadDzA2V8ohtAYkzHD/cdV3Hn6FU+U=
MIME-Version: 1.0
In-Reply-To: <1526681037-2074-4-git-send-email-scott.branden@broadcom.com>
References: <1526681037-2074-1-git-send-email-scott.branden@broadcom.com> <1526681037-2074-4-git-send-email-scott.branden@broadcom.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 21 May 2018 13:37:06 +0200
Message-ID: <CAPDyKFpr6TzDDJA3gaczGzv+5xjjvhqPB1rqL86G4Dmw2xHeXg@mail.gmail.com>
Subject: Re: [PATCH 3/3] mmc: sdhci-iproc: add SDHCI_QUIRK2_HOST_OFF_CARD_ON
 for cygnus
To: Scott Branden <scott.branden@broadcom.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Corneliu Doban <corneliu.doban@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 May 2018 at 00:03, Scott Branden <scott.branden@broadcom.com> wrote:
> From: Corneliu Doban <corneliu.doban@broadcom.com>
>
> The SDHCI_QUIRK2_HOST_OFF_CARD_ON is needed for the driver to
> properly reset the host controller (reset all) on initialization
> after exiting deep sleep.
>
> Signed-off-by: Corneliu Doban <corneliu.doban@broadcom.com>
> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> Reviewed-by: Srinath Mannam <srinath.mannam@broadcom.com>

Applied for fixes, by adding a fixes+stable tag, thanks!

    Fixes: c833e92bbb60 ("mmc: sdhci-iproc: support standard byte
register accesses")
    Cc: stable@vger.kernel.org # v4.10+

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-iproc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
> index 1f0ab08..d0e83db 100644
> --- a/drivers/mmc/host/sdhci-iproc.c
> +++ b/drivers/mmc/host/sdhci-iproc.c
> @@ -186,7 +186,7 @@ static const struct sdhci_ops sdhci_iproc_32only_ops = {
>
>  static const struct sdhci_pltfm_data sdhci_iproc_cygnus_pltfm_data = {
>         .quirks = SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK,
> -       .quirks2 = SDHCI_QUIRK2_ACMD23_BROKEN,
> +       .quirks2 = SDHCI_QUIRK2_ACMD23_BROKEN | SDHCI_QUIRK2_HOST_OFF_CARD_ON,
>         .ops = &sdhci_iproc_32only_ops,
>  };
>
> --
> 2.5.0
>
