Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C47C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA71720855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:52:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA71720855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbeIJOpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 10:45:49 -0400
Received: from emh03.mail.saunalahti.fi ([62.142.5.109]:52536 "EHLO
        emh03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727714AbeIJOpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 10:45:49 -0400
Received: from ydin.reaktio.net (reaktio.net [85.76.255.15])
        by emh03.mail.saunalahti.fi (Postfix) with ESMTP id 2846C400D7;
        Mon, 10 Sep 2018 12:52:32 +0300 (EEST)
Received: by ydin.reaktio.net (Postfix, from userid 1001)
        id BE5AC36C0F6; Mon, 10 Sep 2018 12:52:31 +0300 (EEST)
Date:   Mon, 10 Sep 2018 12:52:31 +0300
From:   Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>
To:     Sinan Kaya <okaya@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <helgaas@kernel.org>, jgross@suse.com,
        Sinan Kaya <okaya@codeaurora.org>,
        Govinda Tatti <Govinda.Tatti@Oracle.COM>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Satanand Burla <satananda.burla@caviumnetworks.com>,
        linux-pci@vger.kernel.org,
        Felix Manlunas <felix.manlunas@caviumnetworks.com>,
        linux-kernel@vger.kernel.org,
        Derek Chickles <derek.chickles@caviumnetworks.com>,
        Srikanth Jampala <Jampala.Srikanth@cavium.com>,
        JBeulich@suse.com, Russell Currey <ruscur@russell.cc>,
        bhelgaas@google.com, xen-devel@lists.xenproject.org,
        boris.ostrovsky@Oracle.COM,
        Raghu Vatsavayi <raghu.vatsavayi@caviumnetworks.com>,
        roger.pau@citrix.com
Subject: Re: [Xen-devel] [PATCH V3 1/2] Drivers/PCI: Export pcie_has_flr()
 interface
Message-ID: <20180910095231.GD18222@reaktio.net>
References: <20171208202424.GC12367@bhelgaas-glaptop.roam.corp.google.com>
 <426eeeab-0dcd-8de3-9c5f-a166acf2c130@Oracle.COM>
 <20171212005919.GB30595@bhelgaas-glaptop.roam.corp.google.com>
 <49956aaf-5fd5-939d-5fc7-231ffdb98b70@Oracle.COM>
 <20171213212420.GH30595@bhelgaas-glaptop.roam.corp.google.com>
 <fea075cf-fe6f-0d0b-11e4-4279fbfc280a@Oracle.COM>
 <20171215181801.GU30595@bhelgaas-glaptop.roam.corp.google.com>
 <20171218122629.GA18423@infradead.org>
 <20180909185944.GC18222@reaktio.net>
 <9ffe43d2-a44b-974c-85c9-9923d71c5dba@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9ffe43d2-a44b-974c-85c9-9923d71c5dba@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Sep 09, 2018 at 10:33:02PM -0400, Sinan Kaya wrote:
> On 9/9/2018 2:59 PM, Pasi Kärkkäinen wrote:
> >I noticed pcie_has_flr() has been recently exported in upstream Linux:
> >https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2d2917f7747805a1f4188672f308d82a8ba01700
> >
> >Are there more changes / cleanups planned to these interfaces, as mentioned last year?
> >
> >(context: xen-pciback reset/do_flr features upstreaming, which kind of stalled last year when pcie_has_flr() wasn't exported at the time)
> 
> Exporting pcie_has_flr() is a very simple change which could have been done
> by the XEN porting effort.
> 
> Maybe, the right question is what is so special about XEN reset?
> 
> What feature PCI core is missing to support XEN FLR reset that caused
> the effort to stall?
>

Well one of the reasons probably was because Christoph was planning to deprecate the pcie_has_flr() functionality..

https://lists.xen.org/archives/html/xen-devel/2017-12/msg01057.html
https://lists.xen.org/archives/html/xen-devel/2017-12/msg01252.html

But now that pcie_has_flr() is exported and available I guess it's fine to continue using it also for xen-pciback :)


Thanks,

-- Pasi

