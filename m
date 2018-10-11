Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D36FC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 10:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CBA82077C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 10:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OQLuTxL3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CBA82077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbeJKSBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 14:01:01 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:39300 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbeJKSBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 14:01:00 -0400
Received: by mail-it1-f196.google.com with SMTP id w200-v6so12389044itc.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 03:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=YwMr/dlAqHUUMcpMWKCOop5zD8o3KQFUotXounkz/tE=;
        b=OQLuTxL34FsiMqp/MDI2sNxoFeh3hi6JmkYF0SV3PKNeTm0SswziIEO3/o4/Yd8+/2
         dXBXsxzFCapBLBDxae0yhNqVU6O9PBMLvP3eY9fJeonKjHlDryqJGfc0PrkYzDkfRcX+
         8dhZlR0BX4U4ZmjOC2bEf5Jf6eO3NHcYKdsT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=YwMr/dlAqHUUMcpMWKCOop5zD8o3KQFUotXounkz/tE=;
        b=ttJQsn/N5MN8vmMGmNAbUboDu+tajpFSHYBjWGz4E6gvAB0sos03Tq5hohWNTLTzG+
         GuX8VBiSh7v+/xTnkR2sxTRK/s/rbziL7MD/FNDzZR0JqDGRG8nNPM0mafeEp8QyIJoE
         B7sSZnUmzvuQmLpOg26avIrRhQXqD00XBmg+nzKgSX1McZhnA5j/cYiphVcmu9uNhj9p
         bDS9zQhvN6j3BV+uyWwHrz5XI5APbg2497Os+KFw2SNtbLtYu8Es7dGt8TOamNInZZFk
         D1zllpqqiPa+OQIrK5SyL27ReRBsIgiDmctMZjfN3nVX+I/B3RY3vvw6eEcGm7Plgxtr
         P9Hg==
X-Gm-Message-State: ABuFfohlz0L3hWOtj4yYSJtXgkqD2Z3fbGbDuC9GxmCxjlT0A+Mxu8R8
        Y2ogiqqHK7hf/b0oqTu9eJknkKFW68tDZAxS8mjGgQ==
X-Google-Smtp-Source: ACcGV63rR/T4Ijyf77gLh1TMsOBE0MADzu9QccbSzje1hMEkBcmg6koFhT7VnuFINaZGWCAxsp7kYg8+CuJIS239pj0=
X-Received: by 2002:a24:554c:: with SMTP id e73-v6mr894128itb.157.1539254061377;
 Thu, 11 Oct 2018 03:34:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:3941:0:0:0:0:0 with HTTP; Thu, 11 Oct 2018 03:33:40
 -0700 (PDT)
In-Reply-To: <CAPDyKFp4DEtavAqDg-ymaCcus+Hddv0OrgfS54HsTX+aWdzN+w@mail.gmail.com>
References: <1539000535-13261-1-git-send-email-ludovic.Barre@st.com>
 <CAPDyKFp0oHHS=bkXj_AbiLmbNxW07pFnk-4m9kwQtYkh_ogKgw@mail.gmail.com>
 <cb919bf8-caa2-b2fe-fee4-ae2f0f4c04b5@st.com> <CAPDyKFp4DEtavAqDg-ymaCcus+Hddv0OrgfS54HsTX+aWdzN+w@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 11 Oct 2018 12:33:40 +0200
Message-ID: <CAPDyKFqTNUihEk-i+t4OU1Eq5iBS57XZ4d8P2QbecgW_uT6NnA@mail.gmail.com>
Subject: Re: [PATCH V6 00/23] mmc: mmci: add sdmmc variant for stm32
To:     Ludovic BARRE <ludovic.barre@st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9 October 2018 at 13:18, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 9 October 2018 at 09:54, Ludovic BARRE <ludovic.barre@st.com> wrote:
>> hi Ulf
>>
>> On 10/09/2018 09:30 AM, Ulf Hansson wrote:
>>>
>>> Applied for next, thanks!
>>>
>>> FYI, I made little fixup of the help text in the Kconfig for the last
>>> patch.
>>
>>
>> Thanks for your review.
>> Did you had a feedback on Qcom platform tests?
>
> Nope. I am leaving the tests for Qcom platforms to be done by
> kernelci, let's see what the reports are.

FYI:

https://kernelci.org/boot/id/5bbdcd2b59b5147001b435a4/

Looks good!

Kind regards
Uffe
