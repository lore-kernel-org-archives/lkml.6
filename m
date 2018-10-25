Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A39ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C05F2083E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:36:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PPtfay5t";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="S8h62TKP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C05F2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbeJYXJp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 19:09:45 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44948 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727323AbeJYXJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 19:09:44 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 293DD60ADB; Thu, 25 Oct 2018 14:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540478201;
        bh=ae06Uuix05sxCrgjLdzFa+7st8or6RmpnX5uJM851+Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PPtfay5tb8q67/M171Es/WbzT4jaCYZymWzEhs7JhPLyBdl8DEGUBkj034Vv+wxR+
         ANNyl5JUY7Ys983i+yynpFpS36gcDhy4rJZFK8jph3YBG3ahetA1uGWlgaTzDQB7kc
         RT7IKe6kQOJx1kohU4hcjEyqGyzk+I+DCBxX2lZQ=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 6DE1E60769;
        Thu, 25 Oct 2018 14:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540478199;
        bh=ae06Uuix05sxCrgjLdzFa+7st8or6RmpnX5uJM851+Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=S8h62TKPNMWm2SwmjLZ4dCQDg1xbXP/q+1WcUFzTsW7LeFlyB5RHB4GE/V0hJSzad
         8En3nu6yRHv+PpAhHhfjnaIzAlpy2bcuA9SPxqAgj9nI16Zp814KG9kO4xE3/skJQD
         SGBWqzuDpos2Fz7GTTGdSQ9kJO4q5iRB8mxmivc0=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 25 Oct 2018 20:06:39 +0530
From:   saiprakash.ranjan@codeaurora.org
To:     Steven Rostedt <rostedt@goodmis.org>,
        srinivas.kandagatla@linaro.org, Stephen Boyd <sboyd@kernel.org>
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
Subject: Re: Crash in msm serial on dragonboard with ftrace bootargs
In-Reply-To: <20181019111205.5c8e98e8@gandalf.local.home>
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
Message-ID: <1e6cc1fa5263b9edfcf7567d3f9f65fd@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/19/2018 8:42 PM, Steven Rostedt wrote:
> On Fri, 19 Oct 2018 20:18:19 +0530
> Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org> wrote:
> 
> 
>>> You said that if you add 'ftrace_filter=msm_read' to the command 
>>> line,
>>> it still crashes?
>>> 
>>> So only tracing that function we have an issue, right?
>>> 
>> 
>> Tracing msm_read does cause the crash, but that is not the only one
>> causing the crash because even after "ftrace_notrace=msm_read" the 
>> board
>> crashes which is why I suspect msm earlycon and not ftrace.
> 
> I'm saying there's a combination of the two. Because when ftrace is not
> involved, early con doesn't crash.
> 
> I would focus on why earlycon crashes when only msm_read is traced.
> That should help narrow down the cause.
> 
> What we know is:
> 
> 	earlycon -> boots
> 
> 	ftrace=function -> boots
> 
>   	earlycon ftrace=function ftrace_filter=msm_read -> crashes
> 
> If we remove the "ftrace=function ftrace_filter=msm_read" it boots
> fine, and I'm assuming that if we just remove earlycon (keeping the
> ftrace_filter), it also boots too.
> 
> Thus, ftrace tracing msm_read is causing earlycon to do something that
> triggers the crash.
> 

Hi,

Sorry for late response on this, was running out of debug options
;-)

Finally after bisecting (which I should have done earlier) this issue
till 4.4 kernel where I don't see the crash,  I could see that
dma node in "apq8016-sbc.dtsi" is somehow causing the crash.

                 dma@7884000 {
                          status = "okay";    <--- This one
                  };

                  serial@78af000 {
                          label = "LS-UART0";
                          status = "okay";
                          pinctrl-names = "default", "sleep";
                          pinctrl-0 = <&blsp1_uart1_default>;
                          pinctrl-1 = <&blsp1_uart1_sleep>;
                  };

                  serial@78b0000 {
                          label = "LS-UART1";
                          status = "okay";
                          pinctrl-names = "default", "sleep";
                          pinctrl-0 = <&blsp1_uart2_default>;
                          pinctrl-1 = <&blsp1_uart2_sleep>;
                  };

"If I disable dma node and LS-UART0, then I don't see any crash and
ftrace also works fine"

And one more observation is that even without ftrace cmdline, if I use
earlycon and disable dma, I face the same crash.

So basically this seems to be some kind of earlycon and dma issue and
not ftrace(I can be wrong).

So adding Srinivas for more info on this dma node.

Also just for a note: apq8096-db820c.dtsi shows UART0 is disabled 
because
bootloader does not allow access to it. Could this also be the case for 
db410c?

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation
