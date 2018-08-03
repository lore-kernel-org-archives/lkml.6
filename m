Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7521EC43142
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 02:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FCD521724
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 02:52:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iVbyf//q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FCD521724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbeHCEqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 00:46:39 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35996 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725736AbeHCEqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 00:46:39 -0400
Received: by mail-pf1-f195.google.com with SMTP id b11-v6so2427329pfo.3;
        Thu, 02 Aug 2018 19:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+rx5nRSqIHZl4QDpTMaJBkINy5D1R74Z8iUnocz+tuA=;
        b=iVbyf//q9sI5DmxRy9BH4n0w3dRhhrEWfOIXI0s0v1XG28yTd+vcS69cmo61D01DP1
         cHvwSQdHnzgUYO7PKfQtDd3J7cmwbqMbd+/ApTJFokuDkcsgdSBLgaGDXShS7aHHNjLH
         6ncNMCXF/T5GGajAJLaBqfXnQeSLGS+sBhqff23Kq+9PPcbvF62/dPMOdNnhUCM3nyjs
         dpn/bNtCcpSKbayzmgNmvVRugO/BcC2vhrP3OgQNGwI2nhufyLOHJdrsif458PcHghVe
         KDDSOzLpSkMWftEVWG0kxiPt9oVdgxV5SmFTNXd28B8vuMwLP5T6AaITAmLvQ7DnGZSD
         uGQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+rx5nRSqIHZl4QDpTMaJBkINy5D1R74Z8iUnocz+tuA=;
        b=NF7VxTwTkwMFHx3hCju+p6akY3CfwOG9KeZtCevJGqDg24vl1B0PGr6OHjPCoZspLD
         xK+mIaCDNnxvds6RttaDCTQHeolDdrozbKOYb+S1V5BwZ0FnHannBhg3gJJlsp0ZUpLx
         65I5O6gdeP+VmjUFTnIeZqedly8P0jJ3j1bq9E1oi16ZsydS8gjEa9nKcY05OclKCWmG
         KGA3dGchFdoTiCG9XZ7ICOpNcmTI7FZ6jThtrL4G4Qzt0M9Mckz73I5dSRJFTF9RgV0T
         VJnMy5zFlabR2PVDMoZuby/XzMKa20MhSMgOzUORzTTwlA3BakCDDPENHrh5zUd/BC9Y
         Ygpw==
X-Gm-Message-State: AOUpUlGoFoV1O72rEjRAC2anv8bwtxMdFiOxlCCp2QH9Jlx8qMpp7nKq
        XscH9zMwPg3u4JoXTEbH6j4K4zr7
X-Google-Smtp-Source: AAOMgpc1bnDW1r4L/ePhdoINQhfU+6B2nk7rBL7fQFPeY7EAGj3wxN4TjWq/dBJsv2AEJe3wnsPVig==
X-Received: by 2002:a63:5025:: with SMTP id e37-v6mr1868289pgb.341.1533264754811;
        Thu, 02 Aug 2018 19:52:34 -0700 (PDT)
Received: from localhost ([175.223.10.158])
        by smtp.gmail.com with ESMTPSA id z184-v6sm4001056pgd.83.2018.08.02.19.52.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Aug 2018 19:52:33 -0700 (PDT)
Date:   Fri, 3 Aug 2018 11:52:30 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tino Lehnig <tino.lehnig@contabo.de>, stable@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 1/2] zram: remove BD_CAP_SYNCHRONOUS_IO with writeback
 feature
Message-ID: <20180803025230.GA502@jagdpanzerIV>
References: <20180802051112.86174-1-minchan@kernel.org>
 <20180802141304.d0589ddc5f8213429ab3b565@linux-foundation.org>
 <20180803023929.GA7500@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180803023929.GA7500@jagdpanzerIV>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (08/03/18 11:39), Sergey Senozhatsky wrote:
> [..]
>
> > A reader looking at this would wonder "why the heck are we doing that".
> > Adding a code comment would help them.
> 
> The interesting thing here is that include/linux/backing-dev.h
> BDI_CAP_SYNCHRONOUS_IO comment says
> 
> 	"Device is so fast that asynchronous IO would be inefficient."
> 
> Which is not the reason why BDI_CAP_SYNCHRONOUS_IO is used by ZRAM.
> Probably, the comment needs to be updated as well.
> 
> Both SWP_SYNCHRONOUS_IO and BDI_CAP_SYNCHRONOUS_IO tend to pivot
> "efficiency" [looking at the comments], but in ZRAM's case the whole
> reason to use SYNC IO is a race condition and user-after-free that
               ^ASYNC IO

	-ss
