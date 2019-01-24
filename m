Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B23C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 09:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78A42218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 09:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XFse94Bs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfAXJlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 04:41:20 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:52304 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbfAXJlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 04:41:19 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0O9fChj120867;
        Thu, 24 Jan 2019 03:41:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1548322872;
        bh=UQ/kj4tVARfiWlYM/+ZPopILMLF8vl9wpbdkUnyJx9M=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=XFse94BsqInQRIY3f7odHxEtFAhexpd/fb7IAio36ZDxZ34ZOFoivOXK9aZTQ+etN
         hT2O588ThCkzUOy4PtuiTRmLVlzsokrDG/2xirb1YEFH+lYh4nWM7TIrZ5/Rv6Gid3
         j98tLqwko+h5o9hA/0aez8uExw8+u7wAYTT50vlQ=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0O9fC7D072240
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Jan 2019 03:41:12 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 24
 Jan 2019 03:41:12 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 24 Jan 2019 03:41:12 -0600
Received: from [172.24.190.215] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0O9f89G007908;
        Thu, 24 Jan 2019 03:41:09 -0600
Subject: Re: [PATCH 0/7] Port am335 and am437 devices to sdhci-omap
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>
CC:     <zhang.chunyan@linaro.org>, <kishon@ti.com>,
        <adrian.hunter@intel.com>, <mark.rutland@arm.com>,
        <robh+dt@kernel.org>, <ulf.hansson@linaro.org>
References: <20190111110851.6805-1-faiz_abbas@ti.com>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <f26aa2cc-fe14-f0e8-171f-bd81ea6a216b@ti.com>
Date:   Thu, 24 Jan 2019 15:14:08 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190111110851.6805-1-faiz_abbas@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/01/19 4:38 PM, Faiz Abbas wrote:
> The following add driver patches for porting TI's am335x and am437x
> devices to the sdhci-omap driver.
> 
> This involves adding external DMA support to sdhci (first 3 patches from
> Chunyan) plus some miscellaneous patches to take care of deviations of
> the controllers from the sdhci model.
> 
> DT changes will be posted in a separate series.
> 
> Untested versions of Chunyan's patches were posted before[1].
> 
> Tested on: am335x-evm, am335x-boneblack, am335x-sk, am437x-gpevm,
> am43xx-gpevm, am437x-idk, dra7xx-evm, dra72x-evm
> 
> [1] https://patchwork.kernel.org/project/linux-mmc/list/?series=54897
> 
> Chunyan Zhang (3):
>   mmc: sdhci: add support for using external DMA devices
>   mmc: sdhci-omap: Add using external dma
>   dt-bindings: sdhci-omap: Add example for using external dma
> 
> Faiz Abbas (4):
>   mmc: sdhci: Add quirk for disabling DTO during erase command
>   mmc: sdhci_omap: Add DISABLE_DTO_FOR_ERASE Quirk
>   dt-bindings: sdhci-omap: Add am335x and am437x specific bindings
>   mmc: sdhci-omap: Add am335x and am437x specific compatibles
> 
>  .../devicetree/bindings/mmc/sdhci-omap.txt    |   9 +
>  drivers/mmc/host/Kconfig                      |   4 +
>  drivers/mmc/host/sdhci-omap.c                 |  27 +-
>  drivers/mmc/host/sdhci.c                      | 274 +++++++++++++++++-
>  drivers/mmc/host/sdhci.h                      |  10 +
>  5 files changed, 319 insertions(+), 5 deletions(-)
> 

Gentle ping.

Thanks,
Faiz
