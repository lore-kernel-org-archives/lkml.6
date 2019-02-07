Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9EC6C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 20:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99C6C21721
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 20:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PxTyxHN1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfBGU02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 15:26:28 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:40108 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbfBGU01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 15:26:27 -0500
Received: by mail-it1-f193.google.com with SMTP id h193so3154606ita.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 12:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YYogv0ka9R4eviTDJxJgfktV/LLRttaROHsNpKGSpSM=;
        b=PxTyxHN1hoesG4TBnAHUlMse5Rx1kOxDW0RujRmLvjkBFwEeMz5u4yT8I69L70ENnf
         3g1+jSbFJtvkg9Js5jFe2GNFHbedkucDl9MqYG53NwtlLT/cBYr8q0wfw+RU2a9vAvSt
         LUDYmOMjsd3uIe5PyrBLb5QVcT6bjeeJDQVUCeeR73mtv5200ufpsXReSoLb4TjcaEoG
         KcZK03EWFWekB5RCjvyD3n6iYbY4yYYOPVRLdzYswpBlMa1fL2nqqhUqOMTSD8AMDXF/
         NTDA1Ssk50W6NEZuP/C9CaGv/N/PNDcJpfmpjOJB1m5gx4QG/wM4w3XstEngvmf3dsl4
         3ZAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YYogv0ka9R4eviTDJxJgfktV/LLRttaROHsNpKGSpSM=;
        b=XLhHoB1aB5HGe2VyZvHO8SUGbSnhQOr86Cl0Ctj7lZcHLVi9qy7xqIZbPadSF5o/RA
         VRqW9jjZKEHF+O4oX0LGR8hK+wmw4saI/HVThhV45muDalNOapHLuouwUGJc4uhpe+8R
         lMXWhfnOuS4f8y3mRpa62hYtLAx3p2+7rwDoZd5Z9Cs03MoZqFugeyJ5pXJS0Tfa9zMt
         0QLMjsE44snExcW7OO9iJeYUZ3pF+4V8b2fk9krb2h0rnU+QNOI7hDXp7uok+4OXZ8gg
         ptHPDza4ugppgc73W/z5s9y1RDdd1w3sOspZ0ZSzIn8TfuDUaO2p1QC44KPpvLZRY4I5
         Bj9w==
X-Gm-Message-State: AHQUAuZNn+8Roc83hY6bbNxBnMGh2SMEKpEGwKMB8cfr47kBpIEpEghD
        BMi7QhXgsPxySUO2bfSFxnCmc+Rm2fewHJbZoHAjcg==
X-Google-Smtp-Source: AHgI3IaQ3+vJNfeCJ+W99aHeTHlZlgJ6d9QJM/gUgVMCJqkxMBpECb7Ts13bCba8MHs1MtIm3R9abENa/+xiFwL/iys=
X-Received: by 2002:a24:db02:: with SMTP id c2mr6811884itg.137.1549571186682;
 Thu, 07 Feb 2019 12:26:26 -0800 (PST)
MIME-Version: 1.0
References: <cover.1548981329.git.saiprakash.ranjan@codeaurora.org> <c050252dc8eb3fea03119cd5efc422ed6e48834e.1548981329.git.saiprakash.ranjan@codeaurora.org>
In-Reply-To: <c050252dc8eb3fea03119cd5efc422ed6e48834e.1548981329.git.saiprakash.ranjan@codeaurora.org>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Thu, 7 Feb 2019 13:26:16 -0700
Message-ID: <CANLsYkwoqOhtENkhhSY5Tv23-vgUst4oakWrmQsB97=gDTVQLA@mail.gmail.com>
Subject: Re: [PATCHv7 5/6] coresight: etm4x: Add ETM PIDs for SDM845 and MSM8996
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Doug Anderson <dianders@chromium.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Tingwei Zhang <tingwei@codeaurora.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Jan 2019 at 17:54, Sai Prakash Ranjan
<saiprakash.ranjan@codeaurora.org> wrote:
>
> Instead of overriding the peripheral id(PID) check in AMBA
> by hardcoding them in DT, add the PIDs to the ETM4x driver.
> Here we use Unique Component Identifier(UCI) for MSM8996
> since the ETM and CPU debug module shares the same PIDs.
> SDM845 does not support CPU debug module.
>
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>
> ---
> For testing, all dependent patches are in below tree:
>  * https://github.com/saiprakash-ranjan/linux/tree/coresight-next
>
> This patch depends on UCI support by Mike Leach in below link:
>  * https://lore.kernel.org/lkml/20190130234051.2294-1-mike.leach@linaro.org/
> ---
>  drivers/hwtracing/coresight/coresight-etm4x.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
> index 08ce37c9475d..5819ced2beec 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.c
> @@ -1078,11 +1078,15 @@ static struct amba_cs_uci_id uci_id_etm4[] = {
>  };
>
>  static const struct amba_id etm4_ids[] = {
> -       CS_AMBA_ID(0x000bb95d),         /* Cortex-A53 */
> -       CS_AMBA_ID(0x000bb95e),         /* Cortex-A57 */
> -       CS_AMBA_ID(0x000bb95a),         /* Cortex-A72 */
> -       CS_AMBA_ID(0x000bb959),         /* Cortex-A73 */
> -       CS_AMBA_UCI_ID(0x000bb9da, uci_id_etm4),        /* Cortex-A35 */
> +       CS_AMBA_ID(0x000bb95d),                 /* Cortex-A53 */
> +       CS_AMBA_ID(0x000bb95e),                 /* Cortex-A57 */
> +       CS_AMBA_ID(0x000bb95a),                 /* Cortex-A72 */
> +       CS_AMBA_ID(0x000bb959),                 /* Cortex-A73 */
> +       CS_AMBA_UCI_ID(0x000bb9da, uci_id_etm4),/* Cortex-A35 */
> +       CS_AMBA_UCI_ID(0x000f0205, uci_id_etm4),/* Qualcomm Kryo */
> +       CS_AMBA_UCI_ID(0x000f0211, uci_id_etm4),/* Qualcomm Kryo */
> +       CS_AMBA_ID(0x000bb802),                 /* Qualcomm Kryo 385 Cortex-A55 */
> +       CS_AMBA_ID(0x000bb803),                 /* Qualcomm Kryo 385 Cortex-A75 */

I am good with this patch but there isn't much I can do with it until
Mike's patchset has been merged.  Please submit again when that has
been done.

Thanks,
Mathieu

>         {},
>  };
>
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
>
