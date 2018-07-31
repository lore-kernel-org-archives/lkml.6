Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6192DC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 01:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2124E20840
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 01:37:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2124E20840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732046AbeGaDPk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 23:15:40 -0400
Received: from mga07.intel.com ([134.134.136.100]:38026 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731997AbeGaDPj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 23:15:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jul 2018 18:37:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,425,1526367600"; 
   d="scan'208";a="76915441"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.13.118])
  by fmsmga001.fm.intel.com with ESMTP; 30 Jul 2018 18:37:51 -0700
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
Date:   Tue, 31 Jul 2018 09:37:50 +0800
In-Reply-To: <1532998716-5037-1-git-send-email-byungchul.park@lge.com>
        (Byungchul Park's message of "Tue, 31 Jul 2018 09:58:36 +0900")
Message-ID: <87d0v4mbgx.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Byungchul Park <byungchul.park@lge.com> writes:

> Hello folks,
>
> I'm careful in saying.. and curious about..
>
> In restrictive cases like only addtions happen but never deletion, can't
> we safely traverse a llist? I believe llist can be more useful if we can
> release the restriction. Can't we?
>
> If yes, we may add another function traversing starting from a head. Or
> just use existing funtion with head->first.
>
> Thank a lot for your answers in advance :)

What's the use case?  I don't know how it is useful that items are never
deleted from the llist.

Some other locks could be used to provide mutual exclusive between

- llist add, llist traverse

and

- llist delete

Is this your use case?

Best Regards,
Huang, Ying
