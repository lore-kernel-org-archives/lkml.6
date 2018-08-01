Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08862C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 05:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3AC4208A2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 05:43:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3AC4208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733235AbeHAH1F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 03:27:05 -0400
Received: from mga12.intel.com ([192.55.52.136]:33441 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733161AbeHAH1F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 03:27:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jul 2018 22:43:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,430,1526367600"; 
   d="scan'208";a="61430322"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.13.118])
  by orsmga008.jf.intel.com with ESMTP; 31 Jul 2018 22:43:11 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Byungchul Park <byungchul.park@lge.com>
Cc:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        <linux-kernel@vger.kernel.org>, <kernel-team@lge.com>,
        <peterz@infradead.org>, <mingo@kernel.org>,
        <jiangshanlai@gmail.com>, <josh@joshtriplett.org>,
        <rostedt@goodmis.org>, <mathieu.desnoyers@efficios.com>,
        <joel@joelfernandes.org>, <len.brown@intel.com>,
        <glider@google.com>, <peter@hurleysoftware.com>, <aik@ozlabs.ru>
Subject: Re: [QUESTION] llist: Comment releasing 'must delete' restriction before traversing
References: <1532998716-5037-1-git-send-email-byungchul.park@lge.com>
        <20180731043042.GJ24813@linux.vnet.ibm.com>
        <20180731092950.GB12241@X58A-UD3R>
Date:   Wed, 01 Aug 2018 13:43:10 +0800
In-Reply-To: <20180731092950.GB12241@X58A-UD3R> (Byungchul Park's message of
        "Tue, 31 Jul 2018 18:29:50 +0900")
Message-ID: <878t5qabgx.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Byungchul Park <byungchul.park@lge.com> writes:

> I think rcu list also works well. But I decided to use llist because
> llist is simpler and has one less pointer.
>
> Just to be sure, let me explain my use case more:
>
>    1. Introduced a global list where single linked list is sufficient.
>    2. All operations I need is to add items and traverse the list.
>    3. Ensure the operations always happen within irq-disabled section.
>    4. I'm considering CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG properly.
>    5. The list can be accessed by every CPU concurrently.
>

Can you provide more information about where is your use case?  Is it a
kernel driver?  Then it is better to submit the patch together with its
user.

And I have the similar concern as Steven Rostedt.  That is, if you are
the only user forever, it's not necessary to change the common code.

Best Regards,
Huang, Ying
