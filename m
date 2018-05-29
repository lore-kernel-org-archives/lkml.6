Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755138AbeE2H7t (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 03:59:49 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:41431 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754796AbeE2H7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 03:59:47 -0400
X-Google-Smtp-Source: ADUXVKLHWtXSCTuRQ6yXi8IWNDdiREjBCj7rxojoXYExO5P1MkFa75cziinG21Ox5Ej0Dfo1TOw4UPC7YcoT+QnP5KE=
MIME-Version: 1.0
In-Reply-To: <d08e0200-f431-8713-0286-cd5bbf3441c8@gmail.com>
References: <20180525155030.3667352-1-arnd@arndb.de> <20180525155030.3667352-3-arnd@arndb.de>
 <d08e0200-f431-8713-0286-cd5bbf3441c8@gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 29 May 2018 09:59:46 +0200
X-Google-Sender-Auth: D-Y6UXiA-ypQ2NlucScmYmHFnIw
Message-ID: <CAK8P3a0_PgaQV-gK0aX6p45cvCXh4t_CYCgxqk2ERp1pt7uojA@mail.gmail.com>
Subject: Re: [Xen-devel] [PATCH 3/8] drm/xen-front: fix 32-bit build warning
To: Oleksandr Andrushchenko <andr2000@gmail.com>
Cc: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>, xen-devel@lists.xen.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 7:58 AM, Oleksandr Andrushchenko
<andr2000@gmail.com> wrote:
> On 05/25/2018 06:50 PM, Arnd Bergmann wrote:

>> b/drivers/gpu/drm/xen/xen_drm_front_shbuf.c
>> index 8099cb343ae3..d333b67cc1a0 100644
>> --- a/drivers/gpu/drm/xen/xen_drm_front_shbuf.c
>> +++ b/drivers/gpu/drm/xen/xen_drm_front_shbuf.c
>> @@ -122,7 +122,7 @@ static void guest_calc_num_grefs(struct
>> xen_drm_front_shbuf *buf)
>>   }
>>     #define xen_page_to_vaddr(page) \
>> -               ((phys_addr_t)pfn_to_kaddr(page_to_xen_pfn(page)))
>> +               ((uintptr_t)pfn_to_kaddr(page_to_xen_pfn(page)))
>>     static int backend_unmap(struct xen_drm_front_shbuf *buf)
>>   {
>
> Thank you for your patch: this issue was already discussed [1] and applied
> [2] to
> drm-misc-next.

Ok, thanks, and sorry for the duplicate. Linux-next releases have been
a bit sporadic recently so I didn't run the latest tree for all cases.

    Arnd
