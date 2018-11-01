Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A831EC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 20:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F0B02064C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 20:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kfT8ixVq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F0B02064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbeKBFVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 01:21:20 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:33234 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727727AbeKBFVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 01:21:20 -0400
Received: by mail-ua1-f66.google.com with SMTP id s26so5562627uao.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 13:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RDCDd0p4OmFseFi2wBnsj0C8loIAFcE/ArZDMAjsLkQ=;
        b=kfT8ixVqkLL5HtNNvmNNFp5dOjfv+B8Ej8abtSuoS32uTtrzyyd6SdgeVzJclM3Y5v
         AIdJNtWBXhXlkNRg2aY9f2nU2J9grgl9Ftw0NuJKQAFRhAVmq8pGChTn67q9eyHn4zDe
         tgsWsSqXHiATO47NdJO0FBhj8cR+exUzBmFKZa7065N9jvLWkoiwYeRTaY+iioHyiKaL
         RbBdgLmFRBQRVBK2q/8CgiJsZKrWfMrAXiOEalEKZjwVpRlJCjxK/AzAylacKzOrD/Jf
         4LtUWqH7KOvrYSYVgx/wOtzi76Gh47R13ngeLrt+njvcwHY577iuuPMQ5bGPLTl0DD7/
         S31A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RDCDd0p4OmFseFi2wBnsj0C8loIAFcE/ArZDMAjsLkQ=;
        b=tAjSB0AAhUndJYKI4E5/okhVeP2al0i/yq++1oibIQ1I7RiOKvjaYGXYkRWcLDVNPJ
         f+Hn6xA9ofLSmOgVuJzFdyUpdh8v8dNA+BwFZ1lgfslaq1/uIY46e1PgilMUB8K/pDTu
         4CAv+QzFaK+iVv/y1CZVxv2v+77VYvTLt49taxzW3Akdquv0j+U7RjrXUvjK/u69WMq5
         0FyjhCc0GUSkMMCoQEcl5CbU/FmM6RgEvEnzb6rs7ZQ147obbUWNi3vqLbGgUKcLrUei
         0pl6a+XgKAF6hHQ6QAGnLTygWJ9TQOYHL8iMMZe1HKw7vnrG8/ns145vC84lsIS9SVwn
         nhaA==
X-Gm-Message-State: AGRZ1gLB8E5CwfLAzp7A0gWcHY5zuo0cwb3xRwwWEXBrRx/wryJe8Kj6
        E/BxSMGXOc/noYJQNEYnbPdPik2tXCISqvC1J47ROw==
X-Google-Smtp-Source: AJdET5cFBrfEMGpEb6loaW9cQy091IfqFKtbs+Yu82CWKqztZ+FEsGKC2qOoF6H1Tiu4zS0vWTrQHHhdW2GJoWFKhyI=
X-Received: by 2002:ab0:7488:: with SMTP id n8mr4196822uap.115.1541103410109;
 Thu, 01 Nov 2018 13:16:50 -0700 (PDT)
MIME-Version: 1.0
References: <1541073999-11752-1-git-send-email-vbadigan@codeaurora.org> <1541073999-11752-3-git-send-email-vbadigan@codeaurora.org>
In-Reply-To: <1541073999-11752-3-git-send-email-vbadigan@codeaurora.org>
From:   Doug Anderson <dianders@google.com>
Date:   Thu, 1 Nov 2018 13:16:37 -0700
Message-ID: <CAD=FV=XbCGQ2v1EAGOxiY_7PVH0WmOy0MMnUtKi9TkJYmhe4=A@mail.gmail.com>
Subject: Re: [PATCH V3 2/2] mmc: sdhci-msm: Re-initialize DLL if MCLK is gated dynamically
To:     vbadigan@codeaurora.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Asutosh Das <asutoshd@codeaurora.org>, riteshh@codeaurora.org,
        stummala@codeaurora.org, sayalil@codeaurora.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Nov 1, 2018 at 5:08 AM Veerabhadrarao Badiganti
