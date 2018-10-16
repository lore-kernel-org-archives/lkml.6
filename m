Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 727D3C5ACCC
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 19:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C7EE2098A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 19:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gx9WToS0";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="IsHxQDxD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C7EE2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727371AbeJQD3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 23:29:50 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48546 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbeJQD3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 23:29:49 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A69EC6058E; Tue, 16 Oct 2018 19:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539718671;
        bh=87nEN6rIuPW2zeMNyFd0uSduzSRuFFF04A/5qGoh+cc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=gx9WToS0ylATijV//oqjpbIEwarGBrsMZdAUleV7fKaVA/Kg7dL4QU29TVJ6fdr1s
         yXeRwfgBDzbMfhmUqA59eIUb9CVhcnQ+UZc+K4GSs+t3A9eUU18hNOBb7bGlun1EhJ
         PDG8jxi9rRwtJ333IytOHYcodSrqpwB8cZFYyArM=
Received: from [192.168.43.47] (unknown [223.227.22.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D9489612EE;
        Tue, 16 Oct 2018 19:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539718670;
        bh=87nEN6rIuPW2zeMNyFd0uSduzSRuFFF04A/5qGoh+cc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=IsHxQDxDeMnd7Urq254pBFmj3OFFwbQKaDe47eoJaU8ajW6j+t86UCd2Zfg0+kckl
         3ncOd6OqLSh65AOJVWYLIYBajq0JuYfCubcJ8Rhz0etK6u2+PIHG9Ll2AH5NE1eJBk
         EBeZrMJ+4ZmHBXP8LPPmdvODULmRC8MYT5nNeC8A=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D9489612EE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: Crash in msm serial on dragonboard with ftrace bootargs
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Jiri Slaby <jslaby@suse.com>,
        Kees Cook <keescook@chromium.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Geliang Tang <geliangtang@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pramod Gurav <gpramod@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>
References: <1cae8f10-55f5-20ce-9105-30af6f88bd6e@codeaurora.org>
 <20181016112928.4b52afb5@gandalf.local.home>
 <8c2fb318-813d-81f1-1e2f-cdbc68353077@codeaurora.org>
 <20181016125721.236ada82@gandalf.local.home>
 <cab1be04-be06-6f53-7fe9-159936893fc8@codeaurora.org>
 <20181016134803.1b9260c1@gandalf.local.home>
 <472db11e-49a6-a1ee-e298-791ee1bbb10b@codeaurora.org>
 <20181016141610.639b9000@gandalf.local.home>
 <accdce6d-8fd2-9f15-d4cd-704cbf0b32eb@codeaurora.org>
 <20181016144123.24c47b38@gandalf.local.home>
 <7781815e-cba2-9e36-db6d-268298747876@codeaurora.org>
 <20181016150328.3450d718@gandalf.local.home>
 <c94103d2-ed5d-bf43-fc71-c60e108f303e@codeaurora.org>
 <20181016151516.786b16cc@gandalf.local.home>
 <20181016151611.0b59ef3d@gandalf.local.home>
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <743842bd-ffbe-f982-4929-951a789ceeec@codeaurora.org>
Date:   Wed, 17 Oct 2018 01:07:40 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181016151611.0b59ef3d@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/2018 12:46 AM, Steven Rostedt wrote:
> On Tue, 16 Oct 2018 15:15:16 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
>> I'd like to see the full command line as well. I bet if you remove the
>> qcom,msm-uartdm from the command line, and had just ftrace=function, it
>> may also boot fine too. Can you try that?
> 
> Note, I probably wont respond for the rest of the day.
> 

Cool, no problem. Will update if I find anything.

Thanks for your time!

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
