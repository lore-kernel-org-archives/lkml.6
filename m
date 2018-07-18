Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B882FECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 630BF2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X6EQTfw0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 630BF2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731593AbeGRREo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 13:04:44 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:44019 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731586AbeGRREo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 13:04:44 -0400
Received: by mail-ua0-f195.google.com with SMTP id x24-v6so3297865ual.10;
        Wed, 18 Jul 2018 09:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8YMZ0uZa465zrChzYNNUEs0iuerWlknGVO71+drWNmY=;
        b=X6EQTfw01/EbU/g4vkjBxULOrV33EsdIrqyZnnxv/7hTFV44eASxEd+DdavM/Momtk
         cwVE6ApnwudrcSrhAXCzidqQl/CE+xqdCxOisqcGivxQpWaC9bWsz0+Id9pU6rU+tvIR
         ceQ6dOgN1Vpnkhi/z2nqyuWLLz7ONQMFXJQBvC7OisiigglqAeF/1aAfcIs8uQz0DaN3
         zOWA1qL2KJMAjg0P/J+LMgzhT5VG6ut77iHeBjUZ07MvmL4TliqJMq1YNWnvgC+MPihI
         H1ZtJO3AlAyFQ6nkX2T7h67WvVIDp69vj3ElsZxYd8RHDfGz1O9hU+qswi3B5sV8aeb8
         dDFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8YMZ0uZa465zrChzYNNUEs0iuerWlknGVO71+drWNmY=;
        b=WVoUZDnBOvM4Q/0jFb/knCFpGk6PyOicyp/1h94s/R9MqkmFoQoCm/em/2mEnHBTR9
         7YZWEICLmDvhJ6rSoBHNCTa1kDGNV0UMNMlWFS4qF2GwNdJBWGwsOCNm0RsoWCcsO+TX
         EcNXtTJ5uoJbW19C0LJ6M+N/DCiRZQ1KRejLorrqyvDKQu6B7ABOZwOfxlygEkMfdt/D
         bIaa7OMe75lInJ6y5JUI/vgc9NZtvwCDUUn0cAoT2cQ0/Pe8lM/0QLfKZCoU0FuxcLvb
         YdZAG823n34/hm0a9uBpyHdNEdKFBwCQLM9Yv2RnIIuaJwhTbnQ6gXyuREkSFM8B5KuC
         qlGQ==
X-Gm-Message-State: AOUpUlFQCywPJtSvOKWdMLhDyktst6gvJAg6M6uVG36D5FqJvemtaC3O
        ObJva5u7EkKYEaxnrAO98HEd/t1WCxvPO/pSztCkMw==
X-Google-Smtp-Source: AAOMgpeP1w8hS2ResumrzohuaAlW4zwidoxpizSJDOqvJvwNZDvTwIwZM9zCENbPjKICfvd7x2bB2CIDuGfIc1OUCrU=
X-Received: by 2002:ab0:70a9:: with SMTP id q9-v6mr4255638ual.141.1531931164229;
 Wed, 18 Jul 2018 09:26:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 09:26:03
 -0700 (PDT)
In-Reply-To: <30d6b568-b785-ae93-9f56-d0a8b7e82901@micronovasrl.com>
References: <20180718094006.105675-1-giulio.benetti@micronovasrl.com>
 <20180718094006.105675-3-giulio.benetti@micronovasrl.com> <CAHp75VcaALb8fYJExnZ=Ye=GcNHc3aPXgFihVK+rAu_a1A01Sg@mail.gmail.com>
 <30d6b568-b785-ae93-9f56-d0a8b7e82901@micronovasrl.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 18 Jul 2018 19:26:03 +0300
Message-ID: <CAHp75VchXfm6J+PPcB8ekoXcDktsPUNok3KKBMFyyk9XV=AUyQ@mail.gmail.com>
Subject: Re: [PATCH v9 4/4] rtc: ds1307: add frequency_test_enable sysfs
 attribute to check tick on m41txx
To:     Giulio Benetti <giulio.benetti@micronovasrl.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" 
        <linux-rtc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 5:06 PM, Giulio Benetti
<giulio.benetti@micronovasrl.com> wrote:

>>> +       int ret;
>>> +
>>> +       ret = kstrtobool(buf, &freq_test_en);
>>> +       if (ret == -EINVAL) {

>> What kind of other error code you may expect and why they are not
>> considered as no error?

> According to documentation, kstrtobool can only fail with -EINVAL.
> See:
> https://elixir.bootlin.com/linux/v4.18-rc5/source/lib/kstrtox.c#L332

That's correct. So, what do you want to show by explicitly mentioned
an error code in the condition?

-- 
With Best Regards,
Andy Shevchenko
