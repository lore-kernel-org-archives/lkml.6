Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3579C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 14:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 693B121104
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 14:20:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="IraMNg7x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 693B121104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbeK1BSF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 20:18:05 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46485 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727195AbeK1BSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 20:18:05 -0500
Received: by mail-wr1-f65.google.com with SMTP id l9so22849167wrt.13
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 06:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aYDvSt9lIOyxlqQ4jJN59XwRDKvRHnE0XhjYO+noWBo=;
        b=IraMNg7x/o0QlK64P+cqIzb/krW83iCBOIja3btgw7gK/bF8+ZISmYM1dTitz2/IsU
         LueHjzWevhJzDQ7dCDhojBJuETbWw6x2vZdVrwIlM4ntv+DeDjl5D1pP0rEdK4lMwzbg
         /mUFRsnMNx/R5YOWklyVlMZsLRTmfsM//aW9gSCvP4vS/41gIjolCgj8uuK4xHWNc01T
         NrZo+ZLz6qyDUqX5RQlMzwpz3dYF87mrXx7AwWXJuCBxqeZqn7j5FTEIOddvjR2lMYN/
         qNySZlxLtGjhjqEXMrdSKsAXzP+M8okskCPIhcz1AFirJCHoCtftIV+czCLoKDyBNegB
         raIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aYDvSt9lIOyxlqQ4jJN59XwRDKvRHnE0XhjYO+noWBo=;
        b=cYnTVdnHefyE09sytW2Wjc5EPXGxx75v3dl3Jue5i5QWdxsTYvbxQLX/peOVUi7e6+
         6xAeNwhw6rZAGxwev66unOpjcovSEYmUYrTYSOIvpiAi2wBD6Ovlm/DqXA3y6pvArKpQ
         5AoYYVj1x0KWznHxoVPKzkv8xNcdnJ/7iP7N80Aw8JzRHNtJIO+tPOKKG1YYXbCkgfoM
         FdMoj3dtv1orsEBJAfaqWDNjjzt9l+8Hqt8Xm2aXkpZaw5ytdSmuXvOUVNuGXjfm9wJD
         IqFVSZrP4nFSC7zc43B3En/MoEG3FdQmzC7tWz16IAjCKiNnvbNS+JwwzHFfwCL84VK1
         Mjgg==
X-Gm-Message-State: AA+aEWb1xLWczMG4If5BrhEhnr2O5R31tPDLNTitO3TuBsY6XZFLUUnA
        ENxZrTGz0+5YPobrHSjB82G4B5TBjg/Is0x3J9iNGA==
X-Google-Smtp-Source: AFSGD/WqfNv0mZBsOrGezaIjgIbGh7twRjGhzSrhQ1iI+rWyLq1ERZKvUCG1D6WfHbzwUui16mAbSHL1SXL2ZThtQ5Y=
X-Received: by 2002:adf:eb45:: with SMTP id u5mr19619754wrn.102.1543328398976;
 Tue, 27 Nov 2018 06:19:58 -0800 (PST)
