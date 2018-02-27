Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752807AbeB0MDf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 07:03:35 -0500
Received: from mga18.intel.com ([134.134.136.126]:35592 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752130AbeB0MDe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 07:03:34 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,400,1515484800";
   d="scan'208";a="37803009"
Date: Tue, 27 Feb 2018 20:01:59 +0800
From: Tiwei Bie <tiwei.bie@intel.com>
To: Jens Freimann <jfreimann@redhat.com>
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        jasowang@redhat.com, wexu@redhat.com
Subject: Re: [PATCH RFC 1/2] virtio: introduce packed ring defines
Message-ID: <20180227120159.g47rtazm3uhoht6f@debian>
References: <20180223111801.15240-1-tiwei.bie@intel.com>
 <20180223111801.15240-2-tiwei.bie@intel.com>
 <20180227085458.h5dytkwaeczrrijr@dhcp-192-241.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180227085458.h5dytkwaeczrrijr@dhcp-192-241.str.redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 27, 2018 at 09:54:58AM +0100, Jens Freimann wrote:
> On Fri, Feb 23, 2018 at 07:18:00PM +0800, Tiwei Bie wrote:
[...]
> > 
> > +struct vring_packed_desc_event {
> > +	/* Descriptor Event Offset */
> > +	__virtio16 desc_event_off   : 15,
> > +	/* Descriptor Event Wrap Counter */
> > +		   desc_event_wrap  : 1;
> > +	/* Descriptor Event Flags */
> > +	__virtio16 desc_event_flags : 2;
> > +};
> 
> Where would the virtqueue number go in driver notifications?

This structure is for event suppression instead of notification.

You could refer to the "Event Suppression Structure Format"
section of the spec for more details:

https://github.com/oasis-tcs/virtio-docs/blob/master/virtio-v1.1-packed-wd08.pdf

Best regards,
Tiwei Bie
