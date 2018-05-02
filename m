Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751214AbeEBI7p (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 04:59:45 -0400
Received: from lelnx193.ext.ti.com ([198.47.27.77]:17561 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751137AbeEBI7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 04:59:42 -0400
Subject: Re: [PATCH] drm: omapdrm: silence unititialized variable warning
To: Dan Carpenter <dan.carpenter@oracle.com>
CC: David Airlie <airlied@linux.ie>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <20180418142937.GA13828@mwanda>
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <5184a8fa-4acb-e6b5-099d-aca1793b1b71@ti.com>
Date: Wed, 2 May 2018 11:59:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180418142937.GA13828@mwanda>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 18/04/18 17:29, Dan Carpenter wrote:
> Smatch complains that "area_free" could be used without being
> initialized.  This code is several years old and premusably works fine
> so this can't be a very serious bug.  But it's easy enough to silence
> the warning.  If "area_free" is false at the end of the function then
> we return -ENOMEM.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> diff --git a/drivers/gpu/drm/omapdrm/tcm-sita.c b/drivers/gpu/drm/omapdrm/tcm-sita.c
> index d7f7bc9f061a..817be3c41863 100644
> --- a/drivers/gpu/drm/omapdrm/tcm-sita.c
> +++ b/drivers/gpu/drm/omapdrm/tcm-sita.c
> @@ -90,7 +90,7 @@ static int l2r_t2b(u16 w, u16 h, u16 a, s16 offset,
>  {
>  	int i;
>  	unsigned long index;
> -	bool area_free;
> +	bool area_free = false;
>  	unsigned long slots_per_band = PAGE_SIZE / slot_bytes;
>  	unsigned long bit_offset = (offset > 0) ? offset / slot_bytes : 0;
>  	unsigned long curr_bit = bit_offset;
> 

Thanks, I've queued this for 4.17 fixes.

 Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
