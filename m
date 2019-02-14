Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 975F9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5889E222D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="MmIgHR9z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405704AbfBNOTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:19:38 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:49702 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbfBNOTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 09:19:37 -0500
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 32F2D10C1477;
        Thu, 14 Feb 2019 06:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1550153977; bh=x7inVug3nWx9VUVjq+5f0/T6Kr35IEx3nZCt6HCe/do=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=MmIgHR9zpE9fNCOUPSjJru99/k5QgZr2ESRCNRyAyd+HmNDon27Yjpaxt+SCntfO1
         tS0I2b7AgrCZcihRyMQRJJD6bL/cA7elGyHRWYm154tMZUYGinyZGUmuoiicuRabnT
         fevQ1ZqJy0nNEKK12gE5+3xgNOZ+CLtrMBMP+VGI74/Pdo0aUU0VDGB5GbeZq60jwu
         HG0xfU2LxpRtCbbOluw/U1jc2fpHCqIAkiG9g18s47+HPX/jTTIVfxi03W+1InNCPD
         N99w/XlqQoIzI1jdeuXMObPZCc5og8C19SJBDL08Dd02oiwqbCvCcCWLn/A0svLH8G
         fZU1N/Xp2XevQ==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 714EDA0090;
        Thu, 14 Feb 2019 14:19:36 +0000 (UTC)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 14 Feb 2019 06:18:06 -0800
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 14 Feb 2019 15:18:04 +0100
Received: from [10.107.19.176] (10.107.19.176) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 14 Feb 2019 15:18:04 +0100
Subject: Re: [net-next, PATCH] net: stmmac: use correct define to get rx
 timestamp on GMAC4
To:     Alexandre Torgue <alexandre.torgue@st.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Jose Abreu <jose.abreu@synopsys.com>, <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1550153571-14404-1-git-send-email-alexandre.torgue@st.com>
From:   Jose Abreu <jose.abreu@synopsys.com>
Message-ID: <7c03dff4-5185-dbd2-eeb4-867972512f2b@synopsys.com>
Date:   Thu, 14 Feb 2019 14:18:02 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <1550153571-14404-1-git-send-email-alexandre.torgue@st.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.19.176]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

On 2/14/2019 2:12 PM, Alexandre Torgue wrote:
> In dwmac4_wrback_get_rx_timestamp_status we looking for a RX timestamp.
> For that receive descriptors are handled and so we should use defines
> related to receive descriptors. It'll no change the functional behavior
> as RDES3_RDES1_VALID=TDES3_RS1V=BIT(26) but it makes code easier to read.
> 
> Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
> index 20299f6..9f062b3 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
> @@ -268,7 +268,7 @@ static int dwmac4_wrback_get_rx_timestamp_status(void *desc, void *next_desc,
>  	int ret = -EINVAL;
>  
>  	/* Get the status from normal w/b descriptor */
> -	if (likely(p->des3 & TDES3_RS1V)) {
> +	if (likely(p->des3 & RDES3_RDES1_VALID)) {

Shouldn't this also use le32_to_cpu() like bellow ?

Thanks,
Jose Miguel Abreu

>  		if (likely(le32_to_cpu(p->des1) & RDES1_TIMESTAMP_AVAILABLE)) {
>  			int i = 0;
>  
> 
