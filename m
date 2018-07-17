Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48736ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 22:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4CD2206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 22:31:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4CD2206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731606AbeGQXFv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 19:05:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:39026 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731292AbeGQXFv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 19:05:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 96DF3AD1A;
        Tue, 17 Jul 2018 22:31:03 +0000 (UTC)
Date:   Tue, 17 Jul 2018 15:30:57 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     akpm@linux-foundation.org, tgraf@suug.ch,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>,
        netdev@vger.kernel.org
Subject: Re: [PATCH] lib/rhashtable: consider param->min_size when setting
 initial table size
Message-ID: <20180717223057.7wdtjwbusxfqpvur@linux-r8p5>
References: <20180714062516.30433-1-dave@stgolabs.net>
 <20180716000046.yscgnpr256qhm2qg@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180716000046.yscgnpr256qhm2qg@gondor.apana.org.au>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jul 2018, Herbert Xu wrote:

>On Fri, Jul 13, 2018 at 11:25:16PM -0700, Davidlohr Bueso wrote:
>> rhashtable_init() currently does not take into account the user-passed
>> min_size parameter unless param->nelem_hint is set as well. As such,
>> the default size (number of buckets) will always be HASH_DEFAULT_SIZE
>> even if the smallest allowed size is larger than that. Remediate this
>> by unconditionally calling into rounded_hashtable_size() and handling
>> things accordingly.
>>
>> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
>
>Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
>
>Normally these patches go through netdev so could you please resend
>it with my ack to netdev@vger.kernel.org?

So I've done the resend, but at least would think that routing the
patch through Andrew would work best as he picked up the rhashtable
changes regarding ipc and this touches the same call.

Thanks,
Davidlohr
