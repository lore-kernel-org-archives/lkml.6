Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F82DC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 20:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0B7D20857
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 20:29:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DuNqhcyw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbfBGU3I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 15:29:08 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:36164 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbfBGU3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 15:29:08 -0500
Received: by mail-it1-f196.google.com with SMTP id c9so3248629itj.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 12:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XQMPFtgiD9kRlMP0xZT8Ht2uYetxaIQrdf6+lFc9OpY=;
        b=DuNqhcywKP09C6NkoUbMBjCCJTWJVY06rTcY5nHiNAAZXOZXE00E0eUwJpcVQmsjGc
         IDh+VcS8g7OpsodKnX2ftUO5X3G9uo6qdL+SGcqn37ijRqmkYb5HCc5DI1buktEry9sS
         glyXZQTDQ8ajIZEzN4p2LJeVpfkBHk0Jx4ca3M6Oryl4uLqxh4VqpQBv76h5q9DVo8vN
         Us6ID3Rpjgv1VKu1qxezX4ppdACsfyndpzI4GF5VzJewcZJCk/IWMKNzOp9ad9O8Qat9
         K6iiITDOQq0Cs4wcPhbkTy90f9Y5I+eGGSOInrX6yN/HaTkU6tBg7DBfG3xwmM2bEHB4
         Ztxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XQMPFtgiD9kRlMP0xZT8Ht2uYetxaIQrdf6+lFc9OpY=;
        b=qwYzXYrRBIHDFNw6dTpYt4m5guk3ECo1NviuCAmIHplSzseimWGyiPFw1t+aUiV1wv
         fFkDzYpX2MpxgIXC0heRdJsHffhtU715hRgXXqKbt+cSRQ70VbTjKm0xg/hWNMMw85YL
         kfYIC23Qead9niwFwIt9N/6Z3x+VUyr1y80DnDF74pNtxgkKXvFzg5ji4NWcsUA0twtl
         LU7UZISNNGkynFfywIuC00Fhmx5MoQ2B9tkrfKPNhqisRdv+s1r9FGWdH00LHtPLZ67V
         ZVR+FN5VgiYaiUkCrBuPSKUtVlN1GRfxb3Ae7PBjN7Xbfyiqb2gROVWZxwxp/1cRB60u
         9oGg==
X-Gm-Message-State: AHQUAuaTbI6e4I7IydbT7lX/OHygkx92qFokFILp2CYK2lvQvxCznh8l
        LsDJXcEBJlGBhSgyodOZlzoHlVWaa766oKyBXE0REA==
X-Google-Smtp-Source: AHgI3IaIb8+ndBXJmvKkRFflVgcEw4+PcfWvXoVOH/BWSeqJXrWzIlFBFARebrSRCDL+K5TWFY9+1TlbfBjvsSSc0qE=
X-Received: by 2002:a24:db02:: with SMTP id c2mr6818644itg.137.1549571346926;
 Thu, 07 Feb 2019 12:29:06 -0800 (PST)
MIME-Version: 1.0
References: <cover.1548981329.git.saiprakash.ranjan@codeaurora.org> <53cf9d9d3b14f503a6c842754f3c55413f5a3392.1548981329.git.saiprakash.ranjan@codeaurora.org>
In-Reply-To: <53cf9d9d3b14f503a6c842754f3c55413f5a3392.1548981329.git.saiprakash.ranjan@codeaurora.org>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Thu, 7 Feb 2019 13:28:56 -0700
Message-ID: <CANLsYky9ujRyftg3WoeSWK37=3_k5hw9x=DV34P_YrUXCLApXw@mail.gmail.com>
Subject: Re: [PATCHv7 6/6] coresight: cpu-debug: Add support for Qualcomm Kryo
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

