Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762FBC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37FC920833
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:51:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37FC920833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbeIJNoB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 09:44:01 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:35454 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726081AbeIJNoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 09:44:01 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01353;MF=chengdong.li@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0T8M9MqJ_1536569442;
Received: from ChengdongdeMacBook-Pro.local(mailfrom:chengdong.li@linux.alibaba.com fp:SMTPD_---0T8M9MqJ_1536569442)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 10 Sep 2018 16:50:43 +0800
From:   Chengdong Li <chengdong.li@linux.alibaba.com>
Subject: Question: How to switch a process namespace by nsfs "device" and
 inode number directly?
To:     ebiederm@xmission.com, peterz@infradead.org,
        kjlx@templeofstupid.com
Cc:     hbathini@linux.vnet.ibm.com, brendan.d.gregg@gmail.com,
        ak@linux.intel.com, linux-kernel@vger.kernel.org,
        chengdong.licd@alibaba-inc.com
Message-ID: <0eb9ec62-1c1b-5903-2db6-43ca571580b9@linux.alibaba.com>
Date:   Mon, 10 Sep 2018 16:50:42 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I am getting stuck by the lack of approach to switch process namespace 
by nsfs "device" and inode number in user-space,  for example (mnt: 
0xf0000000)

 From my best understanding, the normal way to do that is by setns 
system call. But setns only accept fd that refer to a opened namespace, 
sometimes we couldn't get it.

For example:  After perf record, perf report couldn't work well once the 
process that runs inside a container has exited, as the /proc/pid/ns 
doesn't exist anymore after process exit.

Any comments are welcome!


Thanks,

Chengdong

