Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83BE2C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 04:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4776120831
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 04:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gxJV2wfP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4776120831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbeLIEXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 23:23:43 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34659 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbeLIEXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 23:23:42 -0500
Received: by mail-pl1-f195.google.com with SMTP id w4so3656592plz.1;
        Sat, 08 Dec 2018 20:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=UIkx99NthhwThTPnA8nb4vbPBtbfwFbQXdYfq7t8Ews=;
        b=gxJV2wfPeMpfgbFEDYmdEw+YLgLM4YufD1tkpQFDPy9ic6iSVd3eBltw7Fv6Zy4CWo
         1pj7OFqYuZr6lE+mGqVN7zkBz0xbnP8Vg17k4wYg4EiWDECDhLdmb2RGjdOOiLQfONN2
         TaFGemvhCWcKfuOCIdh/IdqIuH26C6UIvxFDtRGSd6NEJFQoqciIXkX1sVFAfli32rKs
         /BYNZsWyhqIHeilh9lLs5Xct36uCTsloFDJFJrDosq94IayT0P8i0v8hMu2ygCyfWbH5
         VsGoSM7iCqZgS3MLGE89KPGYbjg3NWhiYzxLz2rEzpse2kViYfxWmRXTA7o4c1ze+hNu
         uFWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=UIkx99NthhwThTPnA8nb4vbPBtbfwFbQXdYfq7t8Ews=;
        b=aeeONtxjfuFir0g+jevnR/0WD7oOdwXWlWSNp471EMvgCPcnxBE1D5wfBAUaJhcdad
         J5uzKK3YHJBlpRPuDjGzAu7737LiQR3x2ELO4SMJzYky0iShYaKwVEgVjR7kcIXlPesq
         lY4i8u8umi85bMwBa7t2cgmZRW8YBGexV6iQyhpWwQcCRpHAzQbDxtCfr7GFyi0AH0DW
         TY0bb01BxpL5kk9bJlFzm157LDq6vPC1wLAb/ZT2uvQKnGg4uU8iQBv0OewYSlmuU6pU
         YheLylEBIfCfuBc2TQPf+XkbHscKln/k8kccIV2qCx5RXZfB2pbhbuyGy4WYEe1ns9gR
         8chQ==
X-Gm-Message-State: AA+aEWYm6CwmRUS2zJLgeWelASgxAgTnLP3sK49ADJ0eg0nfMJc6Y5uR
        osU2TzJbP5/IeUPaUT5hPgo=
X-Google-Smtp-Source: AFSGD/V5uzjec8AIClJX195+xU5LwAPGR7igJ/Mk7Cygu3uQ2Jznpmb+ExElT768B4nb2swcS8LE6Q==
X-Received: by 2002:a17:902:2dc3:: with SMTP id p61mr7478204plb.166.1544329421558;
        Sat, 08 Dec 2018 20:23:41 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id t21sm9270775pgg.24.2018.12.08.20.23.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 08 Dec 2018 20:23:40 -0800 (PST)
Date:   Sat, 8 Dec 2018 20:23:38 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, xc-racer2@live.ca,
        simon@lineageos.org
Subject: Re: [PATCH 3/8] Input: tm2-touchkey: Use predefined device name
Message-ID: <20181209042338.GC211094@dtor-ws>
References: <20181207105811.1831-1-pawel.mikolaj.chmiel@gmail.com>
 <20181207105811.1831-4-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181207105811.1831-4-pawel.mikolaj.chmiel@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2018 at 11:58:06AM +0100, Paweł Chmiel wrote:
> From: Jonathan Bakker <xc-racer2@live.ca>
> 
> Purely a cosmetic fix, using the names defined earlier

If we decide to keep different names please fold into first patch.

> 
> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
> Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
>  drivers/input/keyboard/tm2-touchkey.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/keyboard/tm2-touchkey.c b/drivers/input/keyboard/tm2-touchkey.c
> index 37a5ced24009..cc713b901bf2 100644
> --- a/drivers/input/keyboard/tm2-touchkey.c
> +++ b/drivers/input/keyboard/tm2-touchkey.c
> @@ -57,13 +57,13 @@ struct tm2_touchkey_data {
>  };
>  
>  static struct touchkey_variant tm2_touchkey_variant = {
> -	.name = "tm2-touchkey",
> +	.name = TM2_TOUCHKEY_DEV_NAME,
>  	.keycode_reg = 0x03,
>  	.base_reg = 0x00,
>  };
>  
>  static struct touchkey_variant midas_touchkey_variant = {
> -	.name = "midas-touchkey",
> +	.name = MIDAS_TOUCHKEY_DEV_NAME,
>  	.keycode_reg = 0x00,
>  	.base_reg = 0x00,
>  };
> -- 
> 2.17.1
> 

-- 
Dmitry
