Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04CFFC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 19:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5AD422506
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 19:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knVeuZLl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5AD422506
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbeKMFWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 00:22:30 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42537 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbeKMFWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 00:22:30 -0500
Received: by mail-pf1-f195.google.com with SMTP id 64so305787pfr.9;
        Mon, 12 Nov 2018 11:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tm2cq821LOAxIyhOgy16Q3y7ydQsQVouoGjjpM6SrZ4=;
        b=knVeuZLlmqcW0mmzFPlf+ZlIdGyFLyIBo+9Trb5uV4HhSnuiY9pqm3tB/n6vL70B0R
         sga1rHe8acLddWJzuPauv1RDdQ4D5UP337/D9ikLY8lkFfQkgOAP6morkESgUP11NZvw
         9c9gz+WycEFqEjhDnKF1wPDSi3/vgFwFUI3zGCCTzy43B02bB+2/C3SNS3/tyKEgv6cK
         23x05zVXrzAPdWFAPVBCY2tWbtqJmsRGw9YK1gVK+1PfUIf2muxa4McB84wFSCHBeP7w
         wpIZvAmxTQFPTrDsB3oXdziBeKVmQ0W67uSgRLCd4eB0PAID2AGp+OAWKe/Fiz/9kqjW
         jYKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tm2cq821LOAxIyhOgy16Q3y7ydQsQVouoGjjpM6SrZ4=;
        b=WOmJyGTgKDzTUEaL1sUvaYRgtwJgW/2XnTuQIyHGbD2gDbqz7qMK9LBAb0E89CHPxx
         Kv2px1Cx15M8kcWxF+o21FdgMuLRhSRTf09br18KAesHviK6tyuID0/yorCedQwYuvuL
         gOqPbHD/ww23ufeQZgh3WsIWKroA3fCRJgX0mNU56angTImZR38ecemlJe6SFIZ8i3bW
         xrKlN4gI9ejmCtJc/e+ara5d2bqTyz4LcYrADnEewehss98O7I5nFqD3ZpxyvuTTlaBo
         J9Yr9qKWaK86uPRnWocac1tuwwzS8+cROMIOlBZlxWcjDseNvt0kGZ6CGPz2piMJOrTG
         TBTg==
X-Gm-Message-State: AGRZ1gKaG12X2YnjVknE5PTC7lEWHZZBPZSkXlsgw90JL27pfYSjbaGU
        lZIWpqNZ7NzOqHyIRBdp1HE=
X-Google-Smtp-Source: AJdET5e1uWKeBXWk2FLOYCfsQGFc1buFoBluF0klpxoIh2AOHNL57jLmrTEF6QDaki/Cvv85mw+hZw==
X-Received: by 2002:a65:484c:: with SMTP id i12mr1873821pgs.309.1542050873144;
        Mon, 12 Nov 2018 11:27:53 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id q6-v6sm3962730pfc.88.2018.11.12.11.27.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Nov 2018 11:27:52 -0800 (PST)
Date:   Mon, 12 Nov 2018 11:27:49 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Ding Tao <miyatsu@qq.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: input: Fix a typo in file input-reset.txt
Message-ID: <20181112192749.GD192687@dtor-ws>
References: <20181107055819.7527-1-miyatsu@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181107055819.7527-1-miyatsu@qq.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2018 at 05:58:19AM +0000, Ding Tao wrote:
> Replace sysrq-reset-seq with keyset.
> 
> Signed-off-by: Ding Tao <miyatsu@qq.com>

Applied, thank you.

> ---
>  Documentation/devicetree/bindings/input/input-reset.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/input/input-reset.txt b/Documentation/devicetree/bindings/input/input-reset.txt
> index 2bb2626fdb78..1ca6cc5ebf8e 100644
> --- a/Documentation/devicetree/bindings/input/input-reset.txt
> +++ b/Documentation/devicetree/bindings/input/input-reset.txt
> @@ -12,7 +12,7 @@ The /chosen node should contain a 'linux,sysrq-reset-seq' child node to define
>  a set of keys.
>  
>  Required property:
> -sysrq-reset-seq: array of Linux keycodes, one keycode per cell.
> +keyset: array of Linux keycodes, one keycode per cell.
>  
>  Optional property:
>  timeout-ms: duration keys must be pressed together in milliseconds before
> -- 
> 2.17.1
> 

-- 
Dmitry
