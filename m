Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC78C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 13:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D83C214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 13:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHvWWnzq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfA1Nj6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 08:39:58 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43332 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbfA1Nj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 08:39:58 -0500
Received: by mail-qt1-f195.google.com with SMTP id i7so18167991qtj.10;
        Mon, 28 Jan 2019 05:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pQi/rMEAGsqSabKPxJR4ulCm4hlXCWFmpjZrdRMjwWI=;
        b=nHvWWnzqqRlgV/XL7hwME3rrIuvubLXepWpM7ARjysHaY/p7+a4PUzs3bHReHTAhY9
         x5JBQNEDCjuNQ2Li641YRXb74RFFH1lvESZ1J1rlUdsXJZ4XBKvCJ8raJkho/6r9Ugt1
         Fm9kF7fuGfH/x6JRVSzkHDIj1//cChx1QoYwLYffIQzDCCGNZK+fI6Noh9RlsjY2lNhg
         FotMWTCpUHffHql+IJHUSTPWwEzcMlM0vlC7UetG84ijXZ40WYa4pHdx+p6tayZ4veU7
         IzhaZGez0SEmGvnxWnHuSrUF+udiOc5BkLCn+kgtbvTQ6Q8WZ92kO1QW2/vqTKzf5QUE
         EkgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pQi/rMEAGsqSabKPxJR4ulCm4hlXCWFmpjZrdRMjwWI=;
        b=LHri0dLUb8xkKcXBEniP3vlP/2jNkbNamgi9vAP9hpmfLdYf1nMa42jr9Y0qfp/a/S
         ASLUnoOrKr7EkEhSnidJRUHsEVeX06p9AK9LtqdIx6Md2gFwV3ZwhxVjExgLYly7i753
         DX6Lsf+eOTbOof8OwOpxDGIgx55F92+mvwFLYi7xZDWHzkNYWWziHVlDdl/2E3Pr2I7o
         8KMUA0+hmQOK+SXUQbnQ5PkqaQr8UkO/90t2+LiRujDj9Cd2TLkXPmUrZkIYDjlM3bLG
         gQGmU7JtTpDloMlRfzkEZqptOm9S5WAPg/9fnkOesOIVup7fbw7hRrokqb16MCszDYT4
         ZkGg==
X-Gm-Message-State: AJcUukdfg7PQgsiKO9z28eqA15LBHzqBnG39pkZILrKHhjwQSd/Orbma
        h9LGlyjUS/Z0K9Wvg1UFEBU=
X-Google-Smtp-Source: ALg8bN7llbaInpjl6E0XFncGejw6n+WsSatuQpUAE82RxBkQj/FXH0u/50/1xxEJfWqOAMO8c0xJJQ==
X-Received: by 2002:aed:202e:: with SMTP id 43mr21776610qta.27.1548682796521;
        Mon, 28 Jan 2019 05:39:56 -0800 (PST)
Received: from renatolg ([186.220.17.21])
        by smtp.gmail.com with ESMTPSA id m49sm80951021qtb.40.2019.01.28.05.39.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 05:39:55 -0800 (PST)
From:   Renato Lui Geh <renatogeh@gmail.com>
X-Google-Original-From: Renato Lui Geh <renatogeh@renatolg>
Date:   Mon, 28 Jan 2019 11:39:50 -0200
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Renato Lui Geh <renatogeh@gmail.com>, lars@metafoo.de,
        Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        stefan.popa@analog.com, alexandru.Ardelean@analog.com,
        giuliano.belinassi@usp.br, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com
Subject: Re: [PATCH v2 2/2] staging: iio: ad7780: moving ad7780 out of staging
Message-ID: <20190128133949.z6eryxwes7yty3l2@renatolg>
References: <20190127203344.ofryhhrae2wjn6j2@renatolg>
 <20190128125426.GG1795@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20190128125426.GG1795@kadam>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/28, Dan Carpenter wrote:
>On Sun, Jan 27, 2019 at 06:33:52PM -0200, Renato Lui Geh wrote:
>> +	st->reg = devm_regulator_get(&spi->dev, "avdd");
>> +	if (IS_ERR(st->reg))
>> +		return PTR_ERR(st->reg);
>> +
>> +	ret = regulator_enable(st->reg);
>> +	if (ret) {
>> +		dev_err(&spi->dev, "Failed to enable specified AVdd supply\n");
>> +		goto error_disable_reg;
>> +	}
>
>We don't need to disable the regulator if enabling it failed (probably,
>I haven't looked at the code).

I wasn't sure if ret would need to be cleaned up on failure, so I kept
it as it was before. I'll change it to a simple return if needed though.
>
>
>> +
>> +	ret = ad_sd_setup_buffer_and_trigger(indio_dev);
>> +	if (ret)
>> +		goto error_disable_reg;
>> +
>> +	ret = iio_device_register(indio_dev);
>> +	if (ret)
>> +		goto error_cleanup_buffer_and_trigger;
>> +
>> +	return 0;
>> +
>> +error_cleanup_buffer_and_trigger:
>> +	ad_sd_cleanup_buffer_and_trigger(indio_dev);
>> +error_disable_reg:
>> +	regulator_disable(st->reg);
>> +
>
>Well chosen label names, btw.  Very easy to review.

That was already there before I came. But yes, very nice choice of
names. :)
>
>> +	return ret;
>> +}
>> +
>
>regards,
>dan carpenter
