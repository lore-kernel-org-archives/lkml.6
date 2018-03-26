Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752042AbeCZK5D (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 06:57:03 -0400
Received: from mga02.intel.com ([134.134.136.20]:45284 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751090AbeCZK5B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 06:57:01 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,364,1517904000";
   d="scan'208";a="214895909"
Date: Mon, 26 Mar 2018 16:21:56 +0530
From: Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
To: hpa@zytor.com
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Anshuman Gupta <anshuman.gupta@intel.com>, glx@linutronix.de,
        x86@kernel.org, mingo@redhat.com, rjw@rjwysocki.net,
        andriy.shevchenko@linux.intel.com, alan@linux.intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] x86: i8237: Register based on FADT legacy boot flag
Message-ID: <20180326105155.GA25340@raj-desk2.iind.intel.com>
References: <alpine.DEB.2.21.1803191152450.2010@nanos.tec.linutronix.de>
 <1521714118-31282-1-git-send-email-anshuman.gupta@intel.com>
 <alpine.DEB.2.21.1803251348190.1481@nanos.tec.linutronix.de>
 <20180326054833.GA25173@raj-desk2.iind.intel.com>
 <alpine.DEB.2.21.1803261110430.1585@nanos.tec.linutronix.de>
 <8A68406D-B05E-4953-89D1-D2AB49904644@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8A68406D-B05E-4953-89D1-D2AB49904644@zytor.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 26, 2018 at 03:34:44AM -0700, hpa@zytor.com wrote:
> On March 26, 2018 2:11:51 AM PDT, Thomas Gleixner <tglx@linutronix.de> wrote:
> >On Mon, 26 Mar 2018, Rajneesh Bhardwaj wrote:
> >
> >> On Sun, Mar 25, 2018 at 01:50:40PM +0200, Thomas Gleixner wrote:
> >> > On Thu, 22 Mar 2018, Anshuman Gupta wrote:
> >> > 
> >> > > From: Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
> >> > > 
> >> > > >From Skylake onwards, the platform controller hub (Sunrisepoint
> >PCH) does
> >> > > not support legacy DMA operations to IO ports 81h-83h, 87h,
> >89h-8Bh, 8Fh.
> >> > > Currently this driver registers as syscore ops and its resume
> >function is
> >> > > called on every resume from S3. On Skylake and Kabylake, this
> >causes a
> >> > > resume delay of around 100ms due to port IO operations, which is
> >a problem.
> >> > > 
> >> > > This change allows to load the driver only when the platform bios
> >> > > explicitly supports such devices or has a cut-off date earlier
> >than 2017.
> >> > 
> >> > Please explain WHY 2017 is the cut-off date. I still have no clue
> >how that
> >> > is decided aside of being a random number.
> >> 
> >> Hello Thomas,
> >> 
> >> We tested on few Intel platforms such as Skylake, Kabylake,
> >Geminilake etc
> >> and realized that the BIOS always sets the FADT flag to be true
> >though the
> >> device may not be physically present on the SoC. This is a BIOS bug.
> >To keep
> >> the impact minimum, we decided to add a cut-off date since we are not
> >aware
> >> of any BIOS (other than the coreboot link provided in the commit msg)
> >that
> >> properly sets this field. SoCs released after Skylake will not have
> >this DMA
> >> device on the PCH. So, because of these two reasons, we decided to
> >add a
> >> cut-off date as 2017.
> >> 
> >> Please let us know if you feel strongly about it and we can change it
> >or
> >> remove it if you feel so.
> >
> >I don't feel strongly about the cut off itself, but I want a reasonable
> >explanation in the changelog or code comment because half a year from
> >now
> >nobody remembers ....
> >
> >Thanks,
> >
> >	tglx
> 
> Can we probe safely for this device?

Hi Peter - Apparently No, that's why we are trying all these indirect means to
determine the presence of the DMA device. As you might have noticed, this
driver registers as syscore ops and not on the basis of a ACPI object or
HWID or anything else.

> -- 
> Sent from my Android device with K-9 Mail. Please excuse my brevity.

-- 
Best Regards,
Rajneesh
