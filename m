Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752392AbeB1Lun (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 06:50:43 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:48503 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752247AbeB1Lum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 06:50:42 -0500
Date: Wed, 28 Feb 2018 12:50:48 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Felipe Balbi <felipe.balbi@linux.intel.com>
cc: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: HRTimer causing rtctest to fail
In-Reply-To: <87k1ux5qpf.fsf@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1802281246420.1886@nanos.tec.linutronix.de>
References: <87vaei601x.fsf@linux.intel.com> <alpine.DEB.2.21.1802271640010.1886@nanos.tec.linutronix.de> <87muzt5usg.fsf@linux.intel.com> <alpine.DEB.2.21.1802281043050.1886@nanos.tec.linutronix.de> <87k1ux5qpf.fsf@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Feb 2018, Felipe Balbi wrote:
> Thomas Gleixner <tglx@linutronix.de> writes:
> > All numbers in micro seconds! What happens if you load the system or
> > restrict C-States?
> 
> added intel_idle.max_cstate=0 to cmdline. Still see some failures,
> albeit a lot more rare, for example, caught one on iteration 8 of
> 8192Hz:
> 
> 8192Hz:	 1 2 3 4 5 6 7
> PIE delta error: 0.000135 should be close to 0.000122
> 
> That is, however, only 13 uS late. Is that within the limits of "we
> don't quite care"?

I think so. 13us (depending on the machine) can easily happen if multiple
interrupts/timers happen at the same time or if something keeps interrupts
disabled for a few microseconds which is certainly possible.

What kind of system is this?

> BTW, it took some effort to get that one failure. I'll leave rtctest
> running in a long loop and try to figure out approximately how frequently
> it fails, but it seems like it's within the realm of "don't care", would
> you agree?

Yes.

Thanks,

	tglx
