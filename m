Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A85C04ABB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 02:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B74FC20880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 02:08:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B74FC20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbeILHKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 03:10:55 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:39319 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726686AbeILHKz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 03:10:55 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9C0991586C2B9;
        Wed, 12 Sep 2018 10:08:45 +0800 (CST)
Received: from [127.0.0.1] (10.177.23.164) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.399.0; Wed, 12 Sep 2018
 10:08:38 +0800
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
CC:     Kunxun Xie <xiekunxun@huawei.com>
Subject: [Question] Are the trace APIs declared by
 "TRACE_EVENT(irq_handler_entry" allowed to be used in Ko?
Message-ID: <5B987525.9070300@huawei.com>
Date:   Wed, 12 Sep 2018 10:08:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.23.164]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After patch 7e066fb870fc ("tracepoints: add DECLARE_TRACE() and DEFINE_TRACE()"),
the trace APIs declared by "TRACE_EVENT(irq_handler_entry" can not be directly used
by ko, because it's not explicitly exported by EXPORT_TRACEPOINT_SYMBOL_GPL or
EXPORT_TRACEPOINT_SYMBOL.

Did we miss it? or it's not recommended to be used in ko?


-------------

commit 7e066fb870fcd1025ec3ba7bbde5d541094f4ce1
Author: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Date:   Fri Nov 14 17:47:47 2008 -0500

    tracepoints: add DECLARE_TRACE() and DEFINE_TRACE()

    Impact: API *CHANGE*. Must update all tracepoint users.

    Add DEFINE_TRACE() to tracepoints to let them declare the tracepoint
    structure in a single spot for all the kernel. It helps reducing memory
    consumption, especially when declaring a lot of tracepoints, e.g. for
    kmalloc tracing.

    *API CHANGE WARNING*: now, DECLARE_TRACE() must be used in headers for
    tracepoint declarations rather than DEFINE_TRACE(). This is the sane way
    to do it. The name previously used was misleading.

    Updates scheduler instrumentation to follow this API change.


-- 
Thanks!
BestRegards

