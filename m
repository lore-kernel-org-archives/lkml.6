Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754635AbeEaLUj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 07:20:39 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34500 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754571AbeEaLUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 07:20:36 -0400
X-Google-Smtp-Source: ADUXVKItiIK5LoJy/v2hhxbAN1NS0o6z5ihLHjT8UK2CUK+Q0GH2nU2y40XgM6jS3qYl3DJXkksssA==
Subject: Re: [PATCH] libata: Drop SanDisk SD7UB3Q*G1001 NOLPM quirk
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, "Richard W . M . Jones" <rjones@redhat.com>,
        Lorenzo Dalrio <lorenzo.dalrio@gmail.com>
References: <20180531111629.13394-1-hdegoede@redhat.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <49d3bc31-ca1e-0fe1-c568-b3a2f510e262@redhat.com>
Date: Thu, 31 May 2018 13:20:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180531111629.13394-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI,

On 31-05-18 13:16, Hans de Goede wrote:
> Commit 184add2ca23c ("libata: Apply NOLPM quirk for SanDisk
> SD7UB3Q*G1001 SSDs") disabled LPM for SanDisk SD7UB3Q*G1001 SSDs.
> 
> This has lead to several reports of users of that SSD where LPM
> was working fine and who know have a significantly increased idle
> power consumption on their laptops.
> 
> Likely there is another problem on the T450s from the original
> reporter which gets exposed by the uncore reaching deeper sleep
> states (higher PC-states) due to LPM being enabled. The problem as
> reported, a hardfreeze about once a day, already did not sound like
> it would be caused by LPM and the reports of the SSD working fine
> confirm this. The original reporter is ok with dropping the quirk.
> 
> A X250 user has reported the same hard freeze problem and for him
> the problem went away after unrelated updates, I suspect some GPU
> driver stack changes fixed things.
> 
> TL;DR: The original reporters problem were triggered by LPM but not
> an LPM issue, so drop the quirk for the SSD in question.
> 
> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1583207
> Cc: stable@vger.kernel.org
> Cc: Richard W.M. Jones <rjones@redhat.com>
> Cc: Lorenzo Dalrio <lorenzo.dalrio@gmail.com>
> Reported-by: Lorenzo Dalrio <lorenzo.dalrio@gmail.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

I should have rebased on top of 4.17-rc7 before doing this, I
will send a v2 which should apply cleanly.

Regards,

Hans




> ---
>   drivers/ata/libata-core.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 68596bd4cf06..6e400ff2b5db 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -4552,9 +4552,6 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
>   	/* This specific Samsung model/firmware-rev does not handle LPM well */
>   	{ "SAMSUNG MZMPC128HBFU-000MV", "CXM14M1Q", ATA_HORKAGE_NOLPM, },
>   
> -	/* Sandisk devices which are known to not handle LPM well */
> -	{ "SanDisk SD7UB3Q*G1001",	NULL,	ATA_HORKAGE_NOLPM, },
> -
>   	/* devices that don't properly handle queued TRIM commands */
>   	{ "Micron_M500_*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
>   						ATA_HORKAGE_ZERO_AFTER_TRIM, },
> 
