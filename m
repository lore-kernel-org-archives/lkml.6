Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D060C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C3AB2177B
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="JdX3cXqS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731679AbfAKKJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 05:09:55 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41027 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727653AbfAKKJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 05:09:54 -0500
Received: by mail-pl1-f194.google.com with SMTP id u6so6565787plm.8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 02:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/fePBMHbq1MNaDWeh3nGl51fvOHFrGFYS71p5Qq34y4=;
        b=JdX3cXqS8Zs0QnDfq9dECYZWRBvIQWd2UUsdJzOSq+AngI8AW1Vu7p6Ylpo5QY0PIY
         fCB81D5Ssu12KY+HgMa5yqudyCxxzJXoZjDHGDxCA++1FXINQKk8630cT471BnQxCLq7
         Jak/vjAnKtWLX26oLaG3V0OgNLtSVmedVHhAlo86bx0FerbUi2qLQ9KqgM+z1UHOZ0ax
         xGJKuWWbZ5kQtStTNxiU8viRX7pPLXTZ8GmN2n9GsCIQF1XpT7q7vS36yeiYl+m1ULTz
         hFi5U5hQeOziEpHTjt6bONuV3AdHtwi8znoOlMSCfxSJeVECsKliCtWCOh8WRkKmscRA
         fVGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/fePBMHbq1MNaDWeh3nGl51fvOHFrGFYS71p5Qq34y4=;
        b=RX6y2vFxJS7kFOVYf6WgwYLliv91zP5mxoIiy053TbZWYSDoNPU9REt44OXvvvcOlt
         6XWoDtRZO2OJQZc9udcwxLjLyrhTYT8HpV/k0INHyc3tUGHzX/i4Tz0wGTJBqfV6vFBG
         /ttvVQ8q0RuxcoL4vNqTgKSv/pa4MhRbi9oh5jIyvqlU+kxNbcC6nx6jHYF+//pphdIl
         TxSjaZnPnxYq6JzTBbOfKyJcHlcZzvZ41f12LgTvPAmL6fE1U55rUCxIDHhUD4AXAm/6
         74473uA2OeCXuYErLq8aJ/sv7IviASDu+2FgKrSGjYMexr/5J10j0g7JfQrAbISbX1XJ
         L1yw==
X-Gm-Message-State: AJcUukcvmzynVPRnWVGkB4GPbPeyaEeXv1J5YMHSiweuOQWzJD2OPpgq
        HcrA9C2V80BOwlBZYR381onegg==
X-Google-Smtp-Source: ALg8bN6w2998wTOg0I2UJfmoWt0oTGSSxzbk0m/ng/0JkMR9ybh8H9ZTz7JR7IJ9Qa6mOeETysBbkQ==
X-Received: by 2002:a17:902:3283:: with SMTP id z3mr14293576plb.76.1547201392779;
        Fri, 11 Jan 2019 02:09:52 -0800 (PST)
Received: from vader ([2601:602:8b00:55d3:e6a7:a0ff:fe0b:c9a8])
        by smtp.gmail.com with ESMTPSA id p7sm157429433pfj.72.2019.01.11.02.09.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 02:09:52 -0800 (PST)
Date:   Fri, 11 Jan 2019 02:09:50 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Tejun Heo <tj@kernel.org>, Josef Bacik <jbacik@fb.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Michael Callahan <michaelcallahan@fb.com>,
        Omar Sandoval <osandov@fb.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Keith Busch <keith.busch@intel.com>,
        Ming Lei <ming.lei@redhat.com>,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
Subject: Re: [PATCH] blk_types.h: Use REQ_OP_WRITE in op_is_write
Message-ID: <20190111100950.GA14142@vader>
References: <20181222100356.559995-1-marcos.souza.org@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181222100356.559995-1-marcos.souza.org@gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 22, 2018 at 08:03:54AM -0200, Marcos Paulo de Souza wrote:
> Instead of just using plain '1', as it improves readability.
> 
> Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
> ---
>  include/linux/blk_types.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index 1dcf652ba0aa..905c666a0101 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -377,7 +377,7 @@ static inline void bio_set_op_attrs(struct bio *bio, unsigned op,
>  
>  static inline bool op_is_write(unsigned int op)
>  {
> -	return (op & 1);
> +	return (op & REQ_OP_WRITE);
>  }
>  
>  /*

Nak. Conceptually, an operation is a write if the least significant bit
is set. The 1 here doesn't mean REQ_OP_WRITE, it means the least
significant bit.
