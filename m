Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753338AbeBJAGS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 19:06:18 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:54091 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753196AbeBJAGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 19:06:16 -0500
X-Google-Smtp-Source: AH8x226KN2F1ALaitbUNVXg+IMDDjQ3cceqduB1Kvthc0CATRhnD66S/XxxqdkGvTm+YVy+lVwEcEjRI06dNrUL5vIY=
MIME-Version: 1.0
In-Reply-To: <20180209231233.107711-1-mka@chromium.org>
References: <20180209231233.107711-1-mka@chromium.org>
From: Guenter Roeck <groeck@google.com>
Date: Fri, 9 Feb 2018 16:06:15 -0800
Message-ID: <CABXOdTfpCuiCRprv4YR7LU0863fsGd3_xyqHK_t3p9rbfkj12Q@mail.gmail.com>
Subject: Re: [PATCH] amdgpu/dc: Remove unnecessary initialization in dc_link_handle_hpd_rx_irq()
To: Matthias Kaehlcke <mka@chromium.org>
Cc: Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>,
        Harry Wentland <harry.wentland@amd.com>,
        Tony Cheng <Tony.Cheng@amd.com>, Wenjing Liu <Wenjing.Liu@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers
        <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Justin TerAvest <teravest@chromium.org>,
        Craig Bergstrom <craigb@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 9, 2018 at 3:12 PM, Matthias Kaehlcke <mka@chromium.org> wrote:
> The initialization of 'result' is unnecessary, the variable is assigned
> unconditionally a few lines below. Removing the initialization also fixes
> the following warning when building with clang:
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dp.c:1931:26:
>   error: implicit conversion from enumeration type 'enum ddc_result'
>   to different enumeration type 'enum dc_status' [-Werror,-Wenum-conversion]
>     enum dc_status result = DDC_RESULT_UNKNOWN;
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> index 4ee4c03a6724..8e3a8c1395a3 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> @@ -1926,7 +1926,7 @@ bool dc_link_handle_hpd_rx_irq(struct dc_link *link, union hpd_irq_data *out_hpd
>  {
>         union hpd_irq_data hpd_irq_dpcd_data = {{{{0}}}};
>         union device_service_irq device_service_clear = { { 0 } };
> -       enum dc_status result = DDC_RESULT_UNKNOWN;
> +       enum dc_status result;
>         bool status = false;
>         /* For use cases related to down stream connection status change,
>          * PSR and device auto test, refer to function handle_sst_hpd_irq
> --
> 2.16.0.rc1.238.g530d649a79-goog
>
