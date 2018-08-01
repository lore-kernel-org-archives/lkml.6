Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 265F9C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 23:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4F7D20840
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 23:04:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMpVpBOo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4F7D20840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732305AbeHBAwH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 20:52:07 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43017 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbeHBAwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 20:52:06 -0400
Received: by mail-pf1-f195.google.com with SMTP id j26-v6so136227pfi.10;
        Wed, 01 Aug 2018 16:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=n0Me1uZ7eeAenm78ZZdQXqzjZY+FGmuWJ8q1MdyTk/I=;
        b=lMpVpBOoN/fTtaVmb9rECBtKv9xssR0dZyEds+Bpsh9wHZAfdx5nkBUDEDCbc9rc6Q
         XdsdklE4cLaTFqv43TZp7tKRsxRpNh1G7MeomYMha7/i6SygXUZc5WExrdQTM4d4mUex
         6RpUi6Iww9j41n87MBCSmi1+97o/LZJgbmZm80bvi6N+eQ+DgVZc8p3vbMaoPUeG+uzQ
         fj6+fzZBVCYPgs0LNwy9a1O5tnHqc6Mb6LbZ6QxJIXU8TNtKQu+JPG/OGgXcgmkexxYv
         XnxpGpAVdWPOLh4WBJlrrGl5FXWzG7HZV/K+iFvIufGtrwR7MXKXKBimuGMxMrDcOsX3
         iHOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=n0Me1uZ7eeAenm78ZZdQXqzjZY+FGmuWJ8q1MdyTk/I=;
        b=hK68cPILfLMxscNxclGd+zrjGIKRTk8lMQo0hyZNhjpJDg64zg9RsUuL93FGOlqOvl
         G3/oYKI4dgxlnWqzqgGRrATiWsbjHbx6GHRoxlc+r/gYnmNeWI/9eo8qYJEBE/0dGo5j
         Po+m4Ad0yx9B/yp6uz3rDP9Q5dJ0tB94Lqe5AIVxyHNPtKyeu9uxfI5lIWQjNWP4kLLi
         CuEVZEnB5wHqo8Vq6kzZZVcPlti5/f3efDB4wBMbvBn/d8ny8Rm5DIZypyB8JfscyvHB
         36111F0TInR78i52A+VIOdduBeAbcm9q/oT4ZU7KAUY3+Vb5xtXXywSTc2oH6xEZTrO4
         RZVw==
X-Gm-Message-State: AOUpUlG4c2uQQu2EnHifTD3EunwFIUL/N3AUWfRHOegGL8qX7S4C38Ld
        fNPIg0nofB1vU7dArW3RpkZ2gxwz
X-Google-Smtp-Source: AAOMgpe705UIhqNpmUSGRPJseNtQoG5LZjp2RUFmNlne+SEHZbCmnzY6COfZNgfQvRCGNYCKtMTbAw==
X-Received: by 2002:a62:954:: with SMTP id e81-v6mr287384pfd.231.1533164637833;
        Wed, 01 Aug 2018 16:03:57 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id r19-v6sm150446pgo.68.2018.08.01.16.03.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Aug 2018 16:03:56 -0700 (PDT)
Date:   Wed, 1 Aug 2018 16:03:54 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Julia Lawall <Julia.Lawall@lip6.fr>
Cc:     joe@perches.com, Chengguang Xu <cgxu519@gmx.com>,
        kernel-janitors@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] Input: elan_i2c_smbus - cast sizeof to int for
 comparison
Message-ID: <20180801230354.GA184797@dtor-ws>
References: <1530466325-1678-1-git-send-email-Julia.Lawall@lip6.fr>
 <1530466325-1678-2-git-send-email-Julia.Lawall@lip6.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530466325-1678-2-git-send-email-Julia.Lawall@lip6.fr>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 01, 2018 at 07:32:03PM +0200, Julia Lawall wrote:
> Comparing an int to a size, which is unsigned, causes the int to become
> unsigned, giving the wrong result.  i2c_smbus_read_block_data can return the
> result of i2c_smbus_xfer, whih can return a negative error code.
> 
> A simplified version of the semantic match that finds this problem is as
> follows: (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @@
> int x;
> expression e,e1;
> identifier f;
> @@
> 
> *x = f(...);
> ... when != x = e1
>     when != if (x < 0 || ...) { ... return ...; }
> *x < sizeof(e)
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> 

Applied, thank you.

> ---
>  drivers/input/mouse/elan_i2c_smbus.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/mouse/elan_i2c_smbus.c b/drivers/input/mouse/elan_i2c_smbus.c
> index c060d27..88e315d 100644
> --- a/drivers/input/mouse/elan_i2c_smbus.c
> +++ b/drivers/input/mouse/elan_i2c_smbus.c
> @@ -387,7 +387,7 @@ static int elan_smbus_prepare_fw_update(struct i2c_client *client)
>  		len = i2c_smbus_read_block_data(client,
>  						ETP_SMBUS_IAP_PASSWORD_READ,
>  						val);
> -		if (len < sizeof(u16)) {
> +		if (len < (int)sizeof(u16)) {
>  			error = len < 0 ? len : -EIO;
>  			dev_err(dev, "failed to read iap password: %d\n",
>  				error);
> 

-- 
Dmitry
