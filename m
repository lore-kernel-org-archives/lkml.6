Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F40C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 20:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31A132172D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 20:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EtKD6mJ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31A132172D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730129AbeHMXNi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 19:13:38 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:37494 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728540AbeHMXNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 19:13:37 -0400
Received: by mail-yw1-f68.google.com with SMTP id w76-v6so14577841ywg.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 13:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=npeB27vPBcPeMvjHIpuLMz5J+dYAUUGtA8DV27XHrQo=;
        b=EtKD6mJ1EMrV0ceSfoTa/XXYftVBYnEMuqXglFTkrjHF80nXci3GEHNryOxmwtMHcv
         /SkL55zUaENWbIAXCxJb2egIuavX4+uaGXb00NrnxKkFyw1BIaMUlEr0EADQ+Hz3iUw/
         VITzq+/mZ9oO6QfyVvBQ7ei1v5Zfn2YAbN7K7cb9M6bXoiUCk4vIvxRRoya2LHYUysWY
         6hzaEtOCmP0KiOI4ZAI5JHvWoyWdOGjoZ51AJuUoKOzhFIDIlT8/fPHyJxTmDpRCCHg/
         QLlK7xsm2+DEfDHzQ3oJvd6exKkb6w5wIxOI1b0nIiJNWxskv6EbJ+KQtUajFEgsiV/K
         igSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=npeB27vPBcPeMvjHIpuLMz5J+dYAUUGtA8DV27XHrQo=;
        b=tnRsoLdNbOny9ETzVn/Seh26pRoa5yiYo/aNpUX8r9goQNBaUdTTPPscJImPJ3TXz5
         cfwXi8wLLMCZkjCnsBxCnhh6PPmDeABbRAya4uCcwL98H5JrtvyaCizY6azciC2264L6
         qM8rNqlh2oiU+saaffD0yJzSrhooqmVvb9frbmE6e+DsYIloAowH1H1Q2g8X0orLumhW
         M5tYhfwf0P0MRM+378dAaGLKyFJ1iSFOZmTDK2JNQOtPiBwqPmiWVyKc6nW3DVdCFB5X
         6XB+MtFDNcNrp/rmatIwx3pUnNoAGRPy+BJzJmVAx05b50ZiQuE6AmgL+B6/Eti6iyhP
         498g==
X-Gm-Message-State: AOUpUlGn5A1oOByhRM+UhGmllt9nfTd2MhKHhpehDi7F1MBvfWqZn08i
        2acCYvlsNBRH0MOZWI0qWLkBis/7CIP0NG7GC/wCbg==
X-Google-Smtp-Source: AA+uWPziDL4xYf4GjS4U90ya6wFtZHOV/t6PiGkS1lQGrgSlu+x1KOftPUeYJnf+P1K2ifrHL7FL7NTx7GCiJIRnq3I=
X-Received: by 2002:a81:7d43:: with SMTP id y64-v6mr9766929ywc.371.1534192189157;
 Mon, 13 Aug 2018 13:29:49 -0700 (PDT)
MIME-Version: 1.0
References: <20180813155002.GC22820@altlinux.org>
In-Reply-To: <20180813155002.GC22820@altlinux.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Mon, 13 Aug 2018 13:29:37 -0700
Message-ID: <CABXOdTdzS35diT=bMsrrGiZgSF5D4t+aYfc7RtHe_5XeT0sFzg@mail.gmail.com>
Subject: Re: [PATCH] uapi: fix sound/skl-tplg-interface.h userspace
 compilation errors
