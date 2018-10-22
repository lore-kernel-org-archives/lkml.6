Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A77E4ECDE43
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 02:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FB1220838
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 02:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uab4DWuf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FB1220838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbeJVKyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 06:54:08 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39259 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbeJVKyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 06:54:08 -0400
Received: by mail-pg1-f193.google.com with SMTP id r9-v6so18299877pgv.6;
        Sun, 21 Oct 2018 19:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MwQK2MU94bA4feWCY+ngFTuKVnx2DkuV61peOqPB8HI=;
        b=Uab4DWuf+bdSGg0dKmZvLOX4p+BC7rf9ETDnPdYl/HWVsZ/0rEuHy2rm64MU8AgGoh
         Wyw8Rgr9fT9idD73a8JXNrmmxRiTpIfpYEGbFsbdk/h9wglpcAVKNNctpiSx3QKL6/AW
         JEkTwmhFeuwQa8IfDbs9ZBqK/P5PVlWVF856BULLu/qyMJPnpISeRx60Av8dFHJZ3Brs
         DJwRugBMr+rfkikMTl6J1zjIdB75WBoK5a0g2M3zXiB62PrXMyZlVRymb7BFXOybyBmG
         sxc7xjsjYIhkRhKxn3j/jRGfqX7gMdZ+C1YYVumBaSNgrFwdxp7gbPGPSGztwaZDU/11
         fk3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MwQK2MU94bA4feWCY+ngFTuKVnx2DkuV61peOqPB8HI=;
        b=X8myEVqpfns7Y2NSFfyzIBhZCAe2aotqPEwwfQIEiqyjsWD7R4oz8p/InZwesysGyT
         w8YLJwI44Vya4ML7a8gF5L1kUiqY2zMOPjjLZivBoy2SmOPPGJZcscKvibVImmNm37UD
         vvO5GXozQXq/RucWaoJw5WMJGP2SlyzoEkacNPGMbstVMtSTnrS6Nj68R6ii2nKQ5TDM
         aIgOdcRaa/gLciH3AmC3SSQakxKJ44ZkWDOvumBQnZwkTvxoSLipgWuGEWhDF9WPnwgc
         TVZ5SzuYQjdraAe4zzHYTbc8eHoWE1mVC0vHhkzF1cbjC0IYgbaVxKDT4itUGMLsgi5K
         wysA==
X-Gm-Message-State: ABuFfojTQk3jA7+nWoEZZq2MaSBzo4PdgONvPntNngTQk6YMQsSDdnxM
        JfyH/lLGv1JcY5rvZyewVvw=
X-Google-Smtp-Source: ACcGV61TCwHH0k8z8CxjJ1Xu0tCjLDRgkSQWNF3qna4e6lMJsJ2GOBdh2cAahVXBwW32bCCB95BFew==
X-Received: by 2002:a63:d556:: with SMTP id v22-v6mr39519561pgi.357.1540175856147;
        Sun, 21 Oct 2018 19:37:36 -0700 (PDT)
Received: from localhost ([39.7.58.252])
        by smtp.gmail.com with ESMTPSA id d124-v6sm34166829pfa.163.2018.10.21.19.37.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 21 Oct 2018 19:37:34 -0700 (PDT)
Date:   Mon, 22 Oct 2018 11:37:31 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Calvin Owens <calvinowens@fb.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH 1/3] printk: Introduce per-console loglevel setting
Message-ID: <20181022023731.GA508@jagdpanzerIV>
References: <08c1dc1a96afd6b6aecc5ff3c7c0e62c36670893.1506644730.git.calvinowens@fb.com>
 <20181019000403.GB877@jagdpanzerIV>
 <20181019220314.GA8164@Haydn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181019220314.GA8164@Haydn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (10/19/18 22:03), Calvin Owens wrote:
> Hi Sergey,
> 
> It's in-progress, I'm sorry it hasn't happened sooner.

Great!

> By embedding the kobject in the console struct, we end up needing to refactor
> the console drivers to use the kobject refcount instead of simply calling
> kfree(), which is what I'm working on. It ends up being tedious but not
> particularly complicated, my goal is to have this up soon :)

OK :)

	-ss
