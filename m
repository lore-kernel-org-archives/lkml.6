Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758772AbeD0Qg2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 12:36:28 -0400
Received: from resqmta-ch2-04v.sys.comcast.net ([69.252.207.36]:59858 "EHLO
        resqmta-ch2-04v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1757565AbeD0Qg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 12:36:26 -0400
Date: Fri, 27 Apr 2018 11:36:23 -0500 (CDT)
From: Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To: Matthew Wilcox <willy@infradead.org>
cc: Michal Hocko <mhocko@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>, linux-mm@kvack.org,
        Jan Kara <jack@suse.cz>, matthew@wil.cx, x86@kernel.org,
        luto@amacapital.net, martin.petersen@oracle.com, jthumshirn@suse.de,
        broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "lsf-pc@lists.linux-foundation.org"
        <lsf-pc@lists.linux-foundation.org>
Subject: Re: [LSF/MM TOPIC NOTES] x86 ZONE_DMA love
In-Reply-To: <20180427161813.GD8161@bombadil.infradead.org>
Message-ID: <alpine.DEB.2.20.1804271136030.11686@nuc-kabylake>
References: <20180426215406.GB27853@wotan.suse.de> <20180427053556.GB11339@infradead.org> <20180427071843.GB17484@dhcp22.suse.cz> <alpine.DEB.2.20.1804271103160.11686@nuc-kabylake> <20180427161813.GD8161@bombadil.infradead.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CMAE-Envelope: MS4wfA/draW3ZiTEfMyQ4beOORMbvaLvXe09S4jHIdjBr/9t2jsdv10+XlNlQTCu+BbqUZ7ZakG8aSBsJnxATAg9+/mfx9pGecdkCw0yK6c66n1h22EE0kAP
 vyIpQJ6m7S0H9JWsl1zxdziJmtcqKbBZpBnKyOO5OSXTeXvUerOdNBjaJv2fobnvou4L04wONxqZDYhPM2XZYZNVfW5FjgKYihdNTqQpJT12Y7jlXyGEFjS2
 Gdt4TqQY9yZM6A8ZWM/hxJCUhK5yaqxyzw551AjalOjlmD/keQD8250qlTpgS5nz4FSeA5djuRhxwNbgyXY3aC6sPMmMSNMz8/gsbTl2NdkNAdh0eNiFLx9b
 6MUfLV9Xwn8xM9lLT1iVRAvZHUNoCSb9Vyl4yYG6NJYacqm24mGFIV2PQj4PnZidp7lKDnVYucZDAYVl1v3WIABv1CzmviI2K0K9SGID5aV+MZ6Rr72SRS3j
 D9myGQd76xn+CF/sjEwHd5iMIMUXj26nCw4Cb7P/xx4VVo8cnMt553vCtYRl/5EZKiaSDi3L5tcmZWlLSyBXpX0b2LgDWhVNK77XcN06Lqpt9Q62tEKhyTLT
 KjmnYSN15HhIeppWNfS1bMQ96WmunonJqauylWUc7bgRTg==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Apr 2018, Matthew Wilcox wrote:

> Some devices have incredibly bogus hardware like 28 bit addressing
> or 39 bit addressing.  We don't have a good way to allocate memory by
> physical address other than than saying "GFP_DMA for anything less than
> 32, GFP_DMA32 (or GFP_KERNEL on 32-bit) for anything less than 64 bit".
>
> Even CMA doesn't have a "cma_alloc_phys()".  Maybe that's the right place
> to put such an allocation API.

The other way out of this would be to require a IOMMU?
