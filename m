Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF06C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 06:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18B70254AD
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 06:14:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18B70254AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752228AbeFYGOs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 02:14:48 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38434 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751984AbeFYGOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 02:14:47 -0400
Received: from mail-wm0-f72.google.com ([74.125.82.72])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <chia-lin.kao@canonical.com>)
        id 1fXKly-0006kG-8R
        for linux-kernel@vger.kernel.org; Mon, 25 Jun 2018 06:14:46 +0000
Received: by mail-wm0-f72.google.com with SMTP id 76-v6so3572107wmw.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jun 2018 23:14:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4O38+L5vlaGclk+ddCGH5+NZDuv6qPo2X507gDOrvC4=;
        b=Y3WZkLLwEuScgu+blQDwWrwXTdlA+rq9qAAGIdXi+mBjIBS3JN+1my3V9KG42jyKy1
         PyqRb24/zbDOkUAlkpuV0QQ10JAqfP3HTFuLdwcHhWCSdnyaj4GLY25KMHvxim4k2AAs
         e/KNGwjxp7ZcPKxtUU883vAXTOZkLEIA1y88mU99kS+vKQzdrvty+jxDtl9LJugFbk6J
         GOtEQegiz61/73qidl6pVBBY3YOrriglqRYFmG0MM1k+zqfZfNAz9YxCrTKKTSYDCi3y
         omRvbDVSZhB+vSOFoyU6+yuUeOn2an4Iqr0HkIfiY5xJVC5Y35EdFznce/E+Zapxk/oN
         RKNg==
X-Gm-Message-State: APt69E0QAwU8s1v49AQlq2voa5kJpYhaaIYeT6/VmerfCHRR7ocn+8Gc
        8RuXF+xAqqwbkKzl2PBv//YPELq8aJnAk8s143AXdm3wyuj+Yma29mXqF3D0jXojBxku/F24PHB
        yCnRSWQVJCCMcLCwasLFG5ocINnGAusMLNMxZSW0Mah5YiqZNBF6IilSvTQ==
X-Received: by 2002:a5d:4a92:: with SMTP id o18-v6mr8207735wrq.132.1529907285961;
        Sun, 24 Jun 2018 23:14:45 -0700 (PDT)
X-Google-Smtp-Source: AAOMgpezUTUMFNGJp6ceJldTJEpfLwsEACrC27YU8gUdsN5vY5GS/E1R/E1w/p1XbPp4U1ATafazoo+Xw6ZI2ibTGto=
X-Received: by 2002:a5d:4a92:: with SMTP id o18-v6mr8207718wrq.132.1529907285599;
 Sun, 24 Jun 2018 23:14:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:bc55:0:0:0:0:0 with HTTP; Sun, 24 Jun 2018 23:14:44
 -0700 (PDT)
In-Reply-To: <20180621203745.GA50452@dtor-ws>
References: <20180621201207.178426-1-delco@chromium.org> <20180621203745.GA50452@dtor-ws>
From:   AceLan Kao <acelan.kao@canonical.com>
Date:   Mon, 25 Jun 2018 14:14:44 +0800
Message-ID: <CAFv23QnUnQdkf5my2cgik-iQ2hG+Q8B0jonjGaRan2shyea+kw@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: intel-vbtn: Ignore extraneous events from
 tablet mode
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Matt Delco <delco@chromium.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.or>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a v2 patch.
Please ignore this one.

2018-06-22 4:37 GMT+08:00 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> On Thu, Jun 21, 2018 at 01:12:07PM -0700, Matt Delco wrote:
>> The Dell laptop I have has an ACPI that sends 0xCB and 0xCC on entering
>> tablet mode.  On exiting tablet mode it sends 0xCA and 0xCD.  This
>> change has the driver ignore 0xCA and 0xCB.
>>
>> Signed-off-by: Matt Delco <delco@chromium.org>
>
> This looks good to me.
>
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>
>> ---
>>  drivers/platform/x86/intel-vbtn.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/platform/x86/intel-vbtn.c b/drivers/platform/x86/intel-vbtn.c
>> index c13780b8dabb..4c6f2bb1d1ac 100644
>> --- a/drivers/platform/x86/intel-vbtn.c
>> +++ b/drivers/platform/x86/intel-vbtn.c
>> @@ -38,8 +38,10 @@ static const struct key_entry intel_vbtn_keymap[] = {
>>       { KE_IGNORE, 0xC7, { KEY_VOLUMEDOWN } },        /* volume-down key release */
>>       { KE_KEY,    0xC8, { KEY_ROTATE_LOCK_TOGGLE } },        /* rotate-lock key press */
>>       { KE_KEY,    0xC9, { KEY_ROTATE_LOCK_TOGGLE } },        /* rotate-lock key release */
>> -     { KE_SW,     0xCC, { .sw = { SW_TABLET_MODE, 1 } } },   /* Tablet */
>> -     { KE_SW,     0xCD, { .sw = { SW_TABLET_MODE, 0 } } },   /* Laptop */
>> +     { KE_IGNORE, 0xCA, { KEY_UNKNOWN } },                   /* Laptop key press */
>> +     { KE_IGNORE, 0xCB, { KEY_UNKNOWN } },                   /* Tablet key press */
>> +     { KE_SW,     0xCC, { .sw = { SW_TABLET_MODE, 1 } } },   /* Tablet key release */
>> +     { KE_SW,     0xCD, { .sw = { SW_TABLET_MODE, 0 } } },   /* Laptop key release */
>>       { KE_END },
>>  };
>>
>> --
>> 2.18.0.rc2.346.g013aa6912e-goog
>>
>
> --
> Dmitry
