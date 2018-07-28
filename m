Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1359CC67790
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 02:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6378C20873
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 02:30:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6378C20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389407AbeG1Dys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 23:54:48 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:20499 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389312AbeG1Dys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 23:54:48 -0400
Received: from fsav401.sakura.ne.jp (fsav401.sakura.ne.jp [133.242.250.100])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w6S2U7kj078362;
        Sat, 28 Jul 2018 11:30:07 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav401.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav401.sakura.ne.jp);
 Sat, 28 Jul 2018 11:30:07 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav401.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126074194044.bbtec.net [126.74.194.44])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w6S2U24d078301
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sat, 28 Jul 2018 11:30:07 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: [PATCH 13/38] tomoyo: Implement security hooks for the new mount
 API [ver #10]
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, tomoyo-dev-en@lists.sourceforge.jp,
        linux-security-module@vger.kernel.org,
        torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <153271267980.9458.7640156373438016898.stgit@warthog.procyon.org.uk>
 <153271277078.9458.16912166489973051987.stgit@warthog.procyon.org.uk>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <b4be11f6-8235-1ee1-9a01-c09eb9b88404@I-love.SAKURA.ne.jp>
Date:   Sat, 28 Jul 2018 11:29:57 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <153271277078.9458.16912166489973051987.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/07/28 2:32, David Howells wrote:
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

Would you provide examples of each possible combination as a C program?
For example, if one mount point from multiple sources with different
options are possible, please describe such pattern using syscall so that
LSM modules can run it to see whether they are working as expected. 
