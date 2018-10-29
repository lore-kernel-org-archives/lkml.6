Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 701FBC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A74B2080A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:25:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A74B2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729375AbeJ3DPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 23:15:46 -0400
Received: from mga12.intel.com ([192.55.52.136]:23634 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728238AbeJ3DPq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 23:15:46 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2018 11:25:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,441,1534834800"; 
   d="scan'208";a="81862040"
Received: from agluck-desk.sc.intel.com (HELO agluck-desk) ([10.3.52.160])
  by fmsmga007.fm.intel.com with ESMTP; 29 Oct 2018 11:25:57 -0700
Date:   Mon, 29 Oct 2018 11:25:57 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Daniel Aberger - Profihost AG <d.aberger@profihost.ag>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "s.priebe@profihost.ag" <s.priebe@profihost.ag>,
        "n.fahldieck@profihost.ag" <n.fahldieck@profihost.ag>,
        "p.kramme@profihost.ag" <p.kramme@profihost.ag>
Subject: Re: MCE reports errors that can't be verified
Message-ID: <20181029182557.GA13320@agluck-desk>
References: <6ccf5413-ce2a-bbb9-0203-b0cc9fe2e641@profihost.ag>
 <20181029161525.GI32150@zn.tnic>
 <3908561D78D1C84285E8C5FCA982C28F7D43AA76@ORSMSX110.amr.corp.intel.com>
 <20181029175129.GL32150@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181029175129.GL32150@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 06:51:29PM +0100, Borislav Petkov wrote:
> On Mon, Oct 29, 2018 at 04:59:44PM +0000, Luck, Tony wrote:
> > The EDAC driver printed out those messages,
> 
> I don't think so - that's __print_mce() in mce.c which dumps the three
> lines under "... events logged". Which means, that's the lowest prio,
> fallback notifier which runs when nothing else before it has done any
> logging.

Ah yes. In which case the EDAC driver wasn't loaded (or gave up
silently) to let us arrive at the end of the decode chain.

Another question. Does /proc/interrupts show a lot of CMCI (for
historical reasons this is the THR: line).

-Tony
