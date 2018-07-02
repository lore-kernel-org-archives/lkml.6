Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CCD7C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 08:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0214C25B99
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 08:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K/iAEDA6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0214C25B99
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933696AbeGBIrZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 04:47:25 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:42548 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754327AbeGBIqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 04:46:06 -0400
Received: by mail-io0-f195.google.com with SMTP id r24-v6so14034384ioh.9
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 01:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IuLV5DB13L6aLqWiOwSpfBC/YgWJABmU9rsUs1091zo=;
        b=K/iAEDA6lhhGRNIbGCzArR+7j/svN5dbJOiXxuVTtio3RPHedwUIorulmJBqfVDK2W
         eUwFOIQKzy5uB3EPUN986f4sVb0AltMYBoyleAzNp5cPWTtZ8J4Qo00EZVfesDpOl8Dz
         vvg/8e2ecevuftst74znOJvx8grrTMdddfzeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IuLV5DB13L6aLqWiOwSpfBC/YgWJABmU9rsUs1091zo=;
        b=IsdfmX40pVz74k96z8pG8Kf+Opox5OU0Opz1mSwcikBKoInerC4y98NvaX73dozRG3
         OGJDSsgFpzXzOgiW7Gv0uV+2Mxsw27p4653DawJaB/2VhackTF8gmNeFqLW8vuCn2HVg
         RTuVqJOFPk/41KfGbbmC5mRe5duszi6eLlhiwIWDEY+9vZWk1vLAUr52iGVhp3hYsCC2
         /De2qZ9KvjdUKZAcw8RsgU9BJEKULGNlNgCszu4Y5ugXevkGiekmtoJnyH7EzVa1TrqZ
         2Gt0sm1b9btB1eh6QbihmktRG6mCs+7HMzXekQ35PWWmr+/+AVGRZpw1NJ0Y87I0DX55
         xViw==
X-Gm-Message-State: APt69E0N1Q01DgVX4tsmO+SY5/2bwTZbJ/gDxf8WbjXiqjKg5BOQov7J
        ofxowmxYm6NsRNOvZ5O4OHJ0pofXuko=
X-Google-Smtp-Source: AAOMgpeNTVsMF3GzA0GLK+ni7YWAwitinUWqdXOeVF3V5sH0tTA2Tffl5E9A3E7RtzKmnv5tMx/sqA==
X-Received: by 2002:a6b:f00a:: with SMTP id w10-v6mr6364620ioc.65.1530521165746;
        Mon, 02 Jul 2018 01:46:05 -0700 (PDT)
Received: from mail-it0-f48.google.com (mail-it0-f48.google.com. [209.85.214.48])
        by smtp.gmail.com with ESMTPSA id o71-v6sm1767475ita.37.2018.07.02.01.46.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 01:46:04 -0700 (PDT)
Received: by mail-it0-f48.google.com with SMTP id p17-v6so10988595itc.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 01:46:04 -0700 (PDT)
X-Received: by 2002:a02:9281:: with SMTP id b1-v6mr20393608jah.33.1530521164026;
 Mon, 02 Jul 2018 01:46:04 -0700 (PDT)
MIME-Version: 1.0
References: <20180627152725.9783-1-stanimir.varbanov@linaro.org> <20180627152725.9783-15-stanimir.varbanov@linaro.org>
In-Reply-To: <20180627152725.9783-15-stanimir.varbanov@linaro.org>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Mon, 2 Jul 2018 17:45:52 +0900
X-Gmail-Original-Message-ID: <CAPBb6MWr2d3uADf23VMC92o=YDV6uS4a2Y3ErDFbwQkQhog_hg@mail.gmail.com>
Message-ID: <CAPBb6MWr2d3uADf23VMC92o=YDV6uS4a2Y3ErDFbwQkQhog_hg@mail.gmail.com>
Subject: Re: [PATCH v4 14/27] venus: helpers: add a helper function to set
 dynamic buffer mode
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, vgarodia@codeaurora.org,
        Tomasz Figa <tfiga@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 12:31 AM Stanimir Varbanov
