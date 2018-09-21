Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D642C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 08:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03D5D2147C
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 08:29:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03D5D2147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389375AbeIUORG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 10:17:06 -0400
Received: from mga01.intel.com ([192.55.52.88]:47809 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726479AbeIUORG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 10:17:06 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Sep 2018 01:29:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,284,1534834800"; 
   d="scan'208";a="259109743"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by orsmga005.jf.intel.com with SMTP; 21 Sep 2018 01:28:38 -0700
Received: by lahna (sSMTP sendmail emulation); Fri, 21 Sep 2018 11:28:37 +0300
Date:   Fri, 21 Sep 2018 11:28:37 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Yehezkel Bernat <yehezkelshb@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andreas Noever <andreas.noever@gmail.com>,
        michael.jamet@intel.com, lukas@wunner.de,
        anthony.wong@canonical.com
Subject: Re: [PATCH v2 0/4] thunderbolt: Miscellaneous cleanups
Message-ID: <20180921082837.GG2664@lahna.fi.intel.com>
References: <20180917144334.18367-1-mika.westerberg@linux.intel.com>
 <CA+CmpXvX2iOhc4eR2mTK1V+5p_w0UbpkVOR+Fv8JkadnD8t1TQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CmpXvX2iOhc4eR2mTK1V+5p_w0UbpkVOR+Fv8JkadnD8t1TQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 01:33:19PM +0300, Yehezkel Bernat wrote:
> On Mon, Sep 17, 2018 at 5:43 PM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> >
> > Hi all,
> >
> > Here are a couple of changes which have been in my TODO list some time
> > already but have not had time to make a proper patch out of them until now.
> >
> > The only change to the previous version is that I realized it could be
> > useful for users to see the actual connected devices (including their name
> > which is read from DROM) printed to the system log. Hence the patch 2/4.
> >
> > Mika Westerberg (4):
> >   thunderbolt: Make the driver less verbose
> >   thunderbolt: Print connected devices
> >   thunderbolt: Convert rest of the driver files to use SPDX identifier
> >   thunderbolt: Add Intel as copyright holder
> >
> >  drivers/thunderbolt/cap.c      |  3 +-
> >  drivers/thunderbolt/ctl.c      |  9 +++--
> >  drivers/thunderbolt/ctl.h      |  3 +-
> >  drivers/thunderbolt/dma_port.c |  5 +--
> >  drivers/thunderbolt/dma_port.h |  5 +--
> >  drivers/thunderbolt/domain.c   |  7 +---
> >  drivers/thunderbolt/eeprom.c   |  5 ++-
> >  drivers/thunderbolt/icm.c      |  5 +--
> >  drivers/thunderbolt/nhi.c      | 33 ++++++++--------
> >  drivers/thunderbolt/nhi.h      |  3 +-
> >  drivers/thunderbolt/nhi_regs.h |  1 +
> >  drivers/thunderbolt/path.c     | 26 ++++++-------
> >  drivers/thunderbolt/property.c |  5 +--
> >  drivers/thunderbolt/switch.c   | 71 +++++++++++++++++++---------------
> >  drivers/thunderbolt/tb.c       | 10 ++---
> >  drivers/thunderbolt/tb.h       |  9 +++--
> >  drivers/thunderbolt/tb_msgs.h  |  5 +--
> >  drivers/thunderbolt/tb_regs.h  |  3 +-
> >  drivers/thunderbolt/xdomain.c  |  5 +--
> >  include/linux/thunderbolt.h    |  5 +--
> >  20 files changed, 107 insertions(+), 111 deletions(-)
> >
> > --
> > 2.18.0
> >
> 
> Acked-by: Yehezkel Bernat <yehezkelshb@gmail.com>

Thanks! Applied all to thunderbolt.git/next.
