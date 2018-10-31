Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE32C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85A9E20664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:12:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85A9E20664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730016AbeKADLe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 23:11:34 -0400
Received: from ale.deltatee.com ([207.54.116.67]:46788 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729823AbeKADLe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 23:11:34 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1gHuyd-0004UZ-EY; Wed, 31 Oct 2018 12:12:24 -0600
To:     Olof Johansson <olof@lixom.net>,
        Palmer Dabbelt <palmer@sifive.com>,
        Fengguang Wu <fengguang.wu@intel.com>
Cc:     linux-riscv@lists.infradead.org, Albert Ou <aou@eecs.berkeley.edu>,
        Zong Li <zongbox@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kbuild@lists.01.org, kbuild test robot <lkp@intel.com>
References: <20181031064709.30981-1-olof@lixom.net>
 <mhng-74b51433-1762-4741-935d-56ca1b3548a0@palmer-si-x1c4>
 <CAOesGMgWDM+Etng3bNU-Yem6+WRJEu+TfddzKoN-htno1Az3=w@mail.gmail.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <861817b9-c5f3-e995-2e18-9526d89d6561@deltatee.com>
Date:   Wed, 31 Oct 2018 12:12:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAOesGMgWDM+Etng3bNU-Yem6+WRJEu+TfddzKoN-htno1Az3=w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: lkp@intel.com, kbuild@lists.01.org, linux-kernel@vger.kernel.org, zongbox@gmail.com, aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org, fengguang.wu@intel.com, palmer@sifive.com, olof@lixom.net
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 0/3] RISC-V: A few build/warning fixes and cleanup
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2018-10-31 11:52 a.m., Olof Johansson wrote:
> I've migrated machines to a new system and that CI is up and running.
> Right now the emails don't go anywhere but me, but let me know where
> you want them sent and I'll be happy to do so (probably not
> linux-riscv due to volume/noise). They're also uploaded to
> http://arm-soc.lixom.net/buildlogs/riscv/.
> 
> Since you keep single-patch branches in your tree, and I compile
> everything for every branch, I've restricted what branches I poll and
> build. Right now it's "for*" and "riscv*".

I think it would also be very nice to get the existing kbuild test robot
to start compile testing a few riscv configs. It already does most of
the other arches. This would help us catch these kinds of issues even
earlier seeing that test robot tests patches on mailing lists and many
other repos before Palmer would even pull them into his branch.
(Including a repo I routinely push branches to before sending out patches.)

I'm not sure who's currently responsible for the robot but I've copied
Fenguang who, I believe, set it up originally as well as the kbuild
lists. Hopefully he can point us in the right direction to help get this
set up.

Thanks,

Logan

