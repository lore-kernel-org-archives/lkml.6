Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 842B4C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15A9220874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:42:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15A9220874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388422AbeGXRuC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 13:50:02 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:46107 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388334AbeGXRuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 13:50:02 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id 3976F217D1;
        Tue, 24 Jul 2018 16:42:43 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo02-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id vr8xgNcajEOh; Tue, 24 Jul 2018 16:42:43 +0000 (UTC)
Received: from [192.168.1.87] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id 38C5120F65;
        Tue, 24 Jul 2018 16:42:33 +0000 (UTC)
Subject: Re: [PATCH] usb: usbip: remove redundant pointer ep
To:     Colin King <colin.king@canonical.com>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>
References: <20180713104501.11482-1-colin.king@canonical.com>
From:   Shuah Khan <shuah@kernel.org>
Message-ID: <4c77677e-a9b2-7482-9121-e3d94c9b8802@kernel.org>
Date:   Tue, 24 Jul 2018 10:42:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180713104501.11482-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/13/2018 04:45 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Pointer ep is being assigned but is never used hence it is
> redundant and can be removed.
> 
> Cleans up clang warning:
> warning: variable 'ep' set but not used [-Wunused-but-set-variable]
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/usb/usbip/vudc_dev.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/usb/usbip/vudc_dev.c b/drivers/usb/usbip/vudc_dev.c
> index 1b9a4f87db59..1634d8698e15 100644
> --- a/drivers/usb/usbip/vudc_dev.c
> +++ b/drivers/usb/usbip/vudc_dev.c
> @@ -279,12 +279,10 @@ static int vep_disable(struct usb_ep *_ep)
>  static struct usb_request *vep_alloc_request(struct usb_ep *_ep,
>  		gfp_t mem_flags)
>  {
> -	struct vep *ep;
>  	struct vrequest *req;
>  
>  	if (!_ep)
>  		return NULL;
> -	ep = to_vep(_ep);
>  
>  	req = kzalloc(sizeof(*req), mem_flags);
>  	if (!req)
> 

Thanks for the patch. Looks good to me.

Acked-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>

thanks,
-- Shuah
