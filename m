Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F771C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 20:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6734921019
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 20:32:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6734921019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbeK3HjS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 02:39:18 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:39596 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbeK3HjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 02:39:17 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CE13888D;
        Thu, 29 Nov 2018 20:32:37 +0000 (UTC)
Date:   Thu, 29 Nov 2018 12:32:36 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Dave Rodgman <dave.rodgman@arm.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Matt Sealey <Matt.Sealey@arm.com>,
        "nitingupta910@gmail.com" <nitingupta910@gmail.com>,
        "rpurdie@openedhand.com" <rpurdie@openedhand.com>,
        "markus@oberhumer.com" <markus@oberhumer.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "sonnyrao@google.com" <sonnyrao@google.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 7/7] lib/lzo: separate lzo-rle from lzo
Message-Id: <20181129123236.8e31034663cd391bf9c24c3e@linux-foundation.org>
In-Reply-To: <293c53a6-3313-359a-c5d0-2e2fa453494a@arm.com>
References: <20181127161913.23863-1-dave.rodgman@arm.com>
        <20181127161913.23863-8-dave.rodgman@arm.com>
        <20181129044333.GH6379@jagdpanzerIV>
        <293c53a6-3313-359a-c5d0-2e2fa453494a@arm.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Nov 2018 10:21:53 +0000 Dave Rodgman <dave.rodgman@arm.com> wrote:

> >> @@ -41,7 +41,7 @@ static DEFINE_IDR(zram_index_idr);
> >>   static DEFINE_MUTEX(zram_index_mutex);
> >>   
> >>   static int zram_major;
> >> -static const char *default_compressor = "lzo";
> >> +static const char *default_compressor = "lzo-rle";
> > 
> > OK, so it's not just "separate lzo-rle", it's also "switch zram to
> > a new compression algorithm by default". I'd say that usually I'd
> > expect this to be separate patches.
> 
> Yes, fair point. akpm has picked this up now though, so probably a bit 
> late to break it out into a separate patch?

That's fine.  akpm is flexible ;)  Whatever produces the best overall
result in the permanent record, please.

