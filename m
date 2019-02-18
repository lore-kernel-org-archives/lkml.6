Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A09C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 05:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0287D218D8
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 05:32:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727643AbfBRFb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 00:31:59 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:47898 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725730AbfBRFb6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 00:31:58 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8E1CE8CD8F587F0E1B95;
        Mon, 18 Feb 2019 13:31:56 +0800 (CST)
Received: from [127.0.0.1] (10.184.38.59) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.408.0; Mon, 18 Feb 2019
 13:31:48 +0800
Subject: Re: [PATCH] x86: livepatch: Treat R_X86_64_PLT32 as R_X86_64_PC32
To:     Jiri Kosina <jikos@kernel.org>,
        "chenzefeng (A)" <chenzefeng2@huawei.com>
CC:     "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "sjenning@redhat.com" <sjenning@redhat.com>,
        "vojtech@suse.com" <vojtech@suse.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "live-patching@vger.kernel.org" <live-patching@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Xiexiuqi (Xie XiuQi)" <xiexiuqi@huawei.com>
References: <79A62BFA453EFB42B7A4E40AD8F3A2264F2A872D@DGGEMA503-MBX.china.huawei.com>
 <nycvar.YFH.7.76.1902150826400.11598@cbobk.fhfr.pm>
From:   "chengjian (D)" <cj.chengjian@huawei.com>
Message-ID: <d137b1a4-ae46-f529-15a0-cdc8fbfc6bbe@huawei.com>
Date:   Mon, 18 Feb 2019 13:29:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <nycvar.YFH.7.76.1902150826400.11598@cbobk.fhfr.pm>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.184.38.59]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi£¬Jiri


This patch should be merged into 4.4 stable,

which still use klp_write_module_reloc.


https://elixir.bootlin.com/linux/v4.4.174/source/arch/x86/kernel/livepatch.c


ZeFeng may have sent a stable(4.4-y) patch to the wrong mail-list(mainline).


Thanks.

On 2019/2/15 15:28, Jiri Kosina wrote:
> On Fri, 15 Feb 2019, chenzefeng (A) wrote:
>
>> On x86-64, for 32-bit PC-relacive branches, we can generate PLT32
>> relocation, instead of PC32 relocation. and R_X86_64_PLT32 can be
>> treated the same as R_X86_64_PC32 since linux kernel doesn't use PLT.
>>
>> In linux 4.4 commit b21ebf2fb4cd ("x86: Treat R_X86_64_PLT32 as
>> R_X86_64_PC32") been fixed for the module loading, but not fixed for
>> livepatch relocation, which will fail to load livepatch with the error
>> message as follow: relocation failed for symbol <symbol name> at <symbol
>> address>
>>
>> Signed-off-by: chenzefeng <chenzefeng2@huawei.com>
> What kernel version is this patch based on? We've got rid of x86-specific
> module loading stub and offloaded all the relocation handling to generic
> kmod loader long time ago.
>


