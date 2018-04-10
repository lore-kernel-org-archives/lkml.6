Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752076AbeDJDXm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 23:23:42 -0400
Received: from mga09.intel.com ([134.134.136.24]:5724 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751629AbeDJDXl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 23:23:41 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,430,1517904000";
   d="scan'208";a="46535620"
Date: Tue, 10 Apr 2018 11:21:34 +0800
From: Tiwei Bie <tiwei.bie@intel.com>
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, wexu@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        jfreimann@redhat.com
Subject: Re: [RFC v2] virtio: support packed ring
Message-ID: <20180410032134.qco4ut2s3lo2zgsc@debian>
References: <20180401141216.8969-1-tiwei.bie@intel.com>
 <5cf4d5d6-c416-28af-0568-750e9f654710@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5cf4d5d6-c416-28af-0568-750e9f654710@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2018 at 10:55:25AM +0800, Jason Wang wrote:
> On 2018年04月01日 22:12, Tiwei Bie wrote:
> > Hello everyone,
> > 
> > This RFC implements packed ring support for virtio driver.
> > 
> > The code was tested with DPDK vhost (testpmd/vhost-PMD) implemented
> > by Jens at http://dpdk.org/ml/archives/dev/2018-January/089417.html
> > Minor changes are needed for the vhost code, e.g. to kick the guest.
> > 
> > TODO:
> > - Refinements and bug fixes;
> > - Split into small patches;
> > - Test indirect descriptor support;
> > - Test/fix event suppression support;
> > - Test devices other than net;
> > 
> > RFC v1 -> RFC v2:
> > - Add indirect descriptor support - compile test only;
> > - Add event suppression supprt - compile test only;
> > - Move vring_packed_init() out of uapi (Jason, MST);
> > - Merge two loops into one in virtqueue_add_packed() (Jason);
> > - Split vring_unmap_one() for packed ring and split ring (Jason);
> > - Avoid using '%' operator (Jason);
> > - Rename free_head -> next_avail_idx (Jason);
> > - Add comments for virtio_wmb() in virtqueue_add_packed() (Jason);
> > - Some other refinements and bug fixes;
> > 
> > Thanks!
> 
> Will try to review this later.
> 
> But it would be better if you can split it (more than 1000 lines is too big
> to be reviewed easily). E.g you can at least split it into three patches,
> new structures, datapath, and event suppression.
> 

No problem! It's on my TODO list. I'll get it done in the next version.

Thanks!
