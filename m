Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68EA5ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 08:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1553320874
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 08:14:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1553320874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387992AbeGWJOf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 05:14:35 -0400
Received: from mga18.intel.com ([134.134.136.126]:41789 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387808AbeGWJOe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 05:14:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jul 2018 01:14:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,392,1526367600"; 
   d="scan'208";a="59010652"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga008.jf.intel.com with ESMTP; 23 Jul 2018 01:12:40 -0700
Message-ID: <cd311a1b46eca9b9238a8071a211a7974154ac31.camel@linux.intel.com>
Subject: Re: [PATCH] nfc: fdp: remove redundant pointer 'client'
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Colin King <colin.king@canonical.com>,
        Samuel Ortiz <sameo@linux.intel.com>,
        Amit Pundir <amit.pundir@linaro.org>,
        linux-wireless@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 23 Jul 2018 11:12:39 +0300
In-Reply-To: <20180720181643.21340-1-colin.king@canonical.com>
References: <20180720181643.21340-1-colin.king@canonical.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-07-20 at 19:16 +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Pointer 'client' is being assigned but is never used hence it is
> redundant and can be removed.
> 
> Cleans up clang warning:
> warning: variable 'client' set but not used [-Wunused-but-set-
> variable]

Oh, thanks! It seems I had missed this when did a refactoring.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/nfc/fdp/i2c.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/nfc/fdp/i2c.c b/drivers/nfc/fdp/i2c.c
> index 70a970c7375c..5d3ea63e405f 100644
> --- a/drivers/nfc/fdp/i2c.c
> +++ b/drivers/nfc/fdp/i2c.c
> @@ -210,7 +210,6 @@ static int fdp_nci_i2c_read(struct fdp_i2c_phy
> *phy, struct sk_buff **skb)
>  static irqreturn_t fdp_nci_i2c_irq_thread_fn(int irq, void *phy_id)
>  {
>  	struct fdp_i2c_phy *phy = phy_id;
> -	struct i2c_client *client;
>  	struct sk_buff *skb;
>  	int r;
>  
> @@ -219,8 +218,6 @@ static irqreturn_t fdp_nci_i2c_irq_thread_fn(int
> irq, void *phy_id)
>  		return IRQ_NONE;
>  	}
>  
> -	client = phy->i2c_dev;
> -
>  	r = fdp_nci_i2c_read(phy, &skb);
>  
>  	if (r == -EREMOTEIO)

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
