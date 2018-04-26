Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754112AbeDZSqt (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 14:46:49 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:36059 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751363AbeDZSqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 14:46:46 -0400
X-Google-Smtp-Source: AB8JxZo1gRZ8Y67uLm5yf4xMZqmM5WLWu9whBeFK19oluXHiDoswmGEH+rYiXnibePPRdtmpsz4qwQ==
Date: Thu, 26 Apr 2018 11:46:43 -0700
From: Tejun Heo <tj@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kevin Shanahan <kevin@shanahan.id.au>
Subject: Re: [PATCH] libata: Apply NOLPM quirk for SAMSUNG MZMPC128HBFU-000MV
 SSD
Message-ID: <20180426184643.GL1911913@devbig577.frc2.facebook.com>
References: <20180424091907.19903-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180424091907.19903-1-hdegoede@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2018 at 11:19:07AM +0200, Hans de Goede wrote:
> Kevin Shanahan reports the following repeating errors when using LPM,
> causing long delays accessing the disk:
> 
>   Apr 23 10:21:43 link kernel: ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x50000 action 0x6 frozen
>   Apr 23 10:21:43 link kernel: ata1: SError: { PHYRdyChg CommWake }
>   Apr 23 10:21:43 link kernel: ata1.00: failed command: WRITE DMA
>   Apr 23 10:21:43 link kernel: ata1.00: cmd ca/00:08:60:5d:cd/00:00:00:00:00/e1 tag 9 dma 4096 out
>                                         res 50/01:01:01:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
>   Apr 23 10:21:43 link kernel: ata1.00: status: { DRDY }
>   Apr 23 10:21:43 link kernel: ata1.00: error: { AMNF }
>   Apr 23 10:21:43 link kernel: ata1: hard resetting link
>   Apr 23 10:21:43 link kernel: ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
>   Apr 23 10:21:43 link kernel: ata1.00: configured for UDMA/133
>   Apr 23 10:21:43 link kernel: ata1: EH complete
> 
> These go away when switching from med_power_with_dipm to medium_power.
> 
> This is somewhat weird as the PM830 datasheet explicitly mentions DIPM
> being supported and the idle power-consumption is specified with DIPM
> enabled.
> 
> There are many OEM customized firmware versions for the PM830, so for now
> lets assume this is firmware version specific and blacklist LPM based on
> the firmware version.
> 
> Cc: Kevin Shanahan <kevin@shanahan.id.au>
> Reported-by: Kevin Shanahan <kevin@shanahan.id.au>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied to libata/for-4.17-fixes.

Thanks.

-- 
tejun
