Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E21DFC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A93520880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:51:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A93520880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbeILV4v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 17:56:51 -0400
Received: from mga18.intel.com ([134.134.136.126]:20768 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726798AbeILV4u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 17:56:50 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Sep 2018 09:51:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,365,1531810800"; 
   d="scan'208";a="73725883"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by orsmga006.jf.intel.com with ESMTP; 12 Sep 2018 09:51:27 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 2338D301376; Wed, 12 Sep 2018 09:51:27 -0700 (PDT)
Date:   Wed, 12 Sep 2018 09:51:27 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Chengdong Li <chengdong.li@linux.alibaba.com>
Cc:     ebiederm@xmission.com, peterz@infradead.org,
        kjlx@templeofstupid.com, hbathini@linux.vnet.ibm.com,
        brendan.d.gregg@gmail.com, linux-kernel@vger.kernel.org,
        chengdong.licd@alibaba-inc.com
Subject: Re: Question: How to switch a process namespace by nsfs "device" and
 inode number directly?
Message-ID: <20180912165127.GX27886@tassilo.jf.intel.com>
References: <0eb9ec62-1c1b-5903-2db6-43ca571580b9@linux.alibaba.com>
 <20180910160201.GV27886@tassilo.jf.intel.com>
 <52b34c00-fb4d-7490-5a40-0b7328895ad1@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52b34c00-fb4d-7490-5a40-0b7328895ad1@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 10:05:27AM +0800, Chengdong Li wrote:
> Thank you, Andi!
> 
> Yes, that's a situation, also it's an important one I guess.
> 
> Another case is that a process running inside a container has exited but the
> container still alive.I think this is also a common case. The potential fix
> solutions I am thinking are following:
> 
> - Using nsfs "device" and inum. This is why I am asking for your help. As we
> already have nsfs "device" and inum of each thread at least.
> 
> - If the current thread has exited, it's probably the parent thread and the
> leader thread of that container are still alive. If we could have those
> threads' pid, then we could use setns.

This would require perf record to parse the data stream and do this
in time. There's no guarantee it can do that in time, and it would
cause a lot more overhead. Currently the data is just passed through.

> 
> If the first item is not doable, I would like to try the second one.

Yes I think that's needed.

-Andi
