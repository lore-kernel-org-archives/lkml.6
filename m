Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66482ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1709A208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:37:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1709A208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbeIXRiw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 13:38:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:60750 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728432AbeIXRiv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 13:38:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C95BAAD33;
        Mon, 24 Sep 2018 11:37:11 +0000 (UTC)
Message-ID: <1537788518.22022.6.camel@suse.com>
Subject: Re: [PATCH] usb: cdc_acm: Do not leak URB buffers
From:   Oliver Neukum <oneukum@suse.com>
To:     Romain Izard <romain.izard.pro@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Date:   Mon, 24 Sep 2018 13:28:38 +0200
In-Reply-To: <20180920144904.24911-1-romain.izard.pro@gmail.com>
References: <20180920144904.24911-1-romain.izard.pro@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Do, 2018-09-20 at 16:49 +0200, Romain Izard wrote:
> When the ACM TTY port is disconnected, the URBs it uses must be killed, and
> then the buffers must be freed. Unfortunately a previous refactor removed
> the code freeing the buffers because it looked extremely similar to the
> code killing the URBs.
> 
> As a result, there were many new leaks for each plug/unplug cycle of a
> CDC-ACM device, that were detected by kmemleak.
> 
> Restore the missing code, and the memory leak is removed.
> 
> Fixes: ba8c931ded8d ("cdc-acm: refactor killing urbs")
> Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
Acked-by: Oliver Neukum <oneukum@suse.com>
