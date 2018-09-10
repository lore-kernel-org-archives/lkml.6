Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC475C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41FFC20865
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:33:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41FFC20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbeIJO0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 10:26:47 -0400
Received: from mga17.intel.com ([192.55.52.151]:28002 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726148AbeIJO0r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 10:26:47 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Sep 2018 02:33:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,355,1531810800"; 
   d="scan'208";a="84582225"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga002.fm.intel.com with SMTP; 10 Sep 2018 02:33:34 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 10 Sep 2018 12:33:33 +0300
Date:   Mon, 10 Sep 2018 12:33:33 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] MAINTAINERS: Add Lukas Wunner as co-maintainer of
 thunderbolt
Message-ID: <20180910093333.GI14465@lahna.fi.intel.com>
References: <cover.1536517047.git.lukas@wunner.de>
 <76fccab34a66023c08b71a864a9fea77daac9742.1536517047.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76fccab34a66023c08b71a864a9fea77daac9742.1536517047.git.lukas@wunner.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukas,

I'm including Greg here in case I've done something wrong as a maintainer.
Since I've only maintained Thunderbolt quite short time, it may be that
I've done mistakes but certainly I did not deliberately try to make life of
people developing this for older Apple systems harder.

On Sun, Sep 09, 2018 at 11:42:01PM +0200, Lukas Wunner wrote:
> Andreas Noever has let it be known off-list already a while ago that he
> currently cannot spare as much time for Thunderbolt development as he'd
> like.  As a result the driver's development has become dominated by
> Intel.

I was not aware of this. Althought Andreas has not commented much
lately, I thought he is still looking after our changes. I hope he still
is :)

> I would like to step up as co-maintainer to provide additional checks
> and balances and prevent the driver from degenerating into an Intel-only
> show.  A number of things really irk me:

I don't have anything against this but at the same time I'm afraid it
might lead to a situation where the Thunderbolt driver evolution gets
stopped into its tracks because of unnecessary fighting over each patch
and change which does not benefit Linux kernel in general.

> * I've been contributing to this driver as well as Thunderbolt-related
>   bits to the EFI, GPU and PCI subsystems for close to three years and
>   was explicitly asked by Intel to cc them on every Thunderbolt-related
>   patch.  Yet Intel did not see fit to cc me on their changes that went
>   into 4.17.  I literally only learned about their existence from
>   reading the news.  In the 4.19 cycle I was only cc'ed on a subset of
>   their patches.
> 
> * Intel's efforts have been focussed exclusively on firmware-controlled
>   tunnel management (ICM).  They made no contributions to OS-controlled
>   tunnel management.  ICM cannot be used on Macs with Thunderbolt 1 + 2.
>   ICM requires trusting a firmware blob.  ICM does not offer the same
>   versatility as OS-controlled tunnel management, e.g. using separate
>   tunnels to afford different QoS levels or correlation of Thunderbolt
>   ports with PCI devices.  Apple chose OS-controlled tunnel management
>   for very valid technical reasons.
> 
> * Our OS-controlled tunnel management still lacks important features
>   such as daisy-chaining and DP tunnels.  Each feature needs to be
>   reverse-engineered because there is no public spec.  Intel issued a
>   press statement in May 2017 promising to make the specification public
>   "next year".  More than a year has passed -- no spec.  The company has
>   since changed leadership, who knows if they haven't silently canned
>   the plans for a public spec?  I offered to sign an NDA and go through
>   a disclosure process for every patch -- no reaction.
> 
> * Reverse-engineering requires verbose logging so that we're able to
>   collect data on various systems and endpoint devices to deduce the
>   meaning of registers.  Yet Intel now seeks to mute log output, thereby
>   curbing our reverse-engineering efforts.  This exemplifies a worrying
>   tendency to ignore the needs of non-Intel stakeholders in the
>   developer community or even undermine them.

The reason for making the driver less verbose comes from direct feedback
from the community. For example:

  https://lkml.org/lkml/2017/10/31/864

The goal is certainly not to prevent reverse-engineering. It simply logs
too much with information that is not usable to the end user. For an OS
such as Linux where drivers tend to be high-quality professional work,
logging like this is simply not acceptable.

I also concluded that all the possible logs you are interested (this
includes Thunderbolt generation 1 and 2 devices) are pretty much already
available to you. Those devices do not appear in any modern designs,
including Apple platforms who use generation 3 devices and those are
already supported by the current driver making the logs irrelevant.

Andreas who did the hard work of reverse-engineering the initial driver and
who I still consider the authorative maintainer was fine at the time to
silence the driver.

> * Recent Intel contributions are maintainer self-commits without any
>   Reviewed-by tags, which is generally considered a bad practice.
>   Review comments offered by Intel-outsiders are not taken seriously.
>   For example the driver's initcall level has been fiddled with twice
>   now.  A review comment pointing out the fragility of abusing initcall
>   levels to implement dependencies and suggesting the use of a notifier
>   chain instead was summarily dismissed as unnecessary unless it breaks
>   a third time.

[Adding more context for Greg first]

  I noticed that if the driver is built into the kernel image, it may
  start DMA before IOMMUs get initialized. This makes it to fail once
  IOMMUs are up and running. I originally moved the driver to load
  before the networking driver (they were using both module_initcall())
  but that turned out causing problems with IOMMUs so I moved the
  initcall level so that initialization happens after IOMMUs but before
  network, and hopefully in future other drivers. Because this is
  problem of ordering of module init code, we cannot use -EPROBE_DEFER
  or device_links. The patch in question is here:

    https://lkml.org/lkml/2018/9/5/248

I mentioned during the review that the proposal you are suggesting
(adding blocking notifiers) is simply too complex solution. Other
drivers more or less use initcall levels to make sure the bus core gets
initialized before any drivers using that bus can be loaded. With
notifiers you would need to implement a proper API that drivers can hook
into which becomes complex and adds many lines of additional code that
needs to be maintained. As the guy who maintains this, I prefer the
simpler solution.

> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a5b256b25905..8815f4639e58 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14445,6 +14445,7 @@ F:	drivers/platform/x86/thinkpad_acpi.c
>  
>  THUNDERBOLT DRIVER
>  M:	Andreas Noever <andreas.noever@gmail.com>
> +M:	Lukas Wunner <lukas@wunner.de>
>  M:	Michael Jamet <michael.jamet@intel.com>
>  M:	Mika Westerberg <mika.westerberg@linux.intel.com>
>  M:	Yehezkel Bernat <YehezkelShB@gmail.com>
> -- 
> 2.18.0
