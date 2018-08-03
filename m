Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7564FC43142
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 02:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AEBF21717
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 02:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2qAi5ZZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AEBF21717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbeHCEaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 00:30:15 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:45810 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbeHCEaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 00:30:15 -0400
Received: by mail-pl0-f67.google.com with SMTP id j8-v6so1868381pll.12;
        Thu, 02 Aug 2018 19:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AX6xF/Zd/rGkWz2OM2zPw+EDntBi/qcRCOYadaNZHqg=;
        b=L2qAi5ZZ0F35ObO1RCkYUfoUMc9f0jovInAqM76ou2W9W/CaGtoB+jOAvj8KWHMZRk
         XO6f//vh84yd3XKfUioRzwNEMBDMsf2IR+lGD7iOjWvfPR/u7WGu5Nhfk0STZNGcA7qO
         2PiK3Yg7aPUpa0QMZsc6jn3xPoQOSK0feFljApBNEGKEW58TYSUU/DxbFsIK8oKq8aUJ
         MhBxCSIof+UHU+jWPcR6jopALlTnpimvHB6BEIJXcnWxFivZ83ci+pyjgMUqyh6cjB2a
         gT2opiCIF30ydalT1R545TweyLnSDMSjnmAhRdBKZ92nsUn3M+aMDQxfhpPD9A+5si0l
         qYgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AX6xF/Zd/rGkWz2OM2zPw+EDntBi/qcRCOYadaNZHqg=;
        b=d7xabo5U/UuGf8BTvwkb4qvvrIDfZXwC/6omiQ5i3XfsR1REID6icrxvEh6vtRbysk
         bNd+yRJ+QYGAd2E1besIYoU/ahsZItKGk2AIXl+yKFhv6q+gWUQEMZ0gISyt3yCpAwQL
         aDK34bMo47rCxTmNK1xkJdPcOKHaDaivBRrWWwA+5dLMVkQsC8FKz0HpfX5/t06yVt1U
         GBXP2i9yPm8U0RfUldXTXSZZHlkfNycivNXoUWXuyEPaycTibcVAgQwg7WAxQ/Uc2tyK
         eYtYEha71b/l8fIQ4Q4lz/6pxoT6g1eENnfSjd2WpNDXwxYCTDSTcR3wra0eGHppkDjp
         Ggdg==
X-Gm-Message-State: AOUpUlFT4Uc3CXq1xuiLtdsZ7OFCgyWJpi+JaHlQixlRbIW6FshQ6cDL
        AG/dENXftoygT9yfGkz0B9w=
X-Google-Smtp-Source: AAOMgpelfspZN15wqcEoquRs+h/KROMof+DTcXgB7F6eaohyOMrneOW7IZ9QwPjVg3ebJs+QQh88rw==
X-Received: by 2002:a17:902:8c84:: with SMTP id t4-v6mr1815445plo.100.1533263773987;
        Thu, 02 Aug 2018 19:36:13 -0700 (PDT)
Received: from localhost ([175.223.10.158])
        by smtp.gmail.com with ESMTPSA id 1-v6sm5835739pfm.145.2018.08.02.19.36.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Aug 2018 19:36:12 -0700 (PDT)
Date:   Fri, 3 Aug 2018 11:39:29 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Minchan Kim <minchan@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Tino Lehnig <tino.lehnig@contabo.de>, stable@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 1/2] zram: remove BD_CAP_SYNCHRONOUS_IO with writeback
 feature
Message-ID: <20180803023929.GA7500@jagdpanzerIV>
References: <20180802051112.86174-1-minchan@kernel.org>
 <20180802141304.d0589ddc5f8213429ab3b565@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180802141304.d0589ddc5f8213429ab3b565@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (08/02/18 14:13), Andrew Morton wrote:
[..]
> That changelog is rather hard to follow.  Please review my edits:
> 
> : If zram supports writeback feature, it's no longer a BD_CAP_SYNCHRONOUS_IO
							^BDI_CAP_SYNCHRONOUS_IO

[..]

> A reader looking at this would wonder "why the heck are we doing that".
> Adding a code comment would help them.

The interesting thing here is that include/linux/backing-dev.h
BDI_CAP_SYNCHRONOUS_IO comment says

	"Device is so fast that asynchronous IO would be inefficient."

Which is not the reason why BDI_CAP_SYNCHRONOUS_IO is used by ZRAM.
Probably, the comment needs to be updated as well.

Both SWP_SYNCHRONOUS_IO and BDI_CAP_SYNCHRONOUS_IO tend to pivot
"efficiency" [looking at the comments], but in ZRAM's case the whole
reason to use SYNC IO is a race condition and user-after-free that
follows.

	-ss
