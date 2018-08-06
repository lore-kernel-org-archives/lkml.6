Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF951C46470
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 01:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8366F21991
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 01:28:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8366F21991
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbeHFDec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 23:34:32 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10632 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726988AbeHFDeb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 23:34:31 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 3D9CA9C30C387;
        Mon,  6 Aug 2018 09:27:48 +0800 (CST)
Received: from localhost (10.67.212.75) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server (TLS) id 14.3.399.0; Mon, 6 Aug 2018
 09:27:43 +0800
Date:   Mon, 6 Aug 2018 09:26:22 +0800
From:   Kenneth Lee <liguozhu@hisilicon.com>
To:     Alan Cox <gnomes@lxorguk.ukuu.org.uk>
CC:     Jerome Glisse <jglisse@redhat.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Kenneth Lee <nek.in.cn@gmail.com>,
        Hao Fang <fanghao11@huawei.com>,
        "Herbert Xu" <herbert@gondor.apana.org.au>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "Philippe Ombredanne" <pombredanne@nexb.com>,
        Zaibo Xu <xuzaibo@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Ross Zwisler <ross.zwisler@linux.intel.com>
Subject: Re: [RFC PATCH 0/7] A General Accelerator Framework, WarpDrive
Message-ID: <20180806012622.GE91035@Turing-Arch-b>
References: <20180801102221.5308-1-nek.in.cn@gmail.com>
 <20180801165644.GA3820@redhat.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D191290E1A@SHSMSX101.ccr.corp.intel.com>
 <20180802111000.4649d9ed@alans-desktop>
 <20180802144627.GB3481@redhat.com>
 <20180803152043.40f88947@alans-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180803152043.40f88947@alans-desktop>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 03, 2018 at 03:20:43PM +0100, Alan Cox wrote:
> Date: Fri, 3 Aug 2018 15:20:43 +0100
> From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
> To: Jerome Glisse <jglisse@redhat.com>
> CC: "Tian, Kevin" <kevin.tian@intel.com>, Kenneth Lee
>  <nek.in.cn@gmail.com>, Hao Fang <fanghao11@huawei.com>, Herbert Xu
>  <herbert@gondor.apana.org.au>, "kvm@vger.kernel.org"
>  <kvm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Greg
>  Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-doc@vger.kernel.org"
>  <linux-doc@vger.kernel.org>, "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
>  "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
>  "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
>  "linuxarm@huawei.com" <linuxarm@huawei.com>, Alex Williamson
>  <alex.williamson@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
>  "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, Philippe
>  Ombredanne <pombredanne@nexb.com>, Zaibo Xu <xuzaibo@huawei.com>, Kenneth
>  Lee <liguozhu@hisilicon.com>, "David S . Miller" <davem@davemloft.net>,
>  Ross Zwisler <ross.zwisler@linux.intel.com>
> Subject: Re: [RFC PATCH 0/7] A General Accelerator Framework, WarpDrive
> Organization: Intel Corporation
> X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
> Message-ID: <20180803152043.40f88947@alans-desktop>
> 
> > If we are going to have any kind of general purpose accelerator API then
> > > it has to be able to implement things like  
> > 
> > Why is the existing driver model not good enough ? So you want
> > a device with function X you look into /dev/X (for instance
> > for GPU you look in /dev/dri)
> 
> Except when my GPU is in an FPGA in which case it might be somewhere else
> or it's a general purpose accelerator that happens to be usable as a GPU.
> Unusual today in big computer space but you'll find it in
> microcontrollers.
> 
> > Each of those device need a userspace driver and thus this
> > user space driver can easily knows where to look. I do not
> > expect that every application will reimplement those drivers
> > but instead use some kind of library that provide a high
> > level API for each of those devices.
> 
> Think about it from the user level. You have a pipeline of things you
> wish to execute, you need to get the right accelerator combinations and
> they need to fit together to meet system constraints like number of
> IOMMU ids the accelerator supports, where they are connected.
> 
> > Now you have a hierarchy of memory for the CPU (HBM, local
> > node main memory aka you DDR dimm, persistent memory) each
> 
> It's not a heirarchy, it's a graph. There's no fundamental reason two
> accelerators can't be close to two different CPU cores but have shared
> HBM that is far from each processor. There are physical reasons it tends
> to look more like a heirarchy today.
> 
> > Anyway i think finding devices and finding relation between
> > devices and memory is 2 separate problems and as such should
> > be handled separatly.
> 
> At a certain level they are deeply intertwined because you need a common
> API. It's not good if I want a particular accelerator and need to then
> see which API its under on this machine and which interface I have to
> use, and maybe have a mix of FPGA, WarpDrive and Google ASIC interfaces
> all different.
> 
> The job of the kernel is to impose some kind of sanity and unity on this
> lot.
> 
> All of it in the end comes down to
> 
> 'Somehow glue some chunk of memory into my address space and find any
> supporting driver I need'
> 

Agree. This is also our intension on WarpDrive. And it looks VFIO is the best
place to fulfill this requirement.

> plus virtualization of the above.
> 
> That bit's easy - but making it usable is a different story.
> 
> Alan

-- 
			-Kenneth(Hisilicon)

================================================================================
本邮件及其附件含有华为公司的保密信息，仅限于发送给上面地址中列出的个人或群组。禁
止任何其他人以任何形式使用（包括但不限于全部或部分地泄露、复制、或散发）本邮件中
的信息。如果您错收了本邮件，请您立即电话或邮件通知发件人并删除本邮件！
This e-mail and its attachments contain confidential information from HUAWEI,
which is intended only for the person or entity whose address is listed above.
Any use of the 
information contained herein in any way (including, but not limited to, total or
partial disclosure, reproduction, or dissemination) by persons other than the
intended 
recipient(s) is prohibited. If you receive this e-mail in error, please notify
the sender by phone or email immediately and delete it!

