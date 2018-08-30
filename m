Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F34C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 08:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79BD32082B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 08:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="H61AcRUH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79BD32082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbeH3MXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 08:23:54 -0400
Received: from mail-it0-f42.google.com ([209.85.214.42]:38739 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727751AbeH3MXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 08:23:54 -0400
Received: by mail-it0-f42.google.com with SMTP id p129-v6so1553112ite.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 01:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DKebPjUuiHkI2MmJvez7z4l5YnMFL+nZpOaMZy0LQAc=;
        b=H61AcRUHfIg2nnQZt1Kh/tin7s3D0GUV6hwvzpbtJ2mQ7ZnB0c/9kI6tmKsG+GLcGR
         2iJBj6C53ZnfnHL/aIs+sQWQL4Y7yVQqLi/KZxqxi8dicqR5mwLkcv7FIFsA6nffN5Je
         Vkw03aGSSEvT1FIgiuIwyHd6bglB6l4kMBMWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DKebPjUuiHkI2MmJvez7z4l5YnMFL+nZpOaMZy0LQAc=;
        b=sp30E5aS1X6WKArfQZ9WeXAAOIT3CNDVSsonYS7WeQg4PWxf3BgxXydvozYDDF5P2x
         FappFQ1zHgotj19E7Ps9B7g0xqO3j+ImYNr4/ds6QlSIix0D7tSlTpvp2NLcxubaoFoD
         3MAbGvWBabCf/CDfevvc7ZWRhcKzbYQNXA+ogGZMFx2GcMz5m/dXnrzn6CkAJlqIgX/T
         dHeoJ8FDjqjt5KxgrKAdNxzuaI7RMPtx7ujGaIOyEL9H3QVuCYcCWEspDVCviRyEFnMH
         Q1DR9+cyrAlmElZwMlAOKWuQgcLYHbTwFU9GdUb/8bFy6tF/3RZo2/yZ6hePvCJKohuT
         5kvQ==
X-Gm-Message-State: APzg51AcLpndieW9LgKZ+bkcY0V7WlsKV4UhTLxb6Ao4dLb5fDKJXyzV
        +NXcuSCo98cviRaIR75N7tiTO6GEFILR6w1qZI5Zzw==
X-Google-Smtp-Source: ANB0VdYO/UdRNueo4zeglbHadcq0rjxGBp4BeCEUdvOs/A2fDzXiNfnrP2yTe3Fu9B0//sHezi3+yMLWMbbra80JqAE=
X-Received: by 2002:a24:3fc6:: with SMTP id d189-v6mr1227923ita.64.1535617375535;
 Thu, 30 Aug 2018 01:22:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:2b03:0:0:0:0:0 with HTTP; Thu, 30 Aug 2018 01:22:55
 -0700 (PDT)
In-Reply-To: <bcdbf067-4213-18ed-6d30-dc0dd2376c02@linaro.org>
References: <516d8599-8038-7b47-a3f5-640bf13856c2@linaro.org>
 <2682482.uFPN0cxrGI@aspire.rjw.lan> <bcdbf067-4213-18ed-6d30-dc0dd2376c02@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 30 Aug 2018 10:22:55 +0200
Message-ID: <CAPDyKFrOoJam38Nc05DTo09HbY964bGaw+27GuikYuEz3o=UWw@mail.gmail.com>
Subject: Re: [RFD] Add debugfs for cpuidle ?
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 May 2018 at 10:47, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> On 24/05/2018 10:28, Rafael J. Wysocki wrote:
>> On Thursday, May 24, 2018 10:14:31 AM CEST Daniel Lezcano wrote:
>>>
>>> Hi all,
>>
>> Hi,
>>
>>> would it be interesting to add debugfs metrics for cpuidle in order
>>> to read some statistics from there and investigate the behavior ?
>>
>> What exactly would you like to see in there?
>
> It could be interesting to have statistics on a per cpu and global basis
> for:
>
> - prediction accuracy:
>
> /sys/kernel/debug/cpuidle/prediction/[good|over|under]
> /sys/kernel/debug/cpuidle/cpu*/state*/prediction/[good|over|under]
>
>  - exit latency
>
> In addition, it is often the case the idle states values are dropped
> randomly, it is interesting to see the average exit latency for the
> states. That could give also an indication the cluster idle state success.
>
> /sys/kernel/debug/cpuidle/state*/latency/[min|max|avg|stddev]
> /sys/kernel/debug/cpuidle/cpu*/state*/prediction/[min|max|avg|stddev]
>
> And perhaps more information like the tick stopped stat ?
>

Daniel,

Any chance that you have some draft version of actual code implementing this?

I would be very interested to try then - or help out to implement
this, in case you haven't started yet.

Kind regards
Uffe
