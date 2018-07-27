Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72434C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 08:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 258A420895
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 08:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KVb8H9ks"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 258A420895
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730525AbeG0KCI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 06:02:08 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:37449 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729481AbeG0KCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 06:02:07 -0400
Received: by mail-oi0-f68.google.com with SMTP id k81-v6so7759829oib.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 01:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xiV6W6QUa6RJq0yEgSuELZNPrpqsyFzh7iY14hvALKw=;
        b=KVb8H9ksWGYTSaKoYGki4Ns9wHJNmxiCvRowg2CzbPsXz1yt8kdXG2Ne887ML7FI6S
         IDFaOi8NRElUeKBabnwhziGaok9txvwyxbTgSX+92em9fvhczXmCvwErXKZrt4XXQcFl
         wW7/kzawrWI5yeV3/57FradCR6LCP+ZtToIPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xiV6W6QUa6RJq0yEgSuELZNPrpqsyFzh7iY14hvALKw=;
        b=durZWjUm4LUBDczPVJECxVL278DZzqaZ6zTr/c0DIpQEBYcnYtbJjuhEUH7SlYQgqI
         67FXjlp7orYGI89Q9WlH2l1Gb5IlNVy22VYEDiw9Ms9e6Qvm7LkTYcO3IYBqATX4Zgnl
         +oGhuJdWKmVv75ASbxXGoOd/5yZH0vlfCrOemJFFJATeAf1qxRbJrGbrDdy0L2NB77HS
         sndDUegZkIhyGYQ4IFqJ6nPrUihprLWuC/yHxgFDIgOG0P/3skDdk82Njm3KyfkeoXWF
         PIHm3jtrUegTxnHjedDDbOwTdiJ5pNPY5RVCFBalKPBOiEEVUWpG+JvH8WAzLEOWwYNO
         dBTQ==
X-Gm-Message-State: AOUpUlGezwcP9hIL7jMI01Q6k2RKjQGQF+yW61UyY3tNF+7+PcDSt675
        DRFOxT48BXY3rZswAaCJPWph4iJkYx94C3USpBezzA==
X-Google-Smtp-Source: AAOMgpej8kSI542Srn7mm1qgwOZB+SyCIH7E8aSr4fIqrjzPZKZj9d9gPEjd0OKy0a8Pc7gBeiaUJ/FW3w3AxC8PfLE=
X-Received: by 2002:aca:7c2:: with SMTP id 185-v6mr5773150oih.31.1532680876497;
 Fri, 27 Jul 2018 01:41:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:237a:0:0:0:0:0 with HTTP; Fri, 27 Jul 2018 01:41:15
 -0700 (PDT)
In-Reply-To: <20180727083605.GA20233@amd>
References: <2c3a8911-150a-9b25-2a66-a9432047f96b@lechnology.com>
 <68996338-a902-2b57-0bb9-df274a496b06@gmail.com> <20180718075637.GA10279@amd>
 <913151e4-c19f-9a22-697c-52a9fb48cb32@gmail.com> <0e0cd8f7-dc73-6733-65f2-9a14506b0f0e@gmail.com>
 <20180718221717.GA5451@amd> <20180719202005.GA7763@amd> <CAMz4kuKGcnDqyF29vGDqjRDMWmmk=c=QVQExYrx_Ymomm3qh+g@mail.gmail.com>
 <20180724114147.GA26036@amd> <CAMz4kuKbjUDvqyM3rovRmUpeSabNL6yHX1HpFUYD0pc9d4PNMg@mail.gmail.com>
 <20180727083605.GA20233@amd>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Fri, 27 Jul 2018 16:41:15 +0800
Message-ID: <CAMz4kuLLf84ZnxEVowCFnj9NGGU8zD39A-Oeqr+cbFSuBc1xOw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] leds: core: Introduce generic pattern interface
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        David Lechner <david@lechnology.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On 27 July 2018 at 16:36, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
>> > This should be a bit better. I attempted to compile it with your
>> > driver, but whether it works is an open question.
>>
>> Sorry for late reply. I've compiled and tested this version on my
>> platform, the hardware pattern can work with one small fix as below.
>>
>>  if (led_cdev->pattern_set && !led_cdev->pattern_set(led_cdev,
>> data->steps, data->nsteps)) {
>>         return;
>>  }
>>
>> But I saw there are lots coding style issues and something can be
>> improved in this patch, so will you send out one clean patch (I will
>> help to test the hardware pattern support)? Or I can help to improve
>> this code and try to upstream it again?
>
> If you could do the upstreaming, that would be great.

OK, I will improve the code and test the software/hardware pattern,
and upstream it again with keeping the original authorization.

> I tried to get hardware accelerated LED to work on N900, but that
> hardware is rather complex, so it would take me some time...

-- 
Baolin Wang
Best Regards
