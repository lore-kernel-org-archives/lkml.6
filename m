Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD36BC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A2F420836
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RPaQvZOd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A2F420836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030561AbeFSTLa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 15:11:30 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:42218 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030434AbeFSTL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 15:11:29 -0400
Received: by mail-lf0-f65.google.com with SMTP id z207-v6so1140897lff.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 12:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Y79aokYl4rO2FeDwJ9m2zP1VtrCiWfj2Olci7Obn+Jk=;
        b=RPaQvZOdwYjEm2F6A2OFk54asyJaeOXa7RA6/Vo3UuerOUmstALyMXYA8aMVTW/xA/
         iJ1rzwauYhl2i7B+lmEsfNY2C18wmEunyZvKnJAkRXSxI4IPbZ6+P78F+Q8Crbas9OnV
         ZIbq+G0m8rdSKxEsN3asIyktSNJri1hfVHSQnJn6Vwk/n7nt9Q7MrqJc21AFnLqAKU2e
         h5464mWhbQPtDLT3rg6MpJHFwRADtqy+0HgdZOYMAPLQdFaDt5PWZVIssZmsKELgtySy
         gJ4i1foG6O2bpa+3Mj3CQG7DAxy+Xsv/Kux6ZJE1/EAu5Tzdsevgw3fW7ZOwPwouGyXD
         VDbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Y79aokYl4rO2FeDwJ9m2zP1VtrCiWfj2Olci7Obn+Jk=;
        b=j7X9Ij0OXVbh3JNpeL/MOWEDxSqyZmg7SzioP2D4qla2A9XZOb40uhVNcsEvRlYP+K
         9cEP8tKuwF7FX0/iyifEO8AJsYaTZlXs7eeQ9d4rlCvpuC4IB7CvbOs1RaoetKGrVmzd
         QOjbh+F91Kpxu2s6ZuEJbAdpSxtyIOnAYHys0I+/yRiedTymluQI6DVCZDEGi7ls96MC
         t3QWxI8wh7lNAo+MsD/RowyLdFeFnuT2qDFi7bEG+y9ceAHZcLn8zR0CimgL5ew5Qp2A
         c5Z64SS8CLv7K+aCqbEHH5I9RieMfXlbIAeJ9aL+OmwOuDyTsUPZVhVrmEYpgA6SQnqX
         HZwg==
X-Gm-Message-State: APt69E0RRJpMRR2o/YfFxf22fNlKLEoJ7930dGhnXG46/72QFc3ZoC5b
        E816fYYTkZRTF1Nv6W9ImjTnwk+DHAwbPyhui6U=
X-Google-Smtp-Source: ADUXVKIefmSHX0KkTkXffnmf1IQjZwEVXV8VKBJ3O63tbC0/L/yiNHGc5ZgyfYhMhng8YY5W6QBlsRfzIMfxPH4oERo=
X-Received: by 2002:a19:d5c7:: with SMTP id m190-v6mr1438946lfg.12.1529435487989;
 Tue, 19 Jun 2018 12:11:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:56c8:0:0:0:0:0 with HTTP; Tue, 19 Jun 2018 12:11:27
 -0700 (PDT)
In-Reply-To: <20180619171407.yoncg72ed2vncf62@merlin>
References: <20180619155826.4106487-1-arnd@arndb.de> <20180619171407.yoncg72ed2vncf62@merlin>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 19 Jun 2018 21:11:27 +0200
X-Google-Sender-Auth: sMXEcfITCQVq-Jeqms9Y24bbNpc
Message-ID: <CAK8P3a0Mcm+AxBPxouMZJKXfbEyX-UD3=_speEj7bsW9nmnjzA@mail.gmail.com>
Subject: Re: [Ocfs2-devel] [PATCH] ocfs2: dlmglue: clean up timestamp handling
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Eric Ren <zren@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        ocfs2-devel@oss.oracle.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 7:14 PM, Goldwyn Rodrigues <rgoldwyn@suse.de> wrote:
>
>
> On 06-19 17:58, Arnd Bergmann wrote:
>> The handling of timestamps outside of the 1970..2038 range in the dlm
>> glue is rather inconsistent: on 32-bit architectures, this has always
>> wrapped around to negative timestamps in the 1902..1969 range, while on
>> 64-bit kernels all timestamps are interpreted as positive 34 bit numbers
>> in the 1970..2514 year range.
...
>
> Will all values written to LVB be the same with or without the patch?
> I am considering the situation where in a cluster some machines have this
> patch and some don't. Depending on that, this may require a version
> change.

There is one part that may change:

>> -static u64 ocfs2_pack_timespec(struct timespec *spec)
>> +static u64 ocfs2_pack_timespec(struct timespec64 *spec)
>>  {
>>       u64 res;
>> -     u64 sec = spec->tv_sec;
>> +     u64 sec = clamp_t(time64_t, spec->tv_sec, 0, 0x3ffffffffull);
>>       u32 nsec = spec->tv_nsec;
>>
>>       res = (sec << OCFS2_SEC_SHIFT) | (nsec & OCFS2_NSEC_MASK);

Here, setting a timestamp before 1970 or after 2514 will get wrapped
around in unpatched kernels, but will be clamped to the minimum
and maximum times after the patch.

It is extremely rare for correct code to need timestamps outside of that
range, but it is also trivial to trigger that with a manual 'touch' command
from user space.

If the change is a problem, I can resend the patch without that one
line change.

         Arnd
