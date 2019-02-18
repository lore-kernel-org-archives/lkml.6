Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E249DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B27B221736
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:14:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729550AbfBRKOM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 05:14:12 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38992 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbfBRKOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 05:14:11 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id F1E0B268AF6
Subject: Re: [PATCH -next] platform/chrome: Make function wilco_ec_transfer()
 static
To:     Wei Yongjun <weiyongjun1@huawei.com>,
        Benson Leung <bleung@chromium.org>,
        Duncan Laurie <dlaurie@google.com>,
        Nick Crews <ncrews@chromium.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20190216060910.139768-1-weiyongjun1@huawei.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <05971cf1-433a-3edf-7dc2-8561c41e539a@collabora.com>
Date:   Mon, 18 Feb 2019 11:14:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190216060910.139768-1-weiyongjun1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/2/19 7:09, Wei Yongjun wrote:
> Fixes the following sparse warning:
> 
> drivers/platform/chrome/wilco_ec/mailbox.c:126:5: warning:
>  symbol 'wilco_ec_transfer' was not declared. Should it be static?
> 
> Fixes: 436dad4fda10 ("platform/chrome: Add new driver for Wilco EC")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/platform/chrome/wilco_ec/mailbox.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 

Applied for 5.1

Thanks

> diff --git a/drivers/platform/chrome/wilco_ec/mailbox.c b/drivers/platform/chrome/wilco_ec/mailbox.c
> index c7028488e575..f6ff29a11f1a 100644
> --- a/drivers/platform/chrome/wilco_ec/mailbox.c
> +++ b/drivers/platform/chrome/wilco_ec/mailbox.c
> @@ -123,8 +123,9 @@ static void wilco_ec_prepare(struct wilco_ec_message *msg,
>   * Context: ec->mailbox_lock should be held while using this function.
>   * Return: number of bytes received or negative error code on failure.
>   */
> -int wilco_ec_transfer(struct wilco_ec_device *ec, struct wilco_ec_message *msg,
> -		      struct wilco_ec_request *rq)
> +static int wilco_ec_transfer(struct wilco_ec_device *ec,
> +			     struct wilco_ec_message *msg,
> +			     struct wilco_ec_request *rq)
>  {
>  	struct wilco_ec_response *rs;
>  	u8 checksum;
> 
> 
> 
