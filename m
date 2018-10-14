Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF82C6787C
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 08:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2723320835
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 08:59:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2723320835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbeJNQiV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 12:38:21 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:53674 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbeJNQiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 12:38:21 -0400
Received: from p5492fe24.dip0.t-ipconnect.de ([84.146.254.36] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gBcDm-0000UA-4G; Sun, 14 Oct 2018 10:57:58 +0200
Date:   Sun, 14 Oct 2018 10:57:57 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Christoph Hellwig <hch@lst.de>
cc:     x86@kernel.org, tedheadster@gmail.com, konrad.wilk@oracle.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: enable swiotlb for > 4GiG ram on 32-bit kernels
In-Reply-To: <20181014081443.GA17889@lst.de>
Message-ID: <alpine.DEB.2.21.1810141055440.1438@nanos.tec.linutronix.de>
References: <20181014075208.2715-1-hch@lst.de> <alpine.DEB.2.21.1810141012510.1438@nanos.tec.linutronix.de> <20181014081443.GA17889@lst.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Oct 2018, Christoph Hellwig wrote:

> On Sun, Oct 14, 2018 at 10:13:31AM +0200, Thomas Gleixner wrote:
> > On Sun, 14 Oct 2018, Christoph Hellwig wrote:
> > 
> > > We already build the swiotlb code for 32b-t kernels with PAE support,
> > > but the code to actually use swiotlb has only been enabled for 64-bit
> > > kernel for an unknown reason.
> > > 
> > > Before Linux 4.18 we papers over this fact because the networking code,
> > > the scsi layer and some random block drivers implenented their own
> > > bounce buffering scheme.
> > > 
> > > Fixes: 21e07dba ("scsi: reduce use of block bounce buffers")

Please use the first 12 characters of the commit SHA for fixes tags in the
future, as documented. No need to resend, I fixed it up for you and added a
Cc: stable as well

Thanks,

	tglx
