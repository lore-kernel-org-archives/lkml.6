Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E55C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 19:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A274F208E6
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 19:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V+geWU1k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A274F208E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966428AbeFOTtf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 15:49:35 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:37533 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965768AbeFOTtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 15:49:33 -0400
Received: by mail-lf0-f68.google.com with SMTP id g21-v6so16257679lfb.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 12:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qEAYulS/oJRaBex8bpbB4qJVp6FOuY4WmEcVWtThwz4=;
        b=V+geWU1khx25S4noeaQVvxGf4X1zZeTMEz6HNxe/q/oxTVswbpTroMIqNaiE5rhtGQ
         2itZ+gY2VeiFOwd8wyqlMWpDNnaLQaxkRbKEex4u23JKZ7wZ+W9W9CfoW5I0L9w6Uqt8
         c983U/0NnFmED2EAo5/jymiIPna2QcPNchZ2Mc32wO+Iqa5dSD5E8DWPqHbCFRkBrUDA
         1oL+ZUueJtUF0Fmrc+x32dcA3/6lS4Xp/g4EbZmAXe+zWmhwx+hY+zjhefnedb8p10my
         5XARQc0aaz7gHVtIfysRgqkzS9bIN8YPngIJyj06+IbWqRoD2uoqCBc1VtIVWAI4QtIy
         AjZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qEAYulS/oJRaBex8bpbB4qJVp6FOuY4WmEcVWtThwz4=;
        b=W08ZOUDya9u8QuUibVmmEGiEmRistIJGgj/9vUQx7bB8iSIumWcqIspdAnB0mrRxOX
         r0XL4/WF4svRPC4DzWOTDn/H5WCKv/8RJH76qQFoAm72mCipU1k24S1HmhrY5YLpoaeM
         F0Fqo6eh7WPSNaioRdewNg6IDCRj1/Vtmv6PJQ8QVMXrOyGr6B1qh62Zmznw+r1E1ldK
         iTTXXErBSfMDzigG/gvB9ifRlRzHTQwR5lSXg7oqaN4btb7oltGSxFPGjDbVOvNrJHL5
         lNrcHjvevIgdxI1O+bT5rrW+eg/q9NFNpnFd0Hh07ZjVi54k4i8ajFnT5fRQiHbCIm5Q
         jraw==
X-Gm-Message-State: APt69E0Fe3G3vK8tfZ5pHGBEgy7e6qX78Q2PXkXV7GnlXBqkrmuwCNR6
        dw4FTodetJYJp5/IpgiqRgI=
X-Google-Smtp-Source: ADUXVKLQcwLBhSo+X9wFT3hydqvLd8n3t/aCD8nf/lj6s5k7JViu3lF+GW19J7li7gkUmbhlZQRLvw==
X-Received: by 2002:a2e:9744:: with SMTP id f4-v6mr2101965ljj.5.1529092172335;
        Fri, 15 Jun 2018 12:49:32 -0700 (PDT)
Received: from mobilestation ([5.166.218.73])
        by smtp.gmail.com with ESMTPSA id d6-v6sm1574457ljd.52.2018.06.15.12.49.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jun 2018 12:49:31 -0700 (PDT)
Date:   Fri, 15 Jun 2018 22:49:40 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH 5/8] NTB: perf: Don't require one more memory window than
 number of peers
Message-ID: <20180615194940.GA25252@mobilestation>
References: <20180609000819.13883-1-logang@deltatee.com>
 <20180609000819.13883-6-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180609000819.13883-6-logang@deltatee.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 08, 2018 at 06:08:15PM -0600, Logan Gunthorpe <logang@deltatee.com> wrote:
> ntb_perf should not require more than one memory window per peer. This
> was probably an off-by-one error.
> 

Good catch. Thanks. IDT got a lot of MWs especially if LookUpTables are
enabled. That's why I didn't find the effect of this error.

Regards,
-Sergey

> Fixes: 5648e56d03fa ("NTB: ntb_perf: Add full multi-port NTB API support")
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  drivers/ntb/test/ntb_perf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
> index 2a9d6b0d1f19..fe27412ffe91 100644
> --- a/drivers/ntb/test/ntb_perf.c
> +++ b/drivers/ntb/test/ntb_perf.c
> @@ -655,7 +655,7 @@ static int perf_init_service(struct perf_ctx *perf)
>  {
>  	u64 mask;
>  
> -	if (ntb_peer_mw_count(perf->ntb) < perf->pcnt + 1) {
> +	if (ntb_peer_mw_count(perf->ntb) < perf->pcnt) {
>  		dev_err(&perf->ntb->dev, "Not enough memory windows\n");
>  		return -EINVAL;
>  	}
> -- 
> 2.11.0
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/20180609000819.13883-6-logang%40deltatee.com.
> For more options, visit https://groups.google.com/d/optout.
