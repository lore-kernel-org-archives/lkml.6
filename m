Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E46C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 20:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CE5320832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 20:35:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CE5320832
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbeK2HiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 02:38:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:60460 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725799AbeK2HiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 02:38:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 44BE6AC24;
        Wed, 28 Nov 2018 20:35:11 +0000 (UTC)
Date:   Wed, 28 Nov 2018 21:35:10 +0100
From:   Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To:     Christian Zigotzky <chzigotzky@xenosoft.de>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Christoph Hellwig <hch@lst.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: use generic DMA mapping code in powerpc V4
Message-ID: <20181128213510.543259e3@kitsune.suse.cz>
In-Reply-To: <535776df-dea3-eb26-6bf3-83f225e977df@xenosoft.de>
References: <20181114082314.8965-1-hch@lst.de>
        <20181127074253.GB30186@lst.de>
        <87zhttfonk.fsf@concordia.ellerman.id.au>
        <535776df-dea3-eb26-6bf3-83f225e977df@xenosoft.de>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Nov 2018 16:55:30 +0100
Christian Zigotzky <chzigotzky@xenosoft.de> wrote:

> On 28 November 2018 at 12:05PM, Michael Ellerman wrote:
> > Nothing specific yet.
> >
> > I'm a bit worried it might break one of the many old obscure platforms
> > we have that aren't well tested.
> >  
> Please don't apply the new DMA mapping code if you don't be sure if it 
> works on all supported PowerPC machines. Is the new DMA mapping code 
> really necessary? It's not really nice, to rewrote code if the old code 
> works perfect. We must not forget, that we work for the end users. Does 
> the end user have advantages with this new code? Is it faster? The old 
> code works without any problems. 

There is another service provided to the users as well: new code that is
cleaner and simpler which allows easier bug fixes and new features.
Without being familiar with the DMA mapping code I cannot really say if
that's the case here.

> I am also worried about this code. How 
> can I test this new DMA mapping code?

I suppose if your machine works it works for you.

Thanks

Michal
