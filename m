Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44AC7C282D7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 04:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12D1121479
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 04:20:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfBKEUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 23:20:40 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45672 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbfBKEUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 23:20:39 -0500
Received: by mail-qt1-f193.google.com with SMTP id e5so10682357qtr.12
        for <linux-kernel@vger.kernel.org>; Sun, 10 Feb 2019 20:20:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KOrB8TrtfHqMnojXCyjW67AA5omgyBw/sPiYU4QGnj8=;
        b=G0+VWLmsOt74uaH1mI9NRCWCfSdlrikNxjysw9keD7P4OQZL2fJlA86uvu+w/xlK2I
         dpt/oEg1hqCSr5WEtXoN8HjjBaFfmLGO5o89AJ8gNbUlkzB/2UWW6USFzK5UaiflRHg5
         Ol2HmL6VVANk2a/FPFjEyt7EQcxTchswOb0Z0WRk+KaoeD5LE4ebRaUb7T37RJb11T9u
         ZrVih5F9S1e29CHux8bmNyH5HK/+r18sFQEDU9GyWFxAKazFPEtPDYHT281fENQWZNRj
         nQSwEBdxvVuibv7zGr+KL6DEILrVbfbOmcgYhOVX7BL5tggwmwd7WnfuQgIK5GnTtla1
         LYMw==
X-Gm-Message-State: AHQUAuYnCxtlh5SRGsXL8Fa460K0obloGSghHt40zBQ/O/aS3qaDddwY
        uQbVTTfTJ/Hf8DOLneIplbIHJfYVPvQ=
X-Google-Smtp-Source: AHgI3IbJ1u9YK285HCM+3PtQHCqZEnK7NVhUwNufd+VHm6kppTXDVZMfwtHTxtadEwtCjG1JJ9aAuw==
X-Received: by 2002:ac8:30c5:: with SMTP id w5mr990179qta.323.1549858838246;
        Sun, 10 Feb 2019 20:20:38 -0800 (PST)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net. [173.76.246.42])
        by smtp.gmail.com with ESMTPSA id k22sm8071513qtm.73.2019.02.10.20.20.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Feb 2019 20:20:37 -0800 (PST)
Date:   Sun, 10 Feb 2019 23:20:35 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/3] generic asm: mman cleanup
Message-ID: <20190210231841-mutt-send-email-mst@kernel.org>
References: <20190124142448.23243-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124142448.23243-1-mst@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 01:02:51AM -0500, Michael S. Tsirkin wrote:
> Now that we have MAP_SHARED, MAP_PRIVATE and MAP_SHARED_VALIDATE on all
> architectures, it probably makes sense to de-duplicate these
> and put them into a common header.
> 
> Please review and consider merging though the generic tree.
> 
> Build tested on x86 only. Has been in linux-next for a while now.

Arnd, would you consider merging at least the cleanups 2/3 and 3/3?
In linux-next they had no ill effects and make things
slightly cleaner IMO.


> Michael S. Tsirkin (3):
>   x86/mpx: tweak header name
>   drm: tweak header name
>   arch: move common mmap flags to linux/mman.h
> 
>  arch/alpha/include/uapi/asm/mman.h     | 4 +---
>  arch/mips/include/uapi/asm/mman.h      | 4 +---
>  arch/parisc/include/uapi/asm/mman.h    | 4 +---
>  arch/x86/mm/mpx.c                      | 2 +-
>  arch/xtensa/include/uapi/asm/mman.h    | 4 +---
>  include/drm/drmP.h                     | 3 +--
>  include/uapi/asm-generic/mman-common.h | 4 +---
>  include/uapi/linux/mman.h              | 4 ++++
>  8 files changed, 11 insertions(+), 18 deletions(-)
> 
> -- 
> MST
> 
