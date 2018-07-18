Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C3FECDFB4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 01:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FFF32075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 01:58:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FFF32075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731524AbeGRCdm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 22:33:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:43198 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731232AbeGRCdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 22:33:41 -0400
Received: from localhost.localdomain (c-24-4-125-7.hsd1.ca.comcast.net [24.4.125.7])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B1A66BD1;
        Wed, 18 Jul 2018 01:58:16 +0000 (UTC)
Date:   Tue, 17 Jul 2018 18:58:15 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>, tgraf@suug.ch,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>,
        netdev@vger.kernel.org
Subject: Re: [PATCH] lib/rhashtable: consider param->min_size when setting
 initial table size
Message-Id: <20180717185815.20e5662318274aadcf9a9357@linux-foundation.org>
In-Reply-To: <20180717223057.7wdtjwbusxfqpvur@linux-r8p5>
References: <20180714062516.30433-1-dave@stgolabs.net>
        <20180716000046.yscgnpr256qhm2qg@gondor.apana.org.au>
        <20180717223057.7wdtjwbusxfqpvur@linux-r8p5>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Jul 2018 15:30:57 -0700 Davidlohr Bueso <dave@stgolabs.net> wrote:

> On Mon, 16 Jul 2018, Herbert Xu wrote:
> 
> >On Fri, Jul 13, 2018 at 11:25:16PM -0700, Davidlohr Bueso wrote:
> >> rhashtable_init() currently does not take into account the user-passed
> >> min_size parameter unless param->nelem_hint is set as well. As such,
> >> the default size (number of buckets) will always be HASH_DEFAULT_SIZE
> >> even if the smallest allowed size is larger than that. Remediate this
> >> by unconditionally calling into rounded_hashtable_size() and handling
> >> things accordingly.
> >>
> >> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
> >
> >Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
> >
> >Normally these patches go through netdev so could you please resend
> >it with my ack to netdev@vger.kernel.org?
> 
> So I've done the resend, but at least would think that routing the
> patch through Andrew would work best as he picked up the rhashtable
> changes regarding ipc and this touches the same call.
> 

Either approach works.

Reviewed-by: Andrew Morton <akpm@linux-foundation.org>

