Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4324EC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 142E22080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:22:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 142E22080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbeJaBQ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 21:16:59 -0400
Received: from mga14.intel.com ([192.55.52.115]:14683 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726223AbeJaBQ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 21:16:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Oct 2018 09:22:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,445,1534834800"; 
   d="scan'208";a="104552320"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by orsmga002.jf.intel.com with ESMTP; 30 Oct 2018 09:22:50 -0700
Message-ID: <8a97f82e93fa42022aaf186ccbe6fef6be56e236.camel@linux.intel.com>
Subject: Re: Build error in drivers/cpufreq/intel_pstate.c
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Igor Stoppa <igor.stoppa@gmail.com>, Len Brown <lenb@kernel.org>
Cc:     linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 30 Oct 2018 09:22:50 -0700
In-Reply-To: <e176a41a-eb24-7f2c-bb75-a9b18eab420f@gmail.com>
References: <e176a41a-eb24-7f2c-bb75-a9b18eab420f@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Tue, 2018-10-30 at 18:00 +0200, Igor Stoppa wrote:
> Hi,
> I'm getting the following build error:
> 
> /home/igor/dev/kernel/linux/drivers/cpufreq/intel_pstate.c: In
> function 
> ‘show_base_frequency’:
> /home/igor/dev/kernel/linux/drivers/cpufreq/intel_pstate.c:726:10: 
> error: implicit declaration of function 
> ‘intel_pstate_get_cppc_guranteed’; did you mean
> ‘intel_pstate_get_epp’? 
> [-Werror=implicit-function-declaration]
>    ratio = intel_pstate_get_cppc_guranteed(policy->cpu);
>            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>            intel_pstate_get_epp
> 
> 

This should fix this:

https://patchwork.kernel.org/patch/10653593/

Thanks,
Srinivas
> 
> on top of:
> 
> commit 11743c56785c751c087eecdb98713eef796609e0
> Merge: 929e134c43c9 928002a5e9da
> 
> --
> igor

