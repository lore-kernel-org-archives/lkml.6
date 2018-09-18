Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 550C8C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 12:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0712021471
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 12:27:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0712021471
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729290AbeIRR7z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 13:59:55 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58744 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728631AbeIRR7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 13:59:55 -0400
Received: from localhost (unknown [147.67.4.98])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 06068C8A;
        Tue, 18 Sep 2018 12:27:32 +0000 (UTC)
Date:   Tue, 18 Sep 2018 14:27:29 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Xavier Deguillard <xdeguillard@vmware.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, linux-mm@kvack.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 00/19] vmw_balloon: compaction, shrinker, 64-bit, etc.
Message-ID: <20180918122729.GA13598@kroah.com>
References: <20180918063853.198332-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180918063853.198332-1-namit@vmware.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 11:38:34PM -0700, Nadav Amit wrote:
> This patch-set adds the following enhancements to the VMware balloon
> driver:
> 
> 1. Balloon compaction support.
> 2. Report the number of inflated/deflated ballooned pages through vmstat.
> 3. Memory shrinker to avoid balloon over-inflation (and OOM).
> 4. Support VMs with memory limit that is greater than 16TB.
> 5. Faster and more aggressive inflation.
> 
> To support compaction we wish to use the existing infrastructure.
> However, we need to make slight adaptions for it. We add a new list
> interface to balloon-compaction, which is more generic and efficient,
> since it does not require as many IRQ save/restore operations. We leave
> the old interface that is used by the virtio balloon.
> 
> Big parts of this patch-set are cleanup and documentation. Patches 1-13
> simplify the balloon code, document its behavior and allow the balloon
> code to run concurrently. The support for concurrency is required for
> compaction and the shrinker interface.
> 
> For documentation we use the kernel-doc format. We are aware that the
> balloon interface is not public, but following the kernel-doc format may
> be useful one day.

kbuild seems to not like this patch series, so I'm going to drop it from
my queue and wait for a v2 respin before looking at it.

thanks,

greg k-h
