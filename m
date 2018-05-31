Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754944AbeEaMKn (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 08:10:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53572 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754701AbeEaMKk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 08:10:40 -0400
Date: Thu, 31 May 2018 13:10:38 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Lorenzo Dalrio <lorenzo.dalrio@gmail.com>
Subject: Re: [PATCH v2] libata: Drop SanDisk SD7UB3Q*G1001 NOLPM quirk
Message-ID: <20180531121038.GR1455@redhat.com>
References: <20180531112107.13778-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180531112107.13778-1-hdegoede@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2018 at 01:21:07PM +0200, Hans de Goede wrote:
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

As the reporter of the original issue, I agree with Hans's
analysis above, so ACK from me.

Rich.

> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1583207
> Cc: stable@vger.kernel.org
> Cc: Richard W.M. Jones <rjones@redhat.com>
> Cc: Lorenzo Dalrio <lorenzo.dalrio@gmail.com>
> Reported-by: Lorenzo Dalrio <lorenzo.dalrio@gmail.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> -Rebase on 4.17-rc7
> ---
>  drivers/ata/libata-core.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 346b163f6e89..9bfd2f7e4542 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -4557,9 +4557,6 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
>  	{ "SAMSUNG MZMPC128HBFU-000MV", "CXM14M1Q", ATA_HORKAGE_NOLPM, },
>  	{ "SAMSUNG SSD PM830 mSATA *",  "CXM13D1Q", ATA_HORKAGE_NOLPM, },
>  
> -	/* Sandisk devices which are known to not handle LPM well */
> -	{ "SanDisk SD7UB3Q*G1001",	NULL,	ATA_HORKAGE_NOLPM, },
> -
>  	/* devices that don't properly handle queued TRIM commands */
>  	{ "Micron_M500IT_*",		"MU01",	ATA_HORKAGE_NO_NCQ_TRIM |
>  						ATA_HORKAGE_ZERO_AFTER_TRIM, },
> -- 
> 2.17.0

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-df lists disk usage of guests without needing to install any
software inside the virtual machine.  Supports Linux and Windows.
http://people.redhat.com/~rjones/virt-df/
