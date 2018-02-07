Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754569AbeBGUs0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 15:48:26 -0500
Received: from mail-yw0-f196.google.com ([209.85.161.196]:36907 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754127AbeBGUsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 15:48:25 -0500
X-Google-Smtp-Source: AH8x224jSvmFVBwD24ywpiWBgLTi5ryycMeUOtUgS5CRkttH7oB5IhJlsZbE7wzKk30FueHBA+kfIUmF88aw1oNxgeA=
MIME-Version: 1.0
In-Reply-To: <CABXOdTf8NTgzzE87ftqvzJLJfB+sqoti0Q8Pda-oxweu5XvuAg@mail.gmail.com>
References: <20180207191017.77392-1-mka@chromium.org> <CABXOdTf8NTgzzE87ftqvzJLJfB+sqoti0Q8Pda-oxweu5XvuAg@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 7 Feb 2018 15:48:24 -0500
Message-ID: <CADnq5_OxjsdCOYhqTEuLTp_Dz7QHFp_dMLgke05b8JkxF1ViWQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/powerplay: Remove extra pair of parentheses
To: Guenter Roeck <groeck@google.com>
Cc: Matthias Kaehlcke <mka@chromium.org>, David Zhou <David1.Zhou@amd.com>,
        Craig Bergstrom <craigb@chromium.org>,
        Justin TerAvest <teravest@chromium.org>,
        David Airlie <airlied@linux.ie>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Guenter Roeck <groeck@chromium.org>,
        Maling list - DRI developers
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>, Rex Zhu <Rex.Zhu@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 7, 2018 at 2:19 PM, Guenter Roeck <groeck@google.com> wrote:
> On Wed, Feb 7, 2018 at 11:10 AM, Matthias Kaehlcke <mka@chromium.org> wrote:
>> The double parentheses are not needed. Removing them fixes the following
>> warning when building with clang:
>>
>> drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c:419:29:
>>   error: equality comparison with extraneous parentheses
>>     [-Werror,-Wparentheses-equality]
>>   if ((data->vdd_gfx_control == SMU7_VOLTAGE_CONTROL_BY_SVID2)) {
>>
>> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
>
> Reviewed-by: Guenter Roeck <groeck@chromium.org>

Applied.  Thanks!

Alex

>
>> ---
>>  drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c
>> index 79e5c05571bc..f5b3de29b632 100644
>> --- a/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c
>> +++ b/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c
>> @@ -416,7 +416,7 @@ static int tonga_populate_cac_tables(struct pp_hwmgr *hwmgr,
>>                         convert_to_vid(vddc_lookup_table->entries[index].us_cac_high);
>>         }
>>
>> -       if ((data->vdd_gfx_control == SMU7_VOLTAGE_CONTROL_BY_SVID2)) {
>> +       if (data->vdd_gfx_control == SMU7_VOLTAGE_CONTROL_BY_SVID2) {
>>                 /* We are populating vddgfx CAC data to BapmVddgfx table in split mode */
>>                 for (count = 0; count < vddgfx_level_count; count++) {
>>                         index = phm_get_voltage_index(vddgfx_lookup_table,
>> --
>> 2.16.0.rc1.238.g530d649a79-goog
>>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
