Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B11BAC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80097218EA
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548952304;
	bh=gpWIdco5o2YJdlELwZUmv5WNqeLBP31go2K7jLLkvUY=;
	h=Subject:From:Cc:References:To:In-Reply-To:Date:List-ID:From;
	b=SQ7+kOByzCYqxRtLl93j4O6D5w6Llb+kSVNBuv148CK1ykvar91VY3L8g7IH8PzAh
	 kPdQ9cHMCxRo/0vYhPmy5hMvwBLpuiUuSqSMxWOvO52ynSl8mklpYh+t2koa4SxBFo
	 f8Zw3++uEK9sv4887YExjcQuEqtYXw4i2mfEaOkQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388487AbfAaQbm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 11:31:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:44388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727189AbfAaQbm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 11:31:42 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC40D20869;
        Thu, 31 Jan 2019 16:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548952301;
        bh=gpWIdco5o2YJdlELwZUmv5WNqeLBP31go2K7jLLkvUY=;
        h=Subject:From:Cc:References:To:In-Reply-To:Date:From;
        b=RF60c/XRDRGOuo1KgEl0pS6UIk+jRo14nu48G6qpcKAHevWsQDokAnHaSquJ9HGHo
         jAeHA1l2UxAuqzYEPQrMH0kUpFzNTjY96I8Yd17g2P0aP7EFtSeEDTbyWk04oYeSIn
         kJ6iJ5HgmYc56ZPciFnRMcQwpeMNNktZZhj+mImA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCHv6 6/6] coresight: debug: Add Unique Component Identifier (UCI) table
From:   Stephen Boyd <sboyd@kernel.org>
Message-ID: <154895230081.169292.7994428901781990604@swboyd.mtv.corp.google.com>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Tingwei Zhang <tingwei@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
References: <cover.1548943727.git.saiprakash.ranjan@codeaurora.org> <f724b28e5bfd7bca062aa5380cfd9328289559bf.1548943727.git.saiprakash.ranjan@codeaurora.org>
User-Agent: alot/0.8
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Gross <andy.gross@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Doug Anderson <dianders@chromium.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Leo Yan <leo.yan@linaro.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        devicetree@vger.kernel.org
In-Reply-To: <f724b28e5bfd7bca062aa5380cfd9328289559bf.1548943727.git.saiprakash.ranjan@codeaurora.org>
Date:   Thu, 31 Jan 2019 08:31:40 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sai Prakash Ranjan (2019-01-31 06:22:24)
> diff --git a/drivers/hwtracing/coresight/coresight-cpu-debug.c b/drivers/=
hwtracing/coresight/coresight-cpu-debug.c
> index e8819d750938..915d86a39cee 100644
> --- a/drivers/hwtracing/coresight/coresight-cpu-debug.c
> +++ b/drivers/hwtracing/coresight/coresight-cpu-debug.c
> @@ -655,24 +655,23 @@ static int debug_remove(struct amba_device *adev)
>         return 0;
>  }
> =20
> +static struct amba_cs_uci_id uci_id_debug[] =3D {

Can this be const?

> +       {
> +               /*  CPU Debug UCI data */
> +               .devarch        =3D 0x47706a15,
> +               .devarch_mask   =3D 0xfff0ffff,
> +               .devtype        =3D 0x00000015,
> +       }
> +};
