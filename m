Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752361AbeDJHxq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 03:53:46 -0400
Received: from smtp.ctxuk.citrix.com ([185.25.65.24]:47434 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752188AbeDJHxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 03:53:45 -0400
X-IronPort-AV: E=Sophos;i="5.48,431,1517875200";
   d="scan'208";a="71291040"
From: Paul Durrant <Paul.Durrant@citrix.com>
To: "'Boris Ostrovsky'" <boris.ostrovsky@oracle.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Juergen Gross <jgross@suse.com>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: RE: [PATCH v3] xen/privcmd: add IOCTL_PRIVCMD_MMAP_RESOURCE
Thread-Topic: [PATCH v3] xen/privcmd: add IOCTL_PRIVCMD_MMAP_RESOURCE
Thread-Index: AQHTz+ZAHd0pwMZUSk+l3hEePnIFYqP4gHmAgAAtUwCAAPROIA==
Date: Tue, 10 Apr 2018 07:53:43 +0000
Message-ID: <440d283396ba4de89481692f02cae1cc@AMSPEX02CL03.citrite.net>
References: <20180409093629.9621-1-paul.durrant@citrix.com>
 <bd84cd4b-1834-b631-303c-3e190ad7676d@oracle.com>
 <3baffa60-bcca-cbf3-f056-db30a6c5178c@oracle.com>
In-Reply-To: <3baffa60-bcca-cbf3-f056-db30a6c5178c@oracle.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3A7sBgX004938

> -----Original Message-----
> From: Boris Ostrovsky [mailto:boris.ostrovsky@oracle.com]
> Sent: 09 April 2018 20:19
> To: Paul Durrant <Paul.Durrant@citrix.com>; xen-devel@lists.xenproject.org;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> Cc: Juergen Gross <jgross@suse.com>; Thomas Gleixner
> <tglx@linutronix.de>; Ingo Molnar <mingo@redhat.com>; Stefano Stabellini
> <sstabellini@kernel.org>
> Subject: Re: [PATCH v3] xen/privcmd: add
> IOCTL_PRIVCMD_MMAP_RESOURCE
> 
> On 04/09/2018 12:36 PM, Boris Ostrovsky wrote:
> > On 04/09/2018 05:36 AM, Paul Durrant wrote:
> >> My recent Xen patch series introduces a new HYPERVISOR_memory_op
> to
> >> support direct priv-mapping of certain guest resources (such as ioreq
> >> pages, used by emulators) by a tools domain, rather than having to access
> >> such resources via the guest P2M.
> >>
> >> This patch adds the necessary infrastructure to the privcmd driver and
> >> Xen MMU code to support direct resource mapping.
> >>
> >> NOTE: The adjustment in the MMU code is partially cosmetic. Xen will
> now
> >>       allow a PV tools domain to map guest pages either by GFN or MFN,
> thus
> >>       the term 'mfn' has been swapped for 'pfn' in the lower layers of the
> >>       remap code.
> >>
> >> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
> > Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> >
> > I think this will have to wait until 4.18 though, it's somewhat late for
> > current merge window right now.
> 
> 
> Warns on 32-bit ARM build:
> 
>   CC      drivers/xen/privcmd.o
> In file included from /data/upstream/linux-xen/include/linux/kernel.h:14:0,
>                  from /data/upstream/linux-xen/drivers/xen/privcmd.c:11:
> /data/upstream/linux-xen/drivers/xen/privcmd.c: In function
> ‘privcmd_ioctl_mmap_resource’:
> /data/upstream/linux-xen/drivers/xen/privcmd.c:788:33: warning: cast to
> pointer from integer of different size [-Wint-to-pointer-cast]
>     pr_info("pfn[%u] = %p\n", i, (void *)pfns[i]);

I'm glad that was caught. It was a line of debug that was supposed to have been removed.

  Paul

>                                  ^
> /data/upstream/linux-xen/include/linux/printk.h:308:34: note: in
> definition of macro ‘pr_info’
>   printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
>                                   ^~~~~~~~~~~
>   AR      drivers/xen/xen-privcmd.o
> 
> 
> -boris
