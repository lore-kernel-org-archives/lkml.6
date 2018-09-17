Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D257ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 21:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1202D2146D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 21:10:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1202D2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728569AbeIRCjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 22:39:14 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42765 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbeIRCjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 22:39:13 -0400
Received: by mail-ot1-f66.google.com with SMTP id h26-v6so12832186otl.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 14:10:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=puJ3mBDOxtGdwK5rKDyjcp3XiYsmpCdlkuS/MUvszGk=;
        b=niP8rND1wQqO9/WC0dNpDvqvcJuCfg8dREAsUCw3ErsXsmjupFQlbNSrArvoCiVc2N
         7rcSl2qAqVqZ4yqgmTDYKj17BK/nx6ae8Ic1Xoha/vndb7hibZCxCb6XDvX3w24VUKkD
         V/3BVYnqbSoezimJXgrATIbdUSbSVRoHNS/R7j1LYKFDw4ypL/wmIBFfxCo3OLfNCgV6
         mXcwxHWE+kRUOn+Txu5wXi34KihnM53c6WFv77dF+9+E+7C/CVhkCKMcM6bJXIBBY2py
         I2iYH/UeQsbVATDnZlbF01apnTyHn3go4mwf5SWk7IFtz48EzHMs7hKlU18eaNLjmk8j
         eW9g==
X-Gm-Message-State: APzg51DFtH6VlvPOYnoYCtyIrX40cdbN+njq8EFIxc91oW6zKJt0VhYW
        PU6nXNjsy42thxa8f2198RFlLi32
X-Google-Smtp-Source: ANB0VdZpmMWUCMqrRAmmPW9n9YicGIkZXGOYcN2iryQaGpLrSe+sH055/UY+z+wBSWedaHkSakB3yg==
X-Received: by 2002:a9d:1422:: with SMTP id h31-v6mr13623784oth.41.1537218609738;
        Mon, 17 Sep 2018 14:10:09 -0700 (PDT)
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com. [209.85.210.54])
        by smtp.gmail.com with ESMTPSA id z1-v6sm4755008ota.44.2018.09.17.14.10.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 14:10:09 -0700 (PDT)
Received: by mail-ot1-f54.google.com with SMTP id a19-v6so12827486otl.12
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 14:10:09 -0700 (PDT)
X-Received: by 2002:a9d:48a:: with SMTP id 10-v6mr12677044otm.361.1537218608869;
 Mon, 17 Sep 2018 14:10:08 -0700 (PDT)
MIME-Version: 1.0
References: <20180915111005.10028-1-yuehaibing@huawei.com>
In-Reply-To: <20180915111005.10028-1-yuehaibing@huawei.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Mon, 17 Sep 2018 16:09:57 -0500
X-Gmail-Original-Message-ID: <CADRPPNSQp78jioP8Eao3ku_vqYCddRTuz1sydskUiPWTfmSUGQ@mail.gmail.com>
Message-ID: <CADRPPNSQp78jioP8Eao3ku_vqYCddRTuz1sydskUiPWTfmSUGQ@mail.gmail.com>
Subject: Re: [PATCH -next] fsl/qe: Fix copy-paste error in ucc_get_tdm_sync_shift
To:     yuehaibing@huawei.com
Cc:     Zhao Qiang <qiang.zhao@nxp.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 15, 2018 at 6:11 AM YueHaibing <yuehaibing@huawei.com> wrote:
>
> if 'mode' is COMM_DIR_TX, 'shift' should use TX_SYNC_SHIFT_BASE
>
> Fixes: bb8b2062aff3 ("fsl/qe: setup clock source for TDM mode")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Thanks for submitting the patch, but there is already the same fix in
the queue from Zhao Qiang and Dan Carpenter.

> ---
>  drivers/soc/fsl/qe/ucc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/soc/fsl/qe/ucc.c b/drivers/soc/fsl/qe/ucc.c
> index c646d87..681f7d4 100644
> --- a/drivers/soc/fsl/qe/ucc.c
> +++ b/drivers/soc/fsl/qe/ucc.c
> @@ -626,7 +626,7 @@ static u32 ucc_get_tdm_sync_shift(enum comm_dir mode, u32 tdm_num)
>  {
>         u32 shift;
>
> -       shift = (mode == COMM_DIR_RX) ? RX_SYNC_SHIFT_BASE : RX_SYNC_SHIFT_BASE;
> +       shift = (mode == COMM_DIR_RX) ? RX_SYNC_SHIFT_BASE : TX_SYNC_SHIFT_BASE;
>         shift -= tdm_num * 2;
>
>         return shift;
> --
> 1.8.3.1
>
>
