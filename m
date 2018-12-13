Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC57C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 11:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D89E20870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 11:54:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D89E20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728821AbeLMLya (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 06:54:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:50470 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728625AbeLMLy3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 06:54:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C836EAFDE;
        Thu, 13 Dec 2018 11:54:27 +0000 (UTC)
Date:   Thu, 13 Dec 2018 12:54:26 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     "Liu, Chuansheng" <chuansheng.liu@intel.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "sergey.senozhatsky@gmail.com" <sergey.senozhatsky@gmail.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2] kernel/hung_task.c: Force console verbose before panic
Message-ID: <20181213115426.lmymctoawomzlkdo@pathway.suse.cz>
References: <27240C0AC20F114CBF8149A2696CBE4A6015B675@SHSMSX101.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27240C0AC20F114CBF8149A2696CBE4A6015B675@SHSMSX101.ccr.corp.intel.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2018-12-13 01:51:22, Liu, Chuansheng wrote:
> Based on patch commit 401c636a0eeb ("kernel/hung_task.c:
> show all hung tasks before panic"), we could get the
> call stack of hung task.
> 
> However, if the console loglevel is not high, we still
> can not see the useful panic information in practice,
> and in most cases users don't set console loglevel to
> high level.
> 
> This patch is to force console verbose before system
> panic, so that the real useful information can be seen
> in the console, instead of being like the following,
> which doesn't have hung task information.
> 
> Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>

Makes sense and looks good to me:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
