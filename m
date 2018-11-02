Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D351C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 19:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6FA52081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 19:43:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kS6TRGpZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6FA52081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbeKCEwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:52:09 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42030 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbeKCEwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 00:52:09 -0400
Received: by mail-ot1-f68.google.com with SMTP id j3so2680126otl.9;
        Fri, 02 Nov 2018 12:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:reply-to:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=/L+3tUMZhFG3cbc1zDuhang1NJfMhFauRYrXsGAEKgc=;
        b=kS6TRGpZ1gFON1Bedcvzey6X2Dq9QyvGBWq+S0rdSK3CZg+yLmA8b+KhCrJkZ8goMC
         uOx12FGkYUjh9CeeHoqSvPMfVAlFHYTgzWki4mw6O24K9msGECO/kP6pgJq29YpYAkfB
         ESql+3dbEgY6EmXDKV9kbmPwKR+Z+nciWkF5sM5Hg4ZXlXtRuqyLMleGuGNTtidpoMoo
         tU+GhXYnazaCHK07gZkIpNBw0IV3uKGyJRmiMDwgMErjKuEhC3BEGj5mVbCoQu6btxaA
         T+1735eYljooUPsaP6tQIKMIc+dxOp79oBNQiouH1rWx8U10Ba0NPHTUDnvSwqG4ANyU
         OJ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=/L+3tUMZhFG3cbc1zDuhang1NJfMhFauRYrXsGAEKgc=;
        b=J+AGl/WWzgE+VK3sV/jtUwBzIzPnWRh+5n5WnyRRa5itrxodXAGKwkR9x433gMR106
         mKsJzWGVcFqkYEYi3W2/qu2FmKf4N+jGASHytqqkXVrAuK2x+QaJFgse9eEIxpZTuJpH
         XfMEFINQCtKlnmTkA8LIi2/6ZusN6UJpJ2WCagVFeD06mAN2Ug6BGLM/zKS2eojtpe2c
         xONrtBNssXzgJvwa5GsJo2O00xaT0LMP8raNqnCKg2Ulwr9GtksxXx9eP2ZL4QrT3m9j
         KoI7QOa6V3sQnYVyK1WnmgCAqmyjEjAdYg1XqV0QNHr2G83XCE011KNJOQWt/o6AFMj/
         qaWw==
X-Gm-Message-State: AGRZ1gI60xNvkFExznJF2s10h5pjxVr9YiJNvpFmZJJnR85ZP+knOcDa
        eAU2iFDh9HrIAhSrGOF0Zg==
X-Google-Smtp-Source: AJdET5d0DH96MzupYvVY7TYvuc9A1bf8CVUvC97l2cOzi9v00R6EJjJzIngwqOzdiPyGfM5Dfc/GhA==
X-Received: by 2002:a9d:42c7:: with SMTP id c7mr7429513otj.119.1541187820135;
        Fri, 02 Nov 2018 12:43:40 -0700 (PDT)
Received: from serve.minyard.net ([47.184.170.128])
        by smtp.gmail.com with ESMTPSA id u5sm5418938otb.8.2018.11.02.12.43.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 12:43:38 -0700 (PDT)
Received: from [192.168.27.3] (t430m.minyard.net [192.168.27.3])
        by serve.minyard.net (Postfix) with ESMTPSA id E88618C2;
        Fri,  2 Nov 2018 14:43:37 -0500 (CDT)
Reply-To: minyard@acm.org
Subject: Re: [PATCH] ipmi: clean an indentation issue, remove extraneous space
To:     Colin King <colin.king@canonical.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        openipmi-developer@lists.sourceforge.net
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181030114652.17167-1-colin.king@canonical.com>
From:   Corey Minyard <minyard@acm.org>
Message-ID: <72af05e6-68b8-b8c0-b6ac-a5a6fe327e73@acm.org>
Date:   Fri, 2 Nov 2018 14:43:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181030114652.17167-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/18 6:46 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> Trivial fix to clean up an indentation issue, remove space


Queued for next release, thanks.

-corey


> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>   drivers/char/ipmi/ipmi_ssif.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
> index d06e00e95891..a7701af8fcf2 100644
> --- a/drivers/char/ipmi/ipmi_ssif.c
> +++ b/drivers/char/ipmi/ipmi_ssif.c
> @@ -1792,7 +1792,7 @@ static int ssif_probe(struct i2c_client *client, const struct i2c_device_id *id)
>   			       ssif_info,
>   			       &ssif_info->client->dev,
>   			       slave_addr);
> -	 if (rv) {
> +	if (rv) {
>   		pr_err("Unable to register device: error %d\n", rv);
>   		goto out_remove_attr;
>   	}


