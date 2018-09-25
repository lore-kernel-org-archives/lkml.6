Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A5AC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C3C120842
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SPAaOltQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C3C120842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbeIYSIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 14:08:55 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45197 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbeIYSIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 14:08:55 -0400
Received: by mail-wr1-f66.google.com with SMTP id m16so6584258wrx.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 05:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5qwEXA/1LPDNo/2MDhGys8jNGHrc1rHckaR/yyH8NEM=;
        b=SPAaOltQYF07OoUEhm4+aASt+uxcPme/2EXAGP4zTPH10KKORpmpHRiKyhuDb/PRXq
         ZU+6BvGLTlm1tJ4BQ6vt9/7fBfKGfw6stchcaS4mW/S3UwZJacvc7iDHAvbIIYG6NP5D
         ZF93AEpYXHTOwSGbzryH5H3OdQJJjtk/FEoOh6VRRqYipj29h883gqu9kShXxMUPLp5C
         s4Yz8erVaGbFt0cogXZwmRtcV9p2e6a7AuOc4sOXT0vDtVdnjCs1IGM7D2EJLPGqiXWe
         DcOI8CFtCJqxZMH1EhEJRc16kKJiG0gVGQzbOZGaIrJsawIGbJ/F9pDSJKnoLqH6nyh3
         F/2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5qwEXA/1LPDNo/2MDhGys8jNGHrc1rHckaR/yyH8NEM=;
        b=ojNmvImGMuxMJLIUqDY3JIwX5E1PqT/qxpIo5PW9QiMlMv76UZ0Iufxp5bchicIL9D
         VcBFE+UNW5Dbtr56wklio7dTVIyTkg2Rf2IH90eFlvruS43u1ldaVXjEY+so+F6Yi+2r
         gI2DdKy62O8PEmkuiKPjQ5saUrHWs+RJX3jIfopA0f+fjSKILrM1ycyK637uLQZ/FaN8
         iGyZUr+UZqC6jsFCtTq64mqAWYsEzg+OeFoG6rOM4H+PSoGrUHNO+ffVCOqodg3Qat0O
         DFHa/kTbN+W41Ju/b8/qhdySJH5VRo6TL5MarJKBelwbZH7U2ALiuiF3EoseJzBxYbOA
         KUZg==
X-Gm-Message-State: ABuFfohT5zB+okQbnN2Mj7zMg5s+5GpHRmit+CccEpJBGS72uQJqXYi4
        DrKSLF4UXwf3wJM9pnutVnowkS7zdaHQ0g==
X-Google-Smtp-Source: ACcGV62duvlftmVPO8iGnsZ0KLih/7KaRrtdGU1hEVEHshxmjm7aLB4GdkbLGEVEKYxcrCe5iFAYNQ==
X-Received: by 2002:adf:c64e:: with SMTP id u14-v6mr617476wrg.177.1537876900761;
        Tue, 25 Sep 2018 05:01:40 -0700 (PDT)
Received: from localhost ([178.121.95.75])
        by smtp.gmail.com with ESMTPSA id x16-v6sm1379466wro.84.2018.09.25.05.01.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 05:01:39 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Tue, 25 Sep 2018 21:01:35 +0900
To:     Petr Mladek <pmladek@suse.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        He Zhe <zhe.he@windriver.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        sergey.senozhatsky@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] printk: Fix panic caused by passing log_buf_len
 to command line
Message-ID: <20180925120135.GB523@tigerII.localdomain>
References: <1537291068-443145-1-git-send-email-zhe.he@windriver.com>
 <20180919015030.GA423@jagdpanzerIV>
 <6c354803-5341-7237-9ee3-7882252c7483@windriver.com>
 <20180919023932.GA14090@jagdpanzerIV>
 <20180918224312.6e9aef50@vmware.local.home>
 <1545bc85-b64a-4b45-d40f-79567ac621dc@windriver.com>
 <20180920123056.27b2cf18@gandalf.local.home>
 <20180921073753.mqayzofcofpmhiyu@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180921073753.mqayzofcofpmhiyu@pathway.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (09/21/18 09:37), Petr Mladek wrote:
> 
> I would personally keep the size as unsigned int. IMHO, a support
> for a log buffer bigger than 4GB is not worth the complexity.
> 

ftrace dumps are bothering me.

Steven Rostedt wrote [0]:
>
> Especially when I have a machine with 240 CPUs. But it also has a ton of
> RAM, I could easily do log_buf_len=32G
>

The systems are getting bigger, so log_buf_len=UINT_MAX+ might become
a norm at some point.

[0] https://lore.kernel.org/lkml/20170428101659.7cd879e7@gandalf.local.home/

	-ss
