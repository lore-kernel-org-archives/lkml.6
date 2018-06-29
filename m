Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9119CC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 06:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 466A827B46
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 06:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FcTNH540";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CDs3WXQY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 466A827B46
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934083AbeF2GWh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 02:22:37 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44788 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933954AbeF2GW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 02:22:29 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1D6BC60B1A; Fri, 29 Jun 2018 06:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530253349;
        bh=GNkaRxFb7PCx249Mz1wDg2M2TRTyGiEB0tq8xRUjT/Q=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=FcTNH540pr+q/9KejSU91Hb4+pmSf7zg+IRVPRENlcD9uM9XaIunTa39wvNpIfz/P
         VNfGX+yo7n22/2vqum9eC9Rgp3rrFqxORqT6NVPyK7dhbbeZQdgSpvBjelcOLEeMed
         PHiLCUqxMUIl03z+QSWPWkLguCbTqNgJNWP7uzOg=
Received: from x230.qca.qualcomm.com (85-76-82-35-nat.elisa-mobile.fi [85.76.82.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 11454606DD;
        Fri, 29 Jun 2018 06:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530253347;
        bh=GNkaRxFb7PCx249Mz1wDg2M2TRTyGiEB0tq8xRUjT/Q=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=CDs3WXQY3j5P+Z2ZglHwoGTRn7haMeqeZ9OFMWk/WZZfDKPTpiTp2f7Fe2PEvBhLo
         6JaSuoxQ9d75bFuV7SxzeZthQNG81XtxZXaRqzEq92bOJ5eGRBa8354CChlZnz3Vcu
         QInjq7YvaQ/WcvRRt773m8/0yMWxzVkLw6E1drEc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 11454606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Sergey Matyukevich <smatyukevich@quantenna.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Igor Mitsyanko <imitsyanko@quantenna.com>,
        Avinash Patil <avinashp@quantenna.com>,
        Wright Feng <wright.feng@cypress.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Quan Nguyen <qnguyen@apm.com>,
        Keyur Chudgar <kchudgar@apm.com>,
        Jiri Pirko <jiri@mellanox.com>,
        Iyappan Subramanian <isubramanian@apm.com>,
        Ido Schimmel <idosch@mellanox.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] net: Remove depends on HAS_DMA in case of platform dependency
References: <20180622110843.31965-1-geert@linux-m68k.org>
Date:   Fri, 29 Jun 2018 09:22:19 +0300
In-Reply-To: <20180622110843.31965-1-geert@linux-m68k.org> (Geert
        Uytterhoeven's message of "Fri, 22 Jun 2018 13:08:43 +0200")
Message-ID: <87a7reglic.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> Remove dependencies on HAS_DMA where a Kconfig symbol depends on another
> symbol that implies HAS_DMA, and, optionally, on "|| COMPILE_TEST".
> In most cases this other symbol is an architecture or platform specific
> symbol, or PCI.
>
> Generic symbols and drivers without platform dependencies keep their
> dependencies on HAS_DMA, to prevent compiling subsystems or drivers that
> cannot work anyway.
>
> This simplifies the dependencies, and allows to improve compile-testing.
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> Acked-by: Robin Murphy <robin.murphy@arm.com>
> ---
> v4:
>   - Rebase to v4.18-rc1 (applies to next-20180622, too),
>
> v3:
>   - Rebase to v4.17-rc1,
>   - Drop obsolete note about FSL_FMAN,
>
> v2:
>   - Add Reviewed-by, Acked-by,
>   - Drop RFC state,
>   - Split per subsystem.
> ---
>  drivers/net/ethernet/amd/Kconfig                | 2 +-
>  drivers/net/ethernet/apm/xgene-v2/Kconfig       | 1 -
>  drivers/net/ethernet/apm/xgene/Kconfig          | 1 -
>  drivers/net/ethernet/arc/Kconfig                | 6 ++++--
>  drivers/net/ethernet/broadcom/Kconfig           | 2 --
>  drivers/net/ethernet/calxeda/Kconfig            | 2 +-
>  drivers/net/ethernet/hisilicon/Kconfig          | 2 +-
>  drivers/net/ethernet/marvell/Kconfig            | 8 +++-----
>  drivers/net/ethernet/mellanox/mlxsw/Kconfig     | 2 +-
>  drivers/net/ethernet/renesas/Kconfig            | 2 --
>  drivers/net/wireless/broadcom/brcm80211/Kconfig | 1 -
>  drivers/net/wireless/quantenna/qtnfmac/Kconfig  | 2 +-
>  12 files changed, 12 insertions(+), 19 deletions(-)

For the wireless part:

Acked-by: Kalle Valo <kvalo@codeaurora.org>

-- 
Kalle Valo
