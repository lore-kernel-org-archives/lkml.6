Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93C5C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 19:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A24E021738
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 19:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TF4Qfnkk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbfBSTwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 14:52:09 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40897 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfBSTwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 14:52:09 -0500
Received: by mail-wr1-f66.google.com with SMTP id q1so23330011wrp.7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 11:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hwFTKdSwPZtqX0QtMqOoFg3pkIluI2fPczZHfa6feJM=;
        b=TF4Qfnkk+jXddJZAwjMmQPuXh4SK+qgdsCiMY+MdACqLdDB6vbG83Dd1MNypyTFUod
         vkQ6tunBIiDGZoEEFhbJ1vbLwT922X2thHwIX2LJ8yMkV+AEqPdIpGmW9r0xNmVRsETi
         AKmILSheFh8xLQJOFizQzpMz6sMYhe5mIQ2/0ZJ+Ws8POSV0hTjJO3TUVJ6/gjdlxU2r
         ZfBr5SkSm4ezrjIR5GopcQYEJ6Ctcsk0MsDL85EEsB0kWuoVOQ3WtPjYCljiIM7ig+W6
         3b2ikXQ/wHe2tOIR6Ozorh9v8SlGbh8R8VZ5J7U4jgoOLGOGxet9xIN+QHSDN5NzKiPv
         6gjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hwFTKdSwPZtqX0QtMqOoFg3pkIluI2fPczZHfa6feJM=;
        b=BYEQVHfM7dsXfVMHj/KXQmrXV5u8ivjSdtkeoet5TZQfHQvF6BElCck6PhLOd4fBY9
         LNF8kLzURLMPH8bIOjzj8IKOPGrV1scP1E/HV1kCy6unlaKZv5h1bOxKzE4P4duDh+4b
         CDr/d5YO5iw7Hc+riQoBrm9ZIgrNay/olwJTyTlv8h5SVueumfmJrNPzarsU4/pFqkwk
         uNc1ElOPlric1xuYRge6FehWZvDwVWQ/usIsS/N0oQT1vnbbIohYoho9CFL+nbVHAxKW
         4QJb/MXfd2Oxu0iOdjo1DtjAVtplWv8pJEE/Uup61rOBT52lw2Am5ytA8qYr02iH36Ig
         vuag==
X-Gm-Message-State: AHQUAuYJWeRLGnpPLpPesGe37OsAvpSzzRxAc1/SiESXLJneoDY6Sr4s
        S1EyfKsfQwMQ/G87BRfu+/FibkacPEwGrdFjtgI/Vg==
X-Google-Smtp-Source: AHgI3IYNTnseh9Ou5OC1DGL6fW+f3f7UX1x2latowH7BYdoyi57d2WZHTNFfXtnH1pwqBNvVV6GbqjMTLRUDWjjLHBg=
X-Received: by 2002:a05:6000:1091:: with SMTP id y17mr21139194wrw.317.1550605927320;
 Tue, 19 Feb 2019 11:52:07 -0800 (PST)
MIME-Version: 1.0
References: <20190219185509.GA23853@embeddedor>
In-Reply-To: <20190219185509.GA23853@embeddedor>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 19 Feb 2019 14:51:53 -0500
Message-ID: <CADnq5_Nntrq2zdzkwERV3ShCRptifbgVNhKP+xNgtyaWftWDdg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/powerplay/smu10_hwmgr: use struct_size() in kzalloc()
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Rex Zhu <rex.zhu@amd.com>, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 1:55 PM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
> One of the more common cases of allocation size calculations is finding
> the size of a structure that has a zero-sized array at the end, along
> with memory for some number of elements for that array. For example:
>
> struct foo {
>     int stuff;
>     struct boo entry[];
> };
>
> size = sizeof(struct foo) + count * sizeof(struct boo);
> instance = kzalloc(size, GFP_KERNEL);
>
> Instead of leaving these open-coded and prone to type mistakes, we can
> now use the new struct_size() helper:
>
> instance = kzalloc(struct_size(instance, entry, count), GFP_KERNEL);
>
> Notice that, in this case, variable table_size is not necessary, hence
> it is removed.
>
> This code was detected with the help of Coccinelle.
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied this and the smu8 patch.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
> index 5273de3c5b98..0ad8fe4a6277 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
> @@ -139,12 +139,10 @@ static int smu10_construct_max_power_limits_table(struct pp_hwmgr *hwmgr,
>  static int smu10_init_dynamic_state_adjustment_rule_settings(
>                                                         struct pp_hwmgr *hwmgr)
>  {
> -       uint32_t table_size =
> -               sizeof(struct phm_clock_voltage_dependency_table) +
> -               (7 * sizeof(struct phm_clock_voltage_dependency_record));
> +       struct phm_clock_voltage_dependency_table *table_clk_vlt;
>
> -       struct phm_clock_voltage_dependency_table *table_clk_vlt =
> -                                       kzalloc(table_size, GFP_KERNEL);
> +       table_clk_vlt = kzalloc(struct_size(table_clk_vlt, entries, 7),
> +                               GFP_KERNEL);
>
>         if (NULL == table_clk_vlt) {
>                 pr_err("Can not allocate memory!\n");
> --
> 2.20.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
