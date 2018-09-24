Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A085ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 243F5206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:40:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 243F5206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731022AbeIXXnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 19:43:43 -0400
Received: from mga06.intel.com ([134.134.136.31]:3813 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbeIXXnn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 19:43:43 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Sep 2018 10:40:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,298,1534834800"; 
   d="scan'208";a="91498752"
Received: from agluck-desk.sc.intel.com (HELO agluck-desk) ([10.3.52.160])
  by fmsmga004.fm.intel.com with ESMTP; 24 Sep 2018 10:38:20 -0700
Date:   Mon, 24 Sep 2018 10:38:20 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-ia64@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>
Subject: Re: [REVIEW][PATCH 0/3] signal/ia64: siginfo fixes and cleanups
Message-ID: <20180924173818.GA9522@agluck-desk>
References: <87bm8n2czz.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bm8n2czz.fsf@xmission.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 04:20:32PM +0200, Eric W. Biederman wrote:
> 
> It turns out that ia64 is one of the noticable offenders.  Ever since
> ia64 was merged in 2.3.43 it has been generating incorrect siginfo for
> SIGSEGV assocaited with the inability to setup a signal stack frame
> or cleanup a signal stack frame.

I'll blame that on the "previous administration". I didn't start work
on Linux until 2.3.99, and didn't take over as maintainer until 2.6.11 :-)

> I don't think I have made made any mistakes in this coversion but if
> people can look the code over and see if they can spot anything I would
> appreciate it.

I don't see any mistakes either. It builds and boots. Obviously I don't
have a test case for this issue (or it would have been found long ago).

> My intention is to merge this through my siginfo tree.  If you feel it
> should go through your arch tree let me know.   All of the prerequisites
> should have been merged several releases ago.

Sure. Merge away.

Acked-by: Tony Luck <tony.luck@intel.com>

-Tony
