Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A27C5C1B0F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 02:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51DBD2083A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 02:56:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wku6Xa93"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51DBD2083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754214AbeFTC4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 22:56:49 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:42199 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753622AbeFTC4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 22:56:47 -0400
Received: by mail-pf0-f195.google.com with SMTP id w7-v6so824645pfn.9;
        Tue, 19 Jun 2018 19:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rQ2At64TYofMmkP/Su7Wc92+J/WmEGPEGYA74k8+A+s=;
        b=Wku6Xa933rHoWIrsknMBf+7JB7Jjy5JWaMbLgv2wpe1zkF63ZhAafUUrjW+xH6BG/H
         3NB8nMnK/ls08lR5CD/iGMG9FuhsZUo8IunupEu3XfG13nOjwIrzj41uxtSHK/cfxnx0
         OetTSJFee+e6a+Sdq05E7vNGChmuj/tOL3u66pmKrO+JlUySYCHQj+X8YwiKWfYXRVaw
         itNGz1zw8GIU9jhmEPq37b8CExgHQ6Gs5koFCp9eD2bTdxio+blaxbWG5ozbFrHVsN2L
         mHpguHOjiwyIhp8l1EbG+bO6io5RB1XudT1u7nDe66Apw82A5XYx3hsWnuiwERVDLpoa
         C7cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rQ2At64TYofMmkP/Su7Wc92+J/WmEGPEGYA74k8+A+s=;
        b=s40YhamdJCJR9tXcPZ/i9EffhtK9utxR/4GNI+lMuNyFnnKraaZURBmMXs34BlnFTu
         XsVRgNB4HqoCdixfmrzj8Y6XqmMhLAz8rGo4F+v9DQ/WFohXbyEoNnxSQcI5uw15p2BM
         xt/NSYXfCFegFkhIoHcUOyO+pV+J7l5uGg4tNqNknHPRg36czy1OgzszPn24qbsU9nQI
         qlRSWNSqYvdBSRGtRRc/fvEnynjmX812KMPJDPux0fCQNLHeXk/4tGxUNg1bV9RwSrXl
         eDUVWkituWeQr4qFHyWlNTn0OvoGrxIoFZFhA9djmYN0KXAlyfFKkhdSnRUbm0oQrhXR
         bZ7Q==
X-Gm-Message-State: APt69E1BZX2yF1wZBgGc0C2fGxPQ9Ac3z7V090bXqtEqqrtiZ56awnB8
        ofuNiDJsujDkV+KkMfKSaWA=
X-Google-Smtp-Source: ADUXVKIuKsLzVKoyAVCd1p68F7aFHkNoc4pVlme/EueL9seO1erA6wEoZ1FdsPmoF3Ba8s7slN5IjQ==
X-Received: by 2002:a65:6157:: with SMTP id o23-v6mr17347109pgv.310.1529463407021;
        Tue, 19 Jun 2018 19:56:47 -0700 (PDT)
Received: from localhost ([110.70.59.159])
        by smtp.gmail.com with ESMTPSA id k80-v6sm1521113pfa.168.2018.06.19.19.56.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 19:56:45 -0700 (PDT)
Date:   Wed, 20 Jun 2018 11:56:41 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        SergeySenozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC][PATCH 0/6] Use printk_safe context for TTY and UART port
 locks
Message-ID: <20180620025641.GF650@jagdpanzerIV>
References: <20180615093919.559-1-sergey.senozhatsky@gmail.com>
 <20180618143818.50b2f2f9@alans-desktop>
 <20180619005308.GA405@jagdpanzerIV>
 <20180619083021.4avsgvcqjrpkat6s@pathway.suse.cz>
 <CA+55aFz9aGc-vGvKv_ZR2W2ZkZNSZfOHa0m_MbGH_a=x8oAW5Q@mail.gmail.com>
 <20180619223447.4369748b@vmware.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619223447.4369748b@vmware.local.home>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (06/19/18 22:34), Steven Rostedt wrote:
> 
> > There is no valid reason why an UART driver should do a printk() of
> > any sort inside the critical region where the console is locked.
> > 
> > Just remove those printk's, don't add new crazy locking.
> 
> Perhaps we should do an audit of the console drivers and remove all
> printk, pr_* , WARN*, BUG* from them.

I think I did a terrible job explaining my motivation.

Sorry for that!


What I tried to address with my patch set was not a direct uart->printk,
but mostly all those

        uart-> tty / core kernel / who knows what else -> printk

cases. When are in that special context "called from uart driver" which
can backfire on us.

	-ss
