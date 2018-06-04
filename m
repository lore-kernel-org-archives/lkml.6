Return-Path: <linux-pci-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti33d1t02-1855653-1528134571-2-384573075591836640
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-pci-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1528134571; b=G+SUJOyjSZ8H063gvCUyU5IU6sO5OQ88r3YBEovOhNNNwMN+/z
    +zf9v/uH9XilbicormRIyXXrz+gt9uGvNlpeYNvFvpZPmP8YCKZnIML+OsQDoS7Q
    VrEk+uuW/JZWvwae1BGdlYu3NT40kMsC87YiC4x23u5h4uy4jbVcYNfuhHdwh7MW
    MRekDdn7crVORQ2e6DMO1mKqzWIJ9kYSfQsESfc7x3PRNzntigizY9zYKh46RvSd
    0f/3POjohwzkryNQJfl0AO3zZMykulTmEO12mOwxlFvYF/ZqPnLkyFAfIyhqyX8I
    HMJfXh1/1ISd0FMFKwLt8U1WiTnzNhN51s2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1528134571; bh=rCqdmVZttoGYeQ6ksHrQJ34bkp2dRo
    Pt6jjAYsBQgB4=; b=lxo3+ntIMJP3Q12XUl2B+IeAQe7W7LHFkLYMRNQFNpqllg
    qW1hP1bPk7L59nhDconNgKVpBVF7Q5Y4ugEXxiIU9JwfgoRQN2u5rEnNCyARv+x4
    lkUwp5/7BS7nXajXsY+z5osNHyKwyjAMuAa7yVrE+96VY4BcWLRM/SBp6FX2/ezS
    r9H9EEtfrWMJqlE5Rt15CgbxmNi5s7sbJgMQyD/b9dIQRAFNkNbm16XhsE4nH8EO
    jmqmTauv+MtR4Kt1GG+L5+iWOSuYIrkD6g0CWHi99paP6blaC2Ftha7vMXO4PLFH
    I7ci+6T3lxsAadiUkkX105I3b2EyYXS9Mdr7Mwrw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=sD+MfTyK header.a=rsa-sha256
    header.s=default x-bits=1024;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=sD+MfTyK header.a=rsa-sha256
      header.s=default x-bits=1024;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfI8AlzCyPIuqm2matTilk3yzEee+duOWYpn7KckH0Sl2YsHFoPsUk7Xmmh6H+wL24ikhhjmBxbMKn/HYB0MDieJZo+RI7coXCFuIv02FW0VRU3gxYqk0
    QKbFjLhVY81MYqRX6KxP3QPRyzXp86HkNzUcvJw5wQf/ZfYLIxNNypxvswoVIXqadgRZCC4ZTUWTmM0zsRVRFjnxwyQTOw+KNvzGaZhF6HJuopAizWuNOWbm
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=7mUfYlMuFuIA:10
    a=mGljFQ1qZkSq3r-IPxcA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751017AbeFDRt1 (ORCPT <rfc822;linux@kroah.com>);
        Mon, 4 Jun 2018 13:49:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:52926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750985AbeFDRt0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 Jun 2018 13:49:26 -0400
Date: Mon, 4 Jun 2018 12:49:24 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Mario.Limonciello@dell.com,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v1 0/2] PCI: shpchp: Minor fixes
Message-ID: <20180604174924.GB30381@bhelgaas-glaptop.roam.corp.google.com>
References: <152791788214.257724.13044360353832574147.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152791788214.257724.13044360353832574147.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-pci-owner@vger.kernel.org
X-Mailing-List: linux-pci@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Jun 02, 2018 at 12:41:59AM -0500, Bjorn Helgaas wrote:
> An AMD POGO check in shpchp incorrectly included any device with device ID
> 0x7458, no matter what the vendor.
> 
> Also, use pci_info() instead of dbg() for messages related to OSHP.
> They're important enough that they should appear in dmesg.
> 
> I intend to include these along with Mika's shpchp updates.
> 
> ---
> 
> Bjorn Helgaas (2):
>       PCI: shpchp: Use dev_printk() for OSHP-related messages
>       PCI: shpchp: Fix AMD POGO identification
> 
> 
>  drivers/pci/hotplug/acpi_pcihp.c  |   13 ++++++-------
>  drivers/pci/hotplug/shpchp_ctrl.c |    8 ++++----
>  2 files changed, 10 insertions(+), 11 deletions(-)

I applied these with reviewed-by from Mika and Rafael to pci/hotplug for
v4.18.
