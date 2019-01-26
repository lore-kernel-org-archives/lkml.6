Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FAECC282C8
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 19:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51F5D2184C
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 19:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iEYfZLDK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbfAZTMI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 14:12:08 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39944 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfAZTMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 14:12:08 -0500
Received: by mail-ed1-f67.google.com with SMTP id g22so9955294edr.7;
        Sat, 26 Jan 2019 11:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hLXYUTqwdiMHSWgI/tBCPnstvbtEDN9527iIniSdS9c=;
        b=iEYfZLDKTSMwhX2s+DNopLtHenJkSmrzVAj8sX8tshHlnKb0yvKZtb5eM20OOwwG2b
         f2aZJKFSN7OK/2eNgrY0Mj8lBhnT51yHPpzxC3W2FYQnaOJ9J7YKk424hi5FdcLE0Gmt
         JcE71ZWvgqpk6+E8+rfG9KIQZ9p+t96SS7Z3KXRXMTcDJe6wSmfEvNbTYNqv94qxBlBO
         UAkTAf+AFEAsLW0clb4ZrSMc3uwNaGSOdrV92cG1jubYdUt2TohFzv4T8NqtFGxpJZ8l
         8YAXZ/7VnB+BAM9YyDW/pyVbSQF1s6UnyqPIp/gm93BCDvnaYGrPz5UUx1u/VPix11Yp
         QYVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hLXYUTqwdiMHSWgI/tBCPnstvbtEDN9527iIniSdS9c=;
        b=ARWFozz5nhCahS6t0d4+gBY8lGDSDVBxboXiGAaWICSDcvdwVHiuQIFrzEAOGt5awZ
         q+ywW2HDTiPmVdok7Vu9TK09XhAAZy8dGHEuh3y8qlkDuzssUk0epwNi6jJenNvd0j0I
         /pC0z3fO91uXiuLWOMPMqrHvWj4IfBO52zxU5PNeF9WbBvlDaH1tGPYCYCLoxhfE0hn6
         U1MnXaben+z0IRh2eAhVEa6/hZCeZ7CAmpH4q0rvvkePNhI+sD2s033bdvbaNeiZvT6j
         eI7cMzHthy9QToZ3olbe3TY/SlZN74X6tydi7+kc/lKTflwtEFXYJF2Y08czDTy9UbK0
         LbQg==
X-Gm-Message-State: AJcUuke5Qx02A9ko/CoyFpqPHvSzEaQIpDGgqvNCsOs360EtK8rwYq3v
        0+hQ1rJayVWAzbUkQuF6yY0=
X-Google-Smtp-Source: ALg8bN6YJvcW0qdXFk3JfPzvLJJ09NkgS/reMaQwm8c+dlzJ3qsR7Lpgd2ietzTYZ7GVoUuFBmn7Zw==
X-Received: by 2002:a17:906:25d7:: with SMTP id n23-v6mr13757143ejb.242.1548529925864;
        Sat, 26 Jan 2019 11:12:05 -0800 (PST)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id g31sm12294256eda.96.2019.01.26.11.12.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 26 Jan 2019 11:12:05 -0800 (PST)
Date:   Sat, 26 Jan 2019 12:12:03 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     YOKOTA Hiroshi <yokota@netlab.is.tsukuba.ac.jp>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pcmcia: Remove unnecessary parentheses
Message-ID: <20190126191203.GC25003@archlinux-ryzen>
References: <20181210235540.7039-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181210235540.7039-1-natechancellor@gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 04:55:40PM -0700, Nathan Chancellor wrote:
> Clang warns:
> 
> drivers/scsi/pcmcia/nsp_cs.c:1137:27: warning: equality comparison with
> extraneous parentheses [-Wparentheses-equality]
>                 if ((tmpSC->SCp.Message == MSG_COMMAND_COMPLETE)) {
>                      ~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~
> drivers/scsi/pcmcia/nsp_cs.c:1137:27: note: remove extraneous
> parentheses around the comparison to silence this warning
>                 if ((tmpSC->SCp.Message == MSG_COMMAND_COMPLETE)) {
>                     ~                   ^                      ~
> drivers/scsi/pcmcia/nsp_cs.c:1137:27: note: use '=' to turn this
> equality comparison into an assignment
>                 if ((tmpSC->SCp.Message == MSG_COMMAND_COMPLETE)) {
>                                         ^~
>                                         =
> 1 warning generated.
> 
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/scsi/pcmcia/nsp_cs.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/pcmcia/nsp_cs.c b/drivers/scsi/pcmcia/nsp_cs.c
> index f3230494a8c9..f28105b144fc 100644
> --- a/drivers/scsi/pcmcia/nsp_cs.c
> +++ b/drivers/scsi/pcmcia/nsp_cs.c
> @@ -1134,7 +1134,8 @@ static irqreturn_t nspintr(int irq, void *dev_id)
>  
>  		//*sync_neg       = SYNC_NOT_YET;
>  
> -		if ((tmpSC->SCp.Message == MSG_COMMAND_COMPLETE)) {     /* all command complete and return status */
> +		/* all command complete and return status */
> +		if (tmpSC->SCp.Message == MSG_COMMAND_COMPLETE) {
>  			tmpSC->result = (DID_OK		             << 16) |
>  					((tmpSC->SCp.Message & 0xff) <<  8) |
>  					((tmpSC->SCp.Status  & 0xff) <<  0);
> -- 
> 2.20.0
> 

Ping?
