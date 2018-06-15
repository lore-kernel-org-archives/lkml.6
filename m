Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 67680C5CFC0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 00:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D523E208D7
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 00:23:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D523E208D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965247AbeFOAXh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 20:23:37 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:45105 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965143AbeFOAXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 20:23:36 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R691e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01429;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0T2mKbdF_1529022207;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0T2mKbdF_1529022207)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 15 Jun 2018 08:23:29 +0800
Subject: Re: [PATCH] doc: add description to dirtytime_expire_seconds
To:     tytso@mit.edu, corbet@lwn.net, akpm@linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1527724613-17768-1-git-send-email-yang.shi@linux.alibaba.com>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <e4cfd434-4ed3-8f27-5f95-d570cfe118ae@linux.alibaba.com>
Date:   Thu, 14 Jun 2018 17:23:25 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1527724613-17768-1-git-send-email-yang.shi@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping


Ted,


Any comment is appreciated.


Regards,

Yang



On 5/30/18 4:56 PM, Yang Shi wrote:
> commit 1efff914afac8a965ad63817ecf8861a927c2ace ("fs: add
> dirtytime_expire_seconds sysctl") introduced dirtytime_expire_seconds
> knob, but there is not description about it in
> Documentation/sysctl/vm.txt.
>
> Add the description for it.
>
> Cc: Theodore Ts'o <tytso@mit.edu>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> ---
> I didn't dig into the old review discussion about why the description
> was not added at the first place. I'm supposed every knob under /proc/sys
> should have a brief description.
>
>   Documentation/sysctl/vm.txt | 11 +++++++++++
>   1 file changed, 11 insertions(+)
>
> diff --git a/Documentation/sysctl/vm.txt b/Documentation/sysctl/vm.txt
> index 17256f2..f4f4f9c 100644
> --- a/Documentation/sysctl/vm.txt
> +++ b/Documentation/sysctl/vm.txt
> @@ -27,6 +27,7 @@ Currently, these files are in /proc/sys/vm:
>   - dirty_bytes
>   - dirty_expire_centisecs
>   - dirty_ratio
> +- dirtytime_expire_seconds
>   - dirty_writeback_centisecs
>   - drop_caches
>   - extfrag_threshold
> @@ -178,6 +179,16 @@ The total available memory is not equal to total system memory.
>   
>   ==============================================================
>   
> +dirtytime_expire_seconds
> +
> +When a lazytime inode is constantly having its pages dirtied, it with an
> +updated timestamp will never get chance to be written out.  This tunable
> +is used to define when dirty inode is old enough to be eligible for
> +writeback by the kernel flusher threads. And, it is also used as the
> +interval to wakeup dirtytime_writeback thread. It is expressed in seconds.
> +
> +==============================================================
> +
>   dirty_writeback_centisecs
>   
>   The kernel flusher threads will periodically wake up and write `old' data

