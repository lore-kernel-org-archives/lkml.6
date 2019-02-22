Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A903C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D89D207E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JthjGUjv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbfBVUVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 15:21:00 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:32904 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbfBVUVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 15:21:00 -0500
Received: by mail-lf1-f65.google.com with SMTP id q12so2694493lfm.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 12:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nPu7TUAGJUbzY11xcVwQR8OVx4CJd93Pgak9brPfP0o=;
        b=JthjGUjvJNPIYZpKp19nplYYUyZZ8rgs8+HUfea1M8Xx9ERSTB4aRUlEmX2DBY8HEL
         OTWHcV4P5DzPfRGDGTz3cryUtjxI4btweIQh81nUWkqq2QLtAp6puF0kLPVrQpOZ9v8H
         VmhjgSLuAyds1hfdVNOlHOMz0j+W4vC/lWc433aoColAhQtGWeYoE4wN2ChOvM7we8LG
         FU1YcEBYd7wNV12jiXtbDZnHCKcL4TId1lb1g0xC4La/2xXiuT4AN4dnni0KqBOyl3Y0
         eXAoHwgexPyrUcnppSsgANX1nJ56+BG8UDW+158UgdhhgB0GytV7aZY418l92ZWWLJJG
         LuUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nPu7TUAGJUbzY11xcVwQR8OVx4CJd93Pgak9brPfP0o=;
        b=JpizKZDfYICHqDP4OICVqbKOLiAAfpKviz+ysAXceKFvMpWWHuAb+4vavYG3kdH6Me
         iHVNvY2B8pKxVcT125sYlrTOoUDJ/Y1GEiRHN8Ajur64WnFXzxDisA5CBKOE/7KJM+6b
         vShFqREmF9sXfw4cR9QR5j+bpPVIrEI1RjIqxmZRyVUy6Hp+1Dv/8WbdIYT/uk4o8Qce
         6239mhQMQiU2G5SLbprM7D9X5n5iS1xSgs9T3iDYywqE5iutlUyZl7YltTKVGPFtUppI
         piDpiAn47z1bTqan3G8RoyI0nm1WIpvgRHbmO2dU+Xtu5hF+Y0lO883Uyetsynun9ZcX
         VQug==
X-Gm-Message-State: AHQUAub9226UwuFdQZjTCZaL6xmmIYDNw+CoLIed9RVaDgNOY0zsLZV+
        zv1yqSpexzn/mShTKYKC3n8=
X-Google-Smtp-Source: AHgI3IYmd7M1BbZzbc52QOwSg9peRfvtKm152u6hNsTIryV4W5JVqCe528sz0beuDGkiP7PvA8W5oA==
X-Received: by 2002:a19:9a8d:: with SMTP id c135mr3423650lfe.100.1550866858061;
        Fri, 22 Feb 2019 12:20:58 -0800 (PST)
Received: from metis.ciupak.eu ([31.130.108.122])
        by smtp.gmail.com with ESMTPSA id m18sm726431lfh.43.2019.02.22.12.20.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 12:20:57 -0800 (PST)
Date:   Fri, 22 Feb 2019 21:20:56 +0100
From:   Marcin Ciupak <marcin.s.ciupak@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Joe Perches <joe@perches.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v4] staging: nrf24: add new driver for 2.4GHz radio
 transceiver
Message-ID: <20190222202055.udjbsm5qkxzkqcdh@metis.ciupak.eu>
References: <20190213194035.n2ldlt7xque5qaps@metis.ciupak.eu>
 <20190219102010.GA18634@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190219102010.GA18634@kroah.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 11:20:10AM +0100, Greg Kroah-Hartman wrote:
> On Wed, Feb 13, 2019 at 08:40:35PM +0100, Marcin Ciupak wrote:
> > This patch adds driver for Nordic Semiconductor nRF24L01+ radio
> > transceiver.
> > 
> > Signed-off-by: Marcin Ciupak <marcin.s.ciupak@gmail.com>
> > ---
> > Changes in v2:
> >   - add terminating newlines to all logging formats
> > Changes in v3:
> >   - patch subject
> >   - comments cleanup
> >   - goto labels cleanup
> >   - scnprintf bugfix
> >   - ida_simple_remove bugfix
> > Changes in v4:
> >   - fix smatch warnings
> 
> What is preventing this from being merged today with the normal
> subsystem for this type of drivers?  Why does this have to go into
> staging?
> 
> thanks,
> 
> greg k-h

As per TODO file:
+Todo:
+- opening and closing pipes via sysfs
+- improve switching in between RX and TX
+- improve handling of MAX_RT interrupt
+- find and fix bugs
+- code cleanup

Additionally, I would like to add ioctl (or any similar) interface
as configuration via sysfs is not very efficent in here.

My beliefes are that this driver needs some time in staging, but I might
be wrong and if you believe otherwise just let me know and I will try to
push it ti regular sybsystem.

Thanks,
Marcin
