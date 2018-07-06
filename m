Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA02C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 213D523FD2
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lo59GdFK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 213D523FD2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754038AbeGFOmW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 10:42:22 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:39631 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753839AbeGFOmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 10:42:20 -0400
Received: by mail-pf0-f193.google.com with SMTP id s21-v6so8644968pfm.6
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 07:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pGfhOTzM9hBOdhLW/DVT3eU+Qq+pjNyD/GuvdfYGwX4=;
        b=Lo59GdFKWy9z5X8MXhAoX5+jdhHWBbGdBI9ZdnPX8JZAttY968YL2l1Gszxq3nYO+M
         kzKTF+A8N0xb51t57NUHiefwxLfE/r6k0CZxDZ4g+hnyZG9TIpk3c2dsJ3RxIBtzpcUu
         qz5Vpuj/wn8gB0eVsjhreyHv67rGMJR6tt1nSoX0TVJYbSABg+RCrSZWVeX34lWx2ldd
         FZ3scDXHH4lFAEQ+ri4ZwGkMrNIPskF6qboly/f0/7ev8SvSxo4wAPIRqGNLcqUGq9re
         LikahZHKxxrNM8HPe9wDK/tzt99J8hnlLGaxkxvBn4yyg2AqkVaXdK69aKMP3pgUnQn6
         oEOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pGfhOTzM9hBOdhLW/DVT3eU+Qq+pjNyD/GuvdfYGwX4=;
        b=ovthX9DRntSu/Swzjb2KacqsWPTZTuyezpRlZKqiXS8hR3wxz1cQw5KaKe/cRlNYSL
         YRDUOWPtNKSRABu9F5uZuiBFIWjSvIQVwwpNbIfZKuVc/bovQ+0Log+dIlbfITPZeDWu
         Ilr/1P/Xm6QEubt2HpPHCL6ToiEKe1/dkisYCy60RdTdI6pJtY8HuZF+2QUTB+pvijAS
         fUdsyQwE7pNeRV5YmXwsBHub1gqkNyw8XlwIRvG9tkHL6iZxai0mrxlrt4QlyOpBB2Aa
         U3ENmnBpH07doPgo2aShInUz/tUeblvetIgA+/WerSfw/ILJauC9aeR3cRJcgEEgcIWV
         Z5AA==
X-Gm-Message-State: APt69E1xdMPzSy5Msv5f6QlYvnACIGsjk72EeJXRwum9gRQoKeMmZvwY
        4Nd/tYHfgqJ7f8PgRs5EoPpN9Xc6
X-Google-Smtp-Source: AAOMgpenVuZ71iQcQ/00fArg6zvaZw1pHvXxEPsRzyyBJyQ8XsBX3Lc/LAwn6KmZt5OpEoENeYDyZA==
X-Received: by 2002:a62:5f81:: with SMTP id t123-v6mr10799089pfb.15.1530888140289;
        Fri, 06 Jul 2018 07:42:20 -0700 (PDT)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id v30-v6sm26901124pgn.80.2018.07.06.07.42.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 07:42:19 -0700 (PDT)
Date:   Fri, 6 Jul 2018 23:42:13 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Tobin C. Harding" <me@tobin.cc>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vsprintf: fix build warning
Message-ID: <20180706144213.GA411@tigerII.localdomain>
References: <20180706134724.563799-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706134724.563799-1-arnd@arndb.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (07/06/18 15:47), Arnd Bergmann wrote:
[..]
> Fixes: bfe80ed3d7c7 ("vsprintf: add command line option debug_boot_weak_hash")

Seems like this one is still in linux-next.
Can we squash this patch and bfe80ed3d7c7?

	-ss
