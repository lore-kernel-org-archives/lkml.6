Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6BB6C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 05:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39C48208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 05:46:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39C48208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbeGaHYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 03:24:30 -0400
Received: from mga12.intel.com ([192.55.52.136]:14315 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726070AbeGaHYa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 03:24:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jul 2018 22:45:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,426,1526367600"; 
   d="scan'208";a="60819400"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.13.118])
  by orsmga007.jf.intel.com with ESMTP; 30 Jul 2018 22:45:55 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Byungchul Park <byungchul.park@lge.com>
Cc:     <linux-kernel@vger.kernel.org>, <kernel-team@lge.com>,
        <peterz@infradead.org>, <mingo@kernel.org>,
        <jiangshanlai@gmail.com>, <paulmck@linux.vnet.ibm.com>,
        <josh@joshtriplett.org>, <rostedt@goodmis.org>,
        <mathieu.desnoyers@efficios.com>, <joel@joelfernandes.org>,
        <len.brown@intel.com>, <glider@google.com>,
        <peter@hurleysoftware.com>, <aik@ozlabs.ru>
Subject: Re: [QUESTION] llist: Comment releasing 'must delete' restriction before traversing
References: <1532998716-5037-1-git-send-email-byungchul.park@lge.com>
        <87d0v4mbgx.fsf@yhuang-dev.intel.com>
        <20180731052551.GA12241@X58A-UD3R>
Date:   Tue, 31 Jul 2018 13:45:54 +0800
In-Reply-To: <20180731052551.GA12241@X58A-UD3R> (Byungchul Park's message of
        "Tue, 31 Jul 2018 14:25:51 +0900")
Message-ID: <8736w0gdpp.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Byungchul Park <byungchul.park@lge.com> writes:

> On Tue, Jul 31, 2018 at 09:37:50AM +0800, Huang, Ying wrote:
>> Byungchul Park <byungchul.park@lge.com> writes:
>> 
>> > Hello folks,
>> >
>> > I'm careful in saying.. and curious about..
>> >
>> > In restrictive cases like only addtions happen but never deletion, can't
>> > we safely traverse a llist? I believe llist can be more useful if we can
>> > release the restriction. Can't we?
>> >
>> > If yes, we may add another function traversing starting from a head. Or
>> > just use existing funtion with head->first.
>> >
>> > Thank a lot for your answers in advance :)
>> 
>> What's the use case?  I don't know how it is useful that items are never
>> deleted from the llist.
>> 
>> Some other locks could be used to provide mutual exclusive between
>> 
>> - llist add, llist traverse
>
> Hello Huang,

Hello Byungchul,

> In my use case, I only do adding and traversing on a llist.

Can you provide more details about your use case?

Best Regards,
Huang, Ying

>> 
>> and
>> 
>> - llist delete
>
> Of course, I will use a lock when deletion is needed.
>
> So.. in the case only adding into and traversing a llist is needed,
> can't we safely traverse a llist in the way I thought? Or am I missing
> something?
>
> Thank you.
>
>> Is this your use case?
>> 
>> Best Regards,
>> Huang, Ying
