Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752295AbeBSJrz convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 04:47:55 -0500
Received: from mga06.intel.com ([134.134.136.31]:51491 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752232AbeBSJry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 04:47:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,534,1511856000";
   d="scan'208";a="35806284"
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Bjorn Helgaas <helgaas@kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Sinan Kaya <okaya@codeaurora.org>
From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
In-Reply-To: <87bmglb9w5.fsf@intel.com>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org,
        David Airlie <airlied@linux.ie>, linux-arm-msm@vger.kernel.org,
        intel-gfx@lists.freedesktop.org,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        linux-arm-kernel@lists.infradead.org
References: <1511801886-6753-1-git-send-email-okaya@codeaurora.org>
 <1511801886-6753-10-git-send-email-okaya@codeaurora.org>
 <20180216145444.GA11014@bhelgaas-glaptop.roam.corp.google.com>
 <87bmglb9w5.fsf@intel.com>
Message-ID: <151903366919.5458.4766479266211215742@jlahtine-desk.ger.corp.intel.com>
User-Agent: alot/0.6
Subject: Re: [PATCH V3 09/29] drm/i915: deprecate pci_get_bus_and_slot()
Date: Mon, 19 Feb 2018 11:47:49 +0200
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jani Nikula (2018-02-19 11:34:34)
> On Fri, 16 Feb 2018, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Mon, Nov 27, 2017 at 11:57:46AM -0500, Sinan Kaya wrote:
> >> pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
> >> where a PCI device is present. This restricts the device drivers to be
> >> reused for other domain numbers.
> >> 
> >> Getting ready to remove pci_get_bus_and_slot() function in favor of
> >> pci_get_domain_bus_and_slot().
> >> 
> >> Extract the domain number from drm_device and pass it into
> >> pci_get_domain_bus_and_slot() function.
> >> 
> >> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> >
> > I don't know what happened to this, and it didn't make it into
> > v4.16-rc1.  I applied it to pci/deprecate-get-bus-and-slot for v4.17
> > along with the patch that actually removes pci_get_bus_and_slot().
> 
> It fell between the cracks as we couldn't apply it before getting a
> backmerge on the dependency. Sorry about that.
> 
> Ack for merging through your tree.

I just retested the patch and it still passes CI. We also now have the
dependency in our tree through the backmerge, so I can send this for the
next drm-next pull request. Either way suits me.

Regards, Joonas
