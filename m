Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33525C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 18:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4F6B2081F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 18:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cJks+EjD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4F6B2081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbeLJSCK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 13:02:10 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:40027 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727515AbeLJSCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 13:02:10 -0500
Received: by mail-io1-f65.google.com with SMTP id n9so9480094ioh.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 10:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uFl0eEvOtz6Xbs8l1Y5DM+iasxlKYsSMKPkIeA8sg+s=;
        b=cJks+EjDZwnHR/7flcD7RYPJSjn8DabbWevW1W/G1M1c2bpsH0GPRjFHQBm8AskVz7
         aew/ARW+9uczlmltkuzDMEFTb/fWzAXgKd21SGgVIOkHpSgV/bQ4BJbRyk5mkqyocb6v
         IifGCoT+fmAo/m+QBY6GyBMN8NKYSmW2Uj7ng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uFl0eEvOtz6Xbs8l1Y5DM+iasxlKYsSMKPkIeA8sg+s=;
        b=FHNQUGEYZjfjtnpkKXF4ztoKwJDj2uYPk2/jNVIKZX9MAPW1WMFsOo93SxML314ob4
         /s9sXA0/NGTkT6fVDqh2/k7NqMnAhPK6OD3wqAVChea1lKv2e52GUoaYBOVeYQLFDNBP
         1zVblEABaFEbeWJe7tVIWaV9WQN8cIk5i3/1HiRJ3VkpqyV9XL1NcWtHHQaI/3bmWqjp
         q7NM8RBiR5lWYqtpxLuVKhM3Xjr4pA5ss4DimZswQd9Zq/DIicQsrQXKzjHy71qMRPyM
         i3X0u8feYs8aH5nsh7kBjTbKy9bJ/WDC3plFsqnBcNFaFGD0T4UZVK1yqwveuasS/7Ma
         lNQw==
X-Gm-Message-State: AA+aEWbuCisTnlMQHFfb1cgvcx3cSXCsxXaz1ldejsOiyuJXXVwbB6bZ
        3VbZlef/1cRcbRSlZ1TWP9Mw3LC5qMv3u0kXJtlbuQ==
X-Google-Smtp-Source: AFSGD/V3GFJq6AYLrr/5fp/6m4H7/saKQCTN+DonofFNnovuG6SOkiC0sIaPNEuI+xRu18U+lV+Fi8mf8Yak/T/nVK8=
X-Received: by 2002:a5d:9602:: with SMTP id w2mr1512638iol.86.1544464927974;
 Mon, 10 Dec 2018 10:02:07 -0800 (PST)
MIME-Version: 1.0
References: <CALZhoSRaR-eMyr7HKUTDi5oRiJfRZ7x1NRRM49v-nn6U7e9sJg@mail.gmail.com>
In-Reply-To: <CALZhoSRaR-eMyr7HKUTDi5oRiJfRZ7x1NRRM49v-nn6U7e9sJg@mail.gmail.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Mon, 10 Dec 2018 11:01:55 -0700
Message-ID: <CANLsYkzTGnPQ3FUPWYc-DOigvzMuTFTGqbbVTqqtVuCQW3esSA@mail.gmail.com>
Subject: Re: Coresight etmv4 enable over 32bit kernel
To:     adrian.wenl@gmail.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        leiwen@outlook.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good day Adrian,

On Sat, 8 Dec 2018 at 05:05, Lei Wen <adrian.wenl@gmail.com> wrote:
>
> Hi Mathieu,
>
> I am enabling etmv4 coresight over one Cortex-A7 soc, using 32bit kernel.
> And I am following [1] to do experiment regarding the addr_range feature.

That wiki is very old and after reading it again I seriously consider
removing it.  It is still accurate but there are better ways to do
things now, i.e perf.  The main openCSD documentation page [2]
contains everything you need to know about the integration with perf.

[2]. https://github.com/Linaro/OpenCSD/blob/master/HOWTO.md

> The default addr_range is set as _stext~_etext, and it works fine with
> etb as sink,
> and etm as source. I could see there are valid kernel addresses using OpenCSD.

I'm really curious about how you use openCSD to validate your traces -
can you  expand more on that?

I think the results are misleading you since the openCSD library can't
readily be used to decode sysfs trace sessions.  The wiki doesn't
mention using openCSD to decode traces either.  The only integrated
way to use openCSD to decode CoreSight traces is via perf.  Again, the
link above will give you all the information you need to do that.

>
> But while I try to store one small range of address pair, which contain only one
> kernel function. It doesn't behavior like what said in [1], the write
> pointer would
> grows rapidly with the read pointer. And I dump the etb buffer and parse it with
> openCSD, finding that there is no I_ASYNC packet in the dump and is fulled with
> I_NOT_SYNC.
>
> So my question is why ETB continue to grow when there is no trigger at all?
> Is it normal? I could provide more info if you need it.

I am dubious about the validation process and as such can't comment on
this.  Please share your results using the perf integration and then
I'll be able to have a better idea of what is going on.

Taking a step back I am curious about the ETMv4/ETB combination...  Is
the ETB the only sink you have to work with?  Moreover, are you sure
it is not a TMC-ETF?  The ETMv4/ETB match seems a little odd to me
since they belong to two different era of the CoreSight architecture.
Usually with an ETMv4 we will see a TMC-ETR, which as a lot more
capabilities.

Regards,
Mathieu

>
> [1]: https://wiki.linaro.org/WorklingGroups/Kernel/Coresight/traceDecodingWithDS5
>
> Thanks,
> Lei
