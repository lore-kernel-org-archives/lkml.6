Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55171C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0683E20868
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:27:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RD6eioVa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0683E20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbeJLQ7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 12:59:00 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39372 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727808AbeJLQ7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 12:59:00 -0400
Received: by mail-pg1-f195.google.com with SMTP id r9-v6so5578484pgv.6
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 02:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=subf+NwwQ5hED6t/gLwRh6VTNdL+xrAtf4Eg8jcUa+M=;
        b=RD6eioVal2JH23tdFO0a7iCi3tG/TUD+k5RMCumVZbD9adn7sd2PH1eHyDhnmaNTfJ
         bMLWBDJOZat9AVQifPtmCTGwdwemhV3a/zVd0NzXm69qwkL1/q9KkYFHefCS9LjhQdLD
         QP78J6SFsJQ52DZk/T01AJf4AHMOvrd+MYrpR2AoTVmcWjP+Vqe0gmXUoA5IF0hj0rcW
         1UK5CSo+Zeun3N2LGpTm5uyp+XsHtFdB+U36ExsFugANg4L1/Ju8TINCrIskCDviJVxK
         EcDPgy8jfuJxIMXJq0FNActadcp0j0ijIaDFLyvelz6J3Lgif9PVGPAr5krPzRMu7FJy
         FWmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=subf+NwwQ5hED6t/gLwRh6VTNdL+xrAtf4Eg8jcUa+M=;
        b=Kyl0hMUvf3tRnwgMV8+V8Ovu6A/GElTSeOllfZhBPwgy533B89Xpcg+k9sYQ03RPPl
         R7BDqmNcdmPJ504wKPLQ0GYPsmLEHqvap4UZYKEmAkhejw82TzE3LhflNn8GOmInD6lb
         NgKRPr/Oocb/OyTIhPOKX1v/9YWwGfmkzeQ+Y3P49aqH5zXAlZN94Z03Qkph2Jae7GpY
         V/ZBDq+Q7JIpsZPSucm2jIIR/YJHaBRQmYpbRyudiEdULMBe0Da/HzMJWHdo7Rc3L8jz
         /6/BLitIOVtSTwy75+LToas3QKdldGKgZJSlGpWTfVXqFxp/8AuL5gTDdq7m4g6HVL+n
         sKDw==
X-Gm-Message-State: ABuFfog8eMhpCZJUQtyuQGjYyKFZCL1MdluWSTtwkPGtiaYAZ1vCxDZX
        udSXwNrfpKZXKCPXEXNcVH0=
X-Google-Smtp-Source: ACcGV60RjZOCr29pPIMdsiyL/XutqGLEwlHe8EceI1shncn7y6tRKbqDOk6yj5OMmxSmXJxvrI09Sg==
X-Received: by 2002:a62:1f03:: with SMTP id f3-v6mr5291241pff.168.1539336448661;
        Fri, 12 Oct 2018 02:27:28 -0700 (PDT)
Received: from localhost ([110.70.57.157])
        by smtp.gmail.com with ESMTPSA id i76-v6sm1518810pfk.43.2018.10.12.02.27.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 02:27:27 -0700 (PDT)
Date:   Fri, 12 Oct 2018 18:27:24 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH] printk: fix integer overflow in setup_log_buf()
Message-ID: <20181012092724.GB19882@jagdpanzerIV>
References: <20181010103808.882-1-sergey.senozhatsky@gmail.com>
 <20181010113308.9337-1-sergey.senozhatsky@gmail.com>
 <20181012090159.nmqcrodrxi66n2lz@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181012090159.nmqcrodrxi66n2lz@pathway.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (10/12/18 11:01), Petr Mladek wrote:
> > Make "free" unsigned integer and use appropriate printk() specifier.
> > 
> > Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> 
> I have pushed this fix into printk.git, for-4.20 branch.

Thanks.

> Please note that this 2nd hunk was already part of the commit
> e6fe3e5b7d16e8f14 ("printk: Give error on attempt to set log
> buffer length to over 2G"), see
> https://git.kernel.org/pub/scm/linux/kernel/git/pmladek/printk.git/commit/?h=for-4.20&id=e6fe3e5b7d16e8f146a4ae7fe481bc6e97acde1e

Oh, indeed. I guess I used linux-next which didn't have your commit.

	-ss
