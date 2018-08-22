Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E0F7C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 00:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 079A1217B7
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 00:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iz1RfG2h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 079A1217B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbeHVDyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 23:54:33 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36162 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726916AbeHVDyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 23:54:33 -0400
Received: by mail-pg1-f196.google.com with SMTP id h17-v6so114600pgv.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 17:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oKCTIzlPfolMTLausV0jcgvpAUMl0DmtrQJMQVClvhc=;
        b=Iz1RfG2h7BUc/QKFehuiRRBTrp42MnFKnICxorzNoyAjH7GgwmxKU7yj7rIqQLvYeo
         GRHmiV6BhqEG2y2OeEoTJbopbaphPKNSkM7zpMmpyzjIjGGrpwrYrQChlNBD4p7lYR6Z
         tiSnqy00xdRh8Ld2/S8jwoyF7aaTAc9UZd4abtSfclxrTwtxcoGXh+PBaXa6O1idY5tb
         iXSCSXiMdOIecentvgf+ETgV5ChgfNyOi9uzTGI2Yykp9L1VtSrtXt+whAeHquJPLBpK
         vGK6L2n0CwrBqchcX5cVTrVRvBB6XJ3+9YyiEpA2Q/fEln742sXuT4GpbSUqEXu4luH2
         CtZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oKCTIzlPfolMTLausV0jcgvpAUMl0DmtrQJMQVClvhc=;
        b=kee7VaWhVqQnbEPuA2lVVjIFA3ZCs4qCogt+HTQqPkZBKTil7BbDPCQnJtrCRAUZRe
         7UwOm3y/H+tS+y5SyTfMxExtEMrnDOXvMGy+WyLGuBuURjE4s4+WllR14X/GNBBU55J1
         eZ5TGoAOXa/oWczENu1edn1dtCmNqxuqITvufndEmwcVW0I0tSdBwhXQcLuhMk23s9VQ
         0oaq5cNud7ritGkzpApgl8oSmDFBfJwiFS3FOVbmEwxwtMcsuFUz1Z9io2e/Xa66HpXG
         W32lnGLnyuILLPhhpvAxfoFP7YAZ2zlfM6HGFrm7cvRUQOjrGD7A4yTA76mLWaxM2JIj
         FW3g==
X-Gm-Message-State: AOUpUlEN06Rb8Zy4VPoknskqTNxprEOEEY4uY3alto//5cRDIUTj4oxL
        jTABKwox8A2m33I5YWSvndU=
X-Google-Smtp-Source: AA+uWPzFYBZNU9t/X5qBkmxD0Aj30XEFl3qOZItd+ym2rkp7yHvSCYR53sUZtM4VZ2NMMwDcJr8new==
X-Received: by 2002:a62:6602:: with SMTP id a2-v6mr55397091pfc.159.1534897929534;
        Tue, 21 Aug 2018 17:32:09 -0700 (PDT)
Received: from localhost ([175.223.33.48])
        by smtp.gmail.com with ESMTPSA id f186-v6sm132795pgc.4.2018.08.21.17.32.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Aug 2018 17:32:07 -0700 (PDT)
Date:   Wed, 22 Aug 2018 09:32:03 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Martin Wilck <mwilck@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC][PATCH] lib/string: introduce sysfs_strncpy() and
 sysfs_strlcpy()
Message-ID: <20180822003203.GA2218@jagdpanzerIV>
References: <20180821062459.1807-1-sergey.senozhatsky@gmail.com>
 <0e06858f-3625-692a-582d-d828a3cc3ebe@rasmusvillemoes.dk>
 <20180821095055.GA400@jagdpanzerIV>
 <20180821114405.GA597@jagdpanzerIV>
 <1fa46100c44abe54d5e66658ae69f3ba71522883.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1fa46100c44abe54d5e66658ae69f3ba71522883.camel@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (08/21/18 15:00), Andy Shevchenko wrote:
> > Returning the length of dst/-EOVERFLOW is a bit inconvenient, because
> > "the length" forces us to have size_t return, which is unsigned.
> 
> We have for ages ssize_t to workaround that.

OK.

[..]
> Wouldn't be better to split out something like
> 
> strnstrip() out of strim(), with simultaneous changes to strim(),
> strstrip(), and use it here?

Maybe yes, maybe not. strim() modifies the original string right after
it's done moving the end pointer. We can't do that in strcpy_trim() and
need to keep the original source string. So probably these two functions
don't have that much of a common code after all.

	-ss
