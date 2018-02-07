Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754452AbeBGUmI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 15:42:08 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:41569 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754087AbeBGUmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 15:42:06 -0500
X-Google-Smtp-Source: AH8x2268MnFm9Op7fWyrA+PRNSDgmyanEXRsb0IyuydJA4AWxgwbLu7en4+SW1MGZLQJc8ZeGONJL5zadxqX5Am4lWA=
MIME-Version: 1.0
In-Reply-To: <20180207194928.93869-1-mka@chromium.org>
References: <20180207194928.93869-1-mka@chromium.org>
From: Guenter Roeck <groeck@google.com>
Date: Wed, 7 Feb 2018 12:42:04 -0800
Message-ID: <CABXOdTdH8GsiPuYk0JnrwRo1jT=GfenaAVw9zexFnG5grptmzw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Remove extra pairs of parentheses in dce_calcs.c
To: Matthias Kaehlcke <mka@chromium.org>
Cc: Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>,
        Harry Wentland <harry.wentland@amd.com>,
        Tony Cheng <tony.cheng@amd.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        Joshua Aberback <Joshua.Aberback@amd.com>,
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
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w17KgCxh013424

On Wed, Feb 7, 2018 at 11:49 AM, Matthias Kaehlcke <mka@chromium.org> wrote:
> The double parentheses are not needed. Removing them fixes multiple
> warnings like this when building with clang:
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dce_calcs.c:617:42:
>   error: equality comparison with extraneous parentheses
>     [-Werror,-Wparentheses-equality]
>   if ((data->graphics_micro_tile_mode == bw_def_rotated_micro_tiling)) {
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>  drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c b/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
> index 2e11fac2a63d..bb03a9c64d5a 100644
> --- a/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
> +++ b/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
> @@ -623,7 +623,7 @@ static void calculate_bandwidth(
>                                 }
>                                 else {
>                                         /*graphics portrait tiling mode*/
> -                                       if ((data->graphics_micro_tile_mode == bw_def_rotated_micro_tiling)) {
> +                                       if (data->graphics_micro_tile_mode == bw_def_rotated_micro_tiling) {
>                                                 data->orthogonal_rotation[i] = 0;
>                                         }
>                                         else {
> @@ -634,7 +634,7 @@ static void calculate_bandwidth(
>                         else {
>                                 if ((i < 4)) {
>                                         /*underlay landscape tiling mode is only supported*/
> -                                       if ((data->underlay_micro_tile_mode == bw_def_display_micro_tiling)) {
> +                                       if (data->underlay_micro_tile_mode == bw_def_display_micro_tiling) {
>                                                 data->orthogonal_rotation[i] = 0;
>                                         }
>                                         else {
> @@ -643,7 +643,7 @@ static void calculate_bandwidth(
>                                 }
>                                 else {
>                                         /*graphics landscape tiling mode*/
> -                                       if ((data->graphics_micro_tile_mode == bw_def_display_micro_tiling)) {
> +                                       if (data->graphics_micro_tile_mode == bw_def_display_micro_tiling) {
>                                                 data->orthogonal_rotation[i] = 0;
>                                         }
>                                         else {
> @@ -947,14 +947,14 @@ static void calculate_bandwidth(
>         }
>         for (i = 0; i <= maximum_number_of_surfaces - 1; i++) {
>                 if (data->enable[i]) {
> -                       if ((data->number_of_displays == 1 && data->number_of_underlay_surfaces == 0)) {
> +                       if (data->number_of_displays == 1 && data->number_of_underlay_surfaces == 0) {
>                                 /*set maximum chunk limit if only one graphic pipe is enabled*/
>                                 data->outstanding_chunk_request_limit[i] = bw_int_to_fixed(127);
>                         }
>                         else {
>                                 data->outstanding_chunk_request_limit[i] = bw_ceil2(bw_div(data->adjusted_data_buffer_size[i], data->pipe_chunk_size_in_bytes[i]), bw_int_to_fixed(1));
>                                 /*clamp maximum chunk limit in the graphic display pipe*/
> -                               if ((i >= 4)) {
> +                               if (i >= 4) {
>                                         data->outstanding_chunk_request_limit[i] = bw_max2(bw_int_to_fixed(127), data->outstanding_chunk_request_limit[i]);
>                                 }
>                         }
> @@ -1337,7 +1337,7 @@ static void calculate_bandwidth(
>         /*if stutter and dram clock state change are gated before cursor then the cursor latency hiding does not limit stutter or dram clock state change*/
>         for (i = 0; i <= maximum_number_of_surfaces - 1; i++) {
>                 if (data->enable[i]) {
> -                       if ((dceip->graphics_lb_nodownscaling_multi_line_prefetching == 1)) {
> +                       if (dceip->graphics_lb_nodownscaling_multi_line_prefetching == 1) {
>                                 data->maximum_latency_hiding[i] = bw_add(data->minimum_latency_hiding[i], bw_mul(bw_frc_to_fixed(8, 10), data->total_dmifmc_urgent_latency));
>                         }
>                         else {
> @@ -1396,7 +1396,7 @@ static void calculate_bandwidth(
>         }
>         /*determine the number of displays with margin to switch in the v_active region*/
>         for (k = 0; k <= maximum_number_of_surfaces - 1; k++) {
> -               if ((data->enable[k] == 1 && data->display_pstate_change_enable[k] == 1)) {
> +               if (data->enable[k] == 1 && data->display_pstate_change_enable[k] == 1) {
>                         number_of_displays_enabled_with_margin = number_of_displays_enabled_with_margin + 1;
>                 }
>         }
> @@ -1442,7 +1442,7 @@ static void calculate_bandwidth(
>                 data->nbp_state_change_enable = bw_def_no;
>         }
>         /*dram clock change is possible only in vblank if all displays are aligned and have no margin*/
> -       if ((number_of_aligned_displays_with_no_margin == number_of_displays_enabled)) {
> +       if (number_of_aligned_displays_with_no_margin == number_of_displays_enabled) {
>                 nbp_state_change_enable_blank = bw_def_yes;
>         }
>         else {
> @@ -1470,7 +1470,7 @@ static void calculate_bandwidth(
>                 }
>         }
>         /*compute minimum time to read one chunk from the dmif buffer*/
> -       if ((number_of_displays_enabled > 2)) {
> +       if (number_of_displays_enabled > 2) {
>                 data->chunk_request_delay = 0;
>         }
>         else {
> @@ -1804,7 +1804,7 @@ static void calculate_bandwidth(
>                                 data->stutter_exit_watermark[i] = bw_add(bw_sub(vbios->stutter_self_refresh_exit_latency, data->total_dmifmc_urgent_latency), data->urgent_watermark[i]);
>                                 data->stutter_entry_watermark[i] = bw_add(bw_sub(bw_add(vbios->stutter_self_refresh_exit_latency, vbios->stutter_self_refresh_entry_latency), data->total_dmifmc_urgent_latency), data->urgent_watermark[i]);
>                                 /*unconditionally remove black out time from the nb p_state watermark*/
> -                               if ((data->display_pstate_change_enable[i] == 1)) {
> +                               if (data->display_pstate_change_enable[i] == 1) {
>                                         data->nbp_state_change_watermark[i] = bw_add(bw_add(vbios->nbp_state_change_latency, data->dmif_burst_time[data->y_clk_level][data->sclk_level]), bw_max2(data->line_source_pixels_transfer_time, data->dram_speed_change_line_source_transfer_time[i][data->y_clk_level][data->sclk_level]));
>                                 }
>                                 else {
> @@ -1816,7 +1816,7 @@ static void calculate_bandwidth(
>                                 data->urgent_watermark[i] = bw_add(bw_add(bw_add(bw_add(bw_add(vbios->mcifwrmc_urgent_latency, data->mcifwr_burst_time[data->y_clk_level][data->sclk_level]), bw_max2(data->line_source_pixels_transfer_time, data->line_source_transfer_time[i][data->y_clk_level][data->sclk_level])), vbios->blackout_duration), data->chunk_request_time), data->cursor_request_time);
>                                 data->stutter_exit_watermark[i] = bw_int_to_fixed(0);
>                                 data->stutter_entry_watermark[i] = bw_int_to_fixed(0);
> -                               if ((data->display_pstate_change_enable[i] == 1)) {
> +                               if (data->display_pstate_change_enable[i] == 1) {
>                                         data->nbp_state_change_watermark[i] = bw_add(bw_add(vbios->nbp_state_change_latency, data->mcifwr_burst_time[data->y_clk_level][data->sclk_level]), bw_max2(data->line_source_pixels_transfer_time, data->dram_speed_change_line_source_transfer_time[i][data->y_clk_level][data->sclk_level]));
>                                 }
>                                 else {
> --
> 2.16.0.rc1.238.g530d649a79-goog
>
