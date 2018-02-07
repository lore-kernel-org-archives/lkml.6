Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754508AbeBGTTN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 14:19:13 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:53852 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754002AbeBGTTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 14:19:12 -0500
X-Google-Smtp-Source: AH8x225+Av8PjAguxoLEAxajbRkW1iSWBXz/R/poQNhF6HXs5H28UP7/nl8DV3ImccHmSWE/rpQOFkOR4l/YTHArccQ=
MIME-Version: 1.0
In-Reply-To: <20180207191017.77392-1-mka@chromium.org>
References: <20180207191017.77392-1-mka@chromium.org>
From: Guenter Roeck <groeck@google.com>
Date: Wed, 7 Feb 2018 11:19:10 -0800
Message-ID: <CABXOdTf8NTgzzE87ftqvzJLJfB+sqoti0Q8Pda-oxweu5XvuAg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/powerplay: Remove extra pair of parentheses
To: Matthias Kaehlcke <mka@chromium.org>
Cc: Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>,
        Rex Zhu <Rex.Zhu@amd.com>,
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

On Wed, Feb 7, 2018 at 11:10 AM, Matthias Kaehlcke <mka@chromium.org> wrote:
> The double parentheses are not needed. Removing them fixes the following
> warning when building with clang:
>
> drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c:419:29:
>   error: equality comparison with extraneous parentheses
>     [-Werror,-Wparentheses-equality]
>   if ((data->vdd_gfx_control == SMU7_VOLTAGE_CONTROL_BY_SVID2)) {
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>  drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c
> index 79e5c05571bc..f5b3de29b632 100644
> --- a/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c
> @@ -416,7 +416,7 @@ static int tonga_populate_cac_tables(struct pp_hwmgr *hwmgr,
>                         convert_to_vid(vddc_lookup_table->entries[index].us_cac_high);
>         }
>
> -       if ((data->vdd_gfx_control == SMU7_VOLTAGE_CONTROL_BY_SVID2)) {
> +       if (data->vdd_gfx_control == SMU7_VOLTAGE_CONTROL_BY_SVID2) {
>                 /* We are populating vddgfx CAC data to BapmVddgfx table in split mode */
>                 for (count = 0; count < vddgfx_level_count; count++) {
>                         index = phm_get_voltage_index(vddgfx_lookup_table,
> --
> 2.16.0.rc1.238.g530d649a79-goog
>
