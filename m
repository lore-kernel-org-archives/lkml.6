Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752438AbeB0JZs convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 04:25:48 -0500
Received: from smtp-out4.electric.net ([192.162.216.185]:60349 "EHLO
        smtp-out4.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751956AbeB0JZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 04:25:46 -0500
From: David Laight <David.Laight@ACULAB.COM>
To: "'Tiwei Bie'" <tiwei.bie@intel.com>, "mst@redhat.com" <mst@redhat.com>,
        "virtualization@lists.linux-foundation.org"
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>,
        "wexu@redhat.com" <wexu@redhat.com>,
        "jfreimann@redhat.com" <jfreimann@redhat.com>
Subject: RE: [PATCH RFC 1/2] virtio: introduce packed ring defines
Thread-Topic: [PATCH RFC 1/2] virtio: introduce packed ring defines
Thread-Index: AQHTrJhawi/1jB/uq0q3lsGi4wUZ3aO4ADyQ
Date: Tue, 27 Feb 2018 09:26:27 +0000
Message-ID: <e7a7f045b87a420a8863030b9378cb38@AcuMS.aculab.com>
References: <20180223111801.15240-1-tiwei.bie@intel.com>
 <20180223111801.15240-2-tiwei.bie@intel.com>
In-Reply-To: <20180223111801.15240-2-tiwei.bie@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Outbound-IP: 156.67.243.126
X-Env-From: David.Laight@ACULAB.COM
X-Proto: esmtps
X-Revdns: 
X-HELO: AcuMS.aculab.com
X-TLS: TLSv1.2:ECDHE-RSA-AES256-SHA384:256
X-Authenticated_ID: 
X-PolicySMART: 3396946, 3397078
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tiwei Bie
> Sent: 23 February 2018 11:18
...
> +struct vring_packed_desc_event {
> +	/* Descriptor Event Offset */
> +	__virtio16 desc_event_off   : 15,
> +	/* Descriptor Event Wrap Counter */
> +		   desc_event_wrap  : 1;
> +	/* Descriptor Event Flags */
> +	__virtio16 desc_event_flags : 2;
> +};

This looks like you are assuming that a bit-field has a defined
layout and can be used to map a 'hardware' structure.
The don't, don't use them like that.

	David
