Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89324C18DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 12:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37A59206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 12:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="f3HNuLdm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37A59206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbeKTXPd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 18:15:33 -0500
Received: from merlin.infradead.org ([205.233.59.134]:57052 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727286AbeKTXPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 18:15:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Hx+N0qqyp8Kutna+wQulsJnrAVNatTI43rCTFTdq0qk=; b=f3HNuLdmTaWL6U6rNKK0XscSJ
        ZBfbc3GRz8rgcfXZeSe0LlAINtRcvwb7puUf7gCuRUfLDJn3U9vyhBNt0XEbdSMnsoLB1RFVSMlKB
        rRFSui1FQYkSrdrklS+gqdxKAk8cfmF+D+/Wxscox/Z1RHHuXiqaNFE/SIGsU0um6eJWOarofYWeJ
        06lXtzh0kmYd4CXEkyqJT08b9mFmp4zwgpAK/pxxJOydRwQiCNqBd7KBhTTjSzMWHKV6zPGfTKOld
        k3NGw/D71OUlBpwmZvYxBm/+z4J7hNpjchRwhwjk7oeQgrQ8uEDJbTb3RbPGzsrDbm9ztwT5RtxPl
        CZVMoGJrQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gP5QA-0007cx-HU; Tue, 20 Nov 2018 12:46:27 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EF1D72029F87F; Tue, 20 Nov 2018 13:46:24 +0100 (CET)
Date:   Tue, 20 Nov 2018 13:46:24 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Waiman Long <longman@redhat.com>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH cgroup/for-4.21 1/2] cpuset: Minor cgroup2 interface
 updates
Message-ID: <20181120124624.GL2131@hirez.programming.kicks-ass.net>
References: <20181113201339.GN2509588@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181113201339.GN2509588@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 12:13:39PM -0800, Tejun Heo wrote:
> From b1e3aeb11c5e86ee0988a038c4e7682d6beaa977 Mon Sep 17 00:00:00 2001
> From: Tejun Heo <tj@kernel.org>
> Date: Tue, 13 Nov 2018 12:03:33 -0800
> 
> * Rename the partition file from "cpuset.sched.partition" to
>   "cpuset.cpus.partition".
> 
> * When writing to the partition file, drop "0" and "1" and only accept
>   "member" and "root".

Why though? The Changelog doesn't give rationale for the actual changes.

And I'm not sure I agree with either one of them.

The partition is a scheduling feature; and I like 0/1 much better to
type, so why not allow that?

