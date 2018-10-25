Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C24DC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 20:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 976E020834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 20:12:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 976E020834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aws-it.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbeJZEqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 00:46:34 -0400
Received: from www.aws-it.at ([83.218.181.38]:56212 "EHLO bigboss.aws-it.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbeJZEqe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 00:46:34 -0400
Received: from localhost (localhost [IPv6:::1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by bigboss.aws-it.at (on AWS-IT Business Server) with ESMTPS id CE2F619E3047
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 22:12:21 +0200 (CEST)
Received: from [2a00:15c0:100a:5000::fffc] ([2a00:15c0:100a:5000::fffc]) by
 www.aws-it.at (Horde Framework) with HTTPS; Thu, 25 Oct 2018 20:12:21 +0000
Date:   Thu, 25 Oct 2018 20:12:21 +0000
Message-ID: <20181025201221.Horde.1UXSw9cRIOdmNlpjDXbda3Y@aws-it.at>
From:   astx <astx@aws-it.at>
To:     linux-kernel@vger.kernel.org
Subject: tc qdisc command partially broken with patch-4.14.76-77 up to
 patch-4.14.77-78
User-Agent: Horde Application Framework 5
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tc qdisc command is partially broken after applying patch-4.14.76-77.
Applying patch-4.14.77-78 didn't fix it.

Test command:
   tc qdisc add dev eth0 root handle 1: hfsc default fffd
Kernel answer:
   RTNETLINK answers: Numerical result out of range

I have identified the problematic sub-patch out of patch-4.14.76-77 to  
be the problem:

    diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
    index 22bc6fc48311..cd69aa067543 100644

Without this small patch the above "tc qdisc" command works like a charm.

Maybe someone can have a look at it.

Best regards, Toni


