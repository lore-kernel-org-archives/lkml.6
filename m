Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D97EC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 09:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 430C12075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 09:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iGmb4/bL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 430C12075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756836AbeFSJuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 05:50:00 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:42605 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755270AbeFSJt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 05:49:58 -0400
Received: by mail-pg0-f68.google.com with SMTP id c10-v6so8922026pgu.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 02:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XeP8Yff6u2ryRFqZaJWbC1JL7sv3cjnk1xacczHn6D0=;
        b=iGmb4/bLX2l/Tab3uK33i6ZHTOMLj9zWcJ5010llibm1i7ofQJAkuXJjTQn0Rrt1I2
         Iphta7UcJ9m5XnZYeTWGTtIA0I3nng9hxrw4m/aVOxI09zUELJuI3UHJHda1rqbxfa4+
         3G2bJktjihhYjsvSpPsQyN8Lmq8tlLXLS1H1H9Yx8JyLG7dds19JFdeuRyoLCEHGvgwH
         xycWFZ9+mN+m+pPBrMOkrwWAtVk09a9ak0Cv3sMVD0YVFneDdYGfeQfs4MKM3mK7S7K4
         pVIG2aaEByHhr4A9JUPZrT1EfSI7ZaAPQn/6zXTQMBZs2/lgQYCJXfQocGZwczBxOe3s
         00GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XeP8Yff6u2ryRFqZaJWbC1JL7sv3cjnk1xacczHn6D0=;
        b=jrv9utq4JY+FsIXnCaqpc4PIfI35vpsHdKL9GZYK0hue5cgxRtfor8X5ZG2fBAy48q
         F2fI2jMwq8aED3hS+sQVPNMzTVs6XW5InhWeHXKb1KJTFdMEpMX5nuBnwHUQ5DLJMqAc
         MJTUuvqWqUeShFuuPno8jhnFEO2s4UWpLwfQEEmGODk4e3e5Y1tHCvmvmOwHnVDIVgPO
         On88pgZUV3sGfcGoCdOzWvoxQ2giMlB0OQ/csA0cD244cmdg/GGnAqG48a9Y25YbGMHM
         rEGFVKYVpcEL3ZX6HOzK90Bayne8LiHf+1UNlOiGxaufcCPAbUJTGhjPPsNsNqZZvIV5
         O2Zg==
X-Gm-Message-State: APt69E1RFo4lz4ONQZwb8PAh0wF2+ly47CJ2Z+0sRXAQNG/YwxrIEhQc
        iWh5U1lDE7IgMrBgaNtpVHppeslq
X-Google-Smtp-Source: ADUXVKIRVtYecBXQS31ac0w8FZ690yaEHUGeX1vOwSGppqDImmnTj/2Oh2UWKJUFVRLytTglKMEAwQ==
X-Received: by 2002:a65:48c9:: with SMTP id o9-v6mr14439562pgs.262.1529401798397;
        Tue, 19 Jun 2018 02:49:58 -0700 (PDT)
Received: from localhost ([175.223.26.106])
        by smtp.gmail.com with ESMTPSA id o87-v6sm32253890pfa.106.2018.06.19.02.49.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 02:49:57 -0700 (PDT)
Date:   Tue, 19 Jun 2018 18:49:53 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Maninder Singh <maninder1.s@samsung.com>,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, a.sahrawat@samsung.com,
        pankaj.m@samsung.com, v.narang@samsung.com
Subject: Re: [PATCH v2] printk: make sure to print log on console.
Message-ID: <20180619094953.GB2631@jagdpanzerIV>
References: <CGME20180601090029epcas5p3cc93d4bfbebb3199f0a2684058da7e26@epcas5p3.samsung.com>
 <20180601090029epcas5p3cc93d4bfbebb3199f0a2684058da7e26~z-a_jkmrI2993329933epcas5p3q@epcas5p3.samsung.com>
 <20180618061550.GA27996@jagdpanzerIV>
 <20180618062306.GA29683@jagdpanzerIV>
 <20180619093244.ehj34uhpnpv6447f@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619093244.ehj34uhpnpv6447f@pathway.suse.cz>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (06/19/18 11:32), Petr Mladek wrote:
> > -               if (suppress_message_printing(msg->level)) {
> > +               if (!ignore_loglevel && (msg->flags & LOG_NOCONS)) {
> > 
> > 
> > `ignore_loglevel' is a module param and can change any time via
> > 	/sys/module/printk/parameters/ignore_loglevel
> > we need to respect its value.
> 
> I would prefer to keep the patch as is. I see it the following way.
> 
> Also console_loglevel can be changed anytime by /proc/sys/kernel/printk.
> The patch basically moves the decision about the message visibility from
> console_unlock() to vprintk_emit(). The logic is easier when all
> aspects are handled in a single location and only once.

But when I set /sys/module/printk/parameters/ignore_loglevel I naturally
expect it to take an immediate action. Without waiting for the consoles
to catch up and to discard N messages [if the consoles were behind the
logbuf head].

	-ss
