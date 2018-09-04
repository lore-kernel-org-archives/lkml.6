Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE3B7C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 13:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6488F20659
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 13:26:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6488F20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbeIDRvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 13:51:47 -0400
Received: from verein.lst.de ([213.95.11.211]:40801 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726208AbeIDRvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 13:51:47 -0400
Received: by newverein.lst.de (Postfix, from userid 2005)
        id C438168D40; Tue,  4 Sep 2018 15:30:06 +0200 (CEST)
Date:   Tue, 4 Sep 2018 15:30:06 +0200
From:   Torsten Duwe <duwe@lst.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     herbert@gondor.apana.org.au, Jeff.Lien@wdc.com,
        ard.biesheuvel@linaro.org, david.darrington@wdc.com,
        hch@infradead.org, jeff.furlong@wdc.com,
        linux-block@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        tim.c.chen@linux.intel.com
Subject: Re: [PATCH v2 1/3] crypto: Introduce notifier for new crypto
 algorithms
Message-ID: <20180904133006.GA28715@lst.de>
References: <20180827060918.tfz7ljufqhlej4kq@gondor.apana.org.au> <20180830150016.15661-1-martin.petersen@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180830150016.15661-1-martin.petersen@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 11:00:14AM -0400, Martin K. Petersen wrote:
> Introduce a facility that can be used to receive a notification
> callback when a new algorithm becomes available. This can be used by
> existing crypto registrations to trigger a switch from a software-only
> algorithm to a hardware-accelerated version.

While this is apparently fine with the patch set you sent, what about
cases where the crypto context of old and new implementation is not
100% compatible? The switch will still work for sure if there are no
current active users of the algo, but otherwise...? Just a thought.

	Torsten

