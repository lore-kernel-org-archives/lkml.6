Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751240AbeECWP0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 18:15:26 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:38730 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751185AbeECWPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 18:15:24 -0400
X-Google-Smtp-Source: AB8JxZotfVrrDkGWTVs1QQo/Qef1pzLiA3rrG3vvkB60CcRzz3aACEosLFitx94KhZHhf23Idx6YuQ==
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [RFC/RFT] Add noats flag to boot parameters
From: Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <5cf699f1-90c1-5ad8-07fe-a65042395d05@codeaurora.org>
Date: Thu, 3 May 2018 15:15:20 -0700
Cc: Joerg Roedel <joro@8bytes.org>, Gil Kupfer <gilkup@gmail.com>,
        dwmw2@infradead.org, bhelgaas@google.com,
        iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Gil Kupfer <gilkup@cs.technion.ac.il>,
        Will Deacon <will.deacon@arm.com>, Bjorn Helgaas <helgaas@kernel.org>
Message-Id: <56E6D90C-A85F-42F7-94C5-EF21DA6C656B@gmail.com>
References: <1525025808-2365-1-git-send-email-gilkup@cs.technion.ac.il>
 <20180503133459.waawna3ebtu3udn6@8bytes.org>
 <359d736a-a7ac-f0e4-f4db-dc7bb506481c@codeaurora.org>
 <20180503135920.o2rdh3exai7qmkvu@8bytes.org>
 <5cf699f1-90c1-5ad8-07fe-a65042395d05@codeaurora.org>
To: Sinan Kaya <okaya@codeaurora.org>
X-Mailer: Apple Mail (2.3273)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w43MFWwe014873

Sinan Kaya <okaya@codeaurora.org> wrote:

> +Bjorn,
> 
> On 5/3/2018 9:59 AM, Joerg Roedel wrote:
>> On Thu, May 03, 2018 at 09:46:34AM -0400, Sinan Kaya wrote:
>>> I also like the idea in general.
>>> Minor nit..
>>> 
>>> Shouldn't this be an iommu parameter rather than a PCI kernel command line parameter?
>>> We now have an iommu.passthrough argument that prevents page translation.
>>> 
>>> Doesn't this fit into the same category especially when it is the IOMMU drivers that
>>> call ATS functions for enablement not the PCI drivers.
>> 
>> ATS is a bit of a grey area between PCI and IOMMU, but since ATS is
>> PCI-specific and the code to enable/disable it is in PCI as well, I
>> think the parameter makes sense for PCI too.
> 
> OK. Bjorn was interested in having a command line driven feature enables in driver/pci
> directory with bitmasks for each optional PCI spec capability rather than noXYZ feature.
> 
> This would allow us to troubleshoot code breakage as well as the platform bring up to
> turn off all optional features.
> 
> Sounds like this would be a good match for that work.

I think that since this feature (ATS) has security implications, it should
be controllable through the kernel boot parameters. Otherwise, it can be
potentially too late to turn it off.

Regards,
Nadav
