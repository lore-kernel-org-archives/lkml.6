Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D16FC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 06:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 559AF20659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 06:31:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tX2vyY+6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfANGbH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 01:31:07 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46249 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbfANGbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 01:31:07 -0500
Received: by mail-pl1-f195.google.com with SMTP id t13so9657424ply.13;
        Sun, 13 Jan 2019 22:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rMW/hVcmVP3nLgp3XkHOcsNW+SRBDiZFA9FHPPvCuuw=;
        b=tX2vyY+6TgLZn9zb8DvpWei3liARXQlvYw4Ue2CNa9rpZpcgmPOuIbcQ/f1DftbWCO
         AWnEX8W/LZPttvoy2BDf3cyNlNgjSallbeP61OYmKyS1VYMXTP48BilqQc4B0i+gYZzC
         6zVyVCWsxFQ/6wLHhgXE7lp2Yqilo+DE4Z8zrwWOd9TfMUxE6sNQvZsxKb3jKbegBBBp
         bxn8XS2+celmMtFZxXu0pB3SjlHbBgeKuk3M4dSynAKlR7Nbp9e2H/lPCk1mNkwKmLus
         lDpUF6bcRfde/IPW/K6tQtvOcFBzME6NQHrGG8ip4OyEQggfVZoCqr76T4d4ZufjDhgz
         zgBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rMW/hVcmVP3nLgp3XkHOcsNW+SRBDiZFA9FHPPvCuuw=;
        b=kqTzIaXNqRGA/fID9URCXxVQuFjPCvRf/Da0K5HZz8FXvl1Dm0vdruVI818GvAXygI
         XNruRhN80Dicxp5yQR3s3CKmBAjVOCDx/LlY0Cymj0PNlebpvSGtAoZHZPAZjCGuRTbe
         snNysCy1Gy9YUuYX7dG5mLD/SevTn4seZqodhof380GC57eArx4n/fTYt+TeckxWzorl
         /LpdLm7wt3Rg0pes8UZN3ZdzkRZFHjqsKe4baI8mCWFSn+tEeguO5iB/1xMBEMppBusb
         +PHG4Htn4knCokjvymBnJUx1vi7T9Laqe58FkyisnzjKwpEIMKzXMML6Jq3/YcYUHBqO
         tgqg==
X-Gm-Message-State: AJcUukdvGoMNISP1/4DJ1Oy+VyrPLdhDpsiEqIGWbjUvzvxz2NMWK2KW
        2ZV7QULa7PphoikXqcUf34eu0PrY
X-Google-Smtp-Source: ALg8bN5mWTUsNy+Os1kXVIaLd3kjdAuwTv4ogCwE+62gmxviOZVlZ3QNuQzKWnG3jgz40qvKXUSb4g==
X-Received: by 2002:a17:902:2a89:: with SMTP id j9mr19580020plb.296.1547447465572;
        Sun, 13 Jan 2019 22:31:05 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id l85sm151362730pfg.161.2019.01.13.22.31.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 13 Jan 2019 22:31:04 -0800 (PST)
Date:   Sun, 13 Jan 2019 22:31:02 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: mcs_touchkey - use struct_size() in kzalloc()
Message-ID: <20190114063102.GA217283@dtor-ws>
References: <20190108211556.GA5760@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190108211556.GA5760@embeddedor>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 03:15:56PM -0600, Gustavo A. R. Silva wrote:
> One of the more common cases of allocation size calculations is finding the
> size of a structure that has a zero-sized array at the end, along with memory
> for some number of elements for that array. For example:
> 
> struct foo {
>     int stuff;
>     void *entry[];
> };
> 
> instance = kzalloc(sizeof(struct foo) + sizeof(void *) * count, GFP_KERNEL);
> 
> Instead of leaving these open-coded and prone to type mistakes, we can now
> use the new struct_size() helper:
> 
> instance = kzalloc(struct_size(instance, entry, count), GFP_KERNEL);
> 
> This code was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied, thank you.

> ---
>  drivers/input/keyboard/mcs_touchkey.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/input/keyboard/mcs_touchkey.c b/drivers/input/keyboard/mcs_touchkey.c
> index be56d4f262a7..b132662201a4 100644
> --- a/drivers/input/keyboard/mcs_touchkey.c
> +++ b/drivers/input/keyboard/mcs_touchkey.c
> @@ -113,9 +113,8 @@ static int mcs_touchkey_probe(struct i2c_client *client,
>  		return -EINVAL;
>  	}
>  
> -	data = kzalloc(sizeof(struct mcs_touchkey_data) +
> -			sizeof(data->keycodes[0]) * (pdata->key_maxval + 1),
> -			GFP_KERNEL);
> +	data = kzalloc(struct_size(data, keycodes, pdata->key_maxval + 1),
> +		       GFP_KERNEL);
>  	input_dev = input_allocate_device();
>  	if (!data || !input_dev) {
>  		dev_err(&client->dev, "Failed to allocate memory\n");
> -- 
> 2.20.1
> 

-- 
Dmitry
