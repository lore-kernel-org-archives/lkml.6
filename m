Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA0BC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 08:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A026820672
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 08:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k0CR7B4k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731711AbeLQIYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 03:24:40 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:45212 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbeLQIYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 03:24:40 -0500
Received: by mail-vs1-f65.google.com with SMTP id v10so7153179vsv.12;
        Mon, 17 Dec 2018 00:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Tn1IquOzT1fcrRk6M9zUUZf2GP3SjXaNUD7m8fLN5AQ=;
        b=k0CR7B4kAtwU//41IGmuVzJLSeKmeTaLvfIO4y1X5hNroSbLMpnIDip+NB3DzFNDTt
         XQ0QTiGmirDyuFP0ToLxZ586lEBAXgsOZ32LjsiHRQupsSsbhbw18hrn9oPlDGdL0ao/
         c7fI1WDuuvlDMHfFMFmd6VRoA4qhsdGLFoqA/kvUCcwuesCPsowYuraow6glgWl1+I7B
         KCtWxIym+AjfeanXlxekIX1nUN17z9sP9dJY0whhyLMzZgP5jziD1Ue27GZY9zd/3KIO
         I3VqbEWhO0lFGcmnpOb2MT3BMCTUI6DY66LsnP4GipExdbIiQwnNNooNat6cN33dzLGW
         Ixhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Tn1IquOzT1fcrRk6M9zUUZf2GP3SjXaNUD7m8fLN5AQ=;
        b=j9r9qalK/Fp+jGgIaYWkAV2T3nUKlLLLczBq+7zv+vHvHY5OQJGXaFHB0rrmP+XJdn
         yUPgRaMsOu/uZ6MKUYxZ9fqqXhU0WsUOIhlG/wgJZMsXSOznEWl/KMieTVuPlze0APcv
         oKf2Rlov4KtB4zeSm1H3ZXzl+12X8coBPbUmWG+g0pRfZg8xE2+CsN2iOG4nN4Kxo+1e
         ufaUaK7bNJ0QU1u7wc+/UUZz3TNmM1iocBGhmdaTd0YpaiR4zl7o/Cg/DVE0Jn+EqBDf
         KlAwCJevsqvQ1xDUUpjfax2EY9tWFyuUFgK2LKmnTw/RvA4D9fbtPGeZimHg4aaGMDd2
         GfVA==
X-Gm-Message-State: AA+aEWbnKzzpbS9ZjWJYzHLhFHwvuZJNtnjFFgju5Awt/f+Z8rCHFgMO
        J5wP1lirUW2vfJ7WqkQvJMVdlFEeA9cVz2U1+w==
X-Google-Smtp-Source: AFSGD/WR0gKxnLs4eNxQCTN53DGpgLL+g1T4+5sEuIbAAYl5syS/maYnkP7yEJ4ILs1PLQ/kvwz8p7f/rhaiYRzBH+g=
X-Received: by 2002:a67:45d8:: with SMTP id z85mr5909713vsf.106.1545035078575;
 Mon, 17 Dec 2018 00:24:38 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ab0:5f19:0:0:0:0:0 with HTTP; Mon, 17 Dec 2018 00:24:38
 -0800 (PST)
In-Reply-To: <20181211151644.599741132@linuxfoundation.org>
References: <20181211151644.216668863@linuxfoundation.org> <20181211151644.599741132@linuxfoundation.org>
From:   Kyuho Choi <chlrbgh0@gmail.com>
Date:   Mon, 17 Dec 2018 17:24:38 +0900
Message-ID: <CAP2JTQJyOad9Tbc8t_K-Xp8q5EpdgeQbaDfTAJgkYUWWpw=TRg@mail.gmail.com>
Subject: Re: [PATCH 4.19 009/118] scsi: ufs: Fix hynix ufs bug with quirk on
 hi36xx SoC
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Wei Li <liwei213@huawei.com>,
        Dmitry Shmidt <dimitrysh@google.com>,
        John Stultz <john.stultz@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

About Hinyx's "hB8aL1" ufs device. For support Kirin AP series, they
are need to apply below VS_DebugSaveConfigTime expand patch.

