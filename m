Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51ED6C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 05:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8E7120671
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 05:35:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8E7120671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729457AbeG0GzK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 02:55:10 -0400
Received: from smtp2.provo.novell.com ([137.65.250.81]:52134 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbeG0GzK (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Fri, 27 Jul 2018 02:55:10 -0400
Received: from linux-r8p5.suse.de (prv-ext-foundry1int.gns.novell.com [137.65.251.240])
        by smtp2.provo.novell.com with ESMTP (TLS encrypted); Thu, 26 Jul 2018 23:34:59 -0600
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     akpm@linux-foundation.org
Cc:     jbaron@akamai.com, viro@zeniv.linux.org.uk, peterz@infradead.org,
        linux-kernel@vger.kernel.org, dave@stgolabs.net
Subject: [PATCH -next 0/2] epoll: loosen irq safety in ep_poll()
Date:   Thu, 26 Jul 2018 22:34:30 -0700
Message-Id: <20180727053432.16679-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Along the same lines than the previous work. Details are in patch 1.
Patch 2 is an add on while eyeballing the code. Similar to the previous
patches, this has survived ltp testcases and various workloads.

Thanks,
Davidlohr

Davidlohr Bueso (2):
  fs/epoll: loosen irq safety in ep_poll()
  fs/eventpoll: simplify ep_is_linked callers

 fs/eventpoll.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

-- 
2.16.4

