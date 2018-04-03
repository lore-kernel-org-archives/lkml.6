Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751414AbeDCOF4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 10:05:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:59626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750722AbeDCOFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 10:05:54 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86E8120CAA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=helgaas@kernel.org
Date: Tue, 3 Apr 2018 09:05:52 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jacob Keller <jacob.keller@gmail.com>
Cc: Tal Gilboa <talgi@mellanox.com>, Tariq Toukan <tariqt@mellanox.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Ariel Elior <ariel.elior@cavium.com>,
        Ganesh Goudar <ganeshgr@chelsio.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        everest-linux-l2@cavium.com, intel-wired-lan@lists.osuosl.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 03/14] PCI: Add pcie_bandwidth_capable() to compute
 max supported link bandwidth
Message-ID: <20180403140552.GB60020@bhelgaas-glaptop.roam.corp.google.com>
References: <152244269202.135666.3064353823697623332.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <152244390359.135666.14890735614456271032.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <31e66048-e8b8-47ba-baf5-023560b4c124@mellanox.com>
 <20180402004049.GA131023@bhelgaas-glaptop.roam.corp.google.com>
 <50346f44-de3f-b226-69ad-6de45e94e261@mellanox.com>
 <20180402140501.GA244675@bhelgaas-glaptop.roam.corp.google.com>
 <CA+P7+xr1N+X5DyPwNpWUtfqr9U4pLL9bMoB1wkBdf2K9n6cxKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+P7+xr1N+X5DyPwNpWUtfqr9U4pLL9bMoB1wkBdf2K9n6cxKw@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 02, 2018 at 05:30:54PM -0700, Jacob Keller wrote:
> On Mon, Apr 2, 2018 at 7:05 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > +/* PCIe speed to Mb/s reduced by encoding overhead */
> > +#define PCIE_SPEED2MBS_ENC(speed) \
> > +       ((speed) == PCIE_SPEED_16_0GT ? (16000*(128/130)) : \
> > +        (speed) == PCIE_SPEED_8_0GT  ?  (8000*(128/130)) : \
> > +        (speed) == PCIE_SPEED_5_0GT  ?  (5000*(8/10)) : \
> > +        (speed) == PCIE_SPEED_2_5GT  ?  (2500*(8/10)) : \
> > +        0)
> > +
> 
> Should this be "(speed * x ) / y" instead? wouldn't they calculate
> 128/130 and truncate that to zero before multiplying by the speed? Or
> are compilers smart enough to do this the other way to avoid the
> losses?

Yep, thanks for saving me yet more embarrassment.
