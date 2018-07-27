Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3992CC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBE4B205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:03:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBE4B205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388917AbeG0LY4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:24:56 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10143 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731165AbeG0LY4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:24:56 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id EFACA22E7980E;
        Fri, 27 Jul 2018 18:03:41 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.382.0; Fri, 27 Jul 2018
 18:03:39 +0800
Subject: Re: [PATCH] hostap: hide unused procfs helpers
To:     Kalle Valo <kvalo@codeaurora.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>
References: <20180713070317.6724-1-yuehaibing@huawei.com>
 <5B485441.1080305@broadcom.com> <87r2jpvxme.fsf@codeaurora.org>
CC:     <j@w1.fi>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-wireless@vger.kernel.org>,
        <davem@davemloft.net>, Randy Dunlap <rdunlap@infradead.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <9c6401cd-c04c-1230-d360-922b476c6541@huawei.com>
Date:   Fri, 27 Jul 2018 18:03:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <87r2jpvxme.fsf@codeaurora.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/7/27 17:25, Kalle Valo wrote:
> Arend van Spriel <arend.vanspriel@broadcom.com> writes:
> 
>> + Randy
>>
>> On 7/13/2018 9:03 AM, YueHaibing wrote:
>>> When CONFIG_PROC_FS isn't set, gcc warning this:
>>>
>>> drivers/net/wireless/intersil/hostap/hostap_hw.c:2901:12: warning: ‘prism2_registers_proc_show’ defined but not used [-Wunused-function]
>>>   static int prism2_registers_proc_show(struct seq_file *m, void *v)
>>>
>>> drivers/net/wireless/intersil/hostap/hostap_proc.c:16:12: warning: ‘prism2_debug_proc_show’ defined but not used [-Wunused-function]
>>>   static int prism2_debug_proc_show(struct seq_file *m, void *v)
>>>              ^
>>> drivers/net/wireless/intersil/hostap/hostap_proc.c:49:12: warning: ‘prism2_stats_proc_show’ defined but not used [-Wunused-function]
>>>   static int prism2_stats_proc_show(struct seq_file *m, void *v)
>>>              ^
>>> drivers/net/wireless/intersil/hostap/hostap_proc.c:177:12: warning: ‘prism2_crypt_proc_show’ defined but not used [-Wunused-function]
>>>   static int prism2_crypt_proc_show(struct seq_file *m, void *v)
>>>              ^
>>>
>>> fix this by adding #ifdef around them.
>>> hfa384x_read_reg is only used by prism2_registers_proc_show,so move it
>>> into #ifdef.
>>
>> There was already a fix for this posted by Randy Dunlap taking a
>> different approach, ie. use __maybe_unused classifier. To be honest I
>> prefer the ifdef approach as it is more explicit and does not feel
>> like a cheat.
> 
> I also prefer the ifdef approach more so I'm planning to take this
> patch.

It's ok if you prefer pick this.

> 

