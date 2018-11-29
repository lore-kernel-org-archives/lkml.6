Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E6FC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 11:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6A292081C
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 11:47:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6A292081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbeK2Wwd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 17:52:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:37290 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726736AbeK2Wwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 17:52:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8830EAEC8;
        Thu, 29 Nov 2018 11:47:26 +0000 (UTC)
Date:   Thu, 29 Nov 2018 12:47:25 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: Make printk_emit() local function.
Message-ID: <20181129102919.vfswav3ybemt3ute@pathway.suse.cz>
References: <1542898768-5732-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20181123122405.3iqc6bvdxkngntzl@pathway.suse.cz>
 <d2dd8a02-4e1d-7e9b-4639-fe3a640a2742@i-love.sakura.ne.jp>
 <5cc99d2c-c408-34f7-d1fc-e1cd2a9e31da@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cc99d2c-c408-34f7-d1fc-e1cd2a9e31da@i-love.sakura.ne.jp>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2018-11-24 13:10:25, Tetsuo Handa wrote:
> Well, moving "__printf(3, 4) __cold" to before
> "int devkmsg_emit(int facility, int level, const char *fmt, ...) {"
> seems to be working. I did not know...
> 
> >From 86fff21e5fef6d3f7970cf5c07a54a907e582b52 Mon Sep 17 00:00:00 2001
> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Date: Sat, 24 Nov 2018 13:05:25 +0900
> Subject: [PATCH v2] printk: Make printk_emit() local function.
> 
> printk_emit() is called from only devkmsg_write() in the same file.
> Save object size by making it a local function.
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

JFYI, I have pushed it into printk.git, for-4.21 branch.

Best Regards,
Petr
