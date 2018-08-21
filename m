Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85DA3C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 09:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A2CE214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 09:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ti38a439"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A2CE214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbeHUNOd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 09:14:33 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39644 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbeHUNOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 09:14:32 -0400
Received: by mail-pg1-f194.google.com with SMTP id a11-v6so8217433pgw.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 02:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XwB731gCknNUDgaXm6u9kYeDp2wCFgAgdUMwz4OMmNQ=;
        b=Ti38a4395OVDaVHrgnZVfln+E+bZQYTn96tmtvdy7JAMrvoM+YKCL0HJ+EmwAd41sU
         E/25bcAgxVVCVF7PxzZVnkPSFQUxAhzW+AveyzLkctLedHFhM4uqVTa9epe5l6vxThqq
         Vi1p+zAjvqS7+M97vLDDTLBbraOMhqhJqgG1Ej90zRtylNLwHAf9TVwl/4ojFKWbvWoW
         6Qj5Q7n2dEe10bX+Wsl4hl3syyh72BlYwrjLosN//6w9oci6X9HqY4saJ5jKHGcdbvZn
         RiFSu8sLA8zfLxs/v0QPmfPORM4mt3J3ugkcWItLHMavSrYmVTFhHrFcAD8YtMQGyRHd
         BUBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XwB731gCknNUDgaXm6u9kYeDp2wCFgAgdUMwz4OMmNQ=;
        b=Qjg2iJrWmUwDZKtlXubrhoKy76WLfkwWM6eAKvlCqKEJdObLxErLifB6+fFcllKCEQ
         MHe+GSn8oxqxKJLycyCw1Su1kXLNWGIz5UnYaIjXwf4LayEPLyqSwK/jtO3ROufCM3Z4
         nOk2r73WG3OH4TfgElhcLmYbWj61QnaSF/0iArzV3HmztP7PAG7hu4Q950E7GlhmeiS0
         gt06bZO1CRnLaXbokHcFkKgYM0xg9JTvcRWTjMMEt73B/OFJGJMcRSqsG1Ow2vgpNAEp
         KPmBbULdEp//+KXq6NLetzuzkeLqD0qUhq5tUbIX2yqqt41oLswwACRS1QSSN4DtODF4
         UXnQ==
X-Gm-Message-State: APzg51BJLie2degmqFsl0Fw5hGxVfTHUBStHtjQOvWckRZ43BH47EOnZ
        NGUpZ2igEqMfw6iWiZlgV4o=
X-Google-Smtp-Source: ANB0Vda+/WOTJySx4k7ju4O5EgLMH2PHnPGGzBbLXYGhNRYIVWgdxcko2O7thYYC9nK86ktcotQ34w==
X-Received: by 2002:a63:4a44:: with SMTP id j4-v6mr910361pgl.167.1534845303114;
        Tue, 21 Aug 2018 02:55:03 -0700 (PDT)
Received: from localhost ([39.7.47.210])
        by smtp.gmail.com with ESMTPSA id 14-v6sm19310672pft.93.2018.08.21.02.55.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Aug 2018 02:55:02 -0700 (PDT)
Date:   Tue, 21 Aug 2018 18:54:59 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Martin Wilck <mwilck@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC][PATCH] lib/string: introduce sysfs_strncpy() and
 sysfs_strlcpy()
Message-ID: <20180821095459.GC400@jagdpanzerIV>
References: <20180821062459.1807-1-sergey.senozhatsky@gmail.com>
 <0e06858f-3625-692a-582d-d828a3cc3ebe@rasmusvillemoes.dk>
 <20180821095055.GA400@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180821095055.GA400@jagdpanzerIV>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (08/21/18 18:50), Sergey Senozhatsky wrote:
> 
> Going point, that's why the patch is in RFC stage: to figure out
> what do we actually want.

s/Going/Good/       don't know how did that happen.

	-ss
