Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63AF4C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6FCA20851
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:00:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6FCA20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbeLCPAt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 10:00:49 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:24208 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726493AbeLCPAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 10:00:49 -0500
Received: from fsav403.sakura.ne.jp (fsav403.sakura.ne.jp [133.242.250.102])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id wB3F0U7g049754;
        Tue, 4 Dec 2018 00:00:30 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav403.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav403.sakura.ne.jp);
 Tue, 04 Dec 2018 00:00:30 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav403.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id wB3F0Pu7049725
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Tue, 4 Dec 2018 00:00:30 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] printk: don't unconditionally shortcut print_time()
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
References: <1543056613-4779-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20181129141921.djeumz723fr7pasn@pathway.suse.cz>
 <201811300226.wAU2Q2JG060388@www262.sakura.ne.jp>
 <20181130123027.cyqfi2k34nh2gjmx@pathway.suse.cz>
 <02b4ce85-c1e5-6601-e3a7-cecfbd5298dc@i-love.sakura.ne.jp>
 <20181203141435.iyaawog4i6ecgxyi@pathway.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <89a20c81-1def-8f09-8259-3ba552f10981@i-love.sakura.ne.jp>
Date:   Tue, 4 Dec 2018 00:00:22 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <20181203141435.iyaawog4i6ecgxyi@pathway.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/12/03 23:14, Petr Mladek wrote:
> Well, IMHO, it does not explain the pagefault above. The copy_to_user()
> could come either from syslog_print() or from syslog_print_all(). They
> both have their own checks that prevent the buf overflow.
> 
> The code is tricky but it looks safe now. Is it possible that
> the crash was with some old, still broken, code? Or did you
> add some extra changes that you used to trigger a testing
> scenario?

I think I was using unmodified current linux.git, but I failed to save
the reproducer because I was editing under /tmp directory which does not
create a backup.

Anyway, after this patch, no problem is occurring.
