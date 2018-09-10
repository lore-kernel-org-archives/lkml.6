Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9BFFC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 02:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 601342086E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 02:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="S47ZWRVz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 601342086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbeIJHYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 03:24:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:46554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725957AbeIJHYq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 03:24:46 -0400
Received: from [192.168.0.114] (cpe-174-109-247-98.nc.res.rr.com [174.109.247.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 697942064D;
        Mon, 10 Sep 2018 02:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536546785;
        bh=NLtty7/keRJEJUYasZGGMYQwHXP91V4W0rp+Y9Qvo8Y=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=S47ZWRVzYZysuapUO1yS94F69SjN8S/o3LWqAQzehljCf0wNAgDMXnblOdZvB5UO9
         UR+hLAvG3Tqj/1pWlku5xJJuUVV6eSof6whnN2c5WoRBfpqYgcyPqJCttM7sSb+7d/
         nl7QlcGqzwCE6zW9Ly1DDJ6uTBxvRD0dGMcdR7EU=
Subject: Re: [Xen-devel] [PATCH V3 1/2] Drivers/PCI: Export pcie_has_flr()
 interface
To:     =?UTF-8?B?UGFzaSBLw6Rya2vDpGluZW4=?= <pasik@iki.fi>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, jgross@suse.com,
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
References: <20171207222145.9769-1-Govinda.Tatti@Oracle.COM>
 <20171207222145.9769-2-Govinda.Tatti@Oracle.COM>
 <20171208202424.GC12367@bhelgaas-glaptop.roam.corp.google.com>
 <426eeeab-0dcd-8de3-9c5f-a166acf2c130@Oracle.COM>
 <20171212005919.GB30595@bhelgaas-glaptop.roam.corp.google.com>
 <49956aaf-5fd5-939d-5fc7-231ffdb98b70@Oracle.COM>
 <20171213212420.GH30595@bhelgaas-glaptop.roam.corp.google.com>
 <fea075cf-fe6f-0d0b-11e4-4279fbfc280a@Oracle.COM>
 <20171215181801.GU30595@bhelgaas-glaptop.roam.corp.google.com>
 <20171218122629.GA18423@infradead.org> <20180909185944.GC18222@reaktio.net>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <9ffe43d2-a44b-974c-85c9-9923d71c5dba@kernel.org>
Date:   Sun, 9 Sep 2018 22:33:02 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180909185944.GC18222@reaktio.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/9/2018 2:59 PM, Pasi Kärkkäinen wrote:
> I noticed pcie_has_flr() has been recently exported in upstream Linux:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2d2917f7747805a1f4188672f308d82a8ba01700
> 
> Are there more changes / cleanups planned to these interfaces, as mentioned last year?
> 
> (context: xen-pciback reset/do_flr features upstreaming, which kind of stalled last year when pcie_has_flr() wasn't exported at the time)

Exporting pcie_has_flr() is a very simple change which could have been done
by the XEN porting effort.

Maybe, the right question is what is so special about XEN reset?

What feature PCI core is missing to support XEN FLR reset that caused
the effort to stall?