<stanimir.varbanov@linaro.org> wrote:
>
> Adds a new helper function to set dynamic buffer mode if it is
> supported by current HFI version. The dynamic buffer mode is
> set unconditionally for both decoder outputs.
>
> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> ---
>  drivers/media/platform/qcom/venus/helpers.c | 22 ++++++++++++++++++++++
>  drivers/media/platform/qcom/venus/helpers.h |  1 +
>  drivers/media/platform/qcom/venus/vdec.c    | 15 +++------------
>  3 files changed, 26 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
> index 03121dbb4175..e3dc2772946f 100644
> --- a/drivers/media/platform/qcom/venus/helpers.c
> +++ b/drivers/media/platform/qcom/venus/helpers.c
> @@ -519,6 +519,28 @@ int venus_helper_set_color_format(struct venus_inst *inst, u32 pixfmt)
>  }
>  EXPORT_SYMBOL_GPL(venus_helper_set_color_format);
>
> +int venus_helper_set_dyn_bufmode(struct venus_inst *inst)
> +{
> +       u32 ptype = HFI_PROPERTY_PARAM_BUFFER_ALLOC_MODE;

This could be const u32.

> +       struct hfi_buffer_alloc_mode mode;
> +       int ret;
> +
> +       if (!is_dynamic_bufmode(inst))
> +               return 0;
> +
> +       mode.type = HFI_BUFFER_OUTPUT;
> +       mode.mode = HFI_BUFFER_MODE_DYNAMIC;
> +
> +       ret = hfi_session_set_property(inst, ptype, &mode);
> +       if (ret)
> +               return ret;
> +
> +       mode.type = HFI_BUFFER_OUTPUT2;
> +
> +       return hfi_session_set_property(inst, ptype, &mode);
> +}
> +EXPORT_SYMBOL_GPL(venus_helper_set_dyn_bufmode);
> +
>  static void delayed_process_buf_func(struct work_struct *work)
>  {
>         struct venus_buffer *buf, *n;
> diff --git a/drivers/media/platform/qcom/venus/helpers.h b/drivers/media/platform/qcom/venus/helpers.h
> index 0e64aa95624a..52b961ed491e 100644
> --- a/drivers/media/platform/qcom/venus/helpers.h
> +++ b/drivers/media/platform/qcom/venus/helpers.h
> @@ -40,6 +40,7 @@ int venus_helper_set_output_resolution(struct venus_inst *inst,
>  int venus_helper_set_num_bufs(struct venus_inst *inst, unsigned int input_bufs,
>                               unsigned int output_bufs);
>  int venus_helper_set_color_format(struct venus_inst *inst, u32 fmt);
> +int venus_helper_set_dyn_bufmode(struct venus_inst *inst);
>  void venus_helper_acquire_buf_ref(struct vb2_v4l2_buffer *vbuf);
>  void venus_helper_release_buf_ref(struct venus_inst *inst, unsigned int idx);
>  void venus_helper_init_instance(struct venus_inst *inst);
> diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
> index 31a240ab142b..92669a358a90 100644
> --- a/drivers/media/platform/qcom/venus/vdec.c
> +++ b/drivers/media/platform/qcom/venus/vdec.c
> @@ -557,18 +557,9 @@ static int vdec_set_properties(struct venus_inst *inst)
>                         return ret;
>         }
>
> -       if (core->res->hfi_version == HFI_VERSION_3XX ||
> -           inst->cap_bufs_mode_dynamic) {
> -               struct hfi_buffer_alloc_mode mode;
> -
> -               ptype = HFI_PROPERTY_PARAM_BUFFER_ALLOC_MODE;
> -               mode.type = HFI_BUFFER_OUTPUT;
> -               mode.mode = HFI_BUFFER_MODE_DYNAMIC;
> -
> -               ret = hfi_session_set_property(inst, ptype, &mode);
> -               if (ret)
> -                       return ret;
> -       }
> +       ret = venus_helper_set_dyn_bufmode(inst);
> +       if (ret)
> +               return ret;
>
>         if (ctr->post_loop_deb_mode) {
>                 ptype = HFI_PROPERTY_CONFIG_VDEC_POST_LOOP_DEBLOCKER;
> --
> 2.14.1
>
