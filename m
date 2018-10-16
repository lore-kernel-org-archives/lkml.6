Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD6C1C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 19:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 727362098A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 19:06:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HilbSA8d";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="c1djIwPm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 727362098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbeJQC6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 22:58:09 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34734 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbeJQC6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 22:58:09 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0100D6130B; Tue, 16 Oct 2018 19:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539716778;
        bh=G1bkRhdg7U1Bs7k0WRQjswBWfUPfdxoY5HA8q92Md/c=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=HilbSA8dX9Gqha4vC8nUiTimdxK+mcUuUORAh17Sn67iWTVqopRgMzNnRtfcPSDqW
         MNGQUILkaMv/+bhseObvKR2HHCKnvCgcdzVsEqNu22fMeVVsuFtIwZw0Jw5WKi/lDY
         3Dy76xv12Ug2wvaxynzFCgf5mXTP+nICPWbTdKjQ=
Received: from [192.168.43.47] (unknown [223.227.22.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 11FA4606DD;
        Tue, 16 Oct 2018 19:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539716777;
        bh=G1bkRhdg7U1Bs7k0WRQjswBWfUPfdxoY5HA8q92Md/c=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=c1djIwPmMEC4FjB93gXOG+rHBoRS0CBFc5pYAyczbllyjQHmNoKpReaqoSskX9cl+
         Vqu4MaAQ08o3V2onnh08bLHNLRsVRUSItd3XNy3CPBZT302OvlKjEA6Nk48qE7HA1/
         9t4gBIXBuOf1ep16nD98EmrCU4nATWw0V8JGWq7E=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 11FA4606DD
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
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <c94103d2-ed5d-bf43-fc71-c60e108f303e@codeaurora.org>
Date:   Wed, 17 Oct 2018 00:36:05 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181016150328.3450d718@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/2018 12:33 AM, Steven Rostedt wrote:
> On Wed, 17 Oct 2018 00:31:03 +0530
> Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org> wrote:
> 
>> Haa seems like you are right! With "ftrace=function
>> ftrace_filter=msm_read" , I can trigger the crash, but
>> sadly "ftrace_notrace=msm_read" also crashes.
> 
> So there's more than one problem area.
> 
> What about ftrace_notrace=m*
> 
> ?
> 

That too crashes.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
