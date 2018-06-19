Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC5DC1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 22:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0E6020693
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 22:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rmbYsrW/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0E6020693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965029AbeFSWRC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 18:17:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:41702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964933AbeFSWQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 18:16:53 -0400
Received: from localhost (unknown [146.7.4.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABEB820693;
        Tue, 19 Jun 2018 22:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529446612;
        bh=xd12WkQNgXWdXbcdmp3hzREWVtxXCLEeQTNQoLqFL/U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rmbYsrW/PvT+YwF7IyEe584Z6AamEup1f489C4XkN5XjuWYEfeV3zobGjTA7KasDI
         COXtUeLxOBHZTTriudd0N5yHf5PJzBNTic9i17vsMF57fKOoByv3N63faJZHE+OLC8
         hilbcsQYHxfIdtBAFeekkidT4sAXzvpe+5kfaLO4=
Date:   Tue, 19 Jun 2018 17:16:51 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Rajat Jain <rajatja@google.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frederick Lawler <fred@fredlawl.com>,
        Oza Pawandeep <poza@codeaurora.org>,
        Keith Busch <keith.busch@intel.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Thomas Tai <thomas.tai@oracle.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jes Sorensen <jsorensen@fb.com>,
        Kyle McMartin <jkkm@fb.com>, rajatxjain@gmail.com
Subject: Re: [PATCH v2 0/5] Expose PCIe AER stats via sysfs
Message-ID: <20180619221651.GH33049@bhelgaas-glaptop.roam.corp.google.com>
References: <20180522222805.80314-1-rajatja@google.com>
 <20180523175808.28030-1-rajatja@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180523175808.28030-1-rajatja@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2018 at 10:58:03AM -0700, Rajat Jain wrote:
> This patchset exposes the AER stats via the sysfs attributes.
> 
> Patchset v2 has minor changes to v1 based on the review comments,
> no functional change.
> Primarily:
>  * Fix license header
>  * Use tabs instead of spaces
>  * Remove use on unlikely() etc
>  * Move documentation to Documentation/ABI/
> 
> Rajat Jain (5):
>   PCI/AER: Define and allocate aer_stats structure for AER capable
>     devices
>   PCI/AER: Add sysfs stats for AER capable devices
>   PCI/AER: Add sysfs attributes to provide breakdown of AERs
>   PCI/AER: Add sysfs attributes for rootport cumulative stats
>   Documentation/ABI: Add details of PCI AER statistics
> 
>  .../testing/sysfs-bus-pci-devices-aer_stats   | 103 ++++++++++
>  Documentation/PCI/pcieaer-howto.txt           |   5 +
>  drivers/pci/pci-sysfs.c                       |   3 +
>  drivers/pci/pci.h                             |   4 +-
>  drivers/pci/pcie/aer/Makefile                 |   2 +-
>  drivers/pci/pcie/aer/aerdrv.h                 |  15 ++
>  drivers/pci/pcie/aer/aerdrv_core.c            |  11 +
>  drivers/pci/pcie/aer/aerdrv_errprint.c        |   7 +-
>  drivers/pci/pcie/aer/aerdrv_stats.c           | 192 ++++++++++++++++++
>  drivers/pci/probe.c                           |   1 +
>  include/linux/pci.h                           |   3 +
>  11 files changed, 342 insertions(+), 4 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
>  create mode 100644 drivers/pci/pcie/aer/aerdrv_stats.c

I broke this by putting all the AER code in one file in v4.18-rc1,
sorry!  Would you mind rebasing these on top of that?

Since everything AER-related is now in aer.c, I'd suggest putting the
stats code there, too.