To:     Guenter Roeck <groeck@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 13, 2018 at 8:50 AM Dmitry V. Levin <ldv@altlinux.org> wrote:
>
> Include <linux/types.h> and consistently use types it provides
> to fix the following sound/skl-tplg-interface.h userspace compilation errors:
>
> /usr/include/sound/skl-tplg-interface.h:146:2: error: unknown type name 'u32'
>   u32 set_params:2;
> /usr/include/sound/skl-tplg-interface.h:147:2: error: unknown type name 'u32'
>   u32 rsvd:30;
> /usr/include/sound/skl-tplg-interface.h:148:2: error: unknown type name 'u32'
>   u32 param_id;
> /usr/include/sound/skl-tplg-interface.h:149:2: error: unknown type name 'u32'
>   u32 max;
> /usr/include/sound/skl-tplg-interface.h:166:2: error: unknown type name 'u16'
>   u16 module_id;
> /usr/include/sound/skl-tplg-interface.h:167:2: error: unknown type name 'u16'
>   u16 instance_id;
> /usr/include/sound/skl-tplg-interface.h:171:2: error: unknown type name 'u32'
>   u32 channels;
> /usr/include/sound/skl-tplg-interface.h:172:2: error: unknown type name 'u32'
>   u32 freq;
> /usr/include/sound/skl-tplg-interface.h:173:2: error: unknown type name 'u32'
>   u32 bit_depth;
> /usr/include/sound/skl-tplg-interface.h:174:2: error: unknown type name 'u32'
>   u32 valid_bit_depth;
> /usr/include/sound/skl-tplg-interface.h:175:2: error: unknown type name 'u32'
>   u32 ch_cfg;
> /usr/include/sound/skl-tplg-interface.h:176:2: error: unknown type name 'u32'
>   u32 interleaving_style;
> /usr/include/sound/skl-tplg-interface.h:177:2: error: unknown type name 'u32'
>   u32 sample_type;
> /usr/include/sound/skl-tplg-interface.h:178:2: error: unknown type name 'u32'
>   u32 ch_map;
> /usr/include/sound/skl-tplg-interface.h:182:2: error: unknown type name 'u32'
>   u32 set_params:2;
> /usr/include/sound/skl-tplg-interface.h:183:2: error: unknown type name 'u32'
>   u32 rsvd:30;
> /usr/include/sound/skl-tplg-interface.h:184:2: error: unknown type name 'u32'
>   u32 param_id;
> /usr/include/sound/skl-tplg-interface.h:185:2: error: unknown type name 'u32'
>   u32 caps_size;
> /usr/include/sound/skl-tplg-interface.h:186:2: error: unknown type name 'u32'
>   u32 caps[HDA_SST_CFG_MAX];
> /usr/include/sound/skl-tplg-interface.h:190:2: error: unknown type name 'u8'
>   u8 pipe_id;
> /usr/include/sound/skl-tplg-interface.h:191:2: error: unknown type name 'u8'
>   u8 pipe_priority;
> /usr/include/sound/skl-tplg-interface.h:192:2: error: unknown type name 'u16'
>   u16 conn_type:4;
> /usr/include/sound/skl-tplg-interface.h:193:2: error: unknown type name 'u16'
>   u16 rsvd:4;
> /usr/include/sound/skl-tplg-interface.h:194:2: error: unknown type name 'u16'
>   u16 memory_pages:8;
> /usr/include/sound/skl-tplg-interface.h:200:2: error: unknown type name 'u16'
>   u16 module_id;
> /usr/include/sound/skl-tplg-interface.h:201:2: error: unknown type name 'u16'
>   u16 instance_id;
> /usr/include/sound/skl-tplg-interface.h:202:2: error: unknown type name 'u32'
>   u32 max_mcps;
> /usr/include/sound/skl-tplg-interface.h:203:2: error: unknown type name 'u32'
>   u32 mem_pages;
> /usr/include/sound/skl-tplg-interface.h:204:2: error: unknown type name 'u32'
>   u32 obs;
> /usr/include/sound/skl-tplg-interface.h:205:2: error: unknown type name 'u32'
>   u32 ibs;
> /usr/include/sound/skl-tplg-interface.h:206:2: error: unknown type name 'u32'
>   u32 vbus_id;
> /usr/include/sound/skl-tplg-interface.h:208:2: error: unknown type name 'u32'
>   u32 max_in_queue:8;
> /usr/include/sound/skl-tplg-interface.h:209:2: error: unknown type name 'u32'
>   u32 max_out_queue:8;
> /usr/include/sound/skl-tplg-interface.h:210:2: error: unknown type name 'u32'
>   u32 time_slot:8;
> /usr/include/sound/skl-tplg-interface.h:211:2: error: unknown type name 'u32'
>   u32 core_id:4;
> /usr/include/sound/skl-tplg-interface.h:212:2: error: unknown type name 'u32'
>   u32 rsvd1:4;
> /usr/include/sound/skl-tplg-interface.h:214:2: error: unknown type name 'u32'
>   u32 module_type:8;
> /usr/include/sound/skl-tplg-interface.h:215:2: error: unknown type name 'u32'
>   u32 conn_type:4;
> /usr/include/sound/skl-tplg-interface.h:216:2: error: unknown type name 'u32'
>   u32 dev_type:4;
> /usr/include/sound/skl-tplg-interface.h:217:2: error: unknown type name 'u32'
>   u32 hw_conn_type:4;
> /usr/include/sound/skl-tplg-interface.h:218:2: error: unknown type name 'u32'
>   u32 rsvd2:12;
> /usr/include/sound/skl-tplg-interface.h:220:2: error: unknown type name 'u32'
>   u32 params_fixup:8;
> /usr/include/sound/skl-tplg-interface.h:221:2: error: unknown type name 'u32'
>   u32 converter:8;
> /usr/include/sound/skl-tplg-interface.h:222:2: error: unknown type name 'u32'
>   u32 input_pin_type:1;
> /usr/include/sound/skl-tplg-interface.h:223:2: error: unknown type name 'u32'
>   u32 output_pin_type:1;
> /usr/include/sound/skl-tplg-interface.h:224:2: error: unknown type name 'u32'
>   u32 is_dynamic_in_pin:1;
> /usr/include/sound/skl-tplg-interface.h:225:2: error: unknown type name 'u32'
>   u32 is_dynamic_out_pin:1;
> /usr/include/sound/skl-tplg-interface.h:226:2: error: unknown type name 'u32'
>   u32 is_loadable:1;
> /usr/include/sound/skl-tplg-interface.h:227:2: error: unknown type name 'u32'
>   u32 rsvd3:11;
>
> Fixes: 0c24fdc00244 ("ASoC: topology: Move skl-tplg-interface.h to uapi")
> Cc: <stable@vger.kernel.org> # v4.18
> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>  include/uapi/sound/skl-tplg-interface.h | 106 ++++++++++++------------
>  1 file changed, 54 insertions(+), 52 deletions(-)
>
> diff --git a/include/uapi/sound/skl-tplg-interface.h b/include/uapi/sound/skl-tplg-interface.h
> index f58cafa42f18..f39352cef382 100644
> --- a/include/uapi/sound/skl-tplg-interface.h
> +++ b/include/uapi/sound/skl-tplg-interface.h
> @@ -10,6 +10,8 @@
>  #ifndef __HDA_TPLG_INTERFACE_H__
>  #define __HDA_TPLG_INTERFACE_H__
>
> +#include <linux/types.h>
> +
>  /*
>   * Default types range from 0~12. type can range from 0 to 0xff
>   * SST types start at higher to avoid any overlapping in future
> @@ -143,10 +145,10 @@ enum skl_module_param_type {
>  };
>
>  struct skl_dfw_algo_data {
> -       u32 set_params:2;
> -       u32 rsvd:30;
> -       u32 param_id;
> -       u32 max;
> +       __u32 set_params:2;
> +       __u32 rsvd:30;
> +       __u32 param_id;
> +       __u32 max;
>         char params[0];
>  } __packed;
>
> @@ -163,68 +165,68 @@ enum skl_tuple_type {
>  /* v4 configuration data */
>
>  struct skl_dfw_v4_module_pin {
> -       u16 module_id;
> -       u16 instance_id;
> +       __u16 module_id;
> +       __u16 instance_id;
>  } __packed;
>
>  struct skl_dfw_v4_module_fmt {
> -       u32 channels;
> -       u32 freq;
> -       u32 bit_depth;
> -       u32 valid_bit_depth;
> -       u32 ch_cfg;
> -       u32 interleaving_style;
> -       u32 sample_type;
> -       u32 ch_map;
> +       __u32 channels;
> +       __u32 freq;
> +       __u32 bit_depth;
> +       __u32 valid_bit_depth;
> +       __u32 ch_cfg;
> +       __u32 interleaving_style;
> +       __u32 sample_type;
> +       __u32 ch_map;
>  } __packed;
>
>  struct skl_dfw_v4_module_caps {
> -       u32 set_params:2;
> -       u32 rsvd:30;
> -       u32 param_id;
> -       u32 caps_size;
> -       u32 caps[HDA_SST_CFG_MAX];
> +       __u32 set_params:2;
> +       __u32 rsvd:30;
> +       __u32 param_id;
> +       __u32 caps_size;
> +       __u32 caps[HDA_SST_CFG_MAX];
>  } __packed;
>
>  struct skl_dfw_v4_pipe {
> -       u8 pipe_id;
> -       u8 pipe_priority;
> -       u16 conn_type:4;
> -       u16 rsvd:4;
> -       u16 memory_pages:8;
> +       __u8 pipe_id;
> +       __u8 pipe_priority;
> +       __u16 conn_type:4;
> +       __u16 rsvd:4;
> +       __u16 memory_pages:8;
>  } __packed;
>
>  struct skl_dfw_v4_module {
>         char uuid[SKL_UUID_STR_SZ];
>
> -       u16 module_id;
> -       u16 instance_id;
> -       u32 max_mcps;
> -       u32 mem_pages;
> -       u32 obs;
> -       u32 ibs;
> -       u32 vbus_id;
> -
> -       u32 max_in_queue:8;
> -       u32 max_out_queue:8;
> -       u32 time_slot:8;
> -       u32 core_id:4;
> -       u32 rsvd1:4;
> -
> -       u32 module_type:8;
> -       u32 conn_type:4;
> -       u32 dev_type:4;
> -       u32 hw_conn_type:4;
> -       u32 rsvd2:12;
> -
> -       u32 params_fixup:8;
> -       u32 converter:8;
> -       u32 input_pin_type:1;
> -       u32 output_pin_type:1;
> -       u32 is_dynamic_in_pin:1;
> -       u32 is_dynamic_out_pin:1;
> -       u32 is_loadable:1;
> -       u32 rsvd3:11;
> +       __u16 module_id;
> +       __u16 instance_id;
> +       __u32 max_mcps;
> +       __u32 mem_pages;
> +       __u32 obs;
> +       __u32 ibs;
> +       __u32 vbus_id;
> +
> +       __u32 max_in_queue:8;
> +       __u32 max_out_queue:8;
> +       __u32 time_slot:8;
> +       __u32 core_id:4;
> +       __u32 rsvd1:4;
> +
> +       __u32 module_type:8;
> +       __u32 conn_type:4;
> +       __u32 dev_type:4;
> +       __u32 hw_conn_type:4;
> +       __u32 rsvd2:12;
> +
> +       __u32 params_fixup:8;
> +       __u32 converter:8;
> +       __u32 input_pin_type:1;
> +       __u32 output_pin_type:1;
> +       __u32 is_dynamic_in_pin:1;
> +       __u32 is_dynamic_out_pin:1;
> +       __u32 is_loadable:1;
> +       __u32 rsvd3:11;
>
>         struct skl_dfw_v4_pipe pipe;
>         struct skl_dfw_v4_module_fmt in_fmt[MAX_IN_QUEUE];
> --
> ldv
