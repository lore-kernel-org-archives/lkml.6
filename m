Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752284AbeB0LdP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 06:33:15 -0500
Received: from mga05.intel.com ([192.55.52.43]:64718 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751093AbeB0LdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 06:33:13 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,400,1515484800";
   d="scan'208";a="33961564"
Date: Tue, 27 Feb 2018 19:31:39 +0800
From: Tiwei Bie <tiwei.bie@intel.com>
To: David Laight <David.Laight@ACULAB.COM>
Cc: "mst@redhat.com" <mst@redhat.com>,
        "virtualization@lists.linux-foundation.org"
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "wexu@redhat.com" <wexu@redhat.com>,
        "jfreimann@redhat.com" <jfreimann@redhat.com>
Subject: Re: [PATCH RFC 1/2] virtio: introduce packed ring defines
Message-ID: <20180227113138.4untitgk6ufnatvb@debian>
References: <20180223111801.15240-1-tiwei.bie@intel.com>
 <20180223111801.15240-2-tiwei.bie@intel.com>
 <e7a7f045b87a420a8863030b9378cb38@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e7a7f045b87a420a8863030b9378cb38@AcuMS.aculab.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 27, 2018 at 09:26:27AM +0000, David Laight wrote:
> From: Tiwei Bie
> > Sent: 23 February 2018 11:18
> ...
> > +struct vring_packed_desc_event {
> > +	/* Descriptor Event Offset */
> > +	__virtio16 desc_event_off   : 15,
> > +	/* Descriptor Event Wrap Counter */
> > +		   desc_event_wrap  : 1;
> > +	/* Descriptor Event Flags */
> > +	__virtio16 desc_event_flags : 2;
> > +};
> 
> This looks like you are assuming that a bit-field has a defined
> layout and can be used to map a 'hardware' structure.
> The don't, don't use them like that.
> 
> 	David
> 

Thanks for the comments! Above definition isn't used in
this RFC, and the corresponding parts (event suppression)
haven't been implemented yet. It's more like some pseudo
code (I should add some comments about this in the code).

I planned to change it to something like this in the next
version:

struct vring_packed_desc_event {
	__virtio16 off_wrap;
	__virtio16 flags;  // XXX maybe not a good name for future
};                         // extension. Only 2bits are used now.

But it seems that I had a misunderstanding about the spec
on this previously:

https://lists.oasis-open.org/archives/virtio-dev/201802/msg00173.html

Anyway, it will be addressed. Thank you very much! ;-)

Best regards,
Tiwei Bie
