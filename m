Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48962ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 11:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E570820882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 11:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qQDvLnnX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E570820882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbeINQd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 12:33:59 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35539 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbeINQd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 12:33:59 -0400
Received: by mail-pl1-f196.google.com with SMTP id g2-v6so4078270plo.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 04:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9NhTa8MI+IXz7f/8/DTUAF5oEY2SDxpnqX6zDRXIj0w=;
        b=qQDvLnnXEDq3xBGSqEeYGfhhEP/vepBMwRSR3ZM3kbMbeV2q33a4RPGKTNkD5/nPX2
         bhGtHDT8Z7t6lHRnqLAoKJQsWTWH5RuoBYdUmlEZemYJQ598/ar6F+dgiiXftkwHQ58R
         kw5AXLl16iidnea8XGIpBZEjPogP4JyffA6GDUGi6SHNNLCGtEk0GE9AyTIxnws/SKkB
         HZel/FokJlkZRiDBVxCIYmCjFYBz9yxZeuClXW07B+2TuSkN/cu466hRtJy4LhOBrLhp
         gfWVW35l4aGOgvIkNljaoWODQeK4w7uIhw8rAJMkI9JjuxxgP0pCZUPEtFQbym3u+t9F
         N/vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9NhTa8MI+IXz7f/8/DTUAF5oEY2SDxpnqX6zDRXIj0w=;
        b=svbhiLnOPm/tAGmnSe+8zEZjgPQeO9BnBKYwcfBq7JQi3QRw/Uiovgv0NESgZHJelf
         T9QGTi3ZtPVxJnDddWNEF4x9yrIRDmZnPDllV/yyHsiExrbJ6mU2p4BnPjiPAxJIcaoV
         cvA9M6EHFIHohkztYV+v7V1cLtlThat2cxal2DUNpU8HJJm4FL94BHKvSVfCW60oxP7w
         vhPAIKJS9572VyzQX1opl4IxuVLZNgcTH2XJcS2O35V+f2nxzlf6QmVGFq3DYA4/uHnu
         vmINcpWlnhftgYHXrVm/ZrXOdFi1AMvToF5XV7GCmy3+emOEsfh22v8AIyVHMpm/f26K
         ndlw==
X-Gm-Message-State: APzg51D1GjPdt6VP/8UgAM0B4wX9letJ9p83ctv32RUq3d+51UUT8l78
        lTDIj2Np6Q3+zaak1I8aZ7TEpSnX
X-Google-Smtp-Source: ANB0Vda2xPqsxnWiCJoUtMbm4sfYsuN0UY8Wdtb84H1yE/bRK7Wv6iMU+ivlOb3xqzIJG8g4QpTpYg==
X-Received: by 2002:a17:902:d688:: with SMTP id v8-v6mr11738453ply.278.1536923997310;
        Fri, 14 Sep 2018 04:19:57 -0700 (PDT)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id d12-v6sm9196037pfn.118.2018.09.14.04.19.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Sep 2018 04:19:56 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Fri, 14 Sep 2018 20:19:53 +0900
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH] printk: CON_PRINTBUFFER console registration is a bit
 racy
Message-ID: <20180914111953.GA20572@tigerII.localdomain>
References: <20180914023428.814-1-sergey.senozhatsky@gmail.com>
 <20180914085934.m2bgixltdzpfh62o@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180914085934.m2bgixltdzpfh62o@pathway.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (09/14/18 10:59), Petr Mladek wrote:
> 
> Well, I am not sure if it is worth the code complexity.
>

Well, I don't think we need to bother that much here. Besides,
exclusive_console is cleared under logbuf_lock with preemption
disabled now. So we set it under logbuf_lock and !irq and we
clear it under logbuf_lock and !irq. Looks quite OK to me.

	-ss
