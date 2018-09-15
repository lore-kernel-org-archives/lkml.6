Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F74ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 112DD20866
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="SwQNm/CB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 112DD20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbeIOHNw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 03:13:52 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:34375 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbeIOHNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 03:13:51 -0400
Received: by mail-oi0-f66.google.com with SMTP id 13-v6so14514210ois.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 18:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Ier55OdN8ijCVQsuan1qMbhtFx9RJk41BwsxiReKB/8=;
        b=SwQNm/CBGhH9BhwfUvq4nlU+nWiGcLCqELK9YkwU6Yg9ZG2OiSTU/g9A9PflcedSdd
         8vgIm96ZnQ4S05EtUhbLIHQARKQQWYsaKKpHyKahZsDRC4lQEnf4iQJYFAMnMkf/rXqF
         EtaHbtKQ41Mbant1iHcXmdsRAaYQpcS8q6f8OKuiiY+Gik+C0k0Bt+/IB8WvJwmn+FLZ
         jjHRxBcgvEiFzD7vr0uizeah9xKDfODWpkYHBQR3tDSxUeqRyvn7j0NvCCZb/zbR3G5w
         DRqL4axaMUJIM02+dPZ7ytMtFa40p2NwqltMSpUNRbqMxHi8rbXjUlfl4kkubTPOJ7n4
         NWpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Ier55OdN8ijCVQsuan1qMbhtFx9RJk41BwsxiReKB/8=;
        b=EMUqnfvwIOzcHjYv25XJTCYiX//rGrW9DjNBgbFTXkLvV2vHSsuupRJThnHqX0VxNm
         zA4W/cccNQxEDJiMKOmhfaQ5AxfGnHNjh9lgk6fwi8c9IDBaqElsVJ2QdzzxmYOpSIQU
         hZfPjwGCtIBvsJ8TOePktO6OtzUbX63ky4Nps1wV+5uTCDCK9yMBrMaUw3slyspTP/76
         GDaVYFMgOf+n9RI8FW1v67yWbHBwsk5lqL9wHPdjdf6hthhJmlD+mcgsiRiO4vMLMHvG
         u2RPIpeiabajyZ2vP/6icNeNjOOwof2SywmcpE6R8z2DjKfeWUIHNKNbO5krefkSYRQG
         uEbQ==
X-Gm-Message-State: APzg51AQaK/3Ec75sc0TBfyAIF0E4BiAqVcY/HETJLF5PPGZ58lVyqI0
        ExVFDt44+6p0+NFgq+jh4JI/uak8dukqwg/Q0M2sN8M7
X-Google-Smtp-Source: ANB0VdYcWSYKL9vBF6r1/GvQ0SyEJYjm9ojUWY0oOhKFRtCUFf9y1mEQZjSTciSPlyTjquawOusZHx9vxeSKxfJLJQk=
X-Received: by 2002:aca:3f41:: with SMTP id m62-v6mr11931008oia.18.1536976606062;
 Fri, 14 Sep 2018 18:56:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:8e85:0:0:0:0:0 with HTTP; Fri, 14 Sep 2018 18:56:45
 -0700 (PDT)
In-Reply-To: <20180915014005.GI3821@sasha-vm>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
 <20180915012944.179481-50-alexander.levin@microsoft.com> <CAPcyv4jbHivBtLMD0uQ6TMMhObPQ_5287Lirus=RRD5O2GjB2w@mail.gmail.com>
 <20180915014005.GI3821@sasha-vm>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 14 Sep 2018 18:56:45 -0700
Message-ID: <CAPcyv4h9B2rxs1JXJVsuBrjvc=-JCMXfzfUogEHiZ88GDbQZ_g@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 4.18 51/92] tools/testing/nvdimm: Fix support for
 emulating controller temperature
To:     Sasha Levin <Alexander.Levin@microsoft.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 6:40 PM, Sasha Levin
<Alexander.Levin@microsoft.com> wrote:
> On Fri, Sep 14, 2018 at 06:34:43PM -0700, Dan Williams wrote:
>>On Fri, Sep 14, 2018 at 6:30 PM, Sasha Levin
>><Alexander.Levin@microsoft.com> wrote:
>>> From: Dan Williams <dan.j.williams@intel.com>
>>>
>>> [ Upstream commit e5d772fbe7685aae0dff99f3b54158a0ec32155e ]
>>>
>>> In addition to populating the value the payload also needs to set the
>>> "controller temperature valid" flag.
>>>
>>> Fixes: cdd77d3e1930 ("nfit, libnvdimm: deprecate the generic SMART ioctl")
>>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>>> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
>>> ---
>>>  tools/testing/nvdimm/test/nfit.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/tools/testing/nvdimm/test/nfit.c b/tools/testing/nvdimm/test/nfit.c
>>> index e2926f72a821..94c3bdf82ff7 100644
>>> --- a/tools/testing/nvdimm/test/nfit.c
>>> +++ b/tools/testing/nvdimm/test/nfit.c
>>> @@ -1308,7 +1308,8 @@ static void smart_init(struct nfit_test *t)
>>>                         | ND_INTEL_SMART_ALARM_VALID
>>>                         | ND_INTEL_SMART_USED_VALID
>>>                         | ND_INTEL_SMART_SHUTDOWN_VALID
>>> -                       | ND_INTEL_SMART_MTEMP_VALID,
>>> +                       | ND_INTEL_SMART_MTEMP_VALID
>>> +                       | ND_INTEL_SMART_CTEMP_VALID,
>>>                 .health = ND_INTEL_SMART_NON_CRITICAL_HEALTH,
>>>                 .media_temperature = 23 * 16,
>>>                 .ctrl_temperature = 25 * 16,
>>
>>Does no harm, but also does no benefit since this is just unit test
>>infrastructure. You may want to blacklist this directory for stable
>>checking in the future.
>
> We backport selftests back to stable trees. People run selftests on
> stable kernels as well, so it's both important to make sure that a
> backport didn't brake anything, and to locate possible missing stable
> patches.

Sure, I don't mind backporting this one, but I suspect the tests will
still have issues on older kernels. Ideally we would have ndctl, the
project that houses the userspace tests, in the kernel tree.
Unfortunately that's never going to happen because upstream is
allergic to autotools, and distros don't like the idea of more
utilities being built from kernel source.


> It is also the case that backporting selftests can't "break" the kernel.
> They are disconnected from the kernel's build process so we can be less
> conservative about backporting them.

I'm on board with the policy in general, but in the specific case of
tools/testing/nvdimm/ I'm not optimistic that we can reasonably keep
this in sync with an out of tree stimulus.
