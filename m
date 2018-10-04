Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B061C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2A3521470
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UW7qXuDk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2A3521470
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbeJDQOU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 12:14:20 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:60324 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbeJDQOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 12:14:19 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w949LSWj001417;
        Thu, 4 Oct 2018 04:21:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1538644888;
        bh=zrBtGmHGGxLT2IYJEHy3fxmRYmzbOzFgGS/4YiayPuk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=UW7qXuDkhPmBQev4hDLHvcJHKuGs8S09KfRd5HIr0BRR2aJmX8VHTKIWYZ1ktqAEG
         oo9iW3lMZCcqewpRqi/QkV9DZZouPHkbTTfVqwXSbB0Yt4jc37C48h0ZH/GSQkdSuE
         vimWDC3i3OH54F2N+l/EzrmtRXKTMj8fNL9aYRlI=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w949LSc2001404;
        Thu, 4 Oct 2018 04:21:28 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 4 Oct
 2018 04:21:28 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 4 Oct 2018 04:21:28 -0500
Received: from [172.24.190.89] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w949LNHv016709;
        Thu, 4 Oct 2018 04:21:25 -0500
Subject: Re: [PATCH 0/4] spi: add support for octal mode data transfer
To:     Yogesh Gaur <yogeshnarayan.gaur@nxp.com>,
        <linux-mtd@lists.infradead.org>, <boris.brezillon@bootlin.com>,
        <marek.vasut@gmail.com>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <robh@kernel.org>, <mark.rutland@arm.com>, <shawnguo@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <computersforpeace@gmail.com>, <frieder.schrempf@exceet.de>,
        <linux-kernel@vger.kernel.org>
References: <1538642920-3843-1-git-send-email-yogeshnarayan.gaur@nxp.com>
From:   Vignesh R <vigneshr@ti.com>
Message-ID: <43cff872-0dc5-d3ce-ca35-082faa0e0e7c@ti.com>
Date:   Thu, 4 Oct 2018 14:52:18 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1538642920-3843-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yogesh,

On Thursday 04 October 2018 02:18 PM, Yogesh Gaur wrote:
> Add support for octal mode IO data transfer.
> Micron flash, mt35xu512aba, supports octal mode data transfer and
> NXP FlexSPI controller supports 8 data lines for data transfer (Rx/Tx).
> 
> Patch series 
> * Add support for octal mode flags and parsing of same in spi driver.
> * Add octal data communication commands required for mt35xu512aba [1] flash.
> * Add support for Read and Write proto for (1-1-8/1-8-8) mode.
> * Add mode bit required for octal mode in nxp-fspi driver [2].
> * Define binding property 'spi-rx/tx-bus-width' for LX2160ARDB target [2].
> 
> Tested on LX2160ARDB target with nxp-fspi driver, below are
> Read performance number of 1-1-1 and 1-1-8 read protocol.
> 
>  root@lxxx:~# cat /proc/mtd
>  dev:    size   erasesize  name
>  mtd0: 04000000 00001000 "spi0.0"
>  mtd1: 04000000 00001000 "spi0.1"
>  root@lxxx:~# time mtd_debug read /dev/mtd0 0x0 0x1000000 0read
>  Copied 16777216 bytes from address 0x00000000 in flash to 0read
>  
>  real    0m2.792s
>  user    0m0.000s
>  sys     0m2.790s
>  root@lxxx:~# time mtd_debug read /dev/mtd1 0x0 0x1000000 0read
>  Copied 16777216 bytes from address 0x00000000 in flash to 0read
>  
>  real    0m0.441s
>  user    0m0.000s
>  sys     0m0.440s
>  root@ls1012ardb:~#
> 
>  Flash device MTD0 configured in 1-1-1 protocol.
>  Flash device MTD1 configured in 1-1-8 protocol.
> 
> [1] https://patchwork.ozlabs.org/project/linux-mtd/list/?series=66317
> [2] https://patchwork.ozlabs.org/project/linux-mtd/list/?series=66887
> 
> Yogesh Gaur (4):
>   spi: add support for octal I/O data transfer
>   mtd: spi-nor: add support for octal mode data transfer
>   spi: nxp-fspi: add mode flag bit for octal support
>   arm64: dts: lx2160a: update fspi node

This is a bit confusing and difficult to follow. I suggest to order
patches such that spi-nor layer changes are at the first, then m25p80
related things, followed by spi-mem (if needed spi) changes and finally
spi-mem controller driver changes.

-- 
Regards
Vignesh
