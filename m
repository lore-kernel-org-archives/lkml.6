Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5291ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79CB4208E2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:37:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79CB4208E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729627AbeGMJu7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 05:50:59 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:34450 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727189AbeGMJu6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 05:50:58 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7E66B1ACC010B;
        Fri, 13 Jul 2018 17:37:04 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.382.0; Fri, 13 Jul 2018
 17:37:04 +0800
Subject: Re: [PATCH] hostap: hide unused procfs helpers
To:     Arend van Spriel <arend.vanspriel@broadcom.com>, <j@w1.fi>,
        <kvalo@codeaurora.org>
References: <20180713070317.6724-1-yuehaibing@huawei.com>
 <5B485441.1080305@broadcom.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-wireless@vger.kernel.org>, <davem@davemloft.net>,
        Randy Dunlap <rdunlap@infradead.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <6ebda7d5-364a-a242-527c-e57ce4888f9b@huawei.com>
Date:   Fri, 13 Jul 2018 17:37:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <5B485441.1080305@broadcom.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2018/7/13 15:26, Arend van Spriel wrote:
> + Randy
> 
> On 7/13/2018 9:03 AM, YueHaibing wrote:
>> When CONFIG_PROC_FS isn't set, gcc warning this:
>>
>> drivers/net/wireless/intersil/hostap/hostap_hw.c:2901:12: warning: ‘prism2_registers_proc_show’ defined but not used [-Wunused-function]
>>   static int prism2_registers_proc_show(struct seq_file *m, void *v)
>>
>> drivers/net/wireless/intersil/hostap/hostap_proc.c:16:12: warning: ‘prism2_debug_proc_show’ defined but not used [-Wunused-function]
>>   static int prism2_debug_proc_show(struct seq_file *m, void *v)
>>              ^
>> drivers/net/wireless/intersil/hostap/hostap_proc.c:49:12: warning: ‘prism2_stats_proc_show’ defined but not used [-Wunused-function]
>>   static int prism2_stats_proc_show(struct seq_file *m, void *v)
>>              ^
>> drivers/net/wireless/intersil/hostap/hostap_proc.c:177:12: warning: ‘prism2_crypt_proc_show’ defined but not used [-Wunused-function]
>>   static int prism2_crypt_proc_show(struct seq_file *m, void *v)
>>              ^
>>
>> fix this by adding #ifdef around them.
>> hfa384x_read_reg is only used by prism2_registers_proc_show,so move it
>> into #ifdef.
> 
> There was already a fix for this posted by Randy Dunlap taking a different approach, ie. use __maybe_unused classifier. To be honest I prefer the ifdef approach as it is more explicit and does not feel like a cheat.
> 
> Actually some of the functions are between a flag already PRISM2_NO_PROCFS_DEBUG which is in a private header file hostap_config.h. Seems like this would be better placed in Kconfig and depend on CONFIG_PROCFS. Anyway, this driver is old cruft. Maybe some people are still running it, but it is probably not worth the effort so fine with either fix.
> 

I dont check Randy's patch. ignore this pls.

> Regards,
> Arend
> 
> .
> 

