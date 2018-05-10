Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757178AbeEJLwJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 07:52:09 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:21245 "EHLO
        SMTP03.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756984AbeEJLwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 07:52:08 -0400
X-IronPort-AV: E=Sophos;i="5.49,385,1520899200";
   d="scan'208";a="54192906"
Date: Thu, 10 May 2018 12:52:06 +0100
From: Wei Liu <wei.liu2@citrix.com>
To: Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
CC: Andrew Cooper <andrew.cooper3@citrix.com>,
        Juergen Gross <jgross@suse.com>, <xen-devel@lists.xenproject.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        <linux-kernel@vger.kernel.org>, Wei Liu <wei.liu2@citrix.com>
Subject: Re: [Xen-devel] [PATCH v2 1/3] xen/pvh: enable and set default MTRR
 type
Message-ID: <20180510115206.nbkthffhksy3l4g5@citrix.com>
References: <20180509102129.14832-1-roger.pau@citrix.com>
 <20180509102129.14832-2-roger.pau@citrix.com>
 <fbe18be3-0e2e-723f-a625-015c6aad89a3@citrix.com>
 <20180509113016.tavac64ba5fu3tob@MacBook-Pro-de-Roger.local>
 <20180509151139.nytwuepervqjkcat@MacBook-Pro-de-Roger.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180509151139.nytwuepervqjkcat@MacBook-Pro-de-Roger.local>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 09, 2018 at 04:11:39PM +0100, Roger Pau Monné wrote:
> On Wed, May 09, 2018 at 12:30:16PM +0100, Roger Pau Monné wrote:
> > On Wed, May 09, 2018 at 11:56:40AM +0100, Andrew Cooper wrote:
> > > On 09/05/18 11:21, Roger Pau Monne wrote:
> > > I'm not sure that setting the default MTRR type is going to be a
> > > clever idea in hindsight when we come to doing PCI Passthrough support.
> > 
> > Setting the default type to WB is also set by hvmloader, it's just
> > that hvmloader also sets some of the fixed and variable ranges to UC
> > in order to cover the iomem areas.
> > 
> > The expectations when doing pci-passthrough is that the guest will
> > always use paging and PAT in order to set the appropriate cache
> > attributes, or else the guest itself will have to program the UC MTRR
> > ranges, I admit that's not very nice however.
> > 
> > What about enabling the default MTRR type and setting it to WB in the
> > toolstack for PVH? IMO doing it Xen itself would be wrong.
> 
> I have the following patch to set the default MTRR type, but I think
> if we go down this road then we will also have to set UC MTRRs for
> MMIO areas, which again seems fine to me.
> 

Can you please document the default type(s) to pvh.markdown once
the issue is resolved?

Wei.
