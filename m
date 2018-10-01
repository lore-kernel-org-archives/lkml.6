Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE8AC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 23:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11BAF208AE
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 23:29:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uqpz3UJb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11BAF208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbeJBGKJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 02:10:09 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41902 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbeJBGKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 02:10:09 -0400
Received: by mail-pf1-f196.google.com with SMTP id m77-v6so64469pfi.8;
        Mon, 01 Oct 2018 16:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9MbPfe4vVAZbt5PG6u2u+bE52SBODk40SAK2IoKwPco=;
        b=uqpz3UJbFYo3LBAh0IXFo6RRrsVjfJJlhmLmiAE12V2Xi8ydgfoNnwkNud2bRvptjF
         t2t6uchbS+aTGn+nFmENGOQJv5pVirXFc2o7XLZnCH4nfDSeiWp/RjnDehd3d7xtHOzv
         y26dGq+fxvTNlMvdOCHM3I5z2As/FSkZ6UWPIGTKY2RPZE7exFT1sT5THsJ/Pyn3KE/J
         jItNh65TiYmj2Dr+7b5ZnyGvqBEW+zpt1Cmy/MjHD2qdmhHfiHQJTGV6J6D/BGalgP0x
         2sC1V5p860ml/67EdUR4CM6shQOCmqlSs8Ere2kpz5GdqDDrOkiR56OR2fj4ZPABzYXG
         87pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9MbPfe4vVAZbt5PG6u2u+bE52SBODk40SAK2IoKwPco=;
        b=KoKSLi6udF801SBvXGPHq7KTOjH75SBBAWeNHCnpF7jNPX1erK/wc/2WjfaN1lzF3n
         XAu0/t53VtD8S7MDxCJAxYCZi4bCQdW+RZeBhYe2sVzaj1LcYN3M1eAsvrZPNJL0NF1A
         c8r5SNSoa+h4F2vtOXXvXXQZOE+fiPh9UDwo3BS1nQ78E4ViJp4EcytpegthmXHmP2Ru
         zRp3uDT7DFaPZ1GSx+zF2hTB7C4saHjl9669CzNRmH3+29qNN/gyfEf8BCLkeCCVPl/+
         hAVYk4fB/PRWAAaL5G9Owbg/kkZuTxsUoWfwbbRIcP6EpgDZxVlHO70jW5q8IatFIpge
         QOCQ==
X-Gm-Message-State: ABuFfogwQOB9ZqUATwBt4apLsJCCYH0X2qyaUBUZzVVLm2o3gR3laaTR
        ZWStFSybM1pe0no2fMbUuu8=
X-Google-Smtp-Source: ACcGV61defRvfc8GKrQoRBk8i6Ue1uCk8swheT9UjwFb3siG5HTvnQEzMgHYvH+yO6PeLNIDs2324Q==
X-Received: by 2002:a63:5308:: with SMTP id h8-v6mr12030000pgb.358.1538436595975;
        Mon, 01 Oct 2018 16:29:55 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id y10-v6sm13304860pgi.85.2018.10.01.16.29.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Oct 2018 16:29:55 -0700 (PDT)
Date:   Mon, 1 Oct 2018 16:29:52 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Michal Simek <michal.simek@xilinx.com>,
        linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] input: xilinx_ps2: Convert to using %pOFn instead of
 device_node.name
Message-ID: <20181001232952.GB194397@dtor-ws>
References: <20181001214351.13230-1-robh@kernel.org>
 <20181001214351.13230-2-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181001214351.13230-2-robh@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 01, 2018 at 04:43:49PM -0500, Rob Herring wrote:
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
> 
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: linux-input@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied, thank you.

> ---
>  drivers/input/serio/xilinx_ps2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/serio/xilinx_ps2.c b/drivers/input/serio/xilinx_ps2.c
> index 07de1b49293c..6615c02a08fd 100644
> --- a/drivers/input/serio/xilinx_ps2.c
> +++ b/drivers/input/serio/xilinx_ps2.c
> @@ -245,7 +245,7 @@ static int xps2_of_probe(struct platform_device *ofdev)
>  	unsigned int irq;
>  	int error;
>  
> -	dev_info(dev, "Device Tree Probing \'%s\'\n", dev->of_node->name);
> +	dev_info(dev, "Device Tree Probing \'%pOFn\'\n", dev->of_node);
>  
>  	/* Get iospace for the device */
>  	error = of_address_to_resource(dev->of_node, 0, &r_mem);
> -- 
> 2.17.1
> 

-- 
Dmitry