<vbadigan@codeaurora.org> wrote:
>
> On few SDHCI-MSM controllers, the host controller's clock tuning
> circuit may go out of sync if controller clocks are gated which
> eventually will result in data CRC, command CRC/timeout errors.
> To overcome this h/w limitation, the DLL needs to be re-initialized
> and restored with its old settings once clocks are ungated.
>
> Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
> ---
>  drivers/mmc/host/sdhci-msm.c | 59 ++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 57 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 3cc8bfe..e38a4e8 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -232,6 +232,7 @@ struct sdhci_msm_variant_ops {
>   */
>  struct sdhci_msm_variant_info {
>         bool mci_removed;
> +       bool restore_dll_config;
>         const struct sdhci_msm_variant_ops *var_ops;
>         const struct sdhci_msm_offset *offset;
>  };
> @@ -256,6 +257,7 @@ struct sdhci_msm_host {
>         bool pwr_irq_flag;
>         u32 caps_0;
>         bool mci_removed;
> +       bool restore_dll_config;
>         const struct sdhci_msm_variant_ops *var_ops;
>         const struct sdhci_msm_offset *offset;
>  };
> @@ -1025,6 +1027,36 @@ static int sdhci_msm_hs400_dll_calibration(struct sdhci_host *host)
>         return ret;
>  }
>
> +static int sdhci_msm_restore_sdr_dll_config(struct sdhci_host *host)
> +{
> +       struct mmc_ios ios = host->mmc->ios;

Please use a pointer.  Right now you're copying the whole structure
onto the stack.  Sure it's maybe only 20 bytes, but why?

...for bonus points add a separate patch that fixes all the other
places in this file that do the same thing.  A grep can see that msm
is the only one that does this, everyone else uses a pointer:

$ git grep 'struct mmc_ios.*=' -- drivers/mmc/host
drivers/mmc/host/omap_hsmmc.c:  struct mmc_ios *ios = &mmc->ios;
drivers/mmc/host/omap_hsmmc.c:  struct mmc_ios *ios = &host->mmc->ios;
drivers/mmc/host/omap_hsmmc.c:  struct mmc_ios *ios = &host->mmc->ios;
drivers/mmc/host/omap_hsmmc.c:  struct mmc_ios *ios = &host->mmc->ios;
drivers/mmc/host/omap_hsmmc.c:  struct mmc_ios *ios = &host->mmc->ios;
drivers/mmc/host/sdhci-msm.c:   struct mmc_ios ios = host->mmc->ios;
drivers/mmc/host/sdhci-msm.c:   struct mmc_ios curr_ios = host->mmc->ios;
drivers/mmc/host/sdhci-msm.c:   struct mmc_ios ios = host->mmc->ios;
drivers/mmc/host/sdhci-msm.c:   struct mmc_ios ios = host->mmc->ios;
drivers/mmc/host/sdhci-msm.c:   struct mmc_ios ios = host->mmc->ios;
drivers/mmc/host/sdhci-msm.c:   struct mmc_ios ios = host->mmc->ios;
drivers/mmc/host/sdhci-omap.c:  struct mmc_ios *ios = &mmc->ios;
drivers/mmc/host/sdhci.c:       struct mmc_ios *ios = &mmc->ios;


> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
> +       int ret;
> +
> +       /*
> +        * SDR DLL comes into picure only if clock frequency is greater than
> +        * 100MHz. And its needed only for SDR104, HS200 and HS400 cards.
> +        * Its not needed for HS400es cards.
> +        */
> +       if (host->clock <= CORE_FREQ_100MHZ ||
> +           !(ios.timing == MMC_TIMING_MMC_HS400 ||
> +           ios.timing == MMC_TIMING_MMC_HS200 ||
> +           ios.timing == MMC_TIMING_UHS_SDR104) ||
> +           ios.enhanced_strobe)

This if test is nearly copied from sdhci_msm_execute_tuning().  My
first thought it that this is complicated enough logic that you should
write a helper.

...looking at this is makes me feel like there's a bug in
sdhci_msm_execute_tuning() because it doesn't check for
"enhanced_strobe".  ...but maybe the answer is that the test in
sdhci_msm_execute_tuning() is pointless anyway because the core code
should only call execute_tuning() if we're using a mode that needs
tuning.  So maybe the answer is to remove the code from
sdhci_msm_execute_tuning()...

...but thinking even more: do we really need this logic?  Basically
you want to invalidate the saved dll config whenever the timing mode
changes, right?  ...because execute_tuning() won't be called if you go
down to a timing change that doesn't use tuning?  Maybe you can just
save the timing mode at the same time you save the phase.  If the
current timing mode doesn't equal the saved timing mode then you don't
restore the phase.


> +               return 0;
> +
> +       /* Reset the tuning block */
> +       ret = msm_init_cm_dll(host);
> +       if (ret)
> +               return ret;
> +
> +       /* Restore the tuning block */
> +       ret = msm_config_cm_dll_phase(host, msm_host->saved_tuning_phase);
> +
> +       return ret;
> +}
> +
>  static int sdhci_msm_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  {
>         struct sdhci_host *host = mmc_priv(mmc);
> @@ -1069,7 +1101,6 @@ static int sdhci_msm_execute_tuning(struct mmc_host *mmc, u32 opcode)
>                 if (rc)
>                         return rc;
>
> -               msm_host->saved_tuning_phase = phase;
>                 rc = mmc_send_tuning(mmc, opcode, NULL);
>                 if (!rc) {
>                         /* Tuning is successful at this tuning point */
> @@ -1094,6 +1125,7 @@ static int sdhci_msm_execute_tuning(struct mmc_host *mmc, u32 opcode)
>                 rc = msm_config_cm_dll_phase(host, phase);
>                 if (rc)
>                         return rc;
> +               msm_host->saved_tuning_phase = phase;
>                 dev_dbg(mmc_dev(mmc), "%s: Setting the tuning phase to %d\n",
>                          mmc_hostname(mmc), phase);
>         } else {
> @@ -1617,12 +1649,21 @@ static void sdhci_msm_set_regulator_caps(struct sdhci_msm_host *msm_host)
>
>  static const struct sdhci_msm_variant_info sdhci_msm_mci_var = {
>         .mci_removed = false,
> +       .restore_dll_config = false,

nit: Linux convention is to rely on static structures to be initted to
0 / false / NULL.  ...so no need to add an "= false" here.


>         .var_ops = &mci_var_ops,
>         .offset = &sdhci_msm_mci_offset,
>  };
>
>  static const struct sdhci_msm_variant_info sdhci_msm_v5_var = {
>         .mci_removed = true,
> +       .restore_dll_config = false,

...and here...


> +       .var_ops = &v5_var_ops,
> +       .offset = &sdhci_msm_v5_offset,
> +};
> +
> +static const struct sdhci_msm_variant_info sdm845_sdhci_var = {
> +       .mci_removed = true,
> +       .restore_dll_config = true,
>         .var_ops = &v5_var_ops,
>         .offset = &sdhci_msm_v5_offset,
>  };
> @@ -1630,6 +1671,7 @@ static void sdhci_msm_set_regulator_caps(struct sdhci_msm_host *msm_host)
>  static const struct of_device_id sdhci_msm_dt_match[] = {
>         {.compatible = "qcom,sdhci-msm-v4", .data = &sdhci_msm_mci_var},
>         {.compatible = "qcom,sdhci-msm-v5", .data = &sdhci_msm_v5_var},
> +       {.compatible = "qcom,sdm845-sdhci", .data = &sdm845_sdhci_var},
>         {},
>  };
>
> @@ -1689,6 +1731,7 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>         var_info = of_device_get_match_data(&pdev->dev);
>
>         msm_host->mci_removed = var_info->mci_removed;
> +       msm_host->restore_dll_config = var_info->restore_dll_config;
>         msm_host->var_ops = var_info->var_ops;
>         msm_host->offset = var_info->offset;
>
> @@ -1928,9 +1971,21 @@ static int sdhci_msm_runtime_resume(struct device *dev)
>         struct sdhci_host *host = dev_get_drvdata(dev);
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>         struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
> +       int ret;
>
> -       return clk_bulk_prepare_enable(ARRAY_SIZE(msm_host->bulk_clks),
> +       ret = clk_bulk_prepare_enable(ARRAY_SIZE(msm_host->bulk_clks),
>                                        msm_host->bulk_clks);
> +       if (ret)
> +               goto out;

no need for a goto since you're not undoing anything.  Just:

if (ret)
  return ret;


> +       /*
> +        * Whenever core-clock is gated dynamically, it's needed to
> +        * restore the SDR DLL settings when the clock is ungated.
> +        */
> +       if (msm_host->restore_dll_config && msm_host->clk_rate)
> +               ret = sdhci_msm_restore_sdr_dll_config(host);
> +
> +out:
> +       return ret;

No need for 'ret' variable:

if (msm_host->restore_dll_config && msm_host->clk_rate)
  return sdhci_msm_restore_sdr_dll_config(host);

return 0;
