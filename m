Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52843C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 17:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04F6020676
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 17:31:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04F6020676
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729499AbeI1Xzy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 19:55:54 -0400
Received: from mga17.intel.com ([192.55.52.151]:15239 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727870AbeI1Xzy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 19:55:54 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Sep 2018 10:31:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,315,1534834800"; 
   d="scan'208";a="87583380"
Received: from agluck-desk.sc.intel.com (HELO agluck-desk) ([10.3.52.160])
  by orsmga003.jf.intel.com with ESMTP; 28 Sep 2018 10:30:45 -0700
Date:   Fri, 28 Sep 2018 10:30:45 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Firoz Khan <firoz.khan@linaro.org>
Cc:     linux-ia64@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org
Subject: Re: [PATCH v2 0/7] System call table generation support
Message-ID: <20180928173044.GA16322@agluck-desk>
References: <1538057720-3392-1-git-send-email-firoz.khan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538057720-3392-1-git-send-email-firoz.khan@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Still does not boot. Last part of console log (nothing unusual
before the "Kernel panic" line):


EFI Variables Facility v0.08 2004-May-17
sd 5:0:0:0: [sdb] 286749488 512-byte logical blocks: (147 GB/137 GiB)
sd 5:0:0:0: [sdb] Write Protect is off
sd 5:0:0:0: [sdb] Write cache: enabled, read cache: enabled, supports DPO and FUA
 sdb: sdb1 sdb2
sd 5:0:0:0: [sdb] Attached SCSI disk
NET: Registered protocol family 17
console [netcon0] enabled
netconsole: network logging started
Freeing unused kernel memory: 960K
This architecture does not have kernel memory protection.
Run /init as init process
Kernel panic - not syncing: Attempted to kill init! exitcode=0x00007f00

---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x00007f00
 ]---

-Tony
