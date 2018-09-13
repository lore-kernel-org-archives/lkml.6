Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76299FC6180
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DFE821529
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 16:05:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DFE821529
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbeIMVPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 17:15:12 -0400
Received: from ale.deltatee.com ([207.54.116.67]:44138 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727811AbeIMVPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 17:15:12 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1g0U74-0001AC-Cj; Thu, 13 Sep 2018 10:05:03 -0600
To:     Wesley.Sheng@microchip.com, kurt.schwemmer@microsemi.com,
        Kurt.Schwemmer@microchip.com
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <DM2PR11MB0105E2CA7030B336AC140B26951A0@DM2PR11MB0105.namprd11.prod.outlook.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <8ad178e5-5444-681a-1eae-5f9aa0c66bfa@deltatee.com>
Date:   Thu, 13 Sep 2018 10:05:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <DM2PR11MB0105E2CA7030B336AC140B26951A0@DM2PR11MB0105.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Kurt.Schwemmer@microchip.com, kurt.schwemmer@microsemi.com, Wesley.Sheng@microchip.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH] switchtec: add customer events and comments PAX specific
 GFMS event
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/09/18 01:34 AM, Wesley.Sheng@microchip.com wrote:
> From: Wesley Sheng <_Wesley.Sheng@microchip.com_
> <mailto:Wesley.Sheng@microchip.com>>

Similar to your previous patches, these are mangled by your email
client. It also would have also been better to send a small patch series
instead of these three individual patches.

  
> reserved for customers to implement up to 6 vendor-specific events, 24
> bytes per event
> comments on PAX specific GFMS event

Why do we need to merge this? You didn't present any code using these
new fields so this seems useless.

> Signed-off-by: Wesley Sheng <Wesley.Sheng@microchip.com>
> ---
> include/linux/switchtec.h | 19 ++++++++++++++++---
> 1 file changed, 16 insertions(+), 3 deletions(-)
>  
> diff --git a/include/linux/switchtec.h b/include/linux/switchtec.h
> index ec93e93..e3cb8b8 100644
> --- a/include/linux/switchtec.h
> +++ b/include/linux/switchtec.h
> @@ -59,6 +59,12 @@ enum mrpc_status {
>          SWITCHTEC_MRPC_STATUS_INTERRUPTED = 0x100,
> };
>  
> +struct event {
> +       u32 hdr;
> +       u32 data[5];
> +};

This doesn't follow the way the other events are doing things, and you
didn't convert all the other events, so it just looks inconsistent.


Logan
