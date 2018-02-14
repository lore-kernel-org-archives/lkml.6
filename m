Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967597AbeBNLuA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 06:50:00 -0500
Received: from 8bytes.org ([81.169.241.247]:45570 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967378AbeBNLt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 06:49:59 -0500
Date: Wed, 14 Feb 2018 12:49:57 +0100
From: Joerg Roedel <joro@8bytes.org>
To: "Hook, Gary" <ghook@amd.com>
Cc: Gary R Hook <gary.hook@amd.com>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/amd - Use dev_err to send events to the system log
Message-ID: <20180214114957.GI16484@8bytes.org>
References: <151736066756.21649.4739957712713863861.stgit@sosam4>
 <20180213132216.gyhndywyu23cdzbv@8bytes.org>
 <325d7406-e01b-f7a1-3da6-390b0cf9bc94@amd.com>
 <20180213160018.fg7baclgu5o5rgxc@8bytes.org>
 <f7e7e2c2-c83d-9c4a-f3ac-5c351576b567@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7e7e2c2-c83d-9c4a-f3ac-5c351576b567@amd.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 02:24:56PM -0500, Hook, Gary wrote:
> Without actually running a driver and getting some debug info, I'll just
> say that my example compiled, the amd_iommu structure points to a pci_dev
> which contains a device, and the two possibilities are likely equivalent.
> 
> I'll vet that, of course, but working under the assumption that they are
> equivalent, the question becomes, do you have a preference?

They are not equivalent, your version points to the pci_dev containing
the IOMMU, my version points to the (virtual) iommu-device for that
particular iommu in the kernel.

So the difference in the prefix is:

	your version: '0000:00:00.2:'

	vs. my version: 'ivhd0:'

The latter is the better prefix, because it points to the iommu. A
pci_dev can contain more than one iommu, so that prefix is not specific
enough. I know that there is currently no hardware implementing multiple
iommus on one pci_dev, but it is allowed according to the spec.


Regards,

	Joerg
