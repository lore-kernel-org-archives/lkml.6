Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE48C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 19:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7A6D208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 19:49:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M9gSYB97"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7A6D208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966402AbeFOTtX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 15:49:23 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:38428 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965768AbeFOTtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 15:49:22 -0400
Received: by mail-lf0-f67.google.com with SMTP id i83-v6so16241977lfh.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 12:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bWQeohNjEzDuNAOeTbK9OgZaaROzzz6Ml+LFMGy7VHo=;
        b=M9gSYB97Xn4ZlmTECraR7qYPBXpoF6dvuBZiIVOtO64qVvLJMH+9b7eoBw9p9aLqRD
         q9CUGDPFR8xMyDBf3U8cMBNdpVl1L7DnZTNHYaxoGPPFnunP4mKPC39Z+Lw+y6uhEE/5
         oGF0Fdy1je8u6FThVEUncKuAYtTh7XkwoJyapPaKb2kavIG5zt0glQmKQdT+C+dBV9gT
         QPXyOgaqgoTQRdOKwB9G/a/e93aNzNMaHyLLxRvCr5MRqO6LF3vttT5Ld/YcYBWbCOEZ
         lbOSDh2DVC/spuJLIHWCBVMW9l6CpPmk8CqasR7jS4+Q7/pJ/5q5shnj3hP+afsQpvwm
         9/+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bWQeohNjEzDuNAOeTbK9OgZaaROzzz6Ml+LFMGy7VHo=;
        b=c+JcbrU4tHdfVTjJLh1tsi1KbCvgxCHvYANFxlujgHWObiQY4QRGkZpA1QK57/oLET
         oAWwDF+9Mg181j6rE6IzWujx4ZeJXBxPrz00YHm1eQbiOZlk9+5U4aj1MgsqIISkmuwv
         RXWwa3Z6Dwh3F+Hzhk/4ZR0ahKxknk1l0ksXDmu8OX5i24/kOm4oi85QL9F8JZ+exInk
         czvffIvEw85CQPrGaidGkGLyjcyW/sNZ18uvsHuRlT67St000G5vUAHlWo5cS6L+Njb1
         d52TUOJE6+UDvkiKSu/VcR4pT5dXYx1GM27ilsOX0uqs0I7wgIq92SJVz6Y6NHbp6GS/
         jGzg==
X-Gm-Message-State: APt69E1Lgfdrmf/dSXHyZzTbpdabnRfMXpebgGIiYNIFxPWWxHiguqOQ
        MGRwoERNURImDAcUoNK/v7fvEg==
X-Google-Smtp-Source: ADUXVKLQtcnzX5yVtuyFXIjQshK+EsFPO0ux6zCYPZ4VH8uu+nHOMipyernsZovbHp3thfI/cdPMpg==
X-Received: by 2002:a19:c452:: with SMTP id u79-v6mr1902204lff.5.1529092160884;
        Fri, 15 Jun 2018 12:49:20 -0700 (PDT)
Received: from mobilestation ([5.166.218.73])
        by smtp.gmail.com with ESMTPSA id p28-v6sm1630867lfh.24.2018.06.15.12.49.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jun 2018 12:49:20 -0700 (PDT)
Date:   Fri, 15 Jun 2018 22:49:29 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH 4/8] NTB: ntb_pingpong: Choose doorbells based on port
 number
Message-ID: <20180615194929.GA24025@mobilestation>
References: <20180609000819.13883-1-logang@deltatee.com>
 <20180609000819.13883-5-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180609000819.13883-5-logang@deltatee.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 08, 2018 at 06:08:14PM -0600, Logan Gunthorpe <logang@deltatee.com> wrote:
> This commit fixes pingpong support for existing drivers that do not
> implement ntb_default_port_number() and ntb_default_peer_port_number().
> This is required for hardware (like the crosslink topology of
> switchtec) which cannot assign reasonable port numbers to each port due
> to its perfect symmetry.
> 
> Instead of picking the doorbell to use based on the the index of the
> peer, we use the peer's port number. This is a bit clearer and easier
> to understand.
> 

Thanks for the patch. It was the original version of the ping-pong driver,
I was going to submit. But I've decided to develop it a bit different. And
here is why.

My goal was to create the multi-port version of the ping-pong test.
The idea of the new driver was to implement the cyclic port-to-port
ping-pong algorithm. Simply speaking each port selects two partner-ports,
one partner would be used as the source of pings and another one would be
target of pongs sent to with the defined delay.

Since IDT got a global Doorbell register, which is shared between all
the ports, I had to assign an unique doorbell bit to each port. I created a
simple algorithm, which linearised in general non-linear port numbers.
Then I used the globally unique port index to select the corresponding
doorbell bit. pp_init_flds() methods implements the corresponding algorithm,
while pp_find_next_peer() performs the next port selection to convey the
pong to.

Regarding the patch. The idea of using the port number instead of linearised
unique index should also work for Intel/AMD/IDT drivers. But the ports-space
linearization algorithm was created for the case if the real port numbers
would exceed the available Doorbell bits. I thought this might be the case of
multi-ports version of the switchtec driver.

Needless to say, that if Switchtec driver had the ports-index API implementation,
this patch wouldn't be needed.

Regards,
-Sergey

> Fixes: c7aeb0afdcc2 ("NTB: ntb_pp: Add full multi-port NTB API support")
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  drivers/ntb/test/ntb_pingpong.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/ntb/test/ntb_pingpong.c b/drivers/ntb/test/ntb_pingpong.c
> index 65865e460ab8..18d00eec7b02 100644
> --- a/drivers/ntb/test/ntb_pingpong.c
> +++ b/drivers/ntb/test/ntb_pingpong.c
> @@ -121,15 +121,14 @@ static int pp_find_next_peer(struct pp_ctx *pp)
>  	link = ntb_link_is_up(pp->ntb, NULL, NULL);
>  
>  	/* Find next available peer */
> -	if (link & pp->nmask) {
> +	if (link & pp->nmask)
>  		pidx = __ffs64(link & pp->nmask);
> -		out_db = BIT_ULL(pidx + 1);
> -	} else if (link & pp->pmask) {
> +	else if (link & pp->pmask)
>  		pidx = __ffs64(link & pp->pmask);
> -		out_db = BIT_ULL(pidx);
> -	} else {
> +	else
>  		return -ENODEV;
> -	}
> +
> +	out_db = BIT_ULL(ntb_peer_port_number(pp->ntb, pidx));
>  
>  	spin_lock(&pp->lock);
>  	pp->out_pidx = pidx;
> @@ -303,7 +302,7 @@ static void pp_init_flds(struct pp_ctx *pp)
>  			break;
>  	}
>  
> -	pp->in_db = BIT_ULL(pidx);
> +	pp->in_db = BIT_ULL(lport);
>  	pp->pmask = GENMASK_ULL(pidx, 0) >> 1;
>  	pp->nmask = GENMASK_ULL(pcnt - 1, pidx);
>  
> @@ -435,4 +434,3 @@ static void __exit pp_exit(void)
>  	debugfs_remove_recursive(pp_dbgfs_topdir);
>  }
>  module_exit(pp_exit);
> -
> -- 
> 2.11.0
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/20180609000819.13883-5-logang%40deltatee.com.
> For more options, visit https://groups.google.com/d/optout.
