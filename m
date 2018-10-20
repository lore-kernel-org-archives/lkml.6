Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 787FBC67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 14:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E8A521534
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 14:14:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E8A521534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbeJTWYg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 18:24:36 -0400
Received: from mga17.intel.com ([192.55.52.151]:6021 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727341AbeJTWYg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 18:24:36 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Oct 2018 07:13:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,404,1534834800"; 
   d="scan'208";a="93597305"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by orsmga003.jf.intel.com with ESMTP; 20 Oct 2018 07:13:58 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 8D3D5300FE1; Sat, 20 Oct 2018 07:13:58 -0700 (PDT)
Date:   Sat, 20 Oct 2018 07:13:58 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andi Kleen <andi@firstfloor.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] x86/microcode: Handle negative microcode revisions
Message-ID: <20181020141358.GB27951@tassilo.jf.intel.com>
References: <20181020001137.31461-1-andi@firstfloor.org>
 <alpine.DEB.2.21.1810201540460.1651@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1810201540460.1651@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 20, 2018 at 03:42:05PM +0200, Thomas Gleixner wrote:
> Andi,
> 
> On Fri, 19 Oct 2018, Andi Kleen wrote:
> > Change the comparison to unsigned. With that the loading works
> > as expected.
> >
> 
> I assume that wants a fixes tag and needs to be backported to stable,
> right?

I think the bug was there since the original microcode loader, not
sure I can dig out the right commit id for that (it might be
in linux-historic)

Yes please cc stable for this.

-Andi
