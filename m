Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754898AbeD3Sor (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 14:44:47 -0400
Received: from mga06.intel.com ([134.134.136.31]:56304 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752994AbeD3Soq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 14:44:46 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,348,1520924400";
   d="scan'208";a="47226616"
Date: Mon, 30 Apr 2018 11:43:47 -0700
From: Dongwon Kim <dongwon.kim@intel.com>
To: Juergen Gross <jgross@suse.com>
Cc: Oleksandr Andrushchenko <andr2000@gmail.com>,
        Wei Liu <wei.liu2@citrix.com>, Artem Mygaiev <Artem_Mygaiev@epam.com>,
        konrad.wilk@oracle.com, airlied@linux.ie, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        "Potrola, MateuszX" <mateuszx.potrola@intel.com>,
        daniel.vetter@intel.com, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com,
        Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
        "Oleksandr_Andrushchenko@epam.com" <Oleksandr_Andrushchenko@epam.com>
Subject: Re: [Xen-devel] [PATCH 0/1] drm/xen-zcopy: Add Xen zero-copy helper
 DRM driver
Message-ID: <20180430184347.GA20292@downor-Z87X-UD5H>
References: <ebcbf6ce-1d7a-5f3e-cff8-546d1c010e59@gmail.com>
 <20180418101058.hyqk3gr3b2ibxswu@MacBook-Pro-de-Roger.local>
 <20180420071914.GG31310@phenom.ffwll.local>
 <76cdc65a-7bb1-9377-7bc5-6164e32f7b5d@gmail.com>
 <20180423115242.ywdwqblj2aseu3fr@citrix.com>
 <61105351-8896-072b-abf0-757c7f6c0edf@gmail.com>
 <20180424115437.GT31310@phenom.ffwll.local>
 <18ab5f76-00b0-42a0-fcb8-e0cbf4cdd527@gmail.com>
 <20180424203514.GA26787@downor-Z87X-UD5H>
 <bdeeb76f-ea65-083b-dde4-450584edb068@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdeeb76f-ea65-083b-dde4-450584edb068@suse.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 25, 2018 at 08:12:08AM +0200, Juergen Gross wrote:
> On 24/04/18 22:35, Dongwon Kim wrote:
> > Had a meeting with Daniel and talked about bringing out generic
> > part of hyper-dmabuf to the userspace, which means we most likely
> > reuse IOCTLs defined in xen-zcopy for our use-case if we follow
> > his suggestion.
> > 
> > So assuming we use these IOCTLs as they are,
> > Several things I would like you to double-check..
> > 
> > 1. returning gref as is to the user space is still unsafe because
> > it is a constant, easy to guess and any process that hijacks it can easily
> > exploit the buffer. So I am wondering if it's possible to keep dmabuf-to
> > -gref or gref-to-dmabuf in kernel space and add other layers on top
> > of those in actual IOCTLs to add some safety.. We introduced flink like
> > hyper_dmabuf_id including random number but many says even that is still
> > not safe.
> 
> grefs are usable by root only. When you have root access in dom0 you can
> do evil things to all VMs even without using grants. That is in no way
> different to root being able to control all other processes on the
> system.

I honestly didn't know about this. I believed kernel code simply can map those
pages. However, out of curiosity, how is non-root usage of gref prevented in
current design? Is there privilege check in grant table driver or hypercalls
needed by this page mapping is only enabled for root in hypervisor level?

And this is pretty critical information for any use-case using grant-table.
Is there any place(doc/website) this is specified/explained?

Thanks,
DW


> 
> 
> Juergen
