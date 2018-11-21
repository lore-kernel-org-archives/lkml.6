Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E83C8C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 15:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B05562146F
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 15:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="pJSawz0c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B05562146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731322AbeKVB7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 20:59:44 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45597 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730948AbeKVB7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 20:59:44 -0500
Received: by mail-lj1-f196.google.com with SMTP id s5-v6so5171166ljd.12
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 07:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xxH6mOj9+GKpOXXoCWfuPHtQ4u//b37G8JYfn463+wQ=;
        b=pJSawz0c1QWsDe9USENleuaC1JrQnUo5JMG8KHlHWOT5zsDNrdyr942uwfSUWlwcR3
         +C22/ZwMKP2DB9PFg9P6v792q+Ge5A7Q4tmTCypz12RNmhtCdaTUFlDOuEaSVQUbGxOu
         fEnS8oyqF8tRFpvb1Vq3dj/9p5Reb/6tmaTEQyzFBzeTZxyIs8fnKEBFDa1G60yJvw0n
         USqqT7Ezy5rWkXflhIRhJtdjN5Qq5+wWE+RIgVMC8I9ePFJbTCqKrD3FycbPaelGPfCX
         egcNiM+xsvX75F2F+n9vX6lZaJdIxtrTwBt5vuesA/UIFv3LPoCbV4Lw/HMFuHfUe64K
         dAOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=xxH6mOj9+GKpOXXoCWfuPHtQ4u//b37G8JYfn463+wQ=;
        b=U6bEP8Rg9EbEdSizAD+Ybiq/kgAUI4ueUPkO1mvpdj41gJEg+2g5uAyNISTBfCXTCB
         DEuWNG7nQw8h7IAek+xza20ssxOBVMff7mQIaFU9LnoYD8baq4i05numZzEtC12OzEPn
         XNTYvE8pwNVrBaNc6YrpNgt/pHqgjgl218aDcY7lx61q/bnFgfYFiAzu3/TeLWKqmjAI
         ZcSlSalQIOiCwTob4WfP2U46WDbqD+Tj46So0kF5RnzaM7gYfnPVLYtauKD6LvugLExt
         b1xmeefF7OKu7bGYv0rMrGrCwCiq+n/77P7hL7nd+LhCYiZMZcPtUQ839aiXmeRVBetk
         Td9g==
X-Gm-Message-State: AA+aEWaNfFx+jJfb3JFMmc0j4DTqPXDrnC7biuldd+peDX+D1Z26YOhr
        TXTAfQe3uuXSyLSXbUA9hfrrRydhy9g=
X-Google-Smtp-Source: AJdET5ekpW1gQrjsg4ZemQNxvyG0+TQNwqxyhUhpk2YfR0nyeY03BF7NGaL09lBXGMlA+Qc/VDhCvQ==
X-Received: by 2002:a2e:7403:: with SMTP id p3-v6mr4319627ljc.97.1542813889702;
        Wed, 21 Nov 2018 07:24:49 -0800 (PST)
Received: from wasted.cogentembedded.com ([31.173.87.250])
        by smtp.gmail.com with ESMTPSA id t81sm6744448lfe.84.2018.11.21.07.24.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 07:24:45 -0800 (PST)
Subject: Re: [PATCH] ata: pata_macio: add of_node_put()
To:     Yangtao Li <tiny.windzz@gmail.com>, b.zolnierkie@samsung.com,
        axboe@kernel.dk
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181121130439.22255-1-tiny.windzz@gmail.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <e45f832b-ef98-e419-6082-27dd7ced71d2@cogentembedded.com>
Date:   Wed, 21 Nov 2018 18:24:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20181121130439.22255-1-tiny.windzz@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 11/21/2018 04:04 PM, Yangtao Li wrote:

> of_find_node_by_path() acquires a reference to the node
> returned by it and that reference needs to be dropped by its caller.
> bl_idle_init() doesn't do that, so fix it.

   I thought we're inside pata_macio_cable_detect()?

> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/ata/pata_macio.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/ata/pata_macio.c b/drivers/ata/pata_macio.c
> index 9588e685d994..8cc9c429ad95 100644
> --- a/drivers/ata/pata_macio.c
> +++ b/drivers/ata/pata_macio.c
> @@ -483,6 +483,8 @@ static int pata_macio_cable_detect(struct ata_port *ap)
>  		struct device_node *root = of_find_node_by_path("/");
>  		const char *model = of_get_property(root, "model", NULL);
>  
> +		of_node_put(root);
> +
>  		if (cable && !strncmp(cable, "80-", 3)) {
>  			/* Some drives fail to detect 80c cable in PowerBook
>  			 * These machine use proprietary short IDE cable

MBR, Sergei
