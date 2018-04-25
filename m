Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754516AbeDYNnP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 09:43:15 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35745 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754462AbeDYNnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 09:43:02 -0400
X-Google-Smtp-Source: AIpwx4/V/GE3nss0iysyoIa8Np2vdSYEaywef41zepo1CS/ATxE8MbhL9o480lTmtwhZikWWBmefsds5agWixrutVuw=
MIME-Version: 1.0
In-Reply-To: <5811471.PjpYk9OX8O@avalon>
References: <20180425121036.28965-1-vthakkar1994@gmail.com> <5811471.PjpYk9OX8O@avalon>
From: Vaishali Thakkar <vthakkar1994@gmail.com>
Date: Wed, 25 Apr 2018 19:12:59 +0530
Message-ID: <CAK-LDbKJ5CF7x-Ott68c7uf-sWW9v8+C9C-F6df7Zu9ZVXBU0w@mail.gmail.com>
Subject: Re: [PATCH] drm: rcar-du: Use drm_dev_put
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-renesas-soc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 25, 2018 at 7:02 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hi Vaishali,
>
> Thank you for the patch.
>
> On Wednesday, 25 April 2018 15:10:36 EEST Vaishali Thakkar wrote:
>> As specified in drm_drv.c, drm_dev_unref is a compatibility alias
>> for drm_dev_put and shouldn't be used in new code. So, use
>> drm_dev_put instead.
>
> This looks good to me. However, how about taking it one step further and mass-
> patching all drivers to use drm_dev_put() ? We could then remove
> drm_dev_unref() completely.

Sure thing! Do you want me to fold this patch in that patchset or will you be
fine with applying this separately?

>> Signed-off-by: Vaishali Thakkar <vthakkar1994@gmail.com>
>> ---
>>  drivers/gpu/drm/rcar-du/rcar_du_drv.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
>> b/drivers/gpu/drm/rcar-du/rcar_du_drv.c index 05745e86d73e..418a80e6b2f4
>> 100644
>> --- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
>> +++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
>> @@ -378,7 +378,7 @@ static int rcar_du_remove(struct platform_device *pdev)
>>       drm_kms_helper_poll_fini(ddev);
>>       drm_mode_config_cleanup(ddev);
>>
>> -     drm_dev_unref(ddev);
>> +     drm_dev_put(ddev);
>>
>>       return 0;
>>  }
>
> --
> Regards,
>
> Laurent Pinchart
>
>
>



-- 
Vaishali
http://vaishalithakkar.in/
