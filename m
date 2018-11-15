Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44C5C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 10:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B15D223CB
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 10:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="iz994EL/";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="UHe3iMsV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B15D223CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387726AbeKOUk4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 15:40:56 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:55384 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728609AbeKOUk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 15:40:56 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id EA06960764; Thu, 15 Nov 2018 10:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542278019;
        bh=UcrABndtdwZgroMuLed8/vaasjc83k8jpPRjBe6hup4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=iz994EL/h4OgrXHnzxHtI0ne5htdqLba9UlCPh0W+rZ6eWufdmHMCCRPUcUv2KBv6
         jjcIYGqtnJaA97LK7gVXpMZjY/pccyXWp+8M2h7r5LuA3FvRVAln5sxgogxEhj38jj
         QpgQCOQiqEn+zm/bXEexIBqaD6f/lbbifcodISTw=
Received: from [10.79.128.176] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9308F6020B;
        Thu, 15 Nov 2018 10:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542278018;
        bh=UcrABndtdwZgroMuLed8/vaasjc83k8jpPRjBe6hup4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=UHe3iMsVMg9sYb5TbuX13dRc796EVZPC2qsAQDv1vYe/4Blc4hX/iHwoGs1q0hWgi
         8bmkMiZb/t3GFyHduTYnjr2J5T1STynx4I8ZqyTwWZxw/YjUoWHh8FK8Wv8ZKMWGgv
         rXH4bnCfZW0CZcFEJ3+R6xu9DGaXCxFqm7w6m+wY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9308F6020B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: Crash in msm serial on dragonboard with ftrace bootargs
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Jiri Slaby <jslaby@suse.com>,
        Kees Cook <keescook@chromium.org>,
        Geliang Tang <geliangtang@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pramod Gurav <gpramod@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>
References: <472db11e-49a6-a1ee-e298-791ee1bbb10b@codeaurora.org>
 <20181016141610.639b9000@gandalf.local.home>
 <accdce6d-8fd2-9f15-d4cd-704cbf0b32eb@codeaurora.org>
 <20181016144123.24c47b38@gandalf.local.home>
 <7781815e-cba2-9e36-db6d-268298747876@codeaurora.org>
 <20181016150328.3450d718@gandalf.local.home>
 <c94103d2-ed5d-bf43-fc71-c60e108f303e@codeaurora.org>
 <20181017223334.29ca2837@vmware.local.home>
 <58d2474c-53cd-e6cb-2d25-db38d1a88da6@codeaurora.org>
 <20181018091706.62310b38@gandalf.local.home>
 <20181019041740.GB141835@joelaf.mtv.corp.google.com>
 <8a75f2d5-f1bd-504e-b545-ae2e2f61ca8f@codeaurora.org>
 <20181019095122.0f1c0946@gandalf.local.home>
 <9cafe321-87f6-98a3-3bda-c2f7a3d7fc67@codeaurora.org>
 <20181019111205.5c8e98e8@gandalf.local.home>
 <1e6cc1fa5263b9edfcf7567d3f9f65fd@codeaurora.org>
 <38099043-f5ed-6d81-bf94-13f61cfa8507@linaro.org>
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <8f65f83b-8cd9-5e35-c324-30b86390906e@codeaurora.org>
Date:   Thu, 15 Nov 2018 16:03:29 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <38099043-f5ed-6d81-bf94-13f61cfa8507@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13/2018 3:14 PM, Srinivas Kandagatla wrote:
> Hi Sai,
> 
> 
> 
> On 25/10/18 15:36, saiprakash.ranjan@codeaurora.org wrote:
>> "If I disable dma node and LS-UART0, then I don't see any crash and
>> ftrace also works fine"
>>
>> And one more observation is that even without ftrace cmdline, if I use
>> earlycon and disable dma, I face the same crash.
>>
>> So basically this seems to be some kind of earlycon and dma issue and
>> not ftrace(I can be wrong).
>>
>> So adding Srinivas for more info on this dma node.
> 
> Its Interesting that my old email conversations with SBoyd show that I 
> have investigated this issue in early 2016!
> 
> My analysis so far:
> 
> This reason for such behavior is due the common iface clock
> (GCC_BLSP1_AHB_CLK) across multiple drivers(serial ports, bam dma
> and other low speed devices).
> The code flow in DB410C is bit different, as the uart0 is first
> attempted to set as console and then uart1, this ordering triggers
> pm state change uart_change_pm(state, UART_PM_STATE_OFF) from serial
> core while setting up uart0, this would go and disable all the
> clocks for uart0.
> As uart1 is not setup Yet, and earlycon is still active, any
> attempts by earlycon to write to registers would trigger a system
> reboot as the clock was just disabled by uart0 change_pm code.
> 
> This can even be triggered with any drivers like spi which uses same
> clock I guess.
> 
> Hope it helps,
> 
> Either earlycon needs to reference the clocks or those clocks needs to
> be marked always-on (but only with earlycon).
> 
>>
>> Also just for a note: apq8096-db820c.dtsi shows UART0 is disabled because
>> bootloader does not allow access to it. Could this also be the case 
>> for db410c?
> No, this is not the case with DB410c. DB820c has added restrictions in 
> TZ, I think new booloaders should have solved this issue.
> 
> 

Hi Srinivas,

Thanks a lot for pointing out the cause of crash.
I just tried setting GCC_BLSP1_AHB_CLK with flag CLK_IS_CRITICAL and the
crash disappears.

But I suppose setting CLK_IS_CRITICAL is not the solution?

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
