Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757533AbeD0HDu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 03:03:50 -0400
Received: from mga01.intel.com ([192.55.52.88]:55504 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757373AbeD0HDs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 03:03:48 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,334,1520924400";
   d="scan'208";a="223819743"
Date: Fri, 27 Apr 2018 12:38:30 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Moritz Fischer <mdf@kernel.org>, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, dan.j.williams@intel.com
Subject: Re: [PATCH v2] dmaengine: axi-dmac: Request IRQ with IRQF_SHARED
Message-ID: <20180427070830.GC6014@localhost>
References: <20180426174000.12008-1-mdf@kernel.org>
 <20180427051115.GX6014@localhost>
 <748ffc14-de12-c11e-eb12-65c599fe5f4e@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <748ffc14-de12-c11e-eb12-65c599fe5f4e@metafoo.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 27, 2018 at 08:53:39AM +0200, Lars-Peter Clausen wrote:
> On 04/27/2018 07:11 AM, Vinod Koul wrote:
> > On Thu, Apr 26, 2018 at 10:40:00AM -0700, Moritz Fischer wrote:
> >> Request IRQ with IRQF_SHARED flag. This works since the interrupt
> >> handler already checks if there is an actual IRQ pending and returns
> >> IRQ_NONE otherwise.
> > 
> > hmmm what are we trying to fix here? Is your device on a shared line or not?
> 
> IRQF_SHARED does not mean that the IRQ is on a shared line. It means that
> the driver can handle it if the IRQ is on a shared line. Since the driver
> can handle it setting the flag is a good idea since this enables usecases
> where the line is shared.

Yes that is correct indeed, but what is the motivation for the change.

If you never expect this to be in shared environment why to do this?
Sorry but "it works" is not a good enough reason for this change, to enable
usecases where the line is shared is a good reason :)

-- 
~Vinod
