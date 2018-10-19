Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C75CECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 09:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 015E721486
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 09:53:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 015E721486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.ee
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbeJSR6V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 13:58:21 -0400
Received: from mx2.cyber.ee ([193.40.6.72]:43070 "EHLO mx2.cyber.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726690AbeJSR6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 13:58:21 -0400
Subject: Re: netconsole warning in 4.19.0-rc7
To:     Dave Jones <davej@codemonkey.org.uk>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>
References: <e0611057-1b5b-9990-b9fa-060a9b5eba40@linux.ee>
 <CAM_iQpU0+LVwgMea32KQWf8z6Bp1VTmWOGnWNwNSmV0PZzf_ew@mail.gmail.com>
 <20181017034047.nrhstc3b4wzevnri@codemonkey.org.uk>
 <20181017035038.czaqown24rnjn2pw@codemonkey.org.uk>
 <fc91f629-8b91-c8c6-3c62-ffb400588597@linux.ee>
 <20181018145922.ytqxvdihp3iqounl@codemonkey.org.uk>
From:   Meelis Roos <mroos@linux.ee>
Message-ID: <ddc5fea8-6c66-d096-57bb-c86a3771fec4@linux.ee>
Date:   Fri, 19 Oct 2018 12:51:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181018145922.ytqxvdihp3iqounl@codemonkey.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: et-EE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>   > > I took another look at that error path. Turns out this is all we need I
>   > > think..
>   >
>   > With this patch applied on top of 4.19-rc8, I stll get the warning:
>   >
>   > [   13.722919] WARNING: CPU: 0 PID: 0 at kernel/softirq.c:168 __local_bh_enable_ip+0x2e/0x44
> 
> It's going to be a couple days before I get chance to get back to this.
> Did the previous patch in this thread (without the _bh) fare any better?

Tried it with rcu_read_unlock() instead, still the same.

-- 
Meelis Roos <mroos@linux.ee>
