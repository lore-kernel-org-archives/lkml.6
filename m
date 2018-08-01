Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F13C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 12:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D971D208A4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 12:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ioc2o97o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D971D208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389168AbeHAOOb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 10:14:31 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:41061 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388696AbeHAOOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 10:14:31 -0400
Received: by mail-qt0-f193.google.com with SMTP id e19-v6so19572587qtp.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 05:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=uUgNRd8RW6SUWu68WCTOVudR6JWC0bHDCdFEswv3m74=;
        b=ioc2o97oH8B3Ti/49otTUlU++IaD+xpkOyg8nhkIShv1KsFuRftSWKXJxu7UcIbLxO
         Wij1eRSIcD5ufaEiQxWwsEHYRr0YEPNvCvkOSOB7QlHVsHEC49iaJFx9vejrhKxHACfe
         P/sY+Dgq1Qq1CyI7Oo6ivWCSnwYOVm2NEUwYCPkx60wsyHuJ2EDV9Wc0fKCImYMDbBFv
         86QGCXWT53hifhDxgGEeMUE+bqg2L0GZiCweFHXloeGEpCfBymrqDhXmb9dNvmrewbws
         3Wj12PM+tLKvW8qiwAZYfiQAGPkEcpcLz2Hu3m7pVxCMPoQowjJcRK2AmdALqItCDN0F
         dP8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=uUgNRd8RW6SUWu68WCTOVudR6JWC0bHDCdFEswv3m74=;
        b=ugdXbDfNmxV3VOxbCt6eoWaVCWj7KLV2s9PZ2LThSwPJhNh4ZDR5c6CWw5xH8awNgM
         iQsXIUGnUavQvorgLSrritOzEoHAafysiBWr42r0OYzGet/0F4km6tv/uOJO2ACEDcry
         mjBA605qDToR1G/8eXkGzH5ZwK4ZTTnswU5YsnsjhKjuIsU/lHXsGTuFG/cGg0UdNWwI
         PqZgJhD4gsxmV30BVoLh2AE7QMbYEqh1AP0cqw/V6TeajPqyCTnEh/RIyFnVSJYmgghW
         MZABdUWphekuc/rDb1+kc0ULFnrhoBuh59WRzbislNwSonAlE5IWc2bKMXR3KTz6xgyH
         7sKg==
X-Gm-Message-State: AOUpUlHW7LJHaIgyf9Xai8LMJfHw/dkwiw6zDlzmt35Lw8p8CQ+sQg1+
        LsNtwLWbZs84s17sG63EkzJh3O35oVtMVQ+eLzk=
X-Google-Smtp-Source: AAOMgpfZeZrH1X2rAU9ivsI7Msh8xLVknJNL/JmAcE4QZaqYjy3Q77m6EcrnWyfVEpiNv2xBq6T6lYPnA2nfqPoJ42w=
X-Received: by 2002:ac8:1631:: with SMTP id p46-v6mr26012765qtj.72.1533126537063;
 Wed, 01 Aug 2018 05:28:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:471a:0:0:0:0:0 with HTTP; Wed, 1 Aug 2018 05:28:36 -0700 (PDT)
In-Reply-To: <20180731025905.GS15118@mellanox.com>
References: <20180730162431.GA13989@gmail.com> <20180731025905.GS15118@mellanox.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 1 Aug 2018 14:28:36 +0200
Message-ID: <CANiq72mvCByCWvxpELMYr2VwWq=XzCFCkFGoXMK9bU4RGEBhCg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add .clang-format entry
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Joe Perches <joe@perches.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,
On Tue, Jul 31, 2018 at 4:59 AM, Jason Gunthorpe <jgg@mellanox.com> wrote:
> On Mon, Jul 30, 2018 at 06:24:31PM +0200, Miguel Ojeda wrote:
>> As discussed in https://lkml.org/lkml/2018/6/25/877
>>
>> Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
>> ---
>>  MAINTAINERS | 5 +++++
>>  1 file changed, 5 insertions(+)
>
> Thanks! Did you setup a tree? Can you take the patch I sent as well?
> Do you want me to resend it?

No, I didn't, but I will pick both and put it up in a branch at
https://github.com/ojeda/linux for a later PR assuming they are not
picked up when the merge window opens. No need to resend! :-)

Cheers & thanks!
Miguel

>
> Jason
