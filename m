Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82635C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 11:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E0C4208E6
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 11:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bFYfTIzK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E0C4208E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbeHUPEA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 11:04:00 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42858 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbeHUPEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 11:04:00 -0400
Received: by mail-pf1-f195.google.com with SMTP id l9-v6so8364355pff.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 04:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tqRNIOGf1OwHAHPr36r2XKZO/JCFWIXwDId3/KEBoGU=;
        b=bFYfTIzKAxFVu8WBOTWeZmW2+BCMnjDNAIphFY0oF6xigfH9gcC53jRKLOZG7mGEIo
         71zlPybu/edqkCXiJ2ibygfiM0RzI1LsLvTOSwBMBRdlDFgSfdb9UIfvba1JixcSWYFU
         CZ6xo4HjnKCAYYTEfXYmd9KoAPTUW1C6/e2GhEkMzlHuLgNbqXKfflYhCwOHAEjNbjOq
         XdA7nccO6r4QK9MKHbvEP9xLyiv66/G6TT1mDm1uWLcC+mYv6qPzJJLWGsXcvyOU6d9I
         qTzwmEUu48hky7f2zbmlzAiBZ1XfamQk0vpGh4y8/oMDH53bQmekrKqjXMmRZmUI2GX/
         SaQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tqRNIOGf1OwHAHPr36r2XKZO/JCFWIXwDId3/KEBoGU=;
        b=DWHtmpQneJvJDG+yn2IHpPBGtY1GHjd+sRfKVEVFQugnyGU3ITtV4wRVCBEjnTatj2
         n+F2PpF1pjanACKLTUsmr+V1sTYz9YwrbTvoAKwtvsfN6fqLOh1yfbJIHZXzx1jPoIpc
         mVortopWtl2gCn/w4A+ly19akM20YWiXCniRgINrQqNGb3W0BEuAGd9bSSQiwjNbjcD7
         s9sLLPXzMGYPOgVDxKKZeS+NXwFXylnH+De9CpGkXLza9oU95gqLo94uNhLxMY7Fb7xZ
         z0Dkibg/96vP5ZoMkpdUfTLzSSkj9CAkHBUF9O5cd0oAD/lwlTpDreW4xheuBm/zHU/Y
         jO7w==
X-Gm-Message-State: AOUpUlH/8/fTbYU8fI7tqCkbxUQ4fnQV/Au9gxSaiXwjtPCOyTz7fZRG
        Xb2mHIPqdv7k2UhDp1L/ISY=
X-Google-Smtp-Source: AA+uWPy3DSuQUa5nskxWkWTHUP/B3YwoYzKFvRFbyj7D2sAwdPeCOdaY70zYyckACsu5QFH3YbnflQ==
X-Received: by 2002:a63:f309:: with SMTP id l9-v6mr45918316pgh.369.1534851850323;
        Tue, 21 Aug 2018 04:44:10 -0700 (PDT)
Received: from localhost ([39.7.47.210])
        by smtp.gmail.com with ESMTPSA id r1-v6sm21963437pfi.17.2018.08.21.04.44.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Aug 2018 04:44:08 -0700 (PDT)
Date:   Tue, 21 Aug 2018 20:44:05 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Martin Wilck <mwilck@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [RFC][PATCH] lib/string: introduce sysfs_strncpy() and
 sysfs_strlcpy()
Message-ID: <20180821114405.GA597@jagdpanzerIV>
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
> > int strcpy_trim(char *dst, size_t dstsize, const char *src, size_t
> > srcsize) - copy (potentially not '\0'-terminated) src to dst, trimming
> > leading and trailing whitespace. dstsize must be positive, and dst is
> > guaranteed to be '\0'-terminated. Returns the length of the string now
> > in dst, or -EOVERFLOW if some none-whitespace character was chopped.
> >
> > would cover all use cases?
> 

Something like below? Not tested, since we are still in "is this
what we want" phase.
Returning the length of dst/-EOVERFLOW is a bit inconvenient, because
"the length" forces us to have size_t return, which is unsigned.

This one returns a number of non-NULL bytes, which were copied
to dst, or 0.

---

size_t strcpy_trim(char *dst, size_t dstsz, const char *src, size_t srcsz)
{
	const char *end;
	size_t ret = 0;
	size_t len = 0;

	if (!dstsz || !srcsz)
		goto out;

	end = src + srcsz - 1;
	while (end >= src && isspace(*end))
		end--;
	end++;
	while (src < end && isspace(*src))
		src++;
	len = (src >= end) ? 0 : end - src;
	if (!len)
		goto out;

	ret = len;
	if (len >= dstsz)
		len = dstsz - 1;
	memcpy(dst, src, len);
out:
	dst[len] = '\0';
	return ret == len ? ret : -EOVERFLOW;
}
