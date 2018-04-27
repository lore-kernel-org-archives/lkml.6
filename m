Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758728AbeD0Q23 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 12:28:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43484 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757716AbeD0Q21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 12:28:27 -0400
Date: Fri, 27 Apr 2018 09:28:22 -0700
From: Matthew Wilcox <willy@infradead.org>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
        mhocko@kernel.org, cl@linux.com, Jan Kara <jack@suse.cz>,
        matthew@wil.cx, x86@kernel.org, luto@amacapital.net,
        martin.petersen@oracle.com, jthumshirn@suse.de, broonie@kernel.org,
        Juergen Gross <jgross@suse.com>, linux-spi@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>, linux-scsi@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>, linux-kernel@vger.kernel.org,
        "lsf-pc@lists.linux-foundation.org"
        <lsf-pc@lists.linux-foundation.org>
Subject: Re: [LSF/MM TOPIC NOTES] x86 ZONE_DMA love
Message-ID: <20180427162822.GE8161@bombadil.infradead.org>
References: <20180426215406.GB27853@wotan.suse.de>
 <20180427053556.GB11339@infradead.org>
 <20180427161456.GD27853@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180427161456.GD27853@wotan.suse.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 27, 2018 at 04:14:56PM +0000, Luis R. Rodriguez wrote:
> > Not really.  We have unchecked_isa_dma to support about 4 drivers,
> 
> Ah very neat:
> 
>   * CONFIG_CHR_DEV_OSST - "SCSI OnStream SC-x0 tape support"

That's an upper level driver, like cdrom, disk and regular tapes.

>   * CONFIG_SCSI_ADVANSYS - "AdvanSys SCSI support"

If we ditch support for the ISA boards, this can go away.

>   * CONFIG_SCSI_AHA1542 - "Adaptec AHA1542 support"

Probably true.

>   * CONFIG_SCSI_ESAS2R - "ATTO Technology's ExpressSAS RAID adapter driver"

That's being set to 0.

You missed BusLogic.c and gdth.c
