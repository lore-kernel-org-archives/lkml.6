Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9DFBC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A15302080A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733010AbfBMMEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 07:04:21 -0500
Received: from mgwkm03.jp.fujitsu.com ([202.219.69.170]:12696 "EHLO
        mgwkm03.jp.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728015AbfBMMEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 07:04:20 -0500
Received: from kw-mxauth.gw.nic.fujitsu.com (unknown [192.168.231.132]) by mgwkm03.jp.fujitsu.com with smtp
         id 0cfa_a3df_d945260a_7030_4754_9494_9d6dc70b2112;
        Wed, 13 Feb 2019 21:04:13 +0900
Received: from g01jpfmpwkw02.exch.g01.fujitsu.local (g01jpfmpwkw02.exch.g01.fujitsu.local [10.0.193.56])
        by kw-mxauth.gw.nic.fujitsu.com (Postfix) with ESMTP id 84F74AC011D
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 21:04:12 +0900 (JST)
Received: from g01jpexchkw33.g01.fujitsu.local (unknown [10.0.193.4])
        by g01jpfmpwkw02.exch.g01.fujitsu.local (Postfix) with ESMTP id 4A3B9328701;
        Wed, 13 Feb 2019 21:04:11 +0900 (JST)
Received: from localhost (10.17.204.234) by g01jpexchkw33.g01.fujitsu.local
 (10.0.193.36) with Microsoft SMTP Server id 14.3.408.0; Wed, 13 Feb 2019
 21:04:11 +0900
X-SecurityPolicyCheck: OK by SHieldMailChecker v2.5.2
X-SHieldMailCheckerPolicyVersion: FJ-ISEC-20170217-enc
X-SHieldMailCheckerMailID: f8d45dfa1c5d4dbcafffd1e55cc164d4
Date:   Wed, 13 Feb 2019 21:03:58 +0900
From:   Takao Indoh <indou.takao@fujitsu.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Keith Busch <keith.busch@intel.com>,
        Takao Indoh <indou.takao@jp.fujitsu.com>, <axboe@fb.com>,
        <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvme: Enable acceleration feature of A64FX processor
Message-ID: <20190213120358.GA3559@esprimo>
References: <20190201124615.16107-1-indou.takao@jp.fujitsu.com>
 <20190201145414.GA22199@localhost.localdomain>
 <20190205124757.GA28465@esprimo>
 <20190205143905.GG22199@localhost.localdomain>
 <20190205161347.GA847@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190205161347.GA847@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SecurityPolicyCheck-GC: OK by FENCE-Mail
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2019 at 05:13:47PM +0100, Christoph Hellwig wrote:
> On Tue, Feb 05, 2019 at 07:39:06AM -0700, Keith Busch wrote:
> > > Standard PCIe devices can use Relaxed Ordering (RO) by setting Attr
> > > field in the TLP header, however, this mechanism cannot be utilized if
> > > the device does not support RO feature. Fujitsu A64FX processor has an
> > > alternate feature to enable RO in its Root Port by setting the bit 56 of
> > > DMA address. This mechanism enables to utilize RO feature even if the
> > > device does not support standard PCIe RO.
> > 
> > I think you're better of just purchasing devices that support the
> > capability per spec rather than with a non-standard work around.
> 
> Agreed, this seems like a pretty gross hack.

Ok, let me think about how I should change this patch.
I'm thinking that the problem of this patch is adding processor specific
code into NVMe common driver, is this correct? Or another problem? It
would be great if you could give me a hint to improve this patch.

Thanks,
Takao Indoh

