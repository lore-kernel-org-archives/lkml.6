Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E66C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 23:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EFE5208E8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 23:34:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EFE5208E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732460AbeGJXgI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 19:36:08 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:30774 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732414AbeGJXgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 19:36:07 -0400
Received: from fsav402.sakura.ne.jp (fsav402.sakura.ne.jp [133.242.250.101])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w6ANYJZi033614;
        Wed, 11 Jul 2018 08:34:19 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav402.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav402.sakura.ne.jp);
 Wed, 11 Jul 2018 08:34:19 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav402.sakura.ne.jp)
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w6ANYJI7033609;
        Wed, 11 Jul 2018 08:34:19 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: (from i-love@localhost)
        by www262.sakura.ne.jp (8.15.2/8.15.2/Submit) id w6ANYJCl033608;
        Wed, 11 Jul 2018 08:34:19 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-Id: <201807102334.w6ANYJCl033608@www262.sakura.ne.jp>
X-Authentication-Warning: www262.sakura.ne.jp: i-love set sender to penguin-kernel@i-love.sakura.ne.jp using -f
Subject: Re: [PATCH 10/32] tomoyo: Implement security hooks for the new mount API
 [ver #9]
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        tomoyo-dev-en@lists.sourceforge.jp, torvalds@linux-foundation.org
MIME-Version: 1.0
Date:   Wed, 11 Jul 2018 08:34:19 +0900
References: <153126248868.14533.9751473662727327569.stgit@warthog.procyon.org.uk> <153126255706.14533.4069320423640498264.stgit@warthog.procyon.org.uk>
In-Reply-To: <153126255706.14533.4069320423640498264.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells wrote:
> Implement the security hook to check the creation of a new mountpoint for
> Tomoyo.
> 
> As far as I can tell, Tomoyo doesn't make use of the mount data or parse
> any mount options, so I haven't implemented any of the fs_context hooks for
> it.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> cc: tomoyo-dev-en@lists.sourceforge.jp
> cc: linux-security-module@vger.kernel.org
> 

Would you provide examples of each possible combination as a C program?
For example, if one mount point from multiple sources with different
options are possible, please describe such pattern using syscall so that
LSM modules can run it to see whether they are working as expected.
