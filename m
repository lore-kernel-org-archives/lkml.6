Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB9CECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 12:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 319A8208E2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 12:00:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 319A8208E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729773AbeGMMOb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 08:14:31 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:35404 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728327AbeGMMOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 08:14:30 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fdwk0-0006od-Tu; Fri, 13 Jul 2018 12:00:04 +0000
Date:   Fri, 13 Jul 2018 13:00:04 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     syzbot <syzbot+2349f5067b1772c1d8a5@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] fs: Add to super_blocks list after SB_BORN is set.
Message-ID: <20180713120004.GF30522@ZenIV.linux.org.uk>
References: <000000000000da8a9b0570a29c01@google.com>
 <0145d376-7ef8-3e17-5a24-94de946a01e5@I-love.SAKURA.ne.jp>
 <7dc64116-f43d-3739-7b35-4eef7a80e343@I-love.SAKURA.ne.jp>
 <5c3c26a9-c5ac-6f1c-1465-4127db1db9f7@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c3c26a9-c5ac-6f1c-1465-4127db1db9f7@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 07:09:03PM +0900, Tetsuo Handa wrote:
> More simple version. Is this assumption correct?

Racy, for obvious reasons (sget/sget)
