Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D54D7C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 08:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89B872075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 08:49:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89B872075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbeIFNX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 09:23:59 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43921 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728141AbeIFNX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 09:23:58 -0400
Received: from 1.general.ikepanhc.us.vpn ([10.172.69.54])
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <ike.pan@canonical.com>)
        id 1fxpyj-0003EN-4r; Thu, 06 Sep 2018 08:49:29 +0000
Subject: Re: [PATCH] platform/x86: ideapad-laptop: Use __func__ instead of
 read_ec_cmd in pr_err
To:     Zhang Xianwei <zhang.xianwei8@zte.com.cn>, dvhart@infradead.org,
        andy@infradead.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhong.weidong@zte.com.cn, jiang.biao2@zte.com.cn
References: <1536044899-10452-1-git-send-email-zhang.xianwei8@zte.com.cn>
From:   Ike Panhc <ike.pan@canonical.com>
Message-ID: <9fce93c1-ad6f-8d02-0cf7-42680b78a924@canonical.com>
Date:   Thu, 6 Sep 2018 16:49:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1536044899-10452-1-git-send-email-zhang.xianwei8@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/04/2018 03:08 PM, Zhang Xianwei wrote:
> Refer to the commit f1395edbcec8 ("platform/x86: ideapad-laptop: Use
> __func__ instead of write_ec_cmd in pr_err"), prefer using '"%s...",
> __func__' to using 'read_ec_cmd' in read_ec_data.
> 
> Signed-off-by: Zhang Xianwei <zhang.xianwei8@zte.com.cn>
> ---
>  drivers/platform/x86/ideapad-laptop.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
> index d4f1259..f856d59 100644
> --- a/drivers/platform/x86/ideapad-laptop.c
> +++ b/drivers/platform/x86/ideapad-laptop.c
> @@ -212,7 +212,7 @@ static int read_ec_data(acpi_handle handle, int cmd, unsigned long *data)
>  			return 0;
>  		}
>  	}
> -	pr_err("timeout in read_ec_cmd\n");
> +	pr_err("timeout in %s\n", __func__);
>  	return -1;
>  }
>  
> 

Good catch. Thanks.

Acked-by: Ike Panhc <ike.pan@canonical.com>

