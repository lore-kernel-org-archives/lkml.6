Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A41C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 065922073D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:10:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 065922073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=phrozen.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729193AbeH3SNM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 14:13:12 -0400
Received: from nbd.name ([46.4.11.11]:35680 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729078AbeH3SNM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 14:13:12 -0400
From:   John Crispin <john@phrozen.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH] nohz: Fix missing tick reprog while interrupting inline timer softirq
Date:   Thu, 30 Aug 2018 16:10:43 +0200
Message-Id: <20180830141043.8169-1-john@phrozen.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <47d2416d-6359-1f48-311d-404fb5bfa3a8@ti.com>
References: <47d2416d-6359-1f48-311d-404fb5bfa3a8@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Sry, that disturbing you all, but what are the conclusion here for 4.14.y?
> - take Thomas's patch https://lore.kernel.org/patchwork/patch/969521/#1162900
> - revert commit 2d898915ccf4838c04531c51a598469e921a5eb5

Hi Frederic,

I reported this very issue to tglx last night and he asked me to verify his
proposed patch which i just did. I can confirm the the patch fixes the issue
on 4.14.67 and Greg should add it to the stable queue please.

Tested-by: John Crispin <john@phrozen.org>

Thanks,
	John

