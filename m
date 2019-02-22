Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7506BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 01:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 465AE2077B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 01:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfBVBUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 20:20:24 -0500
Received: from smtprelay0076.hostedemail.com ([216.40.44.76]:49695 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726165AbfBVBUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 20:20:24 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id BF46F180CA851;
        Fri, 22 Feb 2019 01:20:22 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: wind83_3d36879661133
X-Filterd-Recvd-Size: 2046
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Fri, 22 Feb 2019 01:20:20 +0000 (UTC)
Message-ID: <c238a08cfaae0bd09e434edc889b0ecab50aee24.camel@perches.com>
Subject: Re: [PATCH RFC v2 4/4] PCI: hotplug: Add quirk For Dell nvme pcie
 switches
From:   Joe Perches <joe@perches.com>
To:     Alex_Gagniuc@Dellteam.com, lukas@wunner.de, mr.nuke.me@gmail.com
Cc:     bhelgaas@google.com, Austin.Bolen@dell.com, keith.busch@intel.com,
        Shyam.Iyer@dell.com, okaya@kernel.org, linux-pci@vger.kernel.org,
        mika.westerberg@linux.intel.com, okaya@codeaurora.org,
        poza@codeaurora.org, linux-kernel@vger.kernel.org
Date:   Thu, 21 Feb 2019 17:20:19 -0800
In-Reply-To: <027101b4652c4e0c98b86649aa3e4732@ausx13mps321.AMER.DELL.COM>
References: <20190220012031.10741-1-mr.nuke.me@gmail.com>
         <20190220012031.10741-5-mr.nuke.me@gmail.com>
         <20190221075634.uih5ysqwkna7cku4@wunner.de>
         <027101b4652c4e0c98b86649aa3e4732@ausx13mps321.AMER.DELL.COM>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-02-21 at 18:35 +0000, Alex_Gagniuc@Dellteam.com wrote:
> On 2/21/19 1:57 AM, Lukas Wunner wrote:
> > On Tue, Feb 19, 2019 at 07:20:30PM -0600, Alexandru Gagniuc wrote:
> > > --- a/drivers/pci/hotplug/pciehp_hpc.c
> > > 
> > > +}
> > > +
> > > +DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_PLX, 0x9733,
> > 
> > By convention there's no blank line between the closing curly brace
> > and the DECLARE_PCI_FIXUP_CLASS_FINAL().

Not completely true.
See: arch/mips/pci/fixup-loongson3.c

> I'm sorry for all the style issues. I realize it's noise and should just 
> be done right from the beginning. Is there a way to make checkpatch.pl 
> catch these before they go out?

You could write a new rule, but it's non trivial as
there are multiple consecutive uses and multi-line
uses too.

I think it's a rule not worth writing.


