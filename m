Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DA6C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 16:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 545592146D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 16:00:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="htDJUmv6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 545592146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbeLADJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 22:09:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:41188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726769AbeLADJs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 22:09:48 -0500
Received: from [192.168.0.109] (cpe-174-109-247-98.nc.res.rr.com [174.109.247.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7383320867;
        Fri, 30 Nov 2018 15:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543593601;
        bh=4qlII825xNUpRHgMnW1yIPhJogC4Kpu0TeOslesnxCs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=htDJUmv6XXoILmYZ9zAKdJII0H9gkoYel97tzjryuPgJ3hnybvF7Bl8LqTHciJQlR
         1RrTe6UtQR23sLjuhxkkNXbwidL/zEC98fxNZ1o2pP2nzk91kvqwB4TvbS+60ZGWud
         03/45UKeE5HL8qkrhsahkCQC+XLSrlgGYiOz4iGg=
Subject: Re: [PATCH] dmaengine: remove DBGFS_FUNC_DECL()
To:     Yangtao Li <tiny.windzz@gmail.com>, dan.j.williams@intel.com,
        vkoul@kernel.org, sudeep.dutt@intel.com, ashutosh.dixit@intel.com,
        daniel@zonque.org, haojian.zhuang@gmail.com,
        robert.jarzmik@free.fr, andy.gross@linaro.org,
        david.brown@linaro.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
References: <20181130154249.3222-1-tiny.windzz@gmail.com>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <25087bc1-950d-b75a-1594-9f0d969dd59d@kernel.org>
Date:   Fri, 30 Nov 2018 10:59:34 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181130154249.3222-1-tiny.windzz@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/2018 10:42 AM, Yangtao Li wrote:
> We already have the DEFINE_SHOW_ATTRIBUTE,There is no need to define
> such a macro,so remove DBGFS_FUNC_DECL.Also use macro to simplify some
> code.
> 
> Signed-off-by: Yangtao Li<tiny.windzz@gmail.com>
> ---
>   drivers/dma/amba-pl08x.c     | 14 ++------------
>   drivers/dma/mic_x100_dma.c   | 22 +++-------------------
>   drivers/dma/pxa_dma.c        | 24 ++++++++++++------------
>   drivers/dma/qcom/hidma_dbg.c | 33 ++++++---------------------------

Acked-by: Sinan Kaya <okaya@kernel.org> for drivers/dma/qcom/hidma_dbg.c

>   4 files changed, 23 insertions(+), 70 deletions(-)

