Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFCE0C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 08:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F1B720846
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 08:26:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F1B720846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933025AbeFUIZ5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 04:25:57 -0400
Received: from mga07.intel.com ([134.134.136.100]:23697 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932466AbeFUIZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 04:25:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jun 2018 01:25:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,251,1526367600"; 
   d="scan'208";a="239031151"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.13.118])
  by fmsmga005.fm.intel.com with ESMTP; 21 Jun 2018 01:25:53 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kernel test robot <xiaolong.ye@intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        LKP <lkp@01.org>, Aaron Lu <aaron.lu@intel.com>
Subject: Re: [lkp-robot] [Kbuild] 050e9baa9d: netperf.Throughput_total_tps -5.6% regression (FYI)
References: <20180621080624.GO11011@yexl-desktop>
        <CA+55aFxXCD8qLfHcnshLR2_Feb=RLkOFfCeqPF_sShy7rK2cAw@mail.gmail.com>
Date:   Thu, 21 Jun 2018 16:25:53 +0800
In-Reply-To: <CA+55aFxXCD8qLfHcnshLR2_Feb=RLkOFfCeqPF_sShy7rK2cAw@mail.gmail.com>
        (Linus Torvalds's message of "Thu, 21 Jun 2018 17:15:09 +0900")
Message-ID: <87muvoh7fy.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Linus,

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Thu, Jun 21, 2018 at 5:10 PM kernel test robot <xiaolong.ye@intel.com> wrote:
>>
>> FYI, we noticed a -5.6% regression of netperf.Throughput_total_tps
>> due to commit 050e9b ("Kbuild: rename CC_STACKPROTECTOR[_STRONG]
>> config variables")
>
> That's perhaps a surprisingly large cost to stack protector, but you
> did move from "no stack protector at all":
>
>> $ grep STACKPROTECTOR config-4.17.0-11782-gbe779f0
>> CONFIG_HAVE_CC_STACKPROTECTOR=y
>> CONFIG_CC_HAS_STACKPROTECTOR_NONE=y
>> # CONFIG_CC_STACKPROTECTOR is not set
>> CONFIG_CC_HAS_SANE_STACKPROTECTOR=y
>
> To having the *strong* stack protector enabled:
>
>> $ grep STACKPROTECTOR config-4.17.0-11783-g050e9baa
>> CONFIG_HAVE_CC_STACKPROTECTOR=y
>> CONFIG_CC_HAS_STACKPROTECTOR_NONE=y
>> CONFIG_STACKPROTECTOR=y
>> CONFIG_STACKPROTECTOR_STRONG=y
>> CONFIG_CC_HAS_SANE_STACKPROTECTOR=y
>
> so you're testing the "no overhead" case to the "worst overhead" case.

Do you have interest in some other comparison?

Best Regards,
Huang, Ying
