Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A4BC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 01:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3756620657
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 01:43:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3756620657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbeKAKog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 06:44:36 -0400
Received: from mga06.intel.com ([134.134.136.31]:64294 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbeKAKog (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 06:44:36 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Oct 2018 18:43:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,450,1534834800"; 
   d="scan'208";a="92823546"
Received: from zhangq-mobl1.ccr.corp.intel.com (HELO wfg-t570.sh.intel.com) ([10.254.209.25])
  by FMSMGA003.fm.intel.com with ESMTP; 31 Oct 2018 18:43:46 -0700
Received: from wfg by wfg-t570.sh.intel.com with local (Exim 4.89)
        (envelope-from <fengguang.wu@intel.com>)
        id 1gI21R-0004zi-Jt; Thu, 01 Nov 2018 09:43:45 +0800
Date:   Thu, 1 Nov 2018 09:43:45 +0800
From:   Fengguang Wu <fengguang.wu@intel.com>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Olof Johansson <olof@lixom.net>,
        Palmer Dabbelt <palmer@sifive.com>,
        linux-riscv@lists.infradead.org, Albert Ou <aou@eecs.berkeley.edu>,
        Zong Li <zongbox@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kbuild@lists.01.org, kbuild test robot <lkp@intel.com>,
        Philip Li <philip.li@intel.com>
Subject: Re: [PATCH 0/3] RISC-V: A few build/warning fixes and cleanup
Message-ID: <20181101014345.cdlte4grtaexb234@wfg-t540p.sh.intel.com>
References: <20181031064709.30981-1-olof@lixom.net>
 <mhng-74b51433-1762-4741-935d-56ca1b3548a0@palmer-si-x1c4>
 <CAOesGMgWDM+Etng3bNU-Yem6+WRJEu+TfddzKoN-htno1Az3=w@mail.gmail.com>
 <861817b9-c5f3-e995-2e18-9526d89d6561@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <861817b9-c5f3-e995-2e18-9526d89d6561@deltatee.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC Philip, current kbuild test robot maintainer.

On Wed, Oct 31, 2018 at 12:12:21PM -0600, Logan Gunthorpe wrote:
>
>On 2018-10-31 11:52 a.m., Olof Johansson wrote:
>> I've migrated machines to a new system and that CI is up and running.
>> Right now the emails don't go anywhere but me, but let me know where
>> you want them sent and I'll be happy to do so (probably not
>> linux-riscv due to volume/noise). They're also uploaded to
>> http://arm-soc.lixom.net/buildlogs/riscv/.
>>
>> Since you keep single-patch branches in your tree, and I compile
>> everything for every branch, I've restricted what branches I poll and
>> build. Right now it's "for*" and "riscv*".
>
>I think it would also be very nice to get the existing kbuild test robot
>to start compile testing a few riscv configs. It already does most of
>the other arches. This would help us catch these kinds of issues even
>earlier seeing that test robot tests patches on mailing lists and many
>other repos before Palmer would even pull them into his branch.
>(Including a repo I routinely push branches to before sending out patches.)
>
>I'm not sure who's currently responsible for the robot but I've copied
>Fenguang who, I believe, set it up originally as well as the kbuild
>lists. Hopefully he can point us in the right direction to help get this
>set up.
>
>Thanks,
>
>Logan
>
