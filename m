Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIM_INVALID,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 3E3C8C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 06:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D56BF208B5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 06:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JnqL0L58";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="oPMeGcq9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D56BF208B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755829AbeFOGXj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 02:23:39 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45238 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755727AbeFOGXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 02:23:36 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 29ED9607E4; Fri, 15 Jun 2018 06:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529043816;
        bh=YhzXb8vRHTNLHIlLoUp39CIBw9MyapYUW+ARof+gYMU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=JnqL0L585BBoCloFKDVLzIIwvI+C1SCA6eYTP1B5yN3Xm3fXaqdW0O5mP5EFBDpdm
         WQfoeWEdtMZ7KxoLvfo2rGJzZV5Ynbn0xhE/hRtU6SPsDKZytxcAxFUvLbgyS0mG4J
         zJccTdzrC7MMgOmxKZVrsxo04y8OKqZhgzO3DNHA=
Received: from [10.206.16.80] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rplsssn@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1D942606DB;
        Fri, 15 Jun 2018 06:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529043815;
        bh=YhzXb8vRHTNLHIlLoUp39CIBw9MyapYUW+ARof+gYMU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=oPMeGcq9UbERjT+KZpjZvWN/IhCXu+PhdAOyFJFEgCQhj1CRaQwNoatbTHPyBRsM4
         OaE4XnuFlD7MC+2s1FSgU3MIL55ijXLB9BHjVCVTPHfwdYPWFFTzxreK7PZLgMZF0Q
         x4o5iA++vmpJuyjooio6SFPTY2c95eNJqhSsomb0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1D942606DB
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rplsssn@codeaurora.org
Subject: Re: [PATCH v10 04/10] drivers: qcom: rpmh: add RPMH helper functions
To:     Doug Anderson <dianders@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Lina Iyer <ilina@codeaurora.org>
References: <1528737949-17495-1-git-send-email-rplsssn@codeaurora.org>
 <1528737949-17495-5-git-send-email-rplsssn@codeaurora.org>
 <CAD=FV=ULcTE14gNYFA4hWpViDd6srXztvjbVTO7vBOKKMuEdSA@mail.gmail.com>
From:   Raju P L S S S N <rplsssn@codeaurora.org>
Message-ID: <b49e2591-9eaa-f8ef-5da9-30412ae27f4e@codeaurora.org>
Date:   Fri, 15 Jun 2018 11:53:28 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAD=FV=ULcTE14gNYFA4hWpViDd6srXztvjbVTO7vBOKKMuEdSA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/14/2018 2:39 AM, Doug Anderson wrote:
> Hi,
> 
> On Mon, Jun 11, 2018 at 10:25 AM, Raju P L S S S N
> <rplsssn@codeaurora.org> wrote:
>> +void rpmh_tx_done(const struct tcs_request *msg, int r)
>> +{
>> +       struct rpmh_request *rpm_msg = container_of(msg, struct rpmh_request,
>> +                                                   msg);
>> +       struct completion *compl = rpm_msg->completion;
>> +
>> +       rpm_msg->err = r;
>> +
>> +       if (r)
>> +               dev_err(rpm_msg->dev, "RPMH TX fail in msg addr=%#x, err=%d\n",
>> +                       rpm_msg->msg.cmds[0].addr, r);
>> +
>> +       /* Signal the blocking thread we are done */
>> +       if (compl)
>> +               complete(compl);
>> +}
>> +EXPORT_SYMBOL(rpmh_tx_done);
> 
> You're back to too many EXPORT_SYMBOL's again.  Just use this rule of thumb:
> 
> * If it's static, no EXPORT_SYMBOL.
> 
> * If the prototype is in "rpmh-internal.h", no EXPORT_SYMBOL.
> 
> * If the prototype is in "rpmh.h", then yes EXPORT_SYMBOL.
> 
> In the case of rpmh_tx_done: the protype is in rpmh-internal.h
> 
> 
> To fix, squash in crosreview.com/1099841
> 
> 
> -Doug
> 

Sure. Thanks for review.