MIME-Version: 1.0
References: <1541496909-19625-1-git-send-email-narmstrong@baylibre.com>
In-Reply-To: <1541496909-19625-1-git-send-email-narmstrong@baylibre.com>
From:   Maxime Jourdan <mjourdan@baylibre.com>
Date:   Tue, 27 Nov 2018 15:19:47 +0100
Message-ID: <CAMO6naz=pm_cGo=_fFQdjes_HUXrSAi0CUTEVZYLkHvRCPZq0A@mail.gmail.com>
Subject: Re: [PATCH] drm/meson: Add HDMI 1.4 4k modes
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 6, 2018 at 10:35 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Add the timings for the HDMI 1.4 4K modes support :
> - 3840x2160@30
> - 3840x2160@25
> - 3840x2160@24
>
> Since the 297000Hz pixel clock is already managed and the modes are
> compatible with the HDMI 1.4 current HDMI PHY+Controller support, only
> the missing timings values needs to be added.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/gpu/drm/meson/meson_venc.c | 129 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 129 insertions(+)
>
> diff --git a/drivers/gpu/drm/meson/meson_venc.c b/drivers/gpu/drm/meson/meson_venc.c
> index 514245e..bcffe8e 100644
> --- a/drivers/gpu/drm/meson/meson_venc.c
> +++ b/drivers/gpu/drm/meson/meson_venc.c
> @@ -697,6 +697,132 @@ union meson_hdmi_venc_mode meson_hdmi_encp_mode_1080p60 = {
>         },
>  };
>
> +union meson_hdmi_venc_mode meson_hdmi_encp_mode_2160p24 = {
> +       .encp = {
> +               .dvi_settings = 0x1,
> +               .video_mode = 0x4040,
> +               .video_mode_adv = 0x8,
> +               /* video_sync_mode */
> +               /* video_yc_dly */
> +               /* video_rgb_ctrl */
> +               .video_filt_ctrl = 0x1000,
> +               .video_filt_ctrl_present = true,
> +               /* video_ofld_voav_ofst */
> +               .yfp1_htime = 140,
> +               .yfp2_htime = 140+3840,
> +               .max_pxcnt = 3840+1660-1,
> +               .hspuls_begin = 2156+1920,
> +               .hspuls_end = 44,
> +               .hspuls_switch = 44,
> +               .vspuls_begin = 140,
> +               .vspuls_end = 2059+1920,
> +               .vspuls_bline = 0,
> +               .vspuls_eline = 4,
> +               .havon_begin = 148,
> +               .havon_end = 3987,
> +               .vavon_bline = 89,
> +               .vavon_eline = 2248,
> +               /* eqpuls_begin */
> +               /* eqpuls_end */
> +               /* eqpuls_bline */
> +               /* eqpuls_eline */
> +               .hso_begin = 44,
> +               .hso_end = 2156+1920,
> +               .vso_begin = 2100+1920,
> +               .vso_end = 2164+1920,
> +               .vso_bline = 51,
> +               .vso_eline = 53,
> +               .vso_eline_present = true,
> +               /* sy_val */
> +               /* sy2_val */
> +               .max_lncnt = 2249,
> +       },
> +};
> +
> +union meson_hdmi_venc_mode meson_hdmi_encp_mode_2160p25 = {
> +       .encp = {
> +               .dvi_settings = 0x1,
> +               .video_mode = 0x4040,
> +               .video_mode_adv = 0x8,
> +               /* video_sync_mode */
> +               /* video_yc_dly */
> +               /* video_rgb_ctrl */
> +               .video_filt_ctrl = 0x1000,
> +               .video_filt_ctrl_present = true,
> +               /* video_ofld_voav_ofst */
> +               .yfp1_htime = 140,
> +               .yfp2_htime = 140+3840,
> +               .max_pxcnt = 3840+1440-1,
> +               .hspuls_begin = 2156+1920,
> +               .hspuls_end = 44,
> +               .hspuls_switch = 44,
> +               .vspuls_begin = 140,
> +               .vspuls_end = 2059+1920,
> +               .vspuls_bline = 0,
> +               .vspuls_eline = 4,
> +               .havon_begin = 148,
> +               .havon_end = 3987,
> +               .vavon_bline = 89,
> +               .vavon_eline = 2248,
> +               /* eqpuls_begin */
> +               /* eqpuls_end */
> +               /* eqpuls_bline */
> +               /* eqpuls_eline */
> +               .hso_begin = 44,
> +               .hso_end = 2156+1920,
> +               .vso_begin = 2100+1920,
> +               .vso_end = 2164+1920,
> +               .vso_bline = 51,
> +               .vso_eline = 53,
> +               .vso_eline_present = true,
> +               /* sy_val */
> +               /* sy2_val */
> +               .max_lncnt = 2249,
> +       },
> +};
> +
> +union meson_hdmi_venc_mode meson_hdmi_encp_mode_2160p30 = {
> +       .encp = {
> +               .dvi_settings = 0x1,
> +               .video_mode = 0x4040,
> +               .video_mode_adv = 0x8,
> +               /* video_sync_mode */
> +               /* video_yc_dly */
> +               /* video_rgb_ctrl */
> +               .video_filt_ctrl = 0x1000,
> +               .video_filt_ctrl_present = true,
> +               /* video_ofld_voav_ofst */
> +               .yfp1_htime = 140,
> +               .yfp2_htime = 140+3840,
> +               .max_pxcnt = 3840+560-1,
> +               .hspuls_begin = 2156+1920,
> +               .hspuls_end = 44,
> +               .hspuls_switch = 44,
> +               .vspuls_begin = 140,
> +               .vspuls_end = 2059+1920,
> +               .vspuls_bline = 0,
> +               .vspuls_eline = 4,
> +               .havon_begin = 148,
> +               .havon_end = 3987,
> +               .vavon_bline = 89,
> +               .vavon_eline = 2248,
> +               /* eqpuls_begin */
> +               /* eqpuls_end */
> +               /* eqpuls_bline */
> +               /* eqpuls_eline */
> +               .hso_begin = 44,
> +               .hso_end = 2156+1920,
> +               .vso_begin = 2100+1920,
> +               .vso_end = 2164+1920,
> +               .vso_bline = 51,
> +               .vso_eline = 53,
> +               .vso_eline_present = true,
> +               /* sy_val */
> +               /* sy2_val */
> +               .max_lncnt = 2249,
> +       },
> +};
> +
>  struct meson_hdmi_venc_vic_mode {
>         unsigned int vic;
>         union meson_hdmi_venc_mode *mode;
> @@ -717,6 +843,9 @@ struct meson_hdmi_venc_vic_mode {
>         { 34, &meson_hdmi_encp_mode_1080p30 },
>         { 31, &meson_hdmi_encp_mode_1080p50 },
>         { 16, &meson_hdmi_encp_mode_1080p60 },
> +       { 93, &meson_hdmi_encp_mode_2160p24 },
> +       { 94, &meson_hdmi_encp_mode_2160p25 },
> +       { 95, &meson_hdmi_encp_mode_2160p30 },
>         { 0, NULL}, /* sentinel */
>  };
>
> --
> 2.7.4
>
>
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic

Reviewed-by: Maxime Jourdan <mjourdan@baylibre.com>
