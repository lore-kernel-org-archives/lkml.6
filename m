Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965909AbeEITub (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 15:50:31 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:46814 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965454AbeEITu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 15:50:28 -0400
X-Google-Smtp-Source: AB8JxZqSmGx064PwgBQvqiLwJ3hai3rxFBVmLrM1iQMFOSTwKiXTfEIGbj2JLfKm9VnpsWgFBPrCHn1OG84+33URk6A=
MIME-Version: 1.0
In-Reply-To: <fe695f10-eb1b-f6f4-ae02-c2f12225992c@amd.com>
References: <20180502144316.32056-1-colin.king@canonical.com> <fe695f10-eb1b-f6f4-ae02-c2f12225992c@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 9 May 2018 15:50:26 -0400
Message-ID: <CADnq5_OEzKSnXWbVaAUDnfK-uinyQGh16K-2iAduYNj6+vXRHA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: clean up assignment of amdgpu_crtc
To: Harry Wentland <harry.wentland@amd.com>
Cc: Colin King <colin.king@canonical.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers
        <dri-devel@lists.freedesktop.org>,
        kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 2, 2018 at 11:04 AM, Harry Wentland <harry.wentland@amd.com> wrote:
> On 2018-05-02 10:43 AM, Colin King wrote:
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> The declaration of pointer amdgpu_crtc has a redundant assignment to
>> amdgpu_crtc. Clean this up by removing it.
>>
>> Detected by CoverityScan, CID#1460299 ("Evaluation order violation")
>>
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>
> Looks like i goofed. Thanks for fixing this.
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>


Applied.  Thanks!

Alex

>
> Harry
>
>> ---
>>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index 1dd1142246c2..2beb8821e19e 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -3773,7 +3773,7 @@ static void remove_stream(struct amdgpu_device *adev,
>>  static int get_cursor_position(struct drm_plane *plane, struct drm_crtc *crtc,
>>                              struct dc_cursor_position *position)
>>  {
>> -     struct amdgpu_crtc *amdgpu_crtc = amdgpu_crtc = to_amdgpu_crtc(crtc);
>> +     struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
>>       int x, y;
>>       int xorigin = 0, yorigin = 0;
>>
>>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
