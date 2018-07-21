Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B25ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 09:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88E4A2084A
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 09:54:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88E4A2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zonque.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbeGUKqq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 06:46:46 -0400
Received: from mail.bugwerft.de ([46.23.86.59]:37782 "EHLO mail.bugwerft.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727412AbeGUKqq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 06:46:46 -0400
Received: from [192.168.178.170] (p57BC95AD.dip0.t-ipconnect.de [87.188.149.173])
        by mail.bugwerft.de (Postfix) with ESMTPSA id 66271291131;
        Sat, 21 Jul 2018 09:54:16 +0000 (UTC)
Subject: Re: [PATCH] nfc: st95hf: remove redundant pointers 'dev' and
 'nfcddev'
To:     Colin King <colin.king@canonical.com>,
        Samuel Ortiz <sameo@linux.intel.com>,
        linux-wireless@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180720182431.24353-1-colin.king@canonical.com>
From:   Daniel Mack <daniel@zonque.org>
Message-ID: <8599f87b-8d71-37bc-cfbf-278a3359cf0b@zonque.org>
Date:   Sat, 21 Jul 2018 11:54:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180720182431.24353-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, July 20, 2018 08:24 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Pointers 'dev' and 'nfcddev' are being assigned but are never used
> hence they are redundant and can be removed.
> 
> Cleans up clang warnings:
> warning: variable 'dev' set but not used [-Wunused-but-set-variable]
> warning: variable 'nfcddev' set but not used [-Wunused-but-set-variable]
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

This seems correct.

I am currently working on a bigger series of patches for this driver 
that also touches code in the same area. I plan to post the series next 
week. If this patch is applied until then, I can rebase my changes upon 
it before sending.


Thanks,
Daniel





> ---
>   drivers/nfc/st95hf/core.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/nfc/st95hf/core.c b/drivers/nfc/st95hf/core.c
> index a50a95cfcfd8..36ef0e905ba3 100644
> --- a/drivers/nfc/st95hf/core.c
> +++ b/drivers/nfc/st95hf/core.c
> @@ -781,9 +781,7 @@ static irqreturn_t st95hf_irq_thread_handler(int irq, void  *st95hfcontext)
>   	int result = 0;
>   	int res_len;
>   	static bool wtx;
> -	struct device *dev;
>   	struct device *spidevice;
> -	struct nfc_digital_dev *nfcddev;
>   	struct sk_buff *skb_resp;
>   	struct st95hf_context *stcontext  =
>   		(struct st95hf_context *)st95hfcontext;
> @@ -828,8 +826,6 @@ static irqreturn_t st95hf_irq_thread_handler(int irq, void  *st95hfcontext)
>   		goto end;
>   	}
>   
> -	dev = &stcontext->nfcdev->dev;
> -	nfcddev = stcontext->ddev;
>   	if (skb_resp->data[2] == WTX_REQ_FROM_TAG) {
>   		/* Request for new FWT from tag */
>   		result = st95hf_handle_wtx(stcontext, true, skb_resp->data[3]);
> 

