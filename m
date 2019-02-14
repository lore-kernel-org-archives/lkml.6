Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F948C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2D1E222A4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550140985;
	bh=fahtXq3DVKL0vXCvKJOXinAYJ3+kxzScXhki9IFX4dI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=RbLmKMHMo+k1WBWyz18XUhc+iCgsYSPXXFtUzBJgwXPe/iT7mkrkRcg3dncYwKPRC
	 /lu+xeeAba8ursTyQECyC9t1gLRYFrIcl3PwEAOtL+rUGCCtaJ4FswN1AQD866sNMp
	 MicGFmxUGTivAnTTN3qRIXeDsLGCsJOirgHmx948=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406700AbfBNKnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 05:43:03 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33377 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394286AbfBNKnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 05:43:02 -0500
Received: by mail-ot1-f68.google.com with SMTP id i20so9759713otl.0;
        Thu, 14 Feb 2019 02:43:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RSC7FfOp1eL3+/dELdJD9KCYfJPiqPMHcMMMOYxa89A=;
        b=Vhvwbb+2SJy9sMbZRbeHh+ZAIU7HReuImsI0kOqa579l7S4a/pCJeTCnaaYTRZgkWy
         7vkCmLhtddRGRQGzrBsKuySHXDR14272G2LNw1xo4SbMYeFSk/4ej6qxMUkgpYwDJuMo
         Yqf4QYpyy0dZRuluSlfJgb2Qkitmt2ZB00y7PbWl6Cd0PQCIks6zKy02qqPwVUutpXi+
         u5Yc4rFe/rspGA7ZYJmXwxzX6knZcBErmJWQ6LZWb6/o0rCo/flI3WTsRZaU2O2aDuPc
         +xD0iNHeaVwe3Av9nZIs1Uo1WVqLs8n8eG8TeeD9d1jCHWhTe7HFvsur/LF+lBlQfUwT
         lY5w==
X-Gm-Message-State: AHQUAuZev8t5x/xpKfLrMHTEsJkcG8Ej18i3E/hUAb29EFoPI6xEqYlK
        dZriCylbPHMvlPOstXBuh7QN/ye9z4D+eZrGUyQ=
X-Google-Smtp-Source: AHgI3IYjNDAnrA4i4gmx9VI6xwBkZp4/AL2HD4rDKLoJ//d8HzzpYcgzfcimfRRsbu7dCeY2jBxIu9SvMKtIK26xpzQ=
X-Received: by 2002:a9d:638c:: with SMTP id w12mr1923290otk.139.1550140980784;
 Thu, 14 Feb 2019 02:43:00 -0800 (PST)
MIME-Version: 1.0
References: <1550130368-60513-1-git-send-email-wangxiongfeng2@huawei.com> <1550130368-60513-2-git-send-email-wangxiongfeng2@huawei.com>
In-Reply-To: <1550130368-60513-2-git-send-email-wangxiongfeng2@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 14 Feb 2019 11:42:49 +0100
Message-ID: <CAJZ5v0husvV--mD_8B9cXx6-rD1677s6zT6tcjwk3Dg-dNPAxw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ACPI / CPPC: Add a helper to get desired performance
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, gcherianv@gmail.com,
        Prashanth Prakash <pprakash@codeaurora.org>,
        George Cherian <george.cherian@cavium.com>,
        Robert Moore <robert.moore@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        John Garry <john.garry@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 8:46 AM Xiongfeng Wang
<wangxiongfeng2@huawei.com> wrote:
>
> This patch add a helper to get the value of desired performance
> register.
>
> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> ---
>  drivers/acpi/cppc_acpi.c | 38 ++++++++++++++++++++++++++++++++++++++
>  include/acpi/cppc_acpi.h |  1 +
>  2 files changed, 39 insertions(+)
>
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 217a782..93588c5 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1051,6 +1051,44 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
>  }
>
>  /**
> + * cppc_get_desired_perf - Get the value of desired performance register.
> + * @cpunum: CPU from which to get desired performance.
> + * @desired_perf: address of a variable to store the returned desired performance
> + *
> + * Return: 0 for success, -EIO otherwise.
> + */
> +int cppc_get_desired_perf(int cpunum, u64 *desired_perf)
> +{
> +       struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpunum);
> +       int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpunum);
> +       struct cpc_register_resource *desired_reg;
> +       struct cppc_pcc_data *pcc_ss_data = NULL;
> +       int regs_in_pcc = 0;

It would be better to use bool here, but it would be even better to
not try to avoid calling cpc_read() in two branches.

> +
> +       desired_reg = &cpc_desc->cpc_regs[DESIRED_PERF];
> +
> +       if (CPC_IN_PCC(desired_reg)) {

    int ret = 0;

> +               if (pcc_ss_id < 0)
> +                       return -EIO;
> +               pcc_ss_data = pcc_data[pcc_ss_id];
> +               down_write(&pcc_ss_data->pcc_lock);

    if (send_pcc_cmd(pcc_ss_id, CMD_READ) >= 0)
            cpc_read(cpunum, desired_reg, desired_perf);
    else
            ret = -EIO;

    up_write(&pcc_ss_data->pcc_lock);
    return ret;

> +               regs_in_pcc = 1;
> +               if (send_pcc_cmd(pcc_ss_id, CMD_READ) < 0) {
> +                       up_write(&pcc_ss_data->pcc_lock);
> +                       return -EIO;
> +               }
> +       }

cpc_read(cpunum, desired_reg, desired_perf);
return 0;

> +
> +       cpc_read(cpunum, desired_reg, desired_perf);
> +
> +       if (regs_in_pcc)
> +               up_write(&pcc_ss_data->pcc_lock);
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(cppc_get_desired_perf);
> +
> +/**
>   * cppc_get_perf_caps - Get a CPUs performance capabilities.
>   * @cpunum: CPU from which to get capabilities info.
>   * @perf_caps: ptr to cppc_perf_caps. See cppc_acpi.h
