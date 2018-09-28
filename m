Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B16CC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 20:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3FBB2073F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 20:31:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3FBB2073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbeI2C4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 22:56:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58270 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726976AbeI2C4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 22:56:32 -0400
Received: from smtp.corp.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2970BC004AA1;
        Fri, 28 Sep 2018 20:31:08 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-8.bos.redhat.com [10.18.17.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 50CEC3091373;
        Fri, 28 Sep 2018 20:31:07 +0000 (UTC)
Subject: Re: [PATCH 4/5] locking/lockdep: Make class->ops a percpu counter
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org
References: <1538157201-29173-5-git-send-email-longman@redhat.com>
 <201809290428.pww5fT2d%fengguang.wu@intel.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <328e72f2-4160-2c14-0998-1dc5208de9af@redhat.com>
Date:   Fri, 28 Sep 2018 16:31:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <201809290428.pww5fT2d%fengguang.wu@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.26
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Fri, 28 Sep 2018 20:31:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/28/2018 04:25 PM, kbuild test robot wrote:
> Hi Waiman,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on tip/locking/core]
> [also build test ERROR on v4.19-rc5 next-20180928]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Waiman-Long/locking-lockdep-Remove-add_chain_cache_classes/20180929-031820
> config: i386-randconfig-s2-201838 (attached as .config)
> compiler: gcc-6 (Debian 6.4.0-9) 6.4.0 20171026
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386 
>
> All errors (new ones prefixed by >>):
>
>    kernel/locking/lockdep_proc.c: In function 'l_show':
>>> kernel/locking/lockdep_proc.c:71:34: error: 'struct lock_class' has no member named 'ops'; did you mean 'pops'?
>      seq_printf(m, " OPS:%8ld", class->ops);
>                                      ^~

OK, I missed the ops reference in lockdep_proc.c which is probably not
built in my debug kernel config. I will fix that in the next version.

-Longman
