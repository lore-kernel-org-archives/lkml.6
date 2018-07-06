Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE79C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 20:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2580922BD3
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 20:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="LFIR/Nbl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2580922BD3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934607AbeGFU6F (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 16:58:05 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:45921 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933982AbeGFU6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 16:58:02 -0400
Received: by mail-pf0-f194.google.com with SMTP id y24-v6so9307517pfe.12
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 13:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JIxSwPyC6m/4lkeSnRlFgCnZhqx8aAzSeV+qWqq8uhk=;
        b=LFIR/NblaaDictGPZnhV5BNZ5XFK1s4VxbeNtdh3xzFzMV9vmcqx6QzhhmP03BCnMl
         wlosm/LFkpckYHru9dvd+lShZj4RxPS7JKrLYXf7cGyIg7sBif2jd5OH7gXX/SNHDtZ/
         h+C6IrAaP29M83eF+o6CCr07N3gU9brlT/1UnB3a5vaKB0lujelCX4yPumoXZFzPqciu
         4dofafmBKmx+wRVaFSiQ4/rhSxJV1nbrhTu46bQ7Dz3bwlp5UCKbM3qF77deTppkUvBk
         dWxHIGvdbGd1XzzZppCLNoK03iAGibqKkzE2rq13wwL2rfmlLNhS5IGdazpoYYy3i5WW
         nc3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JIxSwPyC6m/4lkeSnRlFgCnZhqx8aAzSeV+qWqq8uhk=;
        b=KW9345af/MbweKiYTFwvAkxq5048PA0OXfC/HYe64Z6YsdmfmVx7r4xduiRM4/yUCy
         8LtPKvQBdpM/VzBC+ie7PiWkxOs4K8m3UWmLtpKlvjWtTvOJuyFOJfOsfvpNHSXcsimZ
         JbiAkrBX1aEwp60TI54TRGoKGR8eIIk8XkyNXE9OkSGim1Ao8Eu2kXZSYSy8Ip9Dd0zd
         lx0JOP+ZJfXm6Azr+gV+5UADZpWhIKo7gLKYzax141btNRYhdNV4eknwU3zwSA0aGhXP
         xyOkdRtU7qlpnhut4o/EQMcD6iaPAYRJ9S5ZGUmtmkpRPUCY/C16ZVFrbVlNKYYdxP8v
         Dffw==
X-Gm-Message-State: APt69E0VbS7Bctet64TgDwAzTtOA5StyL6d82V+I3UftY8Sv/6OSMwy6
        LJISeNNNDvb0HgNBNuBkd2fSTw==
X-Google-Smtp-Source: AAOMgpfxsWfksACYZ+r77l+1k9/+KM3VMQIW8tpkkfSfE3on6FdDFlm6d2ngg1TDiqNZXnLC3H/LKQ==
X-Received: by 2002:a63:455c:: with SMTP id u28-v6mr10693614pgk.210.1530910682218;
        Fri, 06 Jul 2018 13:58:02 -0700 (PDT)
Received: from vader ([2620:10d:c090:200::4:984e])
        by smtp.gmail.com with ESMTPSA id o3-v6sm13472101pgp.3.2018.07.06.13.58.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 13:58:01 -0700 (PDT)
Date:   Fri, 6 Jul 2018 13:58:00 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-scsi@vger.kernel.org,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        Omar Sandoval <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] sbitmap, scsi/target: add seq_file forward
 declaration
Message-ID: <20180706205800.GD25954@vader>
References: <20180706201920.2185565-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706201920.2185565-1-arnd@arndb.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 10:19:07PM +0200, Arnd Bergmann wrote:
> The target core runs into a warning in the linux/sbitmap.h
> file in some configurations:
> 
> In file included from include/target/target_core_base.h:7,
>                  from drivers/target/target_core_fabric_lib.c:41:
> include/linux/sbitmap.h:331:46: error: 'struct seq_file' declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
>  void sbitmap_show(struct sbitmap *sb, struct seq_file *m);
>                                               ^~~~~~~~
> 
> In general, headers should not depend on others being included first,
> so this fixes it with a forward declaration for that struct name, but
> we probably want to merge the patch through the scsi tree to help
> bisection.
> 
> Fixes: 10e9cbb6b531 ("scsi: target: Convert target drivers to use sbitmap")

Reviewed-by: Omar Sandoval <osandov@fb.com>

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: move declaration to the start of the header, as suggested by Bart
> ---
>  include/linux/sbitmap.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
> index e6539536dea9..804a50983ec5 100644
> --- a/include/linux/sbitmap.h
> +++ b/include/linux/sbitmap.h
> @@ -23,6 +23,8 @@
>  #include <linux/kernel.h>
>  #include <linux/slab.h>
>  
> +struct seq_file;
> +
>  /**
>   * struct sbitmap_word - Word in a &struct sbitmap.
>   */
> -- 
> 2.9.0
> 
