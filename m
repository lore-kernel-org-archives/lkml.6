Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 881CCC5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 13:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 451562089B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 13:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jphY3KJd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 451562089B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933303AbeGJNPy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 09:15:54 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:41283 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932998AbeGJNPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 09:15:51 -0400
Received: by mail-pf0-f196.google.com with SMTP id c21-v6so11456818pfn.8;
        Tue, 10 Jul 2018 06:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=TOM/6cs+vo0eSYc3TbmAPzdovtRMNyE+Swb4waoUH4Y=;
        b=jphY3KJd1w0boN67HeeEJSqVEb2ssgX99MkdL6ZYjPdEXmVX5JmFlUpopXsfmdfq73
         mSmTEvWHugvB7RI0gtv3e8fjbWbsFuVDrpYlSO2zyfftAETsNcQ/TsKjAN8mYCc9MHav
         g8ZxGFj2VFE/pI9RFuNfa33kM8py0PWqyTOOev5FVMMIKsYONV8z8EDZeq3rAnUJw+m4
         bGoAT+xxYe30H/s+SPxB0GEmvz7VuDCDequDdXNDvXtv+V9BnA7/1oyGXuKG6OmAMW1f
         K6x7JhxBWXAHR8xhcrsF4+Bw9YGXkTXhhxEK2mICzzX9ulFvfCsxsfdIm08LsIy47JXg
         A41Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=TOM/6cs+vo0eSYc3TbmAPzdovtRMNyE+Swb4waoUH4Y=;
        b=Cl/z38sJStzeO2/CVyy1rqAGBMEyjTW1/5fKfeIVeIkIbgSlRlh6pA4WC+Rt8eWZfg
         xVQOMHDmMbtxvN31EL2nRrWHEiEqPaAAUCMWRvED5IpA1nwb2xocNoYUzKe8aMzhpNV5
         auVaJ6b7+4kDBMBuCvxNjsCFhXCFFwki0FjRET/1pc7CfJDaV20CRctQjUFhVk61ln5j
         gZK+NJC8cPzXTepNXyccVEfom4n3e1p5La6lQKqVjcQIdTXcN/ICvng9NlT8WaZr2jXh
         BfM/4330Dd7PkX4ZkPIY/mHsJlCoasngvlVY1WoUe5VvELW4mflsKfQGraFC6QN9n7KG
         f4Eg==
X-Gm-Message-State: APt69E1CzFQ/kl5s3dZmyV2IAmzUmjIhbYckXDCGdgPMoBOpOt0uAYKn
        QnudFOZNS2LqasEL7lY7cZv6aqIJ
X-Google-Smtp-Source: AAOMgpdp7GkGow1tqUKCnveJrq/vn4UZ09F+frNWEqovS4yuVx8FsigkmZRnDudCwKSbiX63IAqnGw==
X-Received: by 2002:a65:450a:: with SMTP id n10-v6mr21937678pgq.392.1531228551176;
        Tue, 10 Jul 2018 06:15:51 -0700 (PDT)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id s2-v6sm25999675pfh.186.2018.07.10.06.15.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 06:15:49 -0700 (PDT)
Date:   Tue, 10 Jul 2018 22:15:47 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Maninder Singh <maninder1.s@samsung.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vaneet Narang <v.narang@samsung.com>,
        PANKAJ MISHRA <pankaj.m@samsung.com>
Subject: Re: linux-next: build warning after merge of the printk tree
Message-ID: <20180710131547.GA526@tigerII.localdomain>
References: <20180710164514.22c552db@canb.auug.org.au>
 <CGME20180710064527epcas1p16fd9ad765711d69264b3251890bbcc2e@epcms5p5>
 <2014348883.271177.1531206974788.JavaMail.jboss@ep1ml503>
 <20180710091909.rwgtahcew6grhd6n@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180710091909.rwgtahcew6grhd6n@pathway.suse.cz>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (07/10/18 11:19), Petr Mladek wrote:
> suppress_message_printing() is not longer called in console_unlock().
> Therefore it is not longer needed with disabled CONFIG_PRINTK.
> 
> This fixes the warning:
> 
> kernel/printk/printk.c:2033:13: warning: ‘suppress_message_printing’ defined but not used [-Wunused-function]
>  static bool suppress_message_printing(int level) { return false; }
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Suggested-by: Maninder Singh <maninder1.s@samsung.com>
> Signed-off-by: Petr Mladek <pmladek@suse.com>

Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>


Happens all the time to me as well. I'd rather remove CONFIG_PRINTK
at this point ;)


	-ss
