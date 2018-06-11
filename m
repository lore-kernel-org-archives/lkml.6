Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIM_INVALID,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id C6700C5CFF0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70AD5208BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hjOHR/57";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YsZud230"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70AD5208BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753896AbeFKRIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 13:08:02 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60034 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751912AbeFKRIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 13:08:00 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7785D60791; Mon, 11 Jun 2018 17:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528736879;
        bh=LYfjHBrQCAD2IMKPtcaiEKIMm4ONfHzn8wiUlxbZZaA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=hjOHR/57UlHAaBGeYK+02H/18PAHKNzr+byGREmnHQqieOMfoXM84HiXHIAXy7pLe
         s3UpuMgJXXb5fcB+Q7IW6r09lKnpjN+QsqWF+rvk4xNs7mAWB1NnhMZDD9GFEis8c/
         1SySpa2Bzu9u/5cfDUU+iosybCgOjUBPkUeIRcmU=
Received: from [192.168.1.7] (unknown [183.83.75.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rplsssn@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9D8276074D;
        Mon, 11 Jun 2018 17:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528736878;
        bh=LYfjHBrQCAD2IMKPtcaiEKIMm4ONfHzn8wiUlxbZZaA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=YsZud2303SiRIlLaSdlLVi41xZ+GoB+lxI5jop4I+ptAPdLz4fxOsWyi9T9VTN2zP
         XXO7djihwXAAWL8YpDFK6fGBntNd47qm9GAFU2Dy5kWtNKi1ufdmCANYArAPWcOweU
         tt1TYZ0vbuy+SzPZhs5209f4Ooo3PdzrnJmNg9O0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9D8276074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rplsssn@codeaurora.org
Subject: Re: [PATCH v9 01/10] drivers: qcom: rpmh-rsc: add RPMH controller for
 QCOM SoCs
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
References: <1527158731-17685-1-git-send-email-rplsssn@codeaurora.org>
 <1527158731-17685-2-git-send-email-rplsssn@codeaurora.org>
 <CAD=FV=VG-wDqone04dFZHVPUgxvdPQED0eeT90ZobKqtVKJ-hQ@mail.gmail.com>
From:   Raju P L S S S N <rplsssn@codeaurora.org>
Message-ID: <3f5e0d02-7f95-3337-68a2-8fd05c015eb0@codeaurora.org>
Date:   Mon, 11 Jun 2018 22:37:51 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAD=FV=VG-wDqone04dFZHVPUgxvdPQED0eeT90ZobKqtVKJ-hQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/31/2018 3:19 AM, Doug Anderson wrote:
> Hi,
> 
> On Thu, May 24, 2018 at 3:45 AM, Raju P L S S S N
> <rplsssn@codeaurora.org> wrote:
>> diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
>> new file mode 100644
>> index 0000000..99b23b7
>> --- /dev/null
>> +++ b/drivers/soc/qcom/rpmh-rsc.c
>> @@ -0,0 +1,482 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2016-2018, The Linux Foundation. All rights reserved.
>> + */
>> +
>> +#define pr_fmt(fmt) "%s " fmt, KBUILD_MODNAME
>> +
>> +#include <linux/atomic.h>
>> +#include <linux/delay.h>
>> +#include <linux/export.h>
> 
> Now that you're not exporting any symbols in here, presumably you no
> longer need "export.h" right?

Sure. Will remove.

Thanks,
Raju
