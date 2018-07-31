Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 438B0C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 06:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0276208A4
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 06:40:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qbCIytNs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0276208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731503AbeGaITE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 04:19:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:50188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726591AbeGaITE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 04:19:04 -0400
Received: from mail-wm0-f50.google.com (mail-wm0-f50.google.com [74.125.82.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C95C2208A4;
        Tue, 31 Jul 2018 06:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533019219;
        bh=M5iPjbt+mfCCaAgOHVAwXQvzOypOwWm6BRzTdMwXwUk=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=qbCIytNs43zuVRUPrehCNkLAtnz802/jkVy2IXurNFORFGgRDN9ao1WKwINontBWD
         52kWuRy/mPK96tEF5a273/PnNhKS4MZgsgvijg0Wc36llKRXa46PNHgVvd1U3BNLl6
         gp9nHVBG6bIDu6KNhO3a0p91I69VuQ3PUgqzgsls=
Received: by mail-wm0-f50.google.com with SMTP id h20-v6so1810304wmb.4;
        Mon, 30 Jul 2018 23:40:18 -0700 (PDT)
X-Gm-Message-State: AOUpUlHpFaKBSTq2XEGLLFAWdLveIYMYerTyYOusuSooyyWkBShXjYpw
        QcFOr2D3ELoqlct1ksWEJAjx7cM6tAkTphTxClU=
X-Google-Smtp-Source: AAOMgpeoF5uhpMbBMCovda1A1pBTUqHHjciqZSnZBimO84KCUkY327SkLA04uavkrQuEHUtUmk/fLuL79V6LBFADT1A=
X-Received: by 2002:a1c:3a8f:: with SMTP id h137-v6mr1381550wma.72.1533019217347;
 Mon, 30 Jul 2018 23:40:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9141:0:0:0:0:0 with HTTP; Mon, 30 Jul 2018 23:40:16
 -0700 (PDT)
In-Reply-To: <98004c185428f0ff3ba7e21be29f9377@www.akkea.ca>
References: <CAJKOXPczJWdNugbHiLRQv1krUFhZH=muix3M9R2LUT5=4zypYA@mail.gmail.com>
 <20180725194630.10414-1-angus@akkea.ca> <20180725194630.10414-3-angus@akkea.ca>
 <CAJKOXPeowiD7bXwRrG5horJOcxfEavB6XEmF8sz1unGDoykwoA@mail.gmail.com> <98004c185428f0ff3ba7e21be29f9377@www.akkea.ca>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 31 Jul 2018 08:40:16 +0200
X-Gmail-Original-Message-ID: <CAJKOXPcp229Kj4d+5m8JbX8k7ghgDmowiZ8j6KdWJGhAh0ONnQ@mail.gmail.com>
Message-ID: <CAJKOXPcp229Kj4d+5m8JbX8k7ghgDmowiZ8j6KdWJGhAh0ONnQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] power: bq25890_charger.c: Remove unused table
To:     Angus Ainslie <angus@akkea.ca>
Cc:     angus.ainslie@puri.sm, Sebastian Reichel <sre@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 July 2018 at 17:26, Angus Ainslie <angus@akkea.ca> wrote:
> Hi Krzysztof,
>
> On 2018-07-26 00:51, Krzysztof Kozlowski wrote:
>>
>> On 25 July 2018 at 21:46, Angus Ainslie (Purism) <angus@akkea.ca> wrote:
>>>
>>> The BATCMP table isn't used so drop it
>>
>>
>> TBL_VCLAMP also looks unused. TBL_IPRECHG does not have table entry.
>>
>
> I as looking to drop the tables that would be problematic to the new part.
> Would you like me to resolve these 2 as well ?

Yes. Since you are removing some entry then let's remove all unneeded entries.

Krzysztof
