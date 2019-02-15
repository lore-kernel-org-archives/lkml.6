Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5BA1C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 07:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A22DF2192C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 07:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550216158;
	bh=wrvDthyafpgMx4xB1/UjUawSo+msKKMkFuIt9hJfFEY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=QYvg7j1238MWp/rjyqNW/Zs9p5rSkRYO748dDQWbGskttgyqL9hkpUplBxyDZh4eh
	 rFcH4zlgRjcqe6Dzw6v4tXdyAH8rWm5bsKP5iboE/rDFF0v+G6DaD9zbTUCeJesRyN
	 QRg/OQ3xwj34DXhuA54fPF5OVV6OMclvGoG+1W+g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390036AbfBOHfm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 02:35:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:52520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389982AbfBOHfm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 02:35:42 -0500
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 402BC204FD;
        Fri, 15 Feb 2019 07:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550216138;
        bh=wrvDthyafpgMx4xB1/UjUawSo+msKKMkFuIt9hJfFEY=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=xJnH07r8puCwqAF9AF8RYMLzn1Ic25oqA8piZgwBKt4wXB/2LrKVAarUrTg0wieMe
         z2k0lIvS9fgGndvkQms8Q+0YjpyuiYQ4tQiyUUHMFuVd9EMNphDNYOYKPUv7iMZ9wr
         MTDfPNR90TnegZoigcF4Z8RPoaPKP/HG88NOmFxM=
Date:   Fri, 15 Feb 2019 08:35:23 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     james broadus <jbroadus@gmail.com>
cc:     Kai Heng Feng <kai.heng.feng@canonical.com>,
        Benjamin Tissoires <benjamin.tissoires@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix resume for ELAN2097 touchscreen.
In-Reply-To: <CAKgEEwteam5TCWAUtgQKxQpTzTk3+_DktmqwxZTLa=w3xt5i8Q@mail.gmail.com>
Message-ID: <nycvar.YFH.7.76.1902150834180.11598@cbobk.fhfr.pm>
References: <20190211070040.4569-1-jbroadus@gmail.com> <nycvar.YFH.7.76.1902140036400.11598@cbobk.fhfr.pm> <CAKgEEwteam5TCWAUtgQKxQpTzTk3+_DktmqwxZTLa=w3xt5i8Q@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Feb 2019, james broadus wrote:

> > This should be fixed in hid.git#for-5.1/i2c-hid already by commit
> > 1475af255e18f. Could you please confirm that?
> >
> 
> Hi Jiri. That change mutes the log messages, but I'm still counting 
> around 35000 interrupts per second after resume and touch does not work. 
> With the reset, the device works properly.

Ah, I see. Should your patch then actually replace 1475af255e18f?

Thanks,

-- 
Jiri Kosina
SUSE Labs