On 12/12/18, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 4.19-stable review patch.  If anyone has any objections, please let me
> know.
>
> ------------------
>
> [ Upstream commit 8e4829c6f7470722c1f5a1dc5769ebe09ef036d6 ]
>
> Hynix ufs has deviations on hi36xx platform which will result in ufs bursts
> transfer failures.
>
> To fix the problem, the Hynix device must set the register
> VS_DebugSaveConfigTime to 0x10, which will set time reference for
> SaveConfigTime is 250 ns. The time reference for SaveConfigTime is 40 ns by
> default.
>
> This patch is necessary to boot on HiKey960 boards that use Hynix UFS chips
> (H28U62301AMR model: hB8aL1).
>
> Cc: Vinayak Holikatti <vinholikatti@gmail.com>
> Cc: "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>
> Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
> Cc: linux-scsi@vger.kernel.org
> Signed-off-by: Wei Li <liwei213@huawei.com>
> Signed-off-by: Dmitry Shmidt <dimitrysh@google.com>
> [jstultz: Forward ported from older code, slight tweak to commit message]
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/scsi/ufs/ufs-hisi.c   | 9 +++++++++
>  drivers/scsi/ufs/ufs_quirks.h | 6 ++++++
>  drivers/scsi/ufs/ufshcd.c     | 2 ++
>  3 files changed, 17 insertions(+)
>
> diff --git a/drivers/scsi/ufs/ufs-hisi.c b/drivers/scsi/ufs/ufs-hisi.c
> index 46df707e6f2c..452e19f8fb47 100644
> --- a/drivers/scsi/ufs/ufs-hisi.c
> +++ b/drivers/scsi/ufs/ufs-hisi.c
> @@ -20,6 +20,7 @@
>  #include "unipro.h"
>  #include "ufs-hisi.h"
>  #include "ufshci.h"
> +#include "ufs_quirks.h"
>
>  static int ufs_hisi_check_hibern8(struct ufs_hba *hba)
>  {
> @@ -390,6 +391,14 @@ static void ufs_hisi_set_dev_cap(struct
> ufs_hisi_dev_params *hisi_param)
>
>  static void ufs_hisi_pwr_change_pre_change(struct ufs_hba *hba)
>  {
> +	if (hba->dev_quirks & UFS_DEVICE_QUIRK_HOST_VS_DEBUGSAVECONFIGTIME) {
> +		pr_info("ufs flash device must set VS_DebugSaveConfigTime 0x10\n");
> +		/* VS_DebugSaveConfigTime */
> +		ufshcd_dme_set(hba, UIC_ARG_MIB(0xD0A0), 0x10);
> +		/* sync length */
> +		ufshcd_dme_set(hba, UIC_ARG_MIB(0x1556), 0x48);
> +	}
> +
>  	/* update */
>  	ufshcd_dme_set(hba, UIC_ARG_MIB(0x15A8), 0x1);
>  	/* PA_TxSkip */
> diff --git a/drivers/scsi/ufs/ufs_quirks.h b/drivers/scsi/ufs/ufs_quirks.h
> index 71f73d1d1ad1..5d2dfdb41a6f 100644
> --- a/drivers/scsi/ufs/ufs_quirks.h
> +++ b/drivers/scsi/ufs/ufs_quirks.h
> @@ -131,4 +131,10 @@ struct ufs_dev_fix {
>   */
>  #define UFS_DEVICE_QUIRK_HOST_PA_SAVECONFIGTIME	(1 << 8)
>
> +/*
> + * Some UFS devices require VS_DebugSaveConfigTime is 0x10,
> + * enabling this quirk ensure this.
> + */
> +#define UFS_DEVICE_QUIRK_HOST_VS_DEBUGSAVECONFIGTIME	(1 << 9)
> +
>  #endif /* UFS_QUIRKS_H_ */
> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> index 54074dd483a7..0b81d9d03357 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -230,6 +230,8 @@ static struct ufs_dev_fix ufs_fixups[] = {
>  	UFS_FIX(UFS_VENDOR_SKHYNIX, UFS_ANY_MODEL, UFS_DEVICE_NO_VCCQ),
>  	UFS_FIX(UFS_VENDOR_SKHYNIX, UFS_ANY_MODEL,
>  		UFS_DEVICE_QUIRK_HOST_PA_SAVECONFIGTIME),
> +	UFS_FIX(UFS_VENDOR_SKHYNIX, "hB8aL1" /*H28U62301AMR*/,
> +		UFS_DEVICE_QUIRK_HOST_VS_DEBUGSAVECONFIGTIME),
>
>  	END_FIX
>  };
> --
> 2.19.1
>
>
>
>
