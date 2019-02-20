Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F10CCC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C71652089F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:46:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbfBTJqo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 04:46:44 -0500
Received: from mgwym02.jp.fujitsu.com ([211.128.242.41]:47453 "EHLO
        mgwym02.jp.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfBTJqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 04:46:44 -0500
Received: from yto-m1.gw.nic.fujitsu.com (unknown [192.168.229.100]) by mgwym02.jp.fujitsu.com with smtp
         id 2552_f23a_0aec060d_4551_4ae7_a4e5_e5f45beb343e;
        Wed, 20 Feb 2019 18:46:36 +0900
Received: from g01jpfmpwkw02.exch.g01.fujitsu.local (g01jpfmpwkw02.exch.g01.fujitsu.local [10.0.193.56])
        by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id BB29E40C7D21
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 18:46:35 +0900 (JST)
Received: from G01JPEXCHKW17.g01.fujitsu.local (G01JPEXCHKW17.g01.fujitsu.local [10.0.194.56])
        by g01jpfmpwkw02.exch.g01.fujitsu.local (Postfix) with ESMTP id 57033328708;
        Wed, 20 Feb 2019 18:46:34 +0900 (JST)
Received: from localhost (10.17.204.234) by G01JPEXCHKW17.g01.fujitsu.local
 (10.0.194.56) with Microsoft SMTP Server id 14.3.408.0; Wed, 20 Feb 2019
 18:46:33 +0900
X-SecurityPolicyCheck: OK by SHieldMailChecker v2.5.2
X-SHieldMailCheckerPolicyVersion: FJ-ISEC-20170217-enc
X-SHieldMailCheckerMailID: f6fcba2ed9eb4e9bb20547a14cb14f60
Date:   Wed, 20 Feb 2019 18:46:11 +0900
From:   Takao Indoh <indou.takao@fujitsu.com>
To:     "Elliott, Robert (Persistent Memory)" <elliott@hpe.com>
CC:     Keith Busch <keith.busch@intel.com>,
        Takao Indoh <indou.takao@jp.fujitsu.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH] nvme: Enable acceleration feature of A64FX processor
Message-ID: <20190220094610.GB3559@esprimo>
References: <20190201124615.16107-1-indou.takao@jp.fujitsu.com>
 <20190201145414.GA22199@localhost.localdomain>
 <20190205124757.GA28465@esprimo>
 <20190205143905.GG22199@localhost.localdomain>
 <AT5PR8401MB1169E9738C0A4754D0190F2FAB670@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <AT5PR8401MB1169E9738C0A4754D0190F2FAB670@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SecurityPolicyCheck-GC: OK by FENCE-Mail
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 08:44:48PM +0000, Elliott, Robert (Persistent Memory) wrote:
> 
> 
> > -----Original Message-----
> > From: Linux-nvme [mailto:linux-nvme-bounces@lists.infradead.org] On Behalf Of Keith Busch
> > Sent: Tuesday, February 5, 2019 8:39 AM
> > To: Takao Indoh <indou.takao@fujitsu.com>
> > Cc: Takao Indoh <indou.takao@jp.fujitsu.com>; sagi@grimberg.me; linux-kernel@vger.kernel.org; linux-
> > nvme@lists.infradead.org; axboe@fb.com; hch@lst.de
> > Subject: Re: [PATCH] nvme: Enable acceleration feature of A64FX processor
> > 
> > On Tue, Feb 05, 2019 at 09:56:05PM +0900, Takao Indoh wrote:
> > > On Fri, Feb 01, 2019 at 07:54:14AM -0700, Keith Busch wrote:
> > > > On Fri, Feb 01, 2019 at 09:46:15PM +0900, Takao Indoh wrote:
> > > > > From: Takao Indoh <indou.takao@fujitsu.com>
> > > > >
> > > > > Fujitsu A64FX processor has a feature to accelerate data transfer of
> > > > > internal bus by relaxed ordering. It is enabled when the bit 56 of dma
> > > > > address is set to 1.
> > > >
> > > > Wait, what? RO is a standard PCIe TLP attribute. Why would we need this?
> > >
> > > I should have explained this patch more carefully.
> > >
> > > Standard PCIe devices can use Relaxed Ordering (RO) by setting Attr
> > > field in the TLP header, however, this mechanism cannot be utilized if
> > > the device does not support RO feature. Fujitsu A64FX processor has an
> > > alternate feature to enable RO in its Root Port by setting the bit 56 of
> > > DMA address. This mechanism enables to utilize RO feature even if the
> > > device does not support standard PCIe RO.
> > 
> > I think you're better of just purchasing devices that support the
> > capability per spec rather than with a non-standard work around.
> > 
> 
> The PCIe and NVMe specifications dosn't standardize a way to tell the device
> when to use RO, which leads to system workarounds like this.
> 
> The Enable Relaxed Ordering bit defined by PCIe tells the device when it
> cannot use RO, but doesn't advise when it should or shall use RO.
> 
> For SCSI Express (SOP+PQI), we were going to allow specifying these
> on a per-command basis:
> * TLP attributes (No Snoop, Relaxed Ordering, ID-based Ordering)
> * TLP processing hints (Processing Hints and Steering Tags)
> 
> to be used by the data transfers for the command. In some systems, one
> setting per queue or per device might suffice. Transactions to the
> queues and doorbells require stronger ordering.
> 
> For this workaround:
> * making an extra pass through the SGL to set the address bit is 
> inefficient; it should be done as the SGL is created.

Thanks for your comment, do you mean this should be done in
nvme_pci_setup_sgls()/nvme_pci_setup_prps()?

> * why doesn't it support PRP Lists?

This patch does not support PRP because PRP is used for small data and
we cannot get enough performance improvement by this feature. But I can
support PRP to improve performance of the device which is compliant with
NVMe Spec 1.0 or does not support SGL.

> * how does this interact with an iommu, if there is one? Must the 
> address with bit 56 also be granted permission, or is that
> stripped off before any iommu comparisons?

The latter. A bit 56 is cleared in Root Port before pass it to iommu.

Thanks,
Takao Indoh
