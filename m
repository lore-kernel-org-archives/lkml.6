Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B216C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 11:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42D9A20869
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 11:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="AtF2VhzL";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Fg0Ibpv6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42D9A20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbeJPTtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 15:49:03 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37488 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbeJPTtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 15:49:03 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BFC11606DC; Tue, 16 Oct 2018 11:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539691134;
        bh=pPWB/+3QyAThJjusACEkLmS9S1w7IwMoy7unkoO6N/Y=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=AtF2VhzL27H6vvHLFse22OOcHPvyf1kZiiSg/4v10/FZSmBzY0f0rfmXILMXAp6PC
         uO6CJvJ3+sk0p6fCqPnxCeN2MaivfLjbVDPsP3oXZITzZt2glrtTt6fnJNhpbzqNsB
         HrNUclqIGAJPX+yG2tHeF9a54EcFaT2tTwoA/TCg=
Received: from [10.79.129.10] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2A1F460386;
        Tue, 16 Oct 2018 11:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539691133;
        bh=pPWB/+3QyAThJjusACEkLmS9S1w7IwMoy7unkoO6N/Y=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Fg0Ibpv6MRjAEKlncwRX7JPVT+cQGiaowONG6QSg6W/M69eQhFOKYu1Z/2LdVWpz9
         vMTNYi/uNFdNyLpmcRpmZOsb/FId/+8zM4zoizqsXAoN4svx13YuFRY2CDN5M9WX+j
         8veeS4O3VXWRrhRovcn4954JOvV/mID5pZm18pqM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2A1F460386
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: Crash in msm serial on dragonboard with ftrace bootargs
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Jiri Slaby <jslaby@suse.com>,
        "Ivan T. Ivanov" <ivan.ivanov@linaro.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Geliang Tang <geliangtang@gmail.com>,
        Pramod Gurav <gpramod@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>
References: <1cae8f10-55f5-20ce-9105-30af6f88bd6e@codeaurora.org>
 <20181016114448.GB21790@kroah.com>
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <b07fd629-75ff-b0ff-1634-d0dbe2fcc185@codeaurora.org>
Date:   Tue, 16 Oct 2018 17:28:47 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181016114448.GB21790@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/2018 5:14 PM, Greg Kroah-Hartman wrote:
> On Tue, Oct 16, 2018 at 05:08:25PM +0530, Sai Prakash Ranjan wrote:
>> Hi,
>>
>> On dragonboard 410c, with "ftrace=function" boot args, the console output
>> slows down and board resets without any backtrace as below. This is tested
>> on latest kernel and seems to exist even in older kernels as well.
>>
>> [    2.949164] EINJ: ACPI disabled.
>> [    3.133001] Serial: 8250/16550 dri
>> Format: Log Type - Time(microsec) - Message - Optional Info
>> Log Type: B - Since Boot(Power On Reset),  D - Delta,  S - Statistic
>>
>> But with pstore enabled, able to get the below backtrace:
>>
>> <4>[    2.949164] EINJ: ACPI disabled.
>> <6>[    3.133001] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
>> <6>[    3.164097] SuperH (H)SCI(F) driver initialized
>> <0>[    3.164471] Internal error: synchronous external abort: 96000010 [#1]
>> PREEMPT SMP
>> <4>[    3.164479] Modules linked in:
>> <4>[    3.164495] CPU: 2 PID: 1 Comm: swapper/0 Not tainted
>> 4.19.0-rc8-00008-ge033b9909fff-dirty #175
>> <4>[    3.164501] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC
>> (DT)
>> <4>[    3.164508] pstate: 40000085 (nZcv daIf -PAN -UAO)
>> <4>[    3.164514] pc : msm_read.isra.2+0x20/0x50
>> <4>[    3.164520] lr : msm_read.isra.2+0x1c/0x50
>> <4>[    3.164526] sp : ffff000008033a50
>> <4>[    3.164531] x29: ffff000008033a50 x28: ffff000009486018
>> <4>[    3.164548] x27: 0000000000000001 x26: ffff7dfffe7ff070
>> <4>[    3.164565] x25: 0000000000000034 x24: ffff000009486000
>> <4>[    3.164582] x23: 0000000000000000 x22: ffff00000978e190
>> <4>[    3.164599] x21: ffff0000095e8228 x20: 0000000000000034
>> <4>[    3.164616] x19: ffff7dfffe7ff008 x18: ffffffffffffffff
>> <4>[    3.164632] x17: 0000000000000000 x16: 0000000000000000
>> <4>[    3.164649] x15: ffff0000094a96c8 x14: ffff00008978e6bf
>> <4>[    3.164666] x13: ffff00000978e6cd x12: 0000000000000038
>> <4>[    3.164683] x11: ffff0000094c6000 x10: 0000000000000c24
>> <4>[    3.164699] x9 : ffff80003c89b400 x8 : ffff000008033970
>> <4>[    3.164716] x7 : ffff80000eb04100 x6 : 00000000000af304
>> <4>[    3.164732] x5 : 0000000000000c40 x4 : ffff80003c06f000
>> <4>[    3.164750] x3 : ffff80003c89b498 x2 : 0000000000000000
>> <4>[    3.164766] x1 : ffff80003ca68000 x0 : 0000000000000800
>> <0>[    3.164785] Process swapper/0 (pid: 1, stack limit =
>> 0x(____ptrval____))
>> <4>[    3.164791] Call trace:
>> <4>[    3.164797]  msm_read.isra.2+0x20/0x50
>> <4>[    3.164804]  msm_reset_dm_count+0x44/0x80
>> <4>[    3.164810]  __msm_console_write+0x1c8/0x1d0
>> <4>[    3.164816]  msm_serial_early_write_dm+0x3c/0x50
>> <4>[    3.164823]  console_unlock.part.6+0x468/0x528
>> <4>[    3.164829]  vprintk_emit+0x210/0x218
>> <4>[    3.164835]  vprintk_default+0x48/0x58
>> <4>[    3.164841]  vprintk_func+0xf0/0x1c0
>> <4>[    3.164847]  printk+0x74/0x94
>> <4>[    3.164853]  sci_init+0x24/0x3c
>> <4>[    3.164859]  do_one_initcall+0x54/0x248
>> <4>[    3.164866]  kernel_init_freeable+0x210/0x378
>> <4>[    3.164872]  kernel_init+0x18/0x118
>> <4>[    3.164878]  ret_from_fork+0x10/0x1c
>> <0>[    3.164884] Code: aa1e03e0 8b214273 97e616f7 d503201f (b9400260)
>>
>> Seems to be issue with the msm serial driver and not ftrace.
>> Could someone look into it.
> 
> As you have the hardware to reproduce this, and it has always been an
> issue, you are the best placed to help resolve this.
> 

I would definitely test if serial guys could point somewhere, not that 
the backtrace is not pointing :) but I am not aware of this serial driver.

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
