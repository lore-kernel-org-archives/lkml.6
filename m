Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A2BC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 18:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2ED6208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 18:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qpOyhQlt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2ED6208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729177AbeJFBrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 21:47:11 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43437 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728503AbeJFBrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 21:47:11 -0400
Received: by mail-pl1-f196.google.com with SMTP id 30-v6so7235243plb.10;
        Fri, 05 Oct 2018 11:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AnRoUjt68/ckGVKp30/IGmT3MZBmG8XVUyuzu0z7EEY=;
        b=qpOyhQltSpFp53+kvv+oMQJ5HeaRG25ylTFOLV8Pt6uIivyU2RxEf04vSFp6n+i0Ec
         lKinYDHALwjusOE4ZtIaGj3NYFVjURrraluvyzH+1CMokXpc7FqhHyPBzl9DgFNYIdGY
         Ru+W/HQ6pfSab2BgFNfWIS7b/MW886FPLO19MJnmZwWIEXjFPOZng45n/6+hO8I+9J6o
         JfQvHPI+mSh2LgdW5tsaAWpYBALOesixm+i349kES3mnrJobXAsvgYOQaZitTCa3O+Ia
         EbilcS34BQkRKlmsnZbPYhEWJWXbhB5IyHhvWwIh3ZJI2f9zhVGyMl+xu2Wj6IULoq3M
         lsWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AnRoUjt68/ckGVKp30/IGmT3MZBmG8XVUyuzu0z7EEY=;
        b=bIrF5OpvSRteym0LoucOoiAscbrwINxSEZm9ZN3TivGqJ4MpY1KfBtt/qvGQDsYFq6
         +MnGCEEXjOCDTeLKQFYmC9+aaHgnAOzgG13ufxUgbjSYLcR/+Ik9OoCGGxZwvi+0SiKE
         r9SO1VjQ7D2oUDnxGJ9Z5ab6wk7xQfqjslCSX3j4lAfjUM5svFaK7W84X6f9Fl6KlXV/
         ERYlY3cRNFqqXgv2p0OnrDt8JVs9ty9RsRC43UJcbzWL8yE0WE0cYYzsvxX4MRjAnFpH
         89w1cUosMLDZt0e7y7DgzGQlMU8AbcqA8HSqOujGvCBSRzAQwzjmDbGVS8s2plk4SkWI
         K+Qw==
X-Gm-Message-State: ABuFfohA5m+fnJYIivPSM/5P3k8oWWB0HJHiYMciAvta6GayomY4pV7V
        qxW37YEFMUlgm2nbnS0y4Tg=
X-Google-Smtp-Source: ACcGV63MLkhVhMmADZ8zEOW++GvKGlkllmpnTbnGHMS6JnGPJZX58s/92rr35+WmKfRK1C8NyejcDA==
X-Received: by 2002:a17:902:6b03:: with SMTP id o3-v6mr12926372plk.333.1538765231797;
        Fri, 05 Oct 2018 11:47:11 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id x73-v6sm13644086pfk.139.2018.10.05.11.47.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Oct 2018 11:47:10 -0700 (PDT)
Date:   Fri, 5 Oct 2018 11:47:08 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Martin Kepplinger <martink@posteo.de>
Cc:     geert+renesas@glider.be, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] input: st1232: set INPUT_PROP_DIRECT property
Message-ID: <20181005184708.GA215120@dtor-ws>
References: <20181005081407.15376-1-martink@posteo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181005081407.15376-1-martink@posteo.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2018 at 10:14:07AM +0200, Martin Kepplinger wrote:
> This is how userspace checks for touchscreen devices most reliably.
> 
> Signed-off-by: Martin Kepplinger <martink@posteo.de>

Applied, thank you.

> ---
>  drivers/input/touchscreen/st1232.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/touchscreen/st1232.c b/drivers/input/touchscreen/st1232.c
> index d5dfa4053bbf..b71673911aac 100644
> --- a/drivers/input/touchscreen/st1232.c
> +++ b/drivers/input/touchscreen/st1232.c
> @@ -195,6 +195,7 @@ static int st1232_ts_probe(struct i2c_client *client,
>  	input_dev->id.bustype = BUS_I2C;
>  	input_dev->dev.parent = &client->dev;
>  
> +	__set_bit(INPUT_PROP_DIRECT, input_dev->propbit);
>  	__set_bit(EV_SYN, input_dev->evbit);
>  	__set_bit(EV_KEY, input_dev->evbit);
>  	__set_bit(EV_ABS, input_dev->evbit);
> -- 
> 2.19.0
> 

-- 
Dmitry
