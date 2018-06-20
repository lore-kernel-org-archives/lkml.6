Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAFE0C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CDD320846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BTYnUG+j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CDD320846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932951AbeFTTz1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 15:55:27 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:42050 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932372AbeFTTzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 15:55:25 -0400
Received: by mail-lf0-f65.google.com with SMTP id z207-v6so1099996lff.9;
        Wed, 20 Jun 2018 12:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=XvOCgmDhhrDhs4XBU1Pz7JIORVfXz8atk6MrvVDy3MU=;
        b=BTYnUG+jG0wmbub6ln40yo+bDCf+8l90ESh5eIbnGqBi/l5/wdCmiKGA0WaIHAMqvu
         QYGq0a2VlyM7jclnqY4gths9CgN7slnQtmr1h0K9B4R0B0rxTczDQgOyffuZ3YxBfeMF
         bPFsYbp8cORlyCGJSc/0Mjd2DgIimTSgTWfC52G/LdimHsdUlg2DZcW10U11n80B/GfI
         jAUoKFdJqdEyYlPM05Wqg5LeyxtQ1xlNZoaj2BJx8ZsBX4J47/HTkfa2FFm7paiz3UwP
         sWKggXt7/yR4Pu/QEofmudIPuDZf07CEs8v3sMwVTIQCIQSB569PfxTM83P3k/ZKFueR
         fHcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=XvOCgmDhhrDhs4XBU1Pz7JIORVfXz8atk6MrvVDy3MU=;
        b=WvLYpV1IenXzVo85CaqgBHUMNABK0pAdJvCwPVH8sr4hOWfq7vWLiKHe21aRSlhyMT
         dpRAlLwaAg44AkZQ6mn2voXI4ooT9lwubBOTPBTZWNN1EWSpy3/aB6EW6Fxxqq+LcZC9
         JIlmlDa9/IcU0/9hLY/CNLdSrb5CviVdFYROYKZl7X9qmCC3Gl4Vk9THtn7estrNb7S3
         5UauDm+LZzu5xp4Mj5HW/0Pt2ydttbiNtA3FHPhi2TLymWQJ59NCrfSgbRMXMbq2GKOi
         h52GYDMILRNQZO+XGIj6Qn8Inj46no67/P1vd7UKLbb3xKRHQ9u60jCMNubeW98KbOLx
         Sx6g==
X-Gm-Message-State: APt69E1v2AM7AfjeEgkRF4+abIVnqPfSPH0pWN2ckFyarHBX7SxIzjWl
        5hD63+GGCVYd+3vAMSGV3/quadLiSlC2cQ+tYkU=
X-Google-Smtp-Source: ADUXVKKwM4ajcQ+g60lgxV9ycyTbv/wMkWKG6QLCFNPu3msqZ9NfnOn/qvhDHiywIzT4yJzVbb7P4HzI8e+s8btFgv4=
X-Received: by 2002:a19:d5c7:: with SMTP id m190-v6mr4169458lfg.12.1529524523477;
 Wed, 20 Jun 2018 12:55:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:56c8:0:0:0:0:0 with HTTP; Wed, 20 Jun 2018 12:55:22
 -0700 (PDT)
In-Reply-To: <1529513708.5833.29.camel@dubeyko.com>
References: <20180619160223.4108556-1-arnd@arndb.de> <1529427809.2624.16.camel@dubeyko.com>
 <CAK8P3a0WNPxDqSNJUuijY0P9UwGXPD_DCAUw9AH_OvAg-cPf1Q@mail.gmail.com> <1529513708.5833.29.camel@dubeyko.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 20 Jun 2018 21:55:22 +0200
X-Google-Sender-Auth: pv7jimHlQq9WPalbInagxQnMBrk
Message-ID: <CAK8P3a2X134US86LAecGqx4cd1AbhQgyp5NqFgymKs0v9Hx7dQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] hfs: stop using timespec based interfaces
To:     Viacheslav Dubeyko <slava@dubeyko.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Jeff Layton <jlayton@redhat.com>, Jan Kara <jack@suse.cz>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 6:55 PM, Viacheslav Dubeyko <slava@dubeyko.com> wrote:
> On Tue, 2018-06-19 at 21:42 +0200, Arnd Bergmann wrote:
>> On Tue, Jun 19, 2018 at 7:03 PM, Viacheslav Dubeyko <slava@dubeyko.com> wrote:

>> We never followed that interpretation in Linux though. As I wrote,
>> on 64-bit machines, these two calculations (hfs and hfs+,
>> respectively)
>>
>> #define __hfs_m_to_utime(sec)   (be32_to_cpu(sec) - 2082844800U  +
>> sys_tz.tz_minuteswest * 60)
>> #define __hfsp_mt2ut(t)                (be32_to_cpu(t) - 2082844800U)
>>
>> just wrap around when reading the timestamps before 1970 from
>> disk. On 32-bit machines they get wrapped another time when
>> we assign them to a signed 32-bit time_t.
>>
>
> The whole patchset looks reasonable for me. I simply guess what the
> correct behaviour of HFS/HFS+ file system driver could look like for
> the case of achieving 2040 year. So, maybe the good way could be to
> mount in the READ-ONLY mode. What do you think?

We've discussed doing that in VFS before, this is something we
need to revisit, but I'd like to do it in common code rather than
in every file system with a particular limit.

Deepa has a patch set to introduce minimum/maximum timestamps
in the superblock for this. We definitely want to use that for limiting
the range of utimensat() arguments from user space, and the idea
we had discussed in the past was to have a way to enforce
read-only mounting of file systems that cannot write current i_mtime
values past a certain (user-defined) future date.

We actually need something like that soon, as there are some
organizations that want to support super-long service lifetimes
for Linux systems (e.g. cars, industrial machines, ...) and want
an early-fail behavior to ensure that everything that works today
can in principle keep working for the foreseeable future, while
everything that is known to break can be forced to break already.

This is clearly not a priority for HFS in particular, but there is no
reason for HFS to be different from ext3 here, which has a similar
problem (timestamps are defined to range from 1902 to 2038).

>>  /* time macros: convert between 1904-2040 and 1970-2106 range,
>>   * pre-1970 timestamps are interpreted as post-2038 times after
>> wrap-around */
>> -#define __hfsp_mt2ut(t)                (be32_to_cpu(t) -
>> 2082844800U)
>> +#define __hfsp_mt2ut(t)                ((time64_t)be32_to_cpu(t) -
>> 2082844800U)
>>  #define __hfsp_ut2mt(t)                (cpu_to_be32(t +
>> 2082844800U))
>>
>>  /* compatibility */
>>
>> I can submit that separately so that it can get backported into
>> stable kernels if you like, with the type changes as a follow-up
>> on top.
>>
>
> Sounds good.

Ok, I'll send an updated version with that patch first then.

       Arnd
