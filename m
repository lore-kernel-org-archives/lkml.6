Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E45F3C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 17:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B309F218EA
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 17:44:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ruMcwx3i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbeLZRop (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 12:44:45 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41745 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727165AbeLZRop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 12:44:45 -0500
Received: by mail-wr1-f66.google.com with SMTP id x10so16201642wrs.8;
        Wed, 26 Dec 2018 09:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=e5StMPPFMeRNbftw1fp0WEMyIqn7SJHK8uWKlxriUww=;
        b=ruMcwx3iw6zhSxXv/yhjhNphDrPYQ2LW76Rg+QTkVCh8cmzqK+FgEvJgOzmBXLKgaB
         ni2NbDTiWF6Up11x9hZpw/XK+a8z7nIjgTJJtUbGifjMwHbMlWYkwWSWpRjrv7oXepe4
         cu4RF4ROVFqlA9qfDyCOyWIMcFW+WTPLzMIkNQelRrtgRD3DuZCcmRerAPgJyqspG9Bj
         t91gz6QfYdE9ytAH8wNKKA7Uewg4FXalq0qJyJKfFLc5nSw3GYAyCFoapFQxbUCRMcVE
         RdntgzaW4vn/7NdfrfmKY3L7xyAf/54IAIbASH4GgxPQN8j6Z5b0M13RLYbuUTgqDvQS
         qSNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e5StMPPFMeRNbftw1fp0WEMyIqn7SJHK8uWKlxriUww=;
        b=SJ6C620e+4evVnKYRjlMrpgFtuqR9yUetw0W9ug3jQkOqou+WLobXIcFv8qrAHpDb+
         ozMOcjuAwUoiqpd5/emlJVtU0DchoM+vg0W2mwPbwVSP3+gUfLtDXCR17V5AjsryZAwN
         iNOsgGG1t4TuVv1XDV5zA8/EOJCDm2SUmtWcKifnn7nJOcqU7jXuOUrnCm9+4szKD5Z6
         veDj8D09lgr8BWiYUL6nD/qjAykJBf9zu798OAb9vix+ZEIkj5Typh87zoa7T6hRhhYm
         O8gNOKi21OpS3z/s5Bucvl689U5lzfTQVxrOnne7yT3y67pc48nXpvbtviHYJ8O0mVHn
         R2kw==
X-Gm-Message-State: AJcUukfWbkj2cdK7TGO3eVUyz7DBjAXLqKGg0sIO4ciPmPW80ya01YtX
        GcAR65CNEUA3bdVmY+TX2O+gTIjA
X-Google-Smtp-Source: ALg8bN7Ga4DsuTjqVwkemUhQ3883Y3CLsdvskq4+J04DI/hSvgRja6SOmPG0IMp81p06g34yQPYJuQ==
X-Received: by 2002:a5d:678b:: with SMTP id v11mr20790314wru.245.1545846282766;
        Wed, 26 Dec 2018 09:44:42 -0800 (PST)
Received: from ?IPv6:2003:ea:8bcf:e300:6194:598:7f5e:b2e? (p200300EA8BCFE300619405987F5E0B2E.dip0.t-ipconnect.de. [2003:ea:8bcf:e300:6194:598:7f5e:b2e])
        by smtp.googlemail.com with ESMTPSA id d4sm31348843wrp.89.2018.12.26.09.44.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Dec 2018 09:44:42 -0800 (PST)
Subject: Re: [PATCH] net:phy: Add a return value check on bus write
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Michal Simek <michal.simek@xilinx.com>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20181226173717.7113-1-pakki001@umn.edu>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <77ffa226-5d4c-3fec-6cdc-a2192eefd5dd@gmail.com>
Date:   Wed, 26 Dec 2018 18:44:37 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20181226173717.7113-1-pakki001@umn.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.12.2018 18:37, Aditya Pakki wrote:
> xgmiitorgmii_read_status() could fail when writing to the bus via
> mdiobus_write(). The fix adds a check and returns an error in case
> of failure.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---
>  drivers/net/phy/xilinx_gmii2rgmii.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/phy/xilinx_gmii2rgmii.c b/drivers/net/phy/xilinx_gmii2rgmii.c
> index 74a8782313cf..926879d43373 100644
> --- a/drivers/net/phy/xilinx_gmii2rgmii.c
> +++ b/drivers/net/phy/xilinx_gmii2rgmii.c
> @@ -58,7 +58,9 @@ static int xgmiitorgmii_read_status(struct phy_device *phydev)
>  	else
>  		val |= BMCR_SPEED10;
>  
> -	mdiobus_write(bus, addr, XILINX_GMII2RGMII_REG, val);
> +	err = mdiobus_write(bus, addr, XILINX_GMII2RGMII_REG, val);
> +	if (err)
> +		return err;
>  
>  	return 0;
Why not simply:
return mdiobus_write(bus, addr, XILINX_GMII2RGMII_REG, val);

Heiner
