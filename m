Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2547FC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA09D2184D
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548842387;
	bh=caLKrCLKxUmzNb1bdoAzfpXGhwc0u4/lOLTNF1bFlqc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=COFTWlNXpm6atS1RL2RH2I26dj8efDsfGOz2SL5EJKUG/Xzwl+FIobIkXqVSO6QRp
	 t/nV7O+7Wh/zgD06lMHDfPT/u7FvMikU8NKNvRxNDf05Z2TFLP+i5c876qSjpJozJC
	 kqLONqln3JBuUEmeQCOPli+WnRugP0lt0NohSaik=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730652AbfA3J7p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 04:59:45 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46124 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfA3J7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 04:59:45 -0500
Received: by mail-lf1-f66.google.com with SMTP id f5so16880226lfc.13;
        Wed, 30 Jan 2019 01:59:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a5XBY6xj9+zxrACI0GDVmm78XUqLrekfPbtv6zRYzPY=;
        b=MWygwd0NH3PNfcE0+qmFED6CHe7R/VUwj1+dhgC9zwDutuIur4eWOK/4hahpo+5uRK
         yxl4fvxop7IydoQEzjIfmmTKZKVqmweTmIP7ooGXCAKU9Me+uvwhZqlka07jTP2/8K+u
         6UjaJUF8Ltj4cL2CD3ae3bq+flej1V/gJTbwKHm4p9vyd/RHzFfy0HQF4Hgcf8pYGiqH
         BUAcAfMeBAU8jEZIFp6/LyJxmnNiZBKQxz15+yP3A1ZKZreS6okUp7WRO4e479hN+mPo
         H7QZSAiPpRYtt6HBfoxBOhrNkGrvIjhGAXJ8OnKyec112cbH/OijnWNId+fokJSB0JRR
         zCew==
X-Gm-Message-State: AJcUukdh//h/2BifGz/bdGWlJW3q82XEChk3IRaSVXJV5Y5kncW5yv9Y
        eSlMlzJ/YLQFxkrsui3Eb9M=
X-Google-Smtp-Source: ALg8bN7vcQB1PPKPTEqZYHEnl6iyubsH8P/M6bSZq/xHlRPUN6P3oe5qrJfBIyKYcZeEyyyxR+04zQ==
X-Received: by 2002:a19:5d42:: with SMTP id p2mr22616773lfj.83.1548842382909;
        Wed, 30 Jan 2019 01:59:42 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id f20-v6sm193942ljk.33.2019.01.30.01.59.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 01:59:42 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gomeg-0001Bf-CS; Wed, 30 Jan 2019 10:59:38 +0100
Date:   Wed, 30 Jan 2019 10:59:38 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Myungho Jung <mhjungk@gmail.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Add NULL check for tiocmget() and tiocmset()
Message-ID: <20190130095938.GP3691@localhost>
References: <20190128065910.GA14959@myunghoj-Precision-5530>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128065910.GA14959@myunghoj-Precision-5530>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 27, 2019 at 10:59:13PM -0800, Myungho Jung wrote:
> tiocmget() and tiocmset() operations are optional and some tty drivers
> like pty miss the operations. We need NULL check before referencing
> them.

Good catch. I suggest splitting these fixes in two separate patches
(after addressing Marcel's comments).

Don't forget to CC stable and add a Fixes-tag for each, as we we want to
have this backported to stable.

> Reported-by: syzbot+a950165cbb86bdd023a4@syzkaller.appspotmail.com

Actually, these two bugs were never reported by sysbot AFAIKT so no need
to give credit to anyone else here.

> Signed-off-by: Myungho Jung <mhjungk@gmail.com>
> ---
>  drivers/bluetooth/hci_ath.c   | 13 ++++++++-----
>  drivers/bluetooth/hci_ldisc.c |  5 +++++
>  2 files changed, 13 insertions(+), 5 deletions(-)

Johan