On Thu, 31 Jan 2019 at 17:55, Sai Prakash Ranjan
<saiprakash.ranjan@codeaurora.org> wrote:
>
> Add support for coresight CPU debug module on Qualcomm
> Kryo CPUs. This patch adds the UCI entries for Kryo CPUs
> found on MSM8996 which shares the same PIDs as ETMs.
>
> Without this, below error is observed on MSM8996:
>
> [    5.429867] OF: graph: no port node found in /soc/debug@3810000
> [    5.429938] coresight-etm4x: probe of 3810000.debug failed with error -22
> [    5.435415] coresight-cpu-debug 3810000.debug: Coresight debug-CPU0 initialized
> [    5.446474] OF: graph: no port node found in /soc/debug@3910000
> [    5.448927] coresight-etm4x: probe of 3910000.debug failed with error -22
> [    5.454681] coresight-cpu-debug 3910000.debug: Coresight debug-CPU1 initialized
> [    5.487765] OF: graph: no port node found in /soc/debug@3a10000
> [    5.488007] coresight-etm4x: probe of 3a10000.debug failed with error -22
> [    5.493024] coresight-cpu-debug 3a10000.debug: Coresight debug-CPU2 initialized
> [    5.501802] OF: graph: no port node found in /soc/debug@3b10000
> [    5.512901] coresight-etm4x: probe of 3b10000.debug failed with error -22
> [    5.513192] coresight-cpu-debug 3b10000.debug: Coresight debug-CPU3 initialized
>
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
>
> ---
> For testing, all dependent patches are in below tree:
>  * https://github.com/saiprakash-ranjan/linux/tree/coresight-next
>
> This patch depends on UCI support by Mike Leach in below link:
>  * https://lore.kernel.org/lkml/20190130234051.2294-1-mike.leach@linaro.org/
> ---
>  .../hwtracing/coresight/coresight-cpu-debug.c | 33 +++++++++----------
>  1 file changed, 16 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-cpu-debug.c b/drivers/hwtracing/coresight/coresight-cpu-debug.c
> index e8819d750938..50ebf5b7fa4f 100644
> --- a/drivers/hwtracing/coresight/coresight-cpu-debug.c
> +++ b/drivers/hwtracing/coresight/coresight-cpu-debug.c
> @@ -655,24 +655,23 @@ static int debug_remove(struct amba_device *adev)
>         return 0;
>  }
>
> +static const struct amba_cs_uci_id uci_id_debug[] = {
> +       {
> +               /*  CPU Debug UCI data */
> +               .devarch        = 0x47706a15,
> +               .devarch_mask   = 0xfff0ffff,
> +               .devtype        = 0x00000015,
> +       }
> +};
> +

Thank you for adding that.

>  static const struct amba_id debug_ids[] = {
> -       {       /* Debug for Cortex-A53 */
> -               .id     = 0x000bbd03,
> -               .mask   = 0x000fffff,
> -       },
> -       {       /* Debug for Cortex-A57 */
> -               .id     = 0x000bbd07,
> -               .mask   = 0x000fffff,
> -       },
> -       {       /* Debug for Cortex-A72 */
> -               .id     = 0x000bbd08,
> -               .mask   = 0x000fffff,
> -       },
> -       {       /* Debug for Cortex-A73 */
> -               .id     = 0x000bbd09,
> -               .mask   = 0x000fffff,
> -       },
> -       { 0, 0 },
> +       CS_AMBA_ID(0x000bbd03),                         /* Cortex-A53 */
> +       CS_AMBA_ID(0x000bbd07),                         /* Cortex-A57 */
> +       CS_AMBA_ID(0x000bbd08),                         /* Cortex-A72 */
> +       CS_AMBA_ID(0x000bbd09),                         /* Cortex-A73 */
> +       CS_AMBA_UCI_ID(0x000f0205, uci_id_debug),       /* Qualcomm Kryo */
> +       CS_AMBA_UCI_ID(0x000f0211, uci_id_debug),       /* Qualcomm Kryo */
> +       {},

I have reviewed your work and things look good to me.  Once again
there isn't much I can do with it right now.  Please re-submit when
Mike's set has been merged.

Mathieu

>  };
>
>  static struct amba_driver debug_driver = {
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
>
