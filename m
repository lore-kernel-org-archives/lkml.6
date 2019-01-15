Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D6F4C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 20:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0919B20657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 20:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547583268;
	bh=d5mBMNi3KtArjpHOvC8x4ighPsgQoS2f7WktsJEPv7E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=P73K4/Pzhjn6WQNXuK1Bnwjglwd2ypL7nMl658a3EF4ROkP+tlBctpC8FAr2mGutA
	 SYGgZFcnpwqARIAJtfIWVnyXsp+lzi9B3xm8mr+0SFsR28UVi9L8e32a3m4Oc72Wax
	 InZKRxSpbfGc0GK9/XXsRloQO9znlGoi1s502md0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389790AbfAOUOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 15:14:25 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35267 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728612AbfAOUOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 15:14:25 -0500
Received: by mail-oi1-f196.google.com with SMTP id v6so3195942oif.2;
        Tue, 15 Jan 2019 12:14:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CyUQBmP+iGazWEmfrNU1o6MRlHYu14uuv7V2WlMWplY=;
        b=Yi+E6NBroRJ2XNAYLrgxjKuEURjuv8UP/xltZs6k2x1pG+pZuGoc+9lLOb28G4lI7g
         KVbthWxAT7a6QZZhq3YvjkqBsXMxQ3xF+OlAlSv2xOBUMGFU83/bJfzJn0e9oiXlnZfl
         g+tEzX+nUtTZ/3JTqvqc/yqrciDsJpTGiEky/PcK7DuGZ8Q6lA24AW6W6VDjDfS8Xtry
         /5iZBIcXHYUSCkFNDiIRZNUU1aG+5pb5dv/JFSYQTKcl71Nwc/e9LXqFCRx2m1/8xabd
         YjnuvXvYqgwZxZkOP5MqZGzY7vsXxiRWDdoUol3Bw8/EeqJ7h9KwvdQDDxleKigFEcqX
         /GFw==
X-Gm-Message-State: AJcUuke+6eyFe+co2q/Ox4t07/6lAS3GQIYuniyuoPZN8tUOsWCsjb6Z
        IP0LU3q2lsg4+KOzoMN1Fg==
X-Google-Smtp-Source: ALg8bN7TObt1i8wtgsCsVNH2E7IfQ9L2xPHo9n4xVCDyfIXI02aLszYmWoMKoFwZbbwhIe4Sv5d1Ig==
X-Received: by 2002:aca:5508:: with SMTP id j8mr3015444oib.240.1547583264679;
        Tue, 15 Jan 2019 12:14:24 -0800 (PST)
Received: from localhost ([70.231.7.113])
        by smtp.gmail.com with ESMTPSA id b23sm1691970otq.5.2019.01.15.12.14.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 12:14:23 -0800 (PST)
Date:   Tue, 15 Jan 2019 14:14:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     Xiaoting Liu <xiaoting.liu@hxt-semitech.com>
Cc:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        mark.rutland@arm.com, openbmc@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        shunyong.yang@hxt-semitech.com, dongsheng.wang@hxt-semitech.com,
        Xiaoting Liu <xiaoting.liu@hxt-semitech.com>
Subject: Re: [PATCH v3 2/4] dt-bindings: hwmon: add dps650ab documentation
Message-ID: <20190115201423.GA4331@bogus>
References: <cover.1546918172.git.xiaoting.liu@hxt-semitech.com>
 <0527fcf7155ea12a2a1be680b3617691e6e26d72.1546918172.git.xiaoting.liu@hxt-semitech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0527fcf7155ea12a2a1be680b3617691e6e26d72.1546918172.git.xiaoting.liu@hxt-semitech.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jan 2019 10:24:33 +0800, Xiaoting Liu wrote:
> Bindings for Delta Electronics DPS-650-AB power supply.
> 
> Signed-off-by: Xiaoting Liu <xiaoting.liu@hxt-semitech.com>
> ---
> v3:
>   Change patch commit message.
>   Add vendor delta to the compatible property.
> ---
> v2:
>   Change the patch subject.
> ---
>  Documentation/devicetree/bindings/hwmon/dps650ab.txt | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
