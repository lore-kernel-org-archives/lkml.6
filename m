Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 572D8C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 11:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2608221734
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 11:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfBYLAs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 06:00:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:52870 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726648AbfBYLAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 06:00:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 81730AD2F;
        Mon, 25 Feb 2019 11:00:46 +0000 (UTC)
Date:   Mon, 25 Feb 2019 12:00:43 +0100
From:   Joerg Roedel <jroedel@suse.de>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Dave Young <dyoung@redhat.com>, bhe@redhat.com,
        Jerry Hoemann <jerry.hoemann@hpe.com>, x86@kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pingfan Liu <kernelfans@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, yinghai@kernel.org,
        vgoyal@redhat.com, iommu@lists.linux-foundation.org,
        konrad.wilk@oracle.com
Subject: Re: [PATCHv7] x86/kdump: bugfix, make the behavior of crashkernel=X
 consistent with kaslr
Message-ID: <20190225110043.GA5884@suse.de>
References: <20190206120804.GC10062@dhcp-128-65.nay.redhat.com>
 <20190211204816.GB21473@dhcp-128-65.nay.redhat.com>
 <20190215102458.GD10433@zn.tnic>
 <20190218014820.GA10711@dhcp-128-65.nay.redhat.com>
 <20190220083241.GA3447@zn.tnic>
 <20190220094146.GA8597@dhcp-128-65.nay.redhat.com>
 <20190221171321.GD12997@zn.tnic>
 <20190222021101.GA11654@dhcp-128-65.nay.redhat.com>
 <20190222084241.GC8380@suse.de>
 <20190222130026.GA30766@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190222130026.GA30766@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 02:00:26PM +0100, Borislav Petkov wrote:
> On Fri, Feb 22, 2019 at 09:42:41AM +0100, Joerg Roedel wrote:
> > The current default of 256MB was found by experiments on a bigger
> > number of machines, to create a reasonable default that is at least
> > likely to be sufficient of an average machine.
> 
> Exactly, and this is what makes sense.
> 
> The code should try the requested reservation and if it fails, it should
> try high allocation with default swiotlb size because we need to reserve
> *some* range.

Right, makes sense. While at it, maybe it is time to move the default
allocation policy to 'high' again. The change was reverted six years ago
because it broke old kexec tools, but those are probably out-of-service
now. I think this change would make the whole crashdump allocation
process less fragile.

Regards,

	Joerg

