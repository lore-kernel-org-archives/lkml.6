Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7680C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 19:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A18C6208E1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 19:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="leG7DScR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A18C6208E1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966333AbeFOTrm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 15:47:42 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:41226 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966149AbeFOTrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 15:47:41 -0400
Received: by mail-lf0-f66.google.com with SMTP id d24-v6so16232260lfa.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 12:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BMxlPA9uynTUmNtBWq8jEEjRdz3X01UilQjmvla4N1s=;
        b=leG7DScRnKzckV9j1zye2cI/Rl4B0eOZ9kE6DgrO/JtmzSnB7m0/jQa0GHLZ25/U6e
         mqW+RWIDQuXNMIKpGsIHhp8pEkVuDIIpWEeocpOk9hnIR+D7uukw5uyzhiB1S2fYF0xN
         ZBaLoJMpj1oBybyjPzZpUdiJXRLbR4zdhFVkDi20D22vtHa87A/E4C1CWCrXQM3yN4Bt
         Mjx0zg4fo9MOUvLIjlnJELS+WDta1U8oIJaRJ5077c9b8QWOqOhAIjHu51Wdp5xT4X7L
         6ux2folNPG4oOdPknIdupUfN8Q2k6CN22ZTl+sweccVbygMgYsQ1qOnV3XrMhJOIomDD
         +5Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BMxlPA9uynTUmNtBWq8jEEjRdz3X01UilQjmvla4N1s=;
        b=p7Od3m000KARh/JxeR3/G29dkB6uptzdzRnyyPp41KUAH8pMlbIjX/asYmEZbe8adi
         YqZyG6Jp9EmbkXhUrU2OTVUfzlcLBdKreWXUtaOBceu1NgsDr/KdfLZojKqZ9zoDnUPQ
         5o24I75HHqQybEgeaI+3SlcDmiLiUD73nB+SskGYkUVI4j+GaOg2+K9GrINkztWz7/Ez
         lQciWqw5SGCy9NcAXuc8Rbvu+EIhGNTV3XRaMwkHy2pjjAevo0Z8NHU0cj/6dqljAL6B
         koaSKGKudXwCxJpz6Ibipctf1CzZO3UDAaidgHotAobnoWyuIMwCJfpeHqW3wfEzZm/t
         OjzA==
X-Gm-Message-State: APt69E0ULxuLpp1eJ4F9r0Kg96LMaY0PrJ+depy3kJFW7sdUS/iy6bIf
        42ob5keGSXndkKS4OJXQxA8=
X-Google-Smtp-Source: ADUXVKIcdZRL7djpFCGtxg2taas/CwvHHIHu0XsGxCuQ384mf2EMSFzpnyvuA5dEAWa5RDIsykc7aQ==
X-Received: by 2002:a2e:60:: with SMTP id 93-v6mr2249597lja.96.1529092060182;
        Fri, 15 Jun 2018 12:47:40 -0700 (PDT)
Received: from mobilestation ([5.166.218.73])
        by smtp.gmail.com with ESMTPSA id d62-v6sm36687lfd.50.2018.06.15.12.47.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jun 2018 12:47:39 -0700 (PDT)
Date:   Fri, 15 Jun 2018 22:47:48 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH 1/8] NTB: ntb_tool: reading the link file should not end
 in a NULL byte
Message-ID: <20180615194748.GA15481@mobilestation>
References: <20180609000819.13883-1-logang@deltatee.com>
 <20180609000819.13883-2-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180609000819.13883-2-logang@deltatee.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 08, 2018 at 06:08:11PM -0600, Logan Gunthorpe <logang@deltatee.com> wrote:
> When running ntb_test this warning is issued:
> 
> ./ntb_test.sh: line 200: warning: command substitution: ignored null
> byte in input
> 

This is weird. Neither me nor the folks' who tested the script saw this warning.
I tried it on my laptop with bash and on a target device with busybox-shell. The
warning never occurred. I even tried a simple command like:
[[ $(echo -ne "\x4e\x0a\00") == "N" ]] && echo "True"

It might be that your bash is more modern than mine. Anyway if this patch solves the
problem you see, that's great. Thanks for it.

-Sergey

> This is caused by the kernel returning one more byte than is necessary
> when reading the link file.
> 
> Reduce the number of bytes read back to 2 as it was before the
> commit that regressed this.
> 
> Fixes: 7f46c8b3a552 ("NTB: ntb_tool: Add full multi-port NTB API support")
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  drivers/ntb/test/ntb_tool.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/ntb/test/ntb_tool.c b/drivers/ntb/test/ntb_tool.c
> index d592c0ffbd19..ec5cf095cdb9 100644
> --- a/drivers/ntb/test/ntb_tool.c
> +++ b/drivers/ntb/test/ntb_tool.c
> @@ -504,7 +504,7 @@ static ssize_t tool_peer_link_read(struct file *filep, char __user *ubuf,
>  	buf[1] = '\n';
>  	buf[2] = '\0';
>  
> -	return simple_read_from_buffer(ubuf, size, offp, buf, 3);
> +	return simple_read_from_buffer(ubuf, size, offp, buf, 2);
>  }
>  
>  static TOOL_FOPS_RDWR(tool_peer_link_fops,
> @@ -1690,4 +1690,3 @@ static void __exit tool_exit(void)
>  	debugfs_remove_recursive(tool_dbgfs_topdir);
>  }
>  module_exit(tool_exit);
> -
> -- 
> 2.11.0
> 
