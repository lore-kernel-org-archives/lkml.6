Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 868B6C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EAA620846
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ktCtYwYN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EAA620846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389464AbeGKQek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 12:34:40 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:45116 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbeGKQek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 12:34:40 -0400
Received: by mail-oi0-f66.google.com with SMTP id q11-v6so24789036oic.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 09:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/jx4oPUgOAT3RrrjXvzd/MgHNhRugHxfjaasNguFihY=;
        b=ktCtYwYNZDjds3dSb4y6UeT4SfBZXqxbP0V3VyFkGo6Hut/8pm58+0gUPnEFlVBH80
         OKxBhmfYDgFU3zcMMKfluXKb1wlNhb0HGxj354nhTyeYgCxExANd3Gaxjw2ySqq+rcJc
         sbGHE2mvECpqGUNNpJhf4FlDVjKUxaCTHBkik9t1PaOipMksoUr2LF3Cv6J+jzXXjcBt
         U797uIFmz1zZ+OAq7dyTkpZj896g2uzv/ocZUAS/D8wIrOu9UN4+coT/hzhTQ2k9x37C
         nFhznhPNDsawU3AQPTLuEpH/dWq3w14TVQ0otMt0vjAQhBDZ/AG2EU3nglstHaYr44cH
         0R2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/jx4oPUgOAT3RrrjXvzd/MgHNhRugHxfjaasNguFihY=;
        b=H4VAxVjYu3NbTKnDmV0kby3td7nPCzQkIGpyySR851hg2nGpz4He/YyJbRJF+QjKpD
         vSI5XoeSfmN13pkGDnstq8w8Cr3S3kSvumMPA0/bZOjmOqWsdUw3BGJS6gP8Q1ZLwT8E
         qibtS2UOrUbZxaEWZ7ELlLmlzJ+OuGAdAMIl4lwTfkNTDISVk51tcqy2eKmeDobYWSXS
         /O7XMHmSZNwMJDpquPJcxf+tte+Qmlcgv4EB8uzjwhwN+ZzmXS1rz/dPlZVSSgTibU+S
         vrZ+uUEuanXU7Gn+3EQTbrjjLkuPTohMmpsF/pKzniKuSGLPTf293I7+ezY9x5AXv5Zh
         L3AQ==
X-Gm-Message-State: APt69E0ij7NnTiMPcN5KQsdPkNgcF32SJOJAAWCMysop3mmMU40wXdqv
        i3MKz6SQ0KOQl7Or7gEHQlHo7EHSoJQGVZ1HHXc=
X-Google-Smtp-Source: AAOMgpfMvry7pByYzDpVLxjQg5vZmve5VJXz0C/zCMiqjY9rlZ5uethg8mK6aPLrLdRbkXu9HeAdmIVyF3yrWMPb0ro=
X-Received: by 2002:aca:ecd0:: with SMTP id k199-v6mr35295024oih.227.1531326574055;
 Wed, 11 Jul 2018 09:29:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:c984:0:0:0:0:0 with HTTP; Wed, 11 Jul 2018 09:29:33
 -0700 (PDT)
In-Reply-To: <2022d212-62f2-a163-2493-abecfbafa07b@intel.com>
References: <CAMe9rOqXsQ4Onv8_-kYE_yVYVfN0Hsg81XM0sq9k2cVYE_LvaQ@mail.gmail.com>
 <50d6bb50-5fa4-33d1-1f88-3844d0237f16@intel.com> <CAMe9rOoA=OoyaUfOvWuHGTp_ii9-A_ecR5tj8CefBKx_Hmi50g@mail.gmail.com>
 <7db385ef-0940-8f28-87b0-828921dd2f1d@intel.com> <CAMe9rOoZ=8ROyR6U3-JY+4hib2Bb5LGhBYzY5S_Xp38coj16aQ@mail.gmail.com>
 <9548e10a-7403-425e-bf1f-b1eb9d055d99@intel.com> <CAMe9rOrHowBX06nihdRRmEqhV8v7cs+PwVY7JYQFpUFOnHC71A@mail.gmail.com>
 <f22ee1e2-9a35-697f-50ab-543ac1631c89@intel.com> <CAMe9rOpPwtPd-R+D9=iDYgbFtnP+=akWic-QBKwq9wKa7uadEQ@mail.gmail.com>
 <2022d212-62f2-a163-2493-abecfbafa07b@intel.com>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Wed, 11 Jul 2018 09:29:33 -0700
Message-ID: <CAMe9rOqc0oVw+ZLXCM-nrtPb1OiPFBeHt+Lsx+6K6y=t3HSVhA@mail.gmail.com>
Subject: Re: Kernel 4.17.4 lockup
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 9:24 AM, Dave Hansen <dave.hansen@intel.com> wrote:
> On 07/11/2018 08:40 AM, H.J. Lu wrote:
>> This is a quad-core machine with HT and 6 GB RAM.  The workload is
>> x32 GCC build and test with "make -j8".  The bug is triggered during GCC
>> test after a couple hours.  I have a script to set up my workload:
>>
>> https://github.com/hjl-tools/gcc-regression
>>
>> with a cron job
>>
>> # It takes about 3 hour to bootstrap x86-64 GCC and 3 hour to run tests,
>> TIMEOUT=480
>> # Run it every hour,
>> 30 * * * * /export/gnu/import/git/gcc-test-x32/gcc-build -mx32
>> --with-pic > /dev/null 2>&1
>
> Oh, fun, one of those.
>
> How long does it take to reproduce?

About 5 hours.

-- 
H.J.
