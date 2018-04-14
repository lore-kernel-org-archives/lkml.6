Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751019AbeDNLRP (ORCPT <rfc822;w@1wt.eu>);
        Sat, 14 Apr 2018 07:17:15 -0400
Received: from bmailout3.hostsharing.net ([176.9.242.62]:50429 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750880AbeDNLRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Apr 2018 07:17:13 -0400
Date: Sat, 14 Apr 2018 13:17:11 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Takashi Iwai <tiwai@suse.de>, mario.limonciello@dell.com,
        andy@infradead.org, dvhart@infradead.org, mjg59@srcf.ucam.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v3 3/3] ALSA: hda: Disabled unused audio controller for
 Dell platforms with Switchable Graphics
Message-ID: <20180414111711.GA4245@wunner.de>
References: <20180412104239.25584-1-kai.heng.feng@canonical.com>
 <20180412104239.25584-3-kai.heng.feng@canonical.com>
 <s5hr2nk8zs5.wl-tiwai@suse.de>
 <20180412105909.tbyfcjm55sb47hiq@pali>
 <93DC0F40-81A5-49C6-A470-0D1B6AA85725@canonical.com>
 <20180414104512.GA27158@wunner.de>
 <20180414104950.ngomyjy5l5cwhb5i@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180414104950.ngomyjy5l5cwhb5i@pali>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 14, 2018 at 12:49:50PM +0200, Pali Rohár wrote:
> On Saturday 14 April 2018 12:45:12 Lukas Wunner wrote:
> > On Thu, Apr 12, 2018 at 10:15:41PM +0800, Kai-Heng Feng wrote:
> > > Do you have any suggestion to check if it connects to the system via
> > > Thunderbolt?
> > 
> > Just use pci_is_thunderbolt_attached(), introduced by 8531e283bee6,
> > like this:
> > 
> > if (check_dell_switchable_gfx(pci) && !pci_is_thunderbolt_attached(pci))
> 
> And what about PCI-e device attached to ExpressCard slot?

I don't know of a bullet-proof way to recognize those.  In theory
one could check if the PCIe port above the GPU is a non-hotplug
root port, but I think there are machines with hotplug capable
root ports with GPUs below them that aren't actually removable.

However I think ExpressCard-attached GPUs were rare, much less ones
with integrated HDA controller, so in reality that's probably a
non-issue.

Thanks,

Lukas
